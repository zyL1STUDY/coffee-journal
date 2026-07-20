import 'package:flutter/material.dart';

class AppRadius {
  const AppRadius._();

  static const small = 8.0;
  static const medium = 12.0;
  static const card = 22.0;
  static const todayCard = 30.0;
  static const recordStartSheet = 34.0;
  static const recordDetailSheet = 36.0;
  static const recordOption = 30.0;
  static const recordField = 24.0;
  static const recordChip = 19.0;
  static const recordSaveButton = 29.0;
  static const recordPhotoChangeButton = 16.0;
  static const recordCancelButton = 16.0;
  static const recordDiscardDialog = 26.0;
  static const recordDiscardDialogAction = 22.0;
  static const latteGlass = 26.0;
  static const journalDay = 8.0;
  static const memoryNote = 18.0;
  static const memoryAction = 23.0;
  static const widgetSmall = 24.0;
  static const widgetMedium = 24.0;
  static const large = 20.0;
  static const deviceFrame = 36.0;
  static const pill = 999.0;

  static const button = BorderRadius.all(Radius.circular(25));
  static const cardBorder = BorderRadius.all(Radius.circular(card));
  static const todayCardBorder = BorderRadius.all(Radius.circular(todayCard));
  static const recordStartSheetBorder = BorderRadius.vertical(
    top: Radius.circular(recordStartSheet),
  );
  static const recordDetailSheetBorder = BorderRadius.vertical(
    top: Radius.circular(recordDetailSheet),
  );
}
