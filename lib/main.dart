import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/coffee_journal_app.dart';
import 'shared/widgets/mobile_app_frame.dart';

void main() {
  runApp(const ProviderScope(child: MobileAppFrame(child: CoffeeJournalApp())));
}
