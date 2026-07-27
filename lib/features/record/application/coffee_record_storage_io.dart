import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'coffee_record_storage.dart';
import '../domain/coffee_record.dart';

CoffeeRecordStorage createStorage() {
  return const FileCoffeeRecordStorage();
}

class FileCoffeeRecordStorage implements CoffeeRecordStorage {
  const FileCoffeeRecordStorage();

  static const _fileName = 'coffee_records.json';

  @override
  Future<List<CoffeeRecord>> readRecords() async {
    final file = await _recordsFile();
    if (!await file.exists()) {
      return [];
    }

    final rawJson = await file.readAsString();
    if (rawJson.trim().isEmpty) {
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
    final file = await _recordsFile();
    await file.writeAsString(
      jsonEncode([for (final record in records) record.toJson()]),
      flush: true,
    );
  }

  Future<File> _recordsFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }
}
