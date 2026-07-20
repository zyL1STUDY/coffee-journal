import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/application/coffee_widget_sync_service.dart';
import '../domain/coffee_record.dart';

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

final coffeeRecordRepositoryProvider =
    NotifierProvider<MockCoffeeRecordRepository, List<CoffeeRecord>>(
      MockCoffeeRecordRepository.new,
    );

class MockCoffeeRecordRepository extends Notifier<List<CoffeeRecord>> {
  @override
  List<CoffeeRecord> build() {
    CoffeeWidgetSyncService.syncLatest(null);
    return [];
  }

  CoffeeRecord save(CoffeeRecordDraft draft) {
    final now = DateTime.now();
    final record = CoffeeRecord(
      id: now.microsecondsSinceEpoch.toString(),
      createdAt: now,
      updatedAt: now,
      isDeleted: false,
      sourceType: draft.sourceType,
      sourceName: draft.sourceName,
      drinkName: _normalizeOptional(draft.drinkName),
      photoUrl: _normalizeOptional(draft.photoUrl),
      note: _normalizeOptional(draft.note),
      aiMessage: '这杯咖啡已经安静地留在今天了。',
      aiStatus: AiStatus.idle,
    );

    state = [record, ...state];
    CoffeeWidgetSyncService.syncLatest(record);
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
    state = [
      for (final record in state)
        if (record.id == id && !record.isDeleted)
          record.copyWith(
            updatedAt: now,
            sourceType: draft.sourceType,
            sourceName: draft.sourceName,
            drinkName: _normalizeOptional(draft.drinkName),
            photoUrl: _normalizeOptional(draft.photoUrl),
            note: _normalizeOptional(draft.note),
          )
        else
          record,
    ];
    CoffeeWidgetSyncService.syncLatest(_latestActiveRecord);
  }

  void delete(String id) {
    final now = DateTime.now();
    state = [
      for (final record in state)
        if (record.id == id && !record.isDeleted)
          record.copyWith(isDeleted: true, deletedAt: now, updatedAt: now)
        else
          record,
    ];
    CoffeeWidgetSyncService.syncLatest(_latestActiveRecord);
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
}
