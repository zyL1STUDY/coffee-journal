import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'coffee_photo_assets.dart';
import 'coffee_photo_storage.dart';

final coffeePhotoStorageProvider = Provider<CoffeePhotoStorage>((ref) {
  return createCoffeePhotoStorage();
});

final coffeePhotoPickerProvider = Provider<CoffeePhotoPicker>((ref) {
  return CoffeePhotoPicker(
    picker: ImagePicker(),
    storage: ref.read(coffeePhotoStorageProvider),
  );
});

class CoffeePhotoPicker {
  const CoffeePhotoPicker({required this.picker, required this.storage});

  final ImagePicker picker;
  final CoffeePhotoStorage storage;

  Future<String?> pickFromGallery() async {
    try {
      final photo = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        imageQuality: 82,
      );
      if (photo == null) {
        return null;
      }
      return storage.savePickedPhoto(photo);
    } on MissingPluginException {
      return CoffeePhotoAssets.fallbackStickerPath;
    }
  }
}
