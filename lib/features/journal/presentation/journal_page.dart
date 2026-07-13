import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ai_candy_glass_card.dart';
import '../../../shared/widgets/latte_glass_card.dart';
import '../../record/presentation/record_flow_widgets.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage>
    with SingleTickerProviderStateMixin {
  static const _memories = <int, _JournalMemory>{
    3: _JournalMemory(day: 3, count: 1, order: 0, isToday: true),
    8: _JournalMemory(day: 8, count: 2, order: 1),
    14: _JournalMemory(day: 14, count: 1, order: 2),
    21: _JournalMemory(day: 21, count: 3, order: 3),
    26: _JournalMemory(day: 26, count: 1, order: 4),
  };

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
    return ColoredBox(
      color: AppColors.background,
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
                label: 'June',
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
                label: '2026.06',
                semanticLabel: '选择年份月份',
                style: AppTypography.journalMonthSubtitle,
              ),
            ),
            const Positioned(
              left: 48,
              top: AppDimensions.journalDescriptionTop,
              width: 294,
              height: AppDimensions.journalDescriptionHeight,
              child: Text(
                '这个月的咖啡日记',
                textAlign: TextAlign.left,
                style: AppTypography.journalDescription,
              ),
            ),
            Positioned(
              left: AppDimensions.journalCalendarLeft,
              top: AppDimensions.journalCalendarTop,
              child: LatteGlassCard(
                width: AppDimensions.journalCalendarWidth,
                height: AppDimensions.journalCalendarHeight,
                child: _JournalCalendar(
                  memories: _memories,
                  dropAnimation: _coffeeDropController,
                  onMemoryTap: (memory) => _showCoffeeMemory(context, memory),
                ),
              ),
            ),
            const Positioned(
              left: AppDimensions.journalStatsLeft,
              top: AppDimensions.journalStatsTop,
              width: AppDimensions.journalStatsWidth,
              height: AppDimensions.journalStatsHeight,
              child: _JournalStatsRow(),
            ),
            const Positioned(
              left: AppDimensions.journalSummaryLeft,
              top: AppDimensions.journalSummaryTop,
              width: AppDimensions.journalSummaryWidth,
              height: AppDimensions.journalSummaryHeight,
              child: _JournalMonthlySummary(),
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
  const _JournalStatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _JournalStatItem(value: '18杯', label: '本月咖啡'),
        SizedBox(width: AppDimensions.journalStatGap),
        _JournalStatItem(value: '6家', label: '去过店铺'),
        SizedBox(width: AppDimensions.journalStatGap),
        _JournalStatItem(value: '5天', label: '连续记录'),
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
  const _JournalMonthlySummary();

  @override
  Widget build(BuildContext context) {
    return AiCandyGlassCard(
      radius: AppRadius.card,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            '最近开始更喜欢独立咖啡店了。',
            textAlign: TextAlign.center,
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
    required this.dropAnimation,
    required this.onMemoryTap,
  });

  final Map<int, _JournalMemory> memories;
  final Animation<double> dropAnimation;
  final ValueChanged<_JournalMemory> onMemoryTap;

  static const _weekdays = ['一', '二', '三', '四', '五', '六', '日'];

  @override
  Widget build(BuildContext context) {
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
            for (var day = 1; day <= 30; day++)
              Positioned(
                left: _dayLeft((day - 1) % 7),
                top:
                    AppDimensions.journalFirstWeekTop +
                    ((day - 1) ~/ 7) *
                        (AppDimensions.journalDayHeight +
                            AppDimensions.journalRowGap),
                width: AppDimensions.journalDayWidth,
                height: AppDimensions.journalDayHeight,
                child: _JournalDayCell(
                  day: day,
                  memory: memories[day],
                  dropAnimation: dropAnimation,
                  onMemoryTap: onMemoryTap,
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
}

class _JournalDayCell extends StatelessWidget {
  const _JournalDayCell({
    required this.day,
    required this.memory,
    required this.dropAnimation,
    required this.onMemoryTap,
  });

  final int day;
  final _JournalMemory? memory;
  final Animation<double> dropAnimation;
  final ValueChanged<_JournalMemory> onMemoryTap;

  @override
  Widget build(BuildContext context) {
    final hasMemory = memory != null;
    final isToday = memory?.isToday ?? false;

    return Semantics(
      button: hasMemory,
      label: hasMemory ? '6月$day日咖啡记忆' : '6月$day日',
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
                  child: const _CalendarCoffeeSticker(),
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
  const _CalendarCoffeeSticker();

  static const _assetPath = 'assets/images/home/coffee_sticker.png';

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
              child: Image.asset(
                _assetPath,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
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

class _CoffeeMemorySheet extends StatelessWidget {
  const _CoffeeMemorySheet({required this.memory});

  final _JournalMemory memory;

  @override
  Widget build(BuildContext context) {
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
            const Positioned(
              left:
                  (AppDimensions.mobileViewportWidth -
                      AppDimensions.memoryStickerWidth) /
                  2,
              top: AppDimensions.memoryStickerTop,
              width: AppDimensions.memoryStickerWidth,
              height: AppDimensions.memoryStickerHeight,
              child: _MemoryCoffeeSticker(),
            ),
            const Positioned(
              left: 30,
              top: AppDimensions.memoryDrinkTop,
              width: 330,
              height: AppDimensions.memoryDrinkHeight,
              child: Text(
                '热拿铁',
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
                '蓝瓶 · 独立咖啡店 · 2026年6月${memory.day}日 15:38',
                textAlign: TextAlign.center,
                style: AppTypography.memorySource,
              ),
            ),
            const Positioned(
              left:
                  (AppDimensions.mobileViewportWidth -
                      AppDimensions.memoryAiWidth) /
                  2,
              top: AppDimensions.memoryAiTop,
              width: AppDimensions.memoryAiWidth,
              height: AppDimensions.memoryAiHeight,
              child: AiCandyGlassCard(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      '今天有点冷，这杯热拿铁刚刚好。',
                      textAlign: TextAlign.center,
                      style: AppTypography.memoryAiMessage,
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 24,
              top: AppDimensions.memoryNoteTop,
              width: 342,
              height: AppDimensions.memoryNoteHeight,
              child: _MemoryNoteCard(),
            ),
            const Positioned(
              left: 24,
              top: AppDimensions.memoryActionTop,
              width: AppDimensions.memoryActionWidth,
              height: AppDimensions.memoryActionHeight,
              child: _MemoryActionButton(label: '编辑'),
            ),
            const Positioned(
              left: 208,
              top: AppDimensions.memoryActionTop,
              width: AppDimensions.memoryActionWidth,
              height: AppDimensions.memoryActionHeight,
              child: _MemoryActionButton(label: '删除'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemoryCoffeeSticker extends StatelessWidget {
  const _MemoryCoffeeSticker();

  @override
  Widget build(BuildContext context) {
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
                    'assets/images/home/coffee_sticker.png',
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Image.asset(
            'assets/images/home/coffee_sticker.png',
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
      ],
    );
  }
}

class _MemoryNoteCard extends StatelessWidget {
  const _MemoryNoteCard();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('我的记录', style: AppTypography.memoryNoteTitle),
            SizedBox(height: 8),
            Text(
              '和朋友逛街时买的，拿在手里很暖。',
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
  const _MemoryActionButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
    );
  }
}

class _JournalMemory {
  const _JournalMemory({
    required this.day,
    required this.count,
    required this.order,
    this.isToday = false,
  });

  final int day;
  final int count;
  final int order;
  final bool isToday;
}
