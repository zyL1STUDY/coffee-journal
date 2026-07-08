import 'package:coffee_journal/app/coffee_journal_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('renders navigation and home foundation', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));

    expect(find.text('早上好'), findsOneWidget);
    expect(find.text('7月8日 星期三'), findsOneWidget);
    expect(find.text('今天还没有记录咖啡'), findsOneWidget);
    expect(find.text('+ 记录一杯'), findsOneWidget);
    expect(find.text('最近的咖啡'), findsOneWidget);
    expect(find.text('还没有最近记录'), findsOneWidget);
    expect(find.text('今天'), findsOneWidget);
    expect(find.text('Journal'), findsOneWidget);
    expect(find.text('我的'), findsOneWidget);
  });
}
