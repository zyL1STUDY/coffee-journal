import 'package:flutter/widgets.dart';

import 'coffee_photo_image_impl.dart';

Widget buildCoffeePhotoImage(String photoUrl, {BoxFit fit = BoxFit.cover}) {
  return buildPlatformCoffeePhotoImage(photoUrl, fit: fit);
}
