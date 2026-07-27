import '../domain/coffee_record.dart';

abstract class CoffeeRecordStorage {
  Future<List<CoffeeRecord>> readRecords();

  Future<void> writeRecords(List<CoffeeRecord> records);
}
