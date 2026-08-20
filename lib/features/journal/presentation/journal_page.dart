import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_route.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/ai_prompt_formatter.dart';
import '../../../shared/widgets/app_paper_background.dart';
import '../../../shared/widgets/latte_glass_card.dart';
import '../../../shared/widgets/liquid_glass_prompt_card.dart';
import '../../../shared/widgets/typing_prompt_text.dart';
import '../../record/application/coffee_photo_assets.dart';
import '../../record/application/coffee_record_repository.dart';
import '../../record/domain/coffee_record.dart';
import '../../record/presentation/coffee_photo_image.dart';
import '../../record/presentation/record_flow_widgets.dart';

class JournalPage extends ConsumerStatefulWidget {
  const JournalPage({super.key});

  @override
  ConsumerState<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends ConsumerState<JournalPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _coffeeDropController;
  Route<void>? _memorySheetRoute;
  bool _wasTickerEnabled = false;
  bool _isMemorySheetOpen = false;

  @override
  void initState() {
    super.initState();
    _coffeeDropController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1350),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isTickerEnabled = TickerMode.valuesOf(context).enabled;

    if (isTickerEnabled && !_wasTickerEnabled) {
      _playCoffeeDrop();
    }

    if (!isTickerEnabled && _isMemorySheetOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _isMemorySheetOpen) {
          _removeMemorySheetImmediately();
        }
      });
    }

    _wasTickerEnabled = isTickerEnabled;
  }

  @override
  void dispose() {
    _coffeeDropController.dispose();
    super.dispose();
  }

  Future<void> _playCoffeeDrop() async {
    _coffeeDropController.value = 0;
    await Future<void>.delayed(const Duration(milliseconds: 280));

    if (mounted) {
      _coffeeDropController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final activeRecords = [
      for (final record in ref.watch(coffeeRecordRepositoryProvider))
        if (!record.isDeleted &&
            record.createdAt.year == now.year &&
            record.createdAt.month == now.month)
          record,
    ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final memories = _buildMemories(activeRecords, now);

    return AppPaperBackground(
      child: SizedBox(
        width: AppDimensions.mobileViewportWidth,
        height: AppDimensions.journalContentHeight,
        child: Stack(
          children: [
            Positioned(
              left: 36,
              top: AppDimensions.journalTitleTop,
              width: 128,
              height: AppDimensions.journalTitleHeight,
              child: _JournalPeriodButton(
                label: _monthName(now.month),
                semanticLabel: '选择月份',
                style: AppTypography.journalMonthTitle,
              ),
            ),
            Positioned(
              left: 252,
              top: AppDimensions.journalSubtitleTop,
              width: 112,
              height: AppDimensions.journalSubtitleHeight,
              child: _JournalPeriodButton(
                label: '${now.year}.${now.month.toString().padLeft(2, '0')}',
                semanticLabel: '选择年份月份',
                style: AppTypography.journalMonthSubtitle,
              ),
            ),
            Positioned(
              left: AppDimensions.journalCalendarLeft,
              top: AppDimensions.journalCalendarTop,
              child: LatteGlassCard(
                width: AppDimensions.journalCalendarWidth,
                height: AppDimensions.journalCalendarHeight,
                child: _JournalCalendar(
                  memories: memories,
                  month: now,
                  dropAnimation: _coffeeDropController,
                  onMemoryTap: (memory) => _showCoffeeMemory(context, memory),
                ),
              ),
            ),
            Positioned(
              left: AppDimensions.journalStatsLeft,
              top: AppDimensions.journalStatsTop,
              width: AppDimensions.journalStatsWidth,
              height: AppDimensions.journalStatsHeight,
              child: _JournalStatsRow(records: activeRecords),
            ),
            Positioned(
              left: AppDimensions.journalSummaryLeft,
              top: AppDimensions.journalSummaryTop,
              width: AppDimensions.journalSummaryWidth,
              height: AppDimensions.journalSummaryHeight,
              child: _JournalMonthlySummary(records: activeRecords),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCoffeeMemory(
    BuildContext context,
    _JournalMemory memory,
  ) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    final route = PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.transparent,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: AppDimensions.recordDismissDuration,
      reverseTransitionDuration: AppDimensions.recordDismissDuration,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Material(
          type: MaterialType.transparency,
          child: _CoffeeMemoryOverlay(memory: memory),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );

    _memorySheetRoute = route;
    _isMemorySheetOpen = true;
    await navigator.push(route);

    if (mounted && identical(_memorySheetRoute, route)) {
      _memorySheetRoute = null;
      _isMemorySheetOpen = false;
    }
  }

  void _removeMemorySheetImmediately() {
    final route = _memorySheetRoute;
    if (route == null) {
      return;
    }

    _memorySheetRoute = null;
    _isMemorySheetOpen = false;

    if (route.isActive) {
      route.navigator?.removeRoute(route);
    }
  }
}

class _CoffeeMemoryOverlay extends StatelessWidget {
  const _CoffeeMemoryOverlay({required this.memory});

  final _JournalMemory memory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.mobileViewportWidth,
      height: AppDimensions.mobileViewportHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                child: const ColoredBox(color: AppColors.dimOverlay),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top:
                AppDimensions.mobileViewportHeight -
                AppDimensions.memorySheetHeight,
            child: _CoffeeMemorySheet(memory: memory),
          ),
        ],
      ),
    );
  }
}

class _JournalStatsRow extends StatelessWidget {
  const _JournalStatsRow({required this.records});

  final List<CoffeeRecord> records;

  @override
  Widget build(BuildContext context) {
    final sourceCount = records
        .map((record) => record.sourceName)
        .toSet()
        .length;
    final streak = _recordingStreak(records);

    return Row(
      children: [
        _JournalStatItem(value: '${records.length}杯', label: '本月咖啡'),
        const SizedBox(width: AppDimensions.journalStatGap),
        _JournalStatItem(value: '$sourceCount家', label: '去过店铺'),
        const SizedBox(width: AppDimensions.journalStatGap),
        _JournalStatItem(value: '$streak天', label: '连续记录'),
      ],
    );
  }
}

class _JournalStatItem extends StatelessWidget {
  const _JournalStatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.journalStatItemWidth,
      height: AppDimensions.journalStatsHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            textAlign: TextAlign.center,
            style: AppTypography.journalStatValue,
          ),
          const SizedBox(height: 5),
          Text(label, style: AppTypography.journalStatLabel),
        ],
      ),
    );
  }
}

