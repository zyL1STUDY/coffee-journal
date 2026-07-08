import 'package:coffee_journal/app/coffee_journal_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('renders navigation and home foundation', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));

    expect(find.text('早安'), findsOneWidget);
    expect(find.text('星期五 · 6月26日'), findsOneWidget);
    expect(find.text('今天有点冷，\n热拿铁应该很舒服'), findsOneWidget);
    expect(find.text('记录一杯'), findsOneWidget);
    expect(find.text('最近的咖啡'), findsOneWidget);
    expect(find.text('晨间拿铁'), findsOneWidget);
    expect(find.text('手冲咖啡'), findsOneWidget);
    expect(find.text('冰美式'), findsOneWidget);
    expect(find.bySemanticsLabel('今天'), findsOneWidget);
    expect(find.bySemanticsLabel('Journal'), findsOneWidget);
    expect(find.bySemanticsLabel('我的'), findsOneWidget);
  });

  testWidgets('saves a brand record and returns home', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));

    await tester.tap(find.text('记录一杯'));
    await tester.pumpAndSettle();

    expect(find.text('选择来源'), findsOneWidget);
    expect(find.text('连锁品牌'), findsOneWidget);

    await tester.tap(find.text('连锁品牌'));
    await tester.pumpAndSettle();

    expect(find.text('选择品牌'), findsOneWidget);
    expect(find.text('保存这一杯'), findsOneWidget);

    await tester.tap(find.text('瑞幸'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '测试拿铁');
    await tester.tap(find.text('保存这一杯'));
    await tester.pumpAndSettle();

    expect(find.text('早安'), findsOneWidget);
    expect(find.text('测试拿铁'), findsOneWidget);
    expect(find.text('瑞幸 · 刚刚'), findsOneWidget);
  });

  testWidgets('save button is disabled until brand is selected', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));

    await tester.tap(find.text('记录一杯'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('连锁品牌'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('保存这一杯'));
    await tester.pumpAndSettle();

    expect(find.text('选择品牌'), findsOneWidget);
    expect(find.text('瑞幸 · 刚刚'), findsNothing);
  });

  testWidgets('cancel exits source choice directly', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));

    await tester.tap(find.text('记录一杯'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('×'));
    await tester.pump(const Duration(milliseconds: 260));
    await tester.pumpAndSettle();

    expect(find.text('早安'), findsOneWidget);
    expect(find.text('选择来源'), findsNothing);
  });

  testWidgets('canceling a draft asks before discarding', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));

    await tester.tap(find.text('记录一杯'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('连锁品牌'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('瑞幸'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('×'));
    await tester.pumpAndSettle();

    expect(find.text('放弃这次记录？'), findsOneWidget);

    await tester.tap(find.text('继续记录'));
    await tester.pumpAndSettle();

    expect(find.text('选择品牌'), findsOneWidget);

    await tester.tap(find.text('×'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('放弃'));
    await tester.pump(const Duration(milliseconds: 260));
    await tester.pumpAndSettle();

    expect(find.text('早安'), findsOneWidget);
    expect(find.text('选择品牌'), findsNothing);
  });

  testWidgets('photo preview appears at top after adding a photo', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));

    await tester.tap(find.text('记录一杯'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('连锁品牌'));
    await tester.pumpAndSettle();

    expect(find.text('选择品牌'), findsOneWidget);
    expect(find.text('照片（可选）'), findsOneWidget);
    expect(find.text('添加照片'), findsOneWidget);

    await tester.tap(find.text('添加照片'));
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsWidgets);
    expect(find.text('更换照片'), findsOneWidget);
    expect(find.text('照片（可选）'), findsNothing);
  });

  testWidgets('swipe actions can delete a recent coffee', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));

    expect(find.text('晨间拿铁'), findsOneWidget);

    await tester.drag(find.text('晨间拿铁'), const Offset(-160, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.text('删除').first);
    await tester.pumpAndSettle();

    expect(find.text('晨间拿铁'), findsNothing);
    expect(find.text('编辑'), findsNothing);
    expect(find.text('删除'), findsNothing);
  });
}
