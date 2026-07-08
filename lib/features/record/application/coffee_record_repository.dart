import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final date = DateTime(2026, 6, 26, 8, 20);
    return [
      CoffeeRecord(
        id: 'mock-morning-latte',
        createdAt: date,
        updatedAt: date,
        isDeleted: false,
        sourceType: CoffeeSourceType.cafe,
        sourceName: '温暖的一杯',
        drinkName: '晨间拿铁',
        note: '温暖的一杯 · 08:20',
      ),
      CoffeeRecord(
        id: 'mock-pour-over',
        createdAt: date.subtract(const Duration(days: 1)),
        updatedAt: date.subtract(const Duration(days: 1)),
        isDeleted: false,
        sourceType: CoffeeSourceType.homemade,
        sourceName: '慢慢喝完',
        drinkName: '手冲咖啡',
        note: '慢慢喝完 · 昨天',
      ),
      CoffeeRecord(
        id: 'mock-americano',
        createdAt: date.subtract(const Duration(days: 2)),
        updatedAt: date.subtract(const Duration(days: 2)),
        isDeleted: false,
        sourceType: CoffeeSourceType.brand,
        sourceName: '清爽一点',
        drinkName: '冰美式',
        note: '清爽一点 · 周三',
      ),
    ];
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
    return record;
  }

  CoffeeRecord? findById(String id) {
    for (final record in state) {
      if (record.id == id) {
        return record;
      }
    }
    return null;
  }

  void update(String id, CoffeeRecordDraft draft) {
    final now = DateTime.now();
    state = [
      for (final record in state)
        if (record.id == id)
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
  }

  void delete(String id) {
    state = [
      for (final record in state)
        if (record.id != id) record,
    ];
  }

  String? _normalizeOptional(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}