class _JournalMonthlySummary extends StatelessWidget {
  const _JournalMonthlySummary({required this.records});

  final List<CoffeeRecord> records;

  @override
  Widget build(BuildContext context) {
    final summary = records.isEmpty
        ? '记录一杯后，这里会慢慢长出你的咖啡月历。'
        : '这个月已经留下 ${records.length} 杯咖啡记忆。';

    return LiquidGlassPromptCard(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: TypingPromptText(
            text: AiPromptFormatter.lineBreakAfterComma(summary),
            style: AppTypography.journalSummary,
          ),
        ),
      ),
    );
  }
}

class _JournalPeriodButton extends StatelessWidget {
  const _JournalPeriodButton({
    required this.label,
    required this.semanticLabel,
    required this.style,
  });

  final String label;
  final String semanticLabel;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(label, style: style),
        ),
      ),
    );
  }
}

class _JournalCalendar extends StatelessWidget {
  const _JournalCalendar({
    required this.memories,
    required this.month,
    required this.dropAnimation,
    required this.onMemoryTap,
  });

  final Map<int, _JournalMemory> memories;
  final DateTime month;
  final Animation<double> dropAnimation;
  final ValueChanged<_JournalMemory> onMemoryTap;

  static const _weekdays = ['一', '二', '三', '四', '五', '六', '日'];

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final weekRows = _weekRows(daysInMonth);

