import 'coffee_photo_storage_stub.dart'
    if (dart.library.html) 'coffee_photo_storage_web.dart'
    if (dart.library.io) 'coffee_photo_storage_io.dart';
import 'coffee_photo_storage.dart';

CoffeePhotoStorage createPlatformCoffeePhotoStorage() {
  return createStorage();
}
