import 'coffee_record_storage.dart';
import '../domain/coffee_record.dart';

CoffeeRecordStorage createStorage() {
  return const NoopCoffeeRecordStorage();
}

class NoopCoffeeRecordStorage implements CoffeeRecordStorage {
  const NoopCoffeeRecordStorage();

  @override
  Future<List<CoffeeRecord>> readRecords() async {
    return [];
  }

  @override
  Future<void> writeRecords(List<CoffeeRecord> records) async {}
}
