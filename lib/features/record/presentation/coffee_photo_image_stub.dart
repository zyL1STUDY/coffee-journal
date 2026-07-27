import 'package:flutter/widgets.dart';

import '../application/coffee_photo_assets.dart';

Widget buildImage(String photoUrl, {BoxFit fit = BoxFit.cover}) {
  return Image.asset(CoffeePhotoAssets.fallbackStickerPath, fit: fit);
}
