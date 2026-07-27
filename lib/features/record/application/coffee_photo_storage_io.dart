import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'coffee_photo_storage.dart';

CoffeePhotoStorage createStorage() {
  return const FileCoffeePhotoStorage();
}

class FileCoffeePhotoStorage implements CoffeePhotoStorage {
  const FileCoffeePhotoStorage();

  @override
  Future<String> savePickedPhoto(XFile photo) async {
    final directory = await getApplicationDocumentsDirectory();
    final photoDirectory = await _ensurePhotoDirectory(directory.path);

    final extension = _extensionFor(photo.name);
    final fileName =
        'coffee_${DateTime.now().microsecondsSinceEpoch}$extension';
    final savedFile = File('${photoDirectory.path}/$fileName');

    await File(photo.path).copy(savedFile.path);
    return savedFile.path;
  }

  @override
  Future<String> saveCutoutPhoto(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final photoDirectory = await _ensurePhotoDirectory(directory.path);
    final fileName =
        'coffee_cutout_${DateTime.now().microsecondsSinceEpoch}.png';
    final savedFile = File('${photoDirectory.path}/$fileName');

    await savedFile.writeAsBytes(bytes, flush: true);
    return savedFile.path;
  }

  Future<Directory> _ensurePhotoDirectory(String documentsPath) async {
    final photoDirectory = Directory('$documentsPath/coffee_photos');
    if (!await photoDirectory.exists()) {
      await photoDirectory.create(recursive: true);
    }
    return photoDirectory;
  }

  String _extensionFor(String name) {
    final dotIndex = name.lastIndexOf('.');
    if (dotIndex == -1 || dotIndex == name.length - 1) {
      return '.jpg';
    }
    return name.substring(dotIndex);
  }
}
