import 'package:coffee_journal/app/coffee_journal_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  Future<void> saveBrandRecord(
    WidgetTester tester, {
    String name = '测试拿铁',
  }) async {
    await tester.tap(find.text('记录一杯'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('连锁品牌'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('瑞幸'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, name);
    await tester.tap(find.text('保存这一杯'));
    await tester.pumpAndSettle();
  }

  testWidgets('renders navigation and home foundation', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));

    expect(find.text('早安'), findsOneWidget);
    expect(find.textContaining('星期'), findsOneWidget);
    expect(find.text('今天有点冷，\n热拿铁应该很舒服'), findsOneWidget);
    expect(find.text('记录一杯'), findsOneWidget);
    expect(find.text('最近的咖啡'), findsOneWidget);
    expect(find.text('还没有记录，今天从第一杯开始。'), findsOneWidget);
    expect(find.bySemanticsLabel('今天'), findsOneWidget);
    expect(find.bySemanticsLabel('Journal'), findsOneWidget);
    expect(find.bySemanticsLabel('我的'), findsOneWidget);
  });

  testWidgets('renders final profile page menu', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));

    await tester.tap(find.bySemanticsLabel('我的'));
    await tester.pumpAndSettle();

    expect(find.text('Profile'), findsNothing);
    expect(find.text('Coffee Journal'), findsOneWidget);
    expect(find.text('More than coffee. More than memories.'), findsOneWidget);
    expect(find.text('个人信息'), findsOneWidget);
    expect(find.text('语言'), findsOneWidget);
    expect(find.text('桌面小组件'), findsOneWidget);
    expect(find.text('数据与隐私'), findsOneWidget);
    expect(find.text('关于 Coffee Journal'), findsOneWidget);
    expect(find.text('Sticker 收藏'), findsNothing);
    expect(find.text('Coming Soon'), findsNothing);
    expect(find.text('版本MVP V1.0'), findsOneWidget);
  });

  testWidgets('opens profile detail pages', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));

    await tester.tap(find.bySemanticsLabel('我的'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('个人信息').first);
    await tester.pumpAndSettle();
    expect(find.text('Coffee Lover'), findsOneWidget);
    expect(find.text('累计记录杯数'), findsOneWidget);
    await tester.tap(find.text('‹'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('语言').first);
    await tester.pumpAndSettle();
    expect(find.text('简体中文'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Coming Soon'), findsOneWidget);
    await tester.tap(find.text('‹'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('桌面小组件').first);
    await tester.pumpAndSettle();
    expect(find.text('Small Widget'), findsNothing);
    expect(find.text('Medium Widget'), findsOneWidget);
    expect(find.text('如何添加到桌面'), findsOneWidget);
    await tester.tap(find.text('‹'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('数据与隐私').first);
    await tester.pumpAndSettle();
    expect(find.text('自动备份'), findsOneWidget);
    expect(find.text('隐私政策'), findsOneWidget);
    expect(find.text('用户协议'), findsOneWidget);
    await tester.tap(find.text('隐私政策'));
    await tester.pumpAndSettle();
    expect(find.text('匿名本地模式'), findsNothing);
    expect(find.textContaining('匿名本地模式'), findsOneWidget);
    await tester.tap(find.text('‹'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('用户协议'));
    await tester.pumpAndSettle();
    expect(find.textContaining('作品集展示'), findsOneWidget);
    await tester.tap(find.text('‹'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('‹'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('关于 Coffee Journal').first);
    await tester.pumpAndSettle();
    expect(find.text('Version MVP v1.0'), findsOneWidget);
    expect(find.text('Designed with Ziyu in Australia.'), findsOneWidget);
    expect(find.text('感谢使用 Coffee Journal，希望每一杯咖啡，都值得被记住。'), findsOneWidget);
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
    expect(find.textContaining('瑞幸 ·'), findsOneWidget);
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
    expect(find.textContaining('瑞幸 ·'), findsNothing);
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

    await saveBrandRecord(tester, name: '要删除的拿铁');

    expect(find.text('要删除的拿铁'), findsOneWidget);

    await tester.drag(find.text('要删除的拿铁'), const Offset(-160, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.text('删除').first);
    await tester.pumpAndSettle();

    expect(find.text('要删除的拿铁'), findsNothing);
    expect(find.text('编辑'), findsNothing);
    expect(find.text('删除'), findsNothing);
  });

  testWidgets('journal memory opens from a recorded date', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));

    await saveBrandRecord(tester);

    await tester.tap(find.bySemanticsLabel('Journal'));
    await tester.pumpAndSettle();

    expect(find.text(_currentMonthName()), findsOneWidget);
    expect(find.text('这个月的咖啡日记'), findsNothing);

    await tester.tapAt(_todayMemoryTapOffset());
    await tester.pumpAndSettle();

    expect(find.text('测试拿铁'), findsOneWidget);
    expect(find.text('我的记录'), findsOneWidget);
    expect(find.textContaining('瑞幸 · 连锁品牌'), findsOneWidget);

    await tester.tap(find.text('×'));
    await tester.pumpAndSettle();

    expect(find.text('测试拿铁'), findsNothing);
  });

  testWidgets('journal memory covers bottom navigation', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));

    await saveBrandRecord(tester);

    await tester.tap(find.bySemanticsLabel('Journal'));
    await tester.pumpAndSettle();
    await tester.tapAt(_todayMemoryTapOffset());
    await tester.pumpAndSettle();

    expect(find.text('测试拿铁'), findsOneWidget);

    await tester.tapAt(const Offset(195, 802));
    await tester.pumpAndSettle();

    expect(find.text('测试拿铁'), findsOneWidget);

    await tester.tap(find.text('×'));
    await tester.pumpAndSettle();

    expect(find.text('测试拿铁'), findsNothing);
    expect(find.text(_currentMonthName()), findsOneWidget);
  });
}

Offset _todayMemoryTapOffset() {
  final now = DateTime.now();
  final dayIndex = (now.day - 1) % 7;
  final weekIndex = (now.day - 1) ~/ 7;
  return Offset(59 + dayIndex * 45, 204 + weekIndex * 52);
}

String _currentMonthName() {
  const names = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return names[DateTime.now().month - 1];
}
