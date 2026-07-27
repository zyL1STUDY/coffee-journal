import 'coffee_record_storage_stub.dart'
    if (dart.library.html) 'coffee_record_storage_web.dart'
    if (dart.library.io) 'coffee_record_storage_io.dart';
import 'coffee_record_storage.dart';

CoffeeRecordStorage createPlatformCoffeeRecordStorage() {
  return createStorage();
}
