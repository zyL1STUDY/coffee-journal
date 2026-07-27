import 'dart:convert';

import 'package:web/web.dart' as web;

import 'coffee_record_storage.dart';
import '../domain/coffee_record.dart';

CoffeeRecordStorage createStorage() {
  return const WebCoffeeRecordStorage();
}

class WebCoffeeRecordStorage implements CoffeeRecordStorage {
  const WebCoffeeRecordStorage();

  static const _storageKey = 'coffee_journal.records.v1';

  @override
  Future<List<CoffeeRecord>> readRecords() async {
    final rawJson = web.window.localStorage.getItem(_storageKey);
    if (rawJson == null || rawJson.trim().isEmpty) {
      return [];
    }

    final decoded = jsonDecode(rawJson);
    if (decoded is! List) {
      return [];
    }

    return [
      for (final item in decoded)
        if (item is Map<String, Object?>) CoffeeRecord.fromJson(item),
    ];
  }

  @override
  Future<void> writeRecords(List<CoffeeRecord> records) async {
    web.window.localStorage.setItem(
      _storageKey,
      jsonEncode([for (final record in records) record.toJson()]),
    );
  }
}
