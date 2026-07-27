import 'dart:io';

import 'package:flutter/widgets.dart';

Widget buildImage(String photoUrl, {BoxFit fit = BoxFit.cover}) {
  if (photoUrl.startsWith('assets/')) {
    return Image.asset(photoUrl, fit: fit, filterQuality: FilterQuality.high);
  }

  if (photoUrl.startsWith('http') || photoUrl.startsWith('data:')) {
    return Image.network(photoUrl, fit: fit, filterQuality: FilterQuality.high);
  }

  return Image.file(
    File(photoUrl),
    fit: fit,
    filterQuality: FilterQuality.high,
  );
}
