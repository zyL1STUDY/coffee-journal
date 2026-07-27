import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

import 'coffee_photo_assets.dart';
import 'coffee_photo_storage.dart';

CoffeePhotoStorage createStorage() {
  return const NoopCoffeePhotoStorage();
}

class NoopCoffeePhotoStorage implements CoffeePhotoStorage {
  const NoopCoffeePhotoStorage();

  @override
  Future<String> savePickedPhoto(XFile photo) async {
    return CoffeePhotoAssets.fallbackStickerPath;
  }

  @override
  Future<String> saveCutoutPhoto(Uint8List bytes) async {
    return CoffeePhotoAssets.fallbackStickerPath;
  }
}
