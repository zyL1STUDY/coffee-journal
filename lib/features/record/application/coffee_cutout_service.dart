import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../core/config/app_environment.dart';
import 'coffee_photo_storage.dart';
import 'coffee_photo_picker.dart';

final coffeeCutoutServiceProvider = Provider<CoffeeCutoutService>((ref) {
  return CoffeeCutoutService(
    apiKey: AppEnvironment.removeBgApiKey,
    storage: ref.read(coffeePhotoStorageProvider),
  );
});

class CoffeeCutoutService {
  const CoffeeCutoutService({required this.apiKey, required this.storage});

  static final _removeBgUri = Uri.parse('https://api.remove.bg/v1.0/removebg');

  final String? apiKey;
  final CoffeePhotoStorage storage;

  bool get canProcess => apiKey?.trim().isNotEmpty == true;

  Future<String?> createCutout(String photoUrl) async {
    if (!canProcess || photoUrl.startsWith('assets/')) {
      return null;
    }

    try {
      final request = http.MultipartRequest('POST', _removeBgUri)
        ..headers['X-Api-Key'] = apiKey!.trim()
        ..fields['size'] = 'preview'
        ..fields['format'] = 'png';

      final imageBytes = _bytesFromDataUrl(photoUrl);
      if (imageBytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'image_file',
            imageBytes,
            filename: 'coffee.jpg',
          ),
        );
      } else if (photoUrl.startsWith('http')) {
        request.fields['image_url'] = photoUrl;
      } else {
        request.files.add(
          await http.MultipartFile.fromPath('image_file', photoUrl),
        );
      }

      final response = await http.Response.fromStream(await request.send());
      if (response.statusCode != 200) {
        return null;
      }

      return storage.saveCutoutPhoto(response.bodyBytes);
    } catch (_) {
      return null;
    }
  }

  Uint8List? _bytesFromDataUrl(String value) {
    final marker = 'base64,';
    final index = value.indexOf(marker);
    if (!value.startsWith('data:') || index == -1) {
      return null;
    }
    return base64Decode(value.substring(index + marker.length));
  }
}