    return Padding(
      padding: const EdgeInsets.only(
        left: AppDimensions.journalCalendarGridLeft,
        top: AppDimensions.journalCalendarGridTop,
      ),
      child: SizedBox(
        width: AppDimensions.journalCalendarGridWidth,
        height: AppDimensions.journalCalendarGridHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            for (var index = 0; index < _weekdays.length; index++)
              Positioned(
                left: _dayLeft(index),
                top: 0,
                width: AppDimensions.journalDayWidth,
                height: AppDimensions.journalWeekdayHeight,
                child: Text(
                  _weekdays[index],
                  textAlign: TextAlign.center,
                  style: AppTypography.journalWeekday,
                ),
              ),
            for (var weekIndex = 0; weekIndex < weekRows.length; weekIndex++)
              Positioned(
                left: 0,
                top:
                    AppDimensions.journalFirstWeekTop +
                    weekIndex *
                        (AppDimensions.journalDayHeight +
                            AppDimensions.journalRowGap),
                width: _weekRowWidth(weekRows[weekIndex].length),
                height: AppDimensions.journalDayHeight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (
                      var dayIndex = 0;
                      dayIndex < weekRows[weekIndex].length;
                      dayIndex++
                    ) ...[
                      SizedBox(
                        width: AppDimensions.journalDayWidth,
                        height: AppDimensions.journalDayHeight,
                        child: _JournalDayCell(
                          day: weekRows[weekIndex][dayIndex],
                          memory: memories[weekRows[weekIndex][dayIndex]],
                          month: month,
                          dropAnimation: dropAnimation,
                          onMemoryTap: onMemoryTap,
                        ),
                      ),
                      if (dayIndex != weekRows[weekIndex].length - 1)
                        const SizedBox(width: AppDimensions.journalColumnGap),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  static double _dayLeft(int column) {
    return column *
        (AppDimensions.journalDayWidth + AppDimensions.journalColumnGap);
  }

  static double _weekRowWidth(int dayCount) {
    return dayCount * AppDimensions.journalDayWidth +
        (dayCount - 1) * AppDimensions.journalColumnGap;
  }

  static List<List<int>> _weekRows(int daysInMonth) {
    final rows = <List<int>>[];
    for (var firstDay = 1; firstDay <= daysInMonth; firstDay += 7) {
      final lastDay = (firstDay + 6).clamp(1, daysInMonth);
      rows.add([for (var day = firstDay; day <= lastDay; day++) day]);
    }
    return rows;
  }
}

class _JournalDayCell extends StatelessWidget {
  const _JournalDayCell({
    required this.day,
    required this.memory,
    required this.month,
    required this.dropAnimation,
    required this.onMemoryTap,
  });

  final int day;
  final _JournalMemory? memory;
  final DateTime month;
  final Animation<double> dropAnimation;
  final ValueChanged<_JournalMemory> onMemoryTap;

  @override
  Widget build(BuildContext context) {
    final hasMemory = memory != null;
    final isToday = memory?.isToday ?? false;

    return Semantics(
      button: hasMemory,
      label: hasMemory ? '${month.month}月$day日咖啡记忆' : '${month.month}月$day日',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: hasMemory ? () => onMemoryTap(memory!) : null,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (isToday)
              Positioned(
                left: 7.571428298950195,
                top: -3,
                width: 24,
                height: 24,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.journalTodayHighlight,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            Positioned(
              left: 0,
              top: 0,
              width: AppDimensions.journalDayWidth,
              height: 18,
              child: Text(
                '$day',
                textAlign: TextAlign.center,
                style: isToday
                    ? AppTypography.journalToday
                    : AppTypography.journalDay,
              ),
            ),
            if (hasMemory)
              Positioned(
                left:
                    (AppDimensions.journalDayWidth -
                        AppDimensions.journalStickerSize) /
                    2,
                top: AppDimensions.journalStickerTop,
                width: AppDimensions.journalStickerSize,
                height: AppDimensions.journalStickerSize,
                child: _CoffeeDropIn(
                  animation: dropAnimation,
                  order: memory!.order,
                  child: _CalendarCoffeeSticker(
                    photoUrl: memory!.record.displayPhotoUrl,
                  ),
                ),
              ),
            if (hasMemory && memory!.count > 1)
              Positioned(
                left: AppDimensions.journalDayWidth - 14,
                top: -4,
                width: AppDimensions.journalBadgeSize,
                height: AppDimensions.journalBadgeSize,
                child: _MemoryCountBadge(count: memory!.count),
              ),
            if (isToday)
              const Positioned(
                left: 0,
                top: 34,
                width: AppDimensions.journalDayWidth,
                height: 10,
                child: Text(
                  '今天',
                  textAlign: TextAlign.center,
                  style: AppTypography.journalTodayLabel,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CalendarCoffeeSticker extends StatelessWidget {
  const _CalendarCoffeeSticker({this.photoUrl});

  static const _assetPath = CoffeePhotoAssets.fallbackStickerPath;

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: Transform.translate(
            offset: const Offset(0.5, 1.2),
            child: ImageFiltered(
              imageFilter: ui.ImageFilter.blur(sigmaX: 1.2, sigmaY: 1.2),
              child: Opacity(
                opacity: 0.22,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    AppColors.coffeeStickerShadow,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(_assetPath, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.coffeeStickerShadow,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: AppColors.coffeeStickerOutline,
                width: 1.6,
              ),
            ),
            child: ClipOval(
              child: buildCoffeePhotoImage(
                photoUrl ?? _assetPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CoffeeDropIn extends StatelessWidget {
  const _CoffeeDropIn({
    required this.animation,
    required this.order,
    required this.child,
  });

  final Animation<double> animation;
  final int order;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final start = order * 0.08;
    final end = (start + 0.64).clamp(0.0, 1.0);
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Interval(start, end, curve: Curves.bounceOut),
    );

    return AnimatedBuilder(
      animation: curvedAnimation,
      child: child,
      builder: (context, child) {
        final value = curvedAnimation.value;
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, -92 * (1 - value)),
            child: Transform.scale(scale: 0.72 + (0.28 * value), child: child),
          ),
        );
      },
    );
  }
}

class _MemoryCountBadge extends StatelessWidget {
  const _MemoryCountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.journalBadgeSurface,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: AppColors.coffeeStickerShadow,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Center(child: Text('$count', style: AppTypography.journalBadge)),
    );
  }
}

class _CoffeeMemorySheet extends ConsumerWidget {
  const _CoffeeMemorySheet({required this.memory});

  final _JournalMemory memory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = memory.record;
    final drinkName = record.drinkName?.trim();
    final note = record.note?.trim();
    final title = drinkName == null || drinkName.isEmpty
        ? record.sourceName
        : drinkName;
    final aiMessage = record.aiMessage?.trim().isNotEmpty == true
        ? record.aiMessage!.trim()
        : CoffeeRecordRepository.fallbackAiMessage;

    return SizedBox(
      width: AppDimensions.mobileViewportWidth,
      height: AppDimensions.memorySheetHeight,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.recordStartSheet),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.recordSheetShadow,
              blurRadius: 34,
              offset: Offset(0, -10),
            ),
          ],
        ),
        child: Stack(
          children: [
            const Positioned(
              left: 156,
              top: 16,
              width: AppDimensions.memoryHandleWidth,
              height: AppDimensions.memoryHandleHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.memoryHandle,
                  borderRadius: BorderRadius.all(Radius.circular(99)),
                ),
              ),
            ),
            Positioned(
              right: 26,
              top: 14,
              width: AppDimensions.recordCancelButtonSize,
              height: AppDimensions.recordCancelButtonSize,
              child: RecordCancelButton(
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              left:
                  (AppDimensions.mobileViewportWidth -
                      AppDimensions.memoryStickerWidth) /
                  2,
              top: AppDimensions.memoryStickerTop,
              width: AppDimensions.memoryStickerWidth,
              height: AppDimensions.memoryStickerHeight,
              child: _MemoryCoffeeSticker(photoUrl: record.displayPhotoUrl),
            ),
            Positioned(
              left: 30,
              top: AppDimensions.memoryDrinkTop,
              width: 330,
              height: AppDimensions.memoryDrinkHeight,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppTypography.memoryDrinkName,
              ),
            ),
            Positioned(
              left: 30,
              top: AppDimensions.memoryMetaTop,
              width: 330,
              height: AppDimensions.memoryMetaHeight,
              child: Text(
                '${record.sourceName} · ${record.sourceType.title} · ${_formatMemoryDate(record.createdAt)}',
                textAlign: TextAlign.center,
                style: AppTypography.memorySource,
              ),
            ),
            Positioned(
              left:
                  (AppDimensions.mobileViewportWidth -
                      AppDimensions.memoryAiWidth) /
                  2,
              top: AppDimensions.memoryAiTop,
              width: AppDimensions.memoryAiWidth,
              height: AppDimensions.memoryAiHeight,
              child: LiquidGlassPromptCard(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TypingPromptText(
                      text: AiPromptFormatter.lineBreakAfterComma(aiMessage),
                      style: AppTypography.memoryAiMessage,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24,
              top: AppDimensions.memoryNoteTop,
              width: 342,
              height: AppDimensions.memoryNoteHeight,
              child: _MemoryNoteCard(
                note: note == null || note.isEmpty ? '还没有备注。' : note,
              ),
            ),
            Positioned(
              left: 24,
              top: AppDimensions.memoryActionTop,
              width: AppDimensions.memoryActionWidth,
              height: AppDimensions.memoryActionHeight,
              child: _MemoryActionButton(
                label: '编辑',
                onTap: () {
                  Navigator.of(context).pop();
                  context.go(_editPath(record));
                },
              ),
            ),
            Positioned(
              left: 208,
              top: AppDimensions.memoryActionTop,
              width: AppDimensions.memoryActionWidth,
              height: AppDimensions.memoryActionHeight,
              child: _MemoryActionButton(
                label: '删除',
                onTap: () async {
                  final shouldDelete = await _confirmDelete(context);
                  if (shouldDelete == true && context.mounted) {
                    ref
                        .read(coffeeRecordRepositoryProvider.notifier)
                        .delete(record.id);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemoryCoffeeSticker extends StatelessWidget {
  const _MemoryCoffeeSticker({this.photoUrl});

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final imagePath = photoUrl ?? CoffeePhotoAssets.fallbackStickerPath;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned.fill(
          child: Transform.translate(
            offset: const Offset(
              AppDimensions.homeCoffeeStickerShadowOffsetX,
              AppDimensions.homeCoffeeStickerShadowOffsetY,
            ),
            child: ImageFiltered(
              imageFilter: ui.ImageFilter.blur(
                sigmaX: AppDimensions.homeCoffeeStickerShadowBlur,
                sigmaY: AppDimensions.homeCoffeeStickerShadowBlur,
              ),
              child: Opacity(
                opacity: 0.18,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    AppColors.coffeeStickerShadow,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    CoffeePhotoAssets.fallbackStickerPath,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: buildCoffeePhotoImage(
            imagePath,
            fit: imagePath == CoffeePhotoAssets.fallbackStickerPath
                ? BoxFit.contain
                : BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class _MemoryNoteCard extends StatelessWidget {
  const _MemoryNoteCard({required this.note});

  final String note;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('我的记录', style: AppTypography.memoryNoteTitle),
            const SizedBox(height: 8),
            Text(
              note,
              textAlign: TextAlign.center,
              style: AppTypography.memoryNoteBody,
            ),
          ],
        ),
      ),
    );
  }
}

class _MemoryActionButton extends StatelessWidget {
  const _MemoryActionButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.22),
          border: Border.all(color: AppColors.outline.withValues(alpha: 0.58)),
          borderRadius: BorderRadius.circular(AppRadius.memoryAction),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.memoryAction.copyWith(
              color: AppColors.journalMonthLabel.withValues(alpha: 0.88),
            ),
          ),
        ),
      ),
    );
  }
}

class _JournalMemory {
  const _JournalMemory({
    required this.day,
    required this.records,
    required this.order,
    this.isToday = false,
  });

  final int day;
  final List<CoffeeRecord> records;
  final int order;
  final bool isToday;

  int get count => records.length;

  CoffeeRecord get record => records.first;
}

Map<int, _JournalMemory> _buildMemories(
  List<CoffeeRecord> records,
  DateTime month,
) {
  final grouped = <int, List<CoffeeRecord>>{};
  for (final record in records) {
    grouped.putIfAbsent(record.createdAt.day, () => []).add(record);
  }

  var order = 0;
  final today = DateTime.now();
  final result = <int, _JournalMemory>{};
  for (final day in grouped.keys.toList()..sort()) {
    final dayRecords = grouped[day]!
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    result[day] = _JournalMemory(
      day: day,
      records: dayRecords,
      order: order++,
      isToday:
          today.year == month.year &&
          today.month == month.month &&
          today.day == day,
    );
  }
  return result;
}

String _monthName(int month) {
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
  return names[month - 1];
}

int _recordingStreak(List<CoffeeRecord> records) {
  if (records.isEmpty) {
    return 0;
  }

  final days =
      records
          .map((record) {
            final createdAt = record.createdAt;
            return DateTime(createdAt.year, createdAt.month, createdAt.day);
          })
          .toSet()
          .toList()
        ..sort((a, b) => b.compareTo(a));

  var streak = 1;
  for (var index = 1; index < days.length; index++) {
    final expected = days[index - 1].subtract(const Duration(days: 1));
    if (days[index] != expected) {
      break;
    }
    streak++;
  }
  return streak;
}

String _formatMemoryDate(DateTime value) {
  final month = value.month.toString();
  final day = value.day.toString();
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  return '${value.year}年$month月$day日 $hour:$minute';
}

String _editPath(CoffeeRecord record) {
  final basePath = switch (record.sourceType) {
    CoffeeSourceType.brand => AppRoute.brandRecord.path,
    CoffeeSourceType.cafe => AppRoute.cafeRecord.path,
    CoffeeSourceType.homemade => AppRoute.homemadeRecord.path,
  };
  return '$basePath?editId=${record.id}';
}

Future<bool?> _confirmDelete(BuildContext context) {
  return showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: '删除咖啡记忆',
    barrierColor: Colors.black.withValues(alpha: 0.18),
    transitionDuration: const Duration(milliseconds: 180),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Container(
          width: AppDimensions.recordDiscardDialogWidth,
          padding: const EdgeInsets.all(
            AppDimensions.recordDiscardDialogPadding,
          ),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppRadius.recordField),
            boxShadow: const [
              BoxShadow(
                color: AppColors.recordSheetShadow,
                blurRadius: 24,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('删除这杯咖啡？', style: AppTypography.recordDialogTitle),
              const SizedBox(height: 10),
              const Text(
                '删除后会从最近记录和 Journal 中移除。',
                textAlign: TextAlign.center,
                style: AppTypography.recordGentleNote,
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _DeleteDialogAction(
                      label: '取消',
                      onTap: () => Navigator.of(context).pop(false),
                    ),
                  ),
                  const SizedBox(
                    width: AppDimensions.recordDiscardDialogActionGap,
                  ),
                  Expanded(
                    child: _DeleteDialogAction(
                      label: '删除',
                      isDestructive: true,
                      onTap: () => Navigator.of(context).pop(true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.98, end: 1).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class _DeleteDialogAction extends StatelessWidget {
  const _DeleteDialogAction({
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: AppDimensions.recordDiscardDialogActionHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDestructive
              ? AppColors.homeDeleteActionSurface
              : AppColors.surfaceTint,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Text(
          label,
          style: AppTypography.recordDialogTitle.copyWith(
            color: isDestructive
                ? AppColors.homeDeleteActionText
                : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
