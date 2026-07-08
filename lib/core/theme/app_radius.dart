import 'package:flutter/material.dart';

class AppRadius {
  const AppRadius._();

  static const small = 8.0;
  static const medium = 12.0;
  static const card = 18.0;
  static const large = 20.0;
  static const pill = 999.0;

  static const button = BorderRadius.all(Radius.circular(medium));
  static const cardBorder = BorderRadius.all(Radius.circular(card));
}
