import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

import 'coffee_photo_storage_impl.dart';

abstract class CoffeePhotoStorage {
  Future<String> savePickedPhoto(XFile photo);

  Future<String> saveCutoutPhoto(Uint8List bytes);
}

CoffeePhotoStorage createCoffeePhotoStorage() {
  return createPlatformCoffeePhotoStorage();
}
