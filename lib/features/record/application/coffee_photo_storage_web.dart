import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'coffee_photo_storage.dart';

CoffeePhotoStorage createStorage() {
  return const WebCoffeePhotoStorage();
}

class WebCoffeePhotoStorage implements CoffeePhotoStorage {
  const WebCoffeePhotoStorage();

  @override
  Future<String> savePickedPhoto(XFile photo) async {
    final bytes = await photo.readAsBytes();
    final mimeType = photo.mimeType ?? 'image/jpeg';
    return 'data:$mimeType;base64,${base64Encode(bytes)}';
  }

  @override
  Future<String> saveCutoutPhoto(Uint8List bytes) async {
    return 'data:image/png;base64,${base64Encode(bytes)}';
  }
}
