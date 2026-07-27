import 'package:flutter/widgets.dart';

import 'coffee_photo_image_stub.dart'
    if (dart.library.html) 'coffee_photo_image_web.dart'
    if (dart.library.io) 'coffee_photo_image_io.dart';

Widget buildPlatformCoffeePhotoImage(
  String photoUrl, {
  BoxFit fit = BoxFit.cover,
}) {
  return buildImage(photoUrl, fit: fit);
}
