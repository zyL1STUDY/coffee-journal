import 'package:coffee_journal/app/coffee_journal_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('renders milestone zero app shell', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('今天'), findsOneWidget);
    expect(find.text('Journal'), findsOneWidget);
    expect(find.text('我的'), findsOneWidget);
  });
}
