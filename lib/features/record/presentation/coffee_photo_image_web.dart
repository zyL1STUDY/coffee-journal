import 'package:flutter/widgets.dart';

Widget buildImage(String photoUrl, {BoxFit fit = BoxFit.cover}) {
  if (photoUrl.startsWith('assets/')) {
    return Image.asset(photoUrl, fit: fit, filterQuality: FilterQuality.high);
  }

  return Image.network(photoUrl, fit: fit, filterQuality: FilterQuality.high);
}
