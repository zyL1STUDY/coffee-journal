import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/application/coffee_widget_sync_service.dart';
import '../domain/coffee_record.dart';
import 'coffee_cutout_service.dart';
import 'coffee_record_storage.dart';
import 'coffee_record_storage_impl.dart';

class CoffeeRecordDraft {
  const CoffeeRecordDraft({
    required this.sourceType,
    required this.sourceName,
    this.drinkName,
    this.photoUrl,
    this.note,
  });

  final CoffeeSourceType sourceType;
  final String sourceName;
  final String? drinkName;
  final String? photoUrl;
  final String? note;
}

final coffeeRecordStorageProvider = Provider<CoffeeRecordStorage>((ref) {
  return createPlatformCoffeeRecordStorage();
});

final coffeeRecordRepositoryProvider =
    NotifierProvider<CoffeeRecordRepository, List<CoffeeRecord>>(
      CoffeeRecordRepository.new,
    );

class CoffeeRecordRepository extends Notifier<List<CoffeeRecord>> {
  late final CoffeeRecordStorage _storage;
  late final CoffeeCutoutService _cutoutService;

  @override
  List<CoffeeRecord> build() {
    _storage = ref.read(coffeeRecordStorageProvider);
    _cutoutService = ref.read(coffeeCutoutServiceProvider);
    unawaited(_loadRecords());
    CoffeeWidgetSyncService.syncLatest(null);
    return [];
  }

  CoffeeRecord save(CoffeeRecordDraft draft) {
    final now = DateTime.now();
    final photoUrl = _normalizeOptional(draft.photoUrl);
    final record = CoffeeRecord(
      id: now.microsecondsSinceEpoch.toString(),
      createdAt: now,
      updatedAt: now,
      isDeleted: false,
      sourceType: draft.sourceType,
      sourceName: draft.sourceName,
      drinkName: _normalizeOptional(draft.drinkName),
      photoUrl: photoUrl,
      cutoutStatus: _initialCutoutStatus(photoUrl),
      note: _normalizeOptional(draft.note),
      aiMessage: '这杯咖啡已经安静地留在今天了。',
      aiStatus: AiStatus.idle,
    );

    state = _sortRecords([record, ...state]);
    CoffeeWidgetSyncService.syncLatest(record);
    unawaited(_persistRecords());
    unawaited(_processCutout(record.id, photoUrl));
    return record;
  }

  CoffeeRecord? findById(String id) {
    for (final record in state) {
      if (record.id == id && !record.isDeleted) {
        return record;
      }
    }
    return null;
  }

  void update(String id, CoffeeRecordDraft draft) {
    final now = DateTime.now();
    final photoUrl = _normalizeOptional(draft.photoUrl);
    var shouldProcessCutout = false;
    state = _sortRecords([
      for (final record in state)
        if (record.id == id && !record.isDeleted)
          (() {
            final hasNewPhoto = photoUrl != null && photoUrl != record.photoUrl;
            shouldProcessCutout = hasNewPhoto && _cutoutService.canProcess;
            return record.copyWith(
              updatedAt: now,
              sourceType: draft.sourceType,
              sourceName: draft.sourceName,
              drinkName: _normalizeOptional(draft.drinkName),
              photoUrl: photoUrl,
              clearCutoutPhotoUrl: hasNewPhoto,
              cutoutStatus: hasNewPhoto
                  ? _initialCutoutStatus(photoUrl)
                  : record.cutoutStatus,
              cutoutUpdatedAt: hasNewPhoto ? now : record.cutoutUpdatedAt,
              note: _normalizeOptional(draft.note),
            );
          })()
        else
          record,
    ]);
    CoffeeWidgetSyncService.syncLatest(_latestActiveRecord);
    unawaited(_persistRecords());
    if (shouldProcessCutout) {
      unawaited(_processCutout(id, photoUrl));
    }
  }

  void delete(String id) {
    final now = DateTime.now();
    state = _sortRecords([
      for (final record in state)
        if (record.id == id && !record.isDeleted)
          record.copyWith(isDeleted: true, deletedAt: now, updatedAt: now)
        else
          record,
    ]);
    CoffeeWidgetSyncService.syncLatest(_latestActiveRecord);
    unawaited(_persistRecords());
  }

  CoffeeRecord? get _latestActiveRecord {
    for (final record in state) {
      if (!record.isDeleted) {
        return record;
      }
    }
    return null;
  }

  String? _normalizeOptional(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  CutoutStatus _initialCutoutStatus(String? photoUrl) {
    if (photoUrl == null || !_cutoutService.canProcess) {
      return CutoutStatus.idle;
    }
    return CutoutStatus.processing;
  }

  Future<void> _processCutout(String id, String? photoUrl) async {
    if (photoUrl == null || !_cutoutService.canProcess) {
      return;
    }

    final cutoutPhotoUrl = await _cutoutService.createCutout(photoUrl);
    if (!ref.mounted) {
      return;
    }

    final now = DateTime.now();
    state = _sortRecords([
      for (final record in state)
        if (record.id == id && !record.isDeleted && record.photoUrl == photoUrl)
          record.copyWith(
            updatedAt: now,
            cutoutPhotoUrl: cutoutPhotoUrl,
            cutoutStatus: cutoutPhotoUrl == null
                ? CutoutStatus.failed
                : CutoutStatus.success,
            cutoutUpdatedAt: now,
          )
        else
          record,
    ]);
    CoffeeWidgetSyncService.syncLatest(_latestActiveRecord);
    unawaited(_persistRecords());
  }

  Future<void> _loadRecords() async {
    try {
      final storedRecords = _sortRecords(await _storage.readRecords());
      if (!ref.mounted) {
        return;
      }

      state = _mergeRecords(
        currentRecords: state,
        storedRecords: storedRecords,
      );
      CoffeeWidgetSyncService.syncLatest(_latestActiveRecord);
    } catch (_) {
      if (ref.mounted) {
        CoffeeWidgetSyncService.syncLatest(_latestActiveRecord);
      }
    }
  }

  Future<void> _persistRecords() async {
    try {
      await _storage.writeRecords(state);
    } catch (_) {}
  }

  List<CoffeeRecord> _mergeRecords({
    required List<CoffeeRecord> currentRecords,
    required List<CoffeeRecord> storedRecords,
  }) {
    if (currentRecords.isEmpty) {
      return _sortRecords(storedRecords);
    }

    final recordsById = <String, CoffeeRecord>{
      for (final record in storedRecords) record.id: record,
      for (final record in currentRecords) record.id: record,
    };
    return _sortRecords(recordsById.values.toList());
  }

  List<CoffeeRecord> _sortRecords(List<CoffeeRecord> records) {
    return [...records]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}
