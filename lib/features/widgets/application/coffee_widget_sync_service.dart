import 'package:flutter/services.dart';

import '../../../core/constants/home_ai_copy.dart';
import '../../record/domain/coffee_record.dart';

class CoffeeWidgetSyncService {
  const CoffeeWidgetSyncService._();

  static const _channel = MethodChannel('coffee_journal/widget_sync');

  static Future<void> syncLatest(CoffeeRecord? record) async {
    final payload = record == null
        ? <String, Object?>{}
        : <String, Object?>{
            'name': _displayName(record),
            'time': _formatTime(record.createdAt),
            'aiMessage': HomeAiCopy.widgetSentence,
          };

    try {
      await _channel.invokeMethod<void>('syncLatestCoffee', payload);
    } on MissingPluginException {
      // Non-iOS platforms and widget tests do not provide the native bridge.
    }
  }

  static String _displayName(CoffeeRecord record) {
    final drinkName = record.drinkName?.trim();
    if (drinkName != null && drinkName.isNotEmpty) {
      return drinkName;
    }
    return record.sourceName;
  }

  static String _formatTime(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
