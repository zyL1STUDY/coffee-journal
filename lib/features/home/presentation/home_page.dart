import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/home_ai_copy.dart';
import '../../../core/router/app_route.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/ai_prompt_formatter.dart';
import '../../record/application/coffee_record_repository.dart';
import '../../record/domain/coffee_record.dart';
import '../../../shared/widgets/app_paper_background.dart';
import '../../../shared/widgets/liquid_glass_prompt_card.dart';
import '../../../shared/widgets/primary_action_button.dart';
import '../../../shared/widgets/typing_prompt_text.dart';

class _CoffeePreview {
  const _CoffeePreview({
    required this.id,
    required this.sourceType,
    required this.name,
    required this.meta,
  });

  factory _CoffeePreview.fromRecord(CoffeeRecord record) {
    final drinkName = record.drinkName?.trim();
    return _CoffeePreview(
      id: record.id,
      sourceType: record.sourceType,
      name: drinkName == null || drinkName.isEmpty
          ? record.sourceName
          : drinkName,
      meta: record.note?.trim().isNotEmpty == true
          ? record.note!.trim()
          : '${record.sourceName} · ${_formatRecordTime(record.createdAt)}',
    );
  }

  final String id;
  final CoffeeSourceType sourceType;
  final String name;
  final String meta;
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedRecords = ref.watch(coffeeRecordRepositoryProvider);
    final coffees = [
      for (final record in savedRecords)
        if (!record.isDeleted) _CoffeePreview.fromRecord(record),
    ];

    return SizedBox(
      width: AppDimensions.homeContentWidth,
      height: AppDimensions.homeContentHeight,
      child: AppPaperBackground(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.homeContentHorizontalPadding,
              AppDimensions.homeContentTopPadding,
              AppDimensions.homeContentHorizontalPadding,
              AppDimensions.homeContentBottomPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HomeHeader(),
                const SizedBox(height: AppDimensions.homeHeaderToTodayCardGap),
                _HomePrimaryPanel(
                  onRecordPressed: () => context.go(AppRoute.record.path),
                ),
                const SizedBox(
                  height: AppDimensions.homeButtonToRecentTitleGap,
                ),
                _RecentCoffeeSection(coffees: coffees),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeBackdropPreview extends StatelessWidget {
  const HomeBackdropPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: AppDimensions.homeContentWidth,
      height: AppDimensions.homeContentHeight,
      child: AppPaperBackground(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppDimensions.homeContentHorizontalPadding,
            AppDimensions.homeContentTopPadding,
            AppDimensions.homeContentHorizontalPadding,
            AppDimensions.homeContentBottomPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HomeHeader(),
              SizedBox(height: AppDimensions.homeHeaderToTodayCardGap),
              _HomePrimaryPanel(),
              SizedBox(height: AppDimensions.homeButtonToRecentTitleGap),
              Text('最近的咖啡', style: AppTypography.homeRecentSectionTitle),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('早安', style: AppTypography.greeting),
        const SizedBox(height: 6),
        Text(_formatTodayLabel(DateTime.now()), style: AppTypography.date),
      ],
    );
  }
}

class _HomePrimaryPanel extends StatelessWidget {
  const _HomePrimaryPanel({this.onRecordPressed});

  final VoidCallback? onRecordPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.homePrimaryPanelWidth,
      child: Column(
        children: [
          const _TodayCard(),
          const SizedBox(height: AppDimensions.homeTodayCardToButtonGap),
          _RecordCoffeeButton(onPressed: onRecordPressed),
        ],
      ),
    );
  }
}

class _TodayCard extends StatelessWidget {
  const _TodayCard();

  @override
  Widget build(BuildContext context) {
    final formattedSentence = AiPromptFormatter.lineBreakAfterComma(
      HomeAiCopy.sentence,
    );

    return SizedBox(
      width: AppDimensions.homeTodayCardWidth,
      height: AppDimensions.homeTodayCardHeight,
      child: LiquidGlassPromptCard(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.homeTodayCardPaddingLeft,
            AppDimensions.homeTodayCardPaddingTop,
            AppDimensions.homeTodayCardPaddingRight,
            AppDimensions.homeTodayCardPaddingBottom,
          ),
          child: SizedBox(
            height: AppDimensions.homeTodayCardCopyHeight,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppDimensions.homeTodayCardTextTop,
                ),
                child: TypingPromptText(
                  text: formattedSentence,
                  style: AppTypography.todayCardSentence,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RecordCoffeeButton extends StatelessWidget {
  const _RecordCoffeeButton({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppDimensions.homeRecordButtonWidth,
        child: PrimaryActionButton(label: '记录一杯', onPressed: onPressed),
      ),
    );
  }
}

class _RecentCoffeeSection extends ConsumerWidget {
  const _RecentCoffeeSection({required this.coffees});

  final List<_CoffeePreview> coffees;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('最近的咖啡', style: AppTypography.homeRecentSectionTitle),
        const SizedBox(height: AppDimensions.homeRecentTitleToCardGap),
        if (coffees.isEmpty)
          const _RecentCoffeeEmptyState()
        else
          for (var index = 0; index < coffees.length; index++) ...[
            _SwipeableRecentCoffeeTile(
              key: ValueKey(coffees[index].id),
              coffee: coffees[index],
              onEdit: () => context.go(_editPath(coffees[index])),
              onDelete: () => ref
                  .read(coffeeRecordRepositoryProvider.notifier)
                  .delete(coffees[index].id),
            ),
            if (index != coffees.length - 1)
              const SizedBox(height: AppDimensions.homeRecentCardGap),
          ],
      ],
    );
  }

  String _editPath(_CoffeePreview coffee) {
    final basePath = switch (coffee.sourceType) {
      CoffeeSourceType.brand => AppRoute.brandRecord.path,
      CoffeeSourceType.cafe => AppRoute.cafeRecord.path,
      CoffeeSourceType.homemade => AppRoute.homemadeRecord.path,
    };
    return '$basePath?editId=${coffee.id}';
  }
}

class _RecentCoffeeEmptyState extends StatelessWidget {
  const _RecentCoffeeEmptyState();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.homeCoffeeCardWidth,
      height: 42,
      child: const Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          '还没有记录，今天从第一杯开始。',
          textAlign: TextAlign.center,
          style: AppTypography.homeEmptyHint,
        ),
      ),
    );
  }
}

class _SwipeableRecentCoffeeTile extends StatefulWidget {
  const _SwipeableRecentCoffeeTile({
    required this.coffee,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final _CoffeePreview coffee;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  State<_SwipeableRecentCoffeeTile> createState() =>
      _SwipeableRecentCoffeeTileState();
}

class _SwipeableRecentCoffeeTileState
    extends State<_SwipeableRecentCoffeeTile> {
  static const _actionRevealWidth = 132.0;
  double _dragOffset = 0;

  bool get _isOpen => _dragOffset > _actionRevealWidth / 2;

  @override
  void didUpdateWidget(covariant _SwipeableRecentCoffeeTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.coffee.id != widget.coffee.id) {
      _dragOffset = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: (details) {
        setState(() {
          _dragOffset = (_dragOffset - details.delta.dx).clamp(
            0,
            _actionRevealWidth,
          );
        });
      },
      onHorizontalDragEnd: (_) {
        setState(() {
          _dragOffset = _isOpen ? _actionRevealWidth : 0;
        });
      },
      child: SizedBox(
        width: AppDimensions.homeCoffeeCardWidth,
        height: AppDimensions.homeCoffeeCardHeight,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerRight,
          children: [
            _CoffeeTileActions(
              revealProgress: _dragOffset / _actionRevealWidth,
              onEdit: widget.onEdit,
              onDelete: () {
                setState(() {
                  _dragOffset = 0;
                });
                widget.onDelete();
              },
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              transform: Matrix4.translationValues(-_dragOffset, 0, 0),
              child: _RecentCoffeeTile(coffee: widget.coffee),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoffeeTileActions extends StatelessWidget {
  const _CoffeeTileActions({
    required this.revealProgress,
    required this.onEdit,
    required this.onDelete,
  });

  final double revealProgress;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final progress = revealProgress.clamp(0.0, 1.0);
    if (progress == 0) {
      return const SizedBox.shrink();
    }

    return Positioned(
      right: 0,
      child: Opacity(
        opacity: progress,
        child: Transform.scale(
          scale: 0.92 + progress * 0.08,
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              _CoffeeActionPill(label: '编辑', onTap: onEdit),
              const SizedBox(width: AppDimensions.homeCoffeeActionGap),
              _CoffeeActionPill(
                label: '删除',
                isDestructive: true,
                onTap: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoffeeActionPill extends StatelessWidget {
  const _CoffeeActionPill({
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
        width: AppDimensions.homeCoffeeActionWidth,
        height: AppDimensions.homeCoffeeActionHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDestructive
              ? AppColors.homeDeleteActionSurface
              : AppColors.homeEditActionSurface,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          boxShadow: const [
            BoxShadow(
              color: AppColors.recordOptionShadow,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Text(
          label,
          style: AppTypography.homeCoffeeAction.copyWith(
            color: isDestructive
                ? AppColors.homeDeleteActionText
                : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _RecentCoffeeTile extends StatelessWidget {
  const _RecentCoffeeTile({required this.coffee});

  final _CoffeePreview coffee;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.homeCoffeeCardWidth,
      height: AppDimensions.homeCoffeeCardHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.paperSurface,
                border: Border.all(color: AppColors.paperSurfaceBorder),
                borderRadius: AppRadius.cardBorder,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.paperSurfaceShadow,
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            left: AppDimensions.homeCoffeeStickerLeftOffset,
            top: AppDimensions.homeCoffeeStickerTopOffset,
            child: _CoffeeSticker(),
          ),
          Positioned(
            left: AppDimensions.homeCoffeeCardContentLeftPadding,
            top: AppDimensions.homeCoffeeCardContentTopPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(coffee.name, style: AppTypography.coffeeCardTitle),
                const SizedBox(height: AppDimensions.homeCoffeeCardTextGap),
                Text(coffee.meta, style: AppTypography.coffeeCardMeta),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CoffeeSticker extends StatelessWidget {
  const _CoffeeSticker();

  @override
  Widget build(BuildContext context) {
    const sticker = 'assets/images/home/coffee_sticker.png';

    return SizedBox(
      width: AppDimensions.homeCoffeeStickerWidth,
      height: AppDimensions.homeCoffeeStickerHeight,
      child: Stack(
        clipBehavior: Clip.none,
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
                  opacity: 0.2,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      AppColors.coffeeStickerShadow,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      sticker,
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
              sticker,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
        ],
      ),
    );
  }
}

String _formatTodayLabel(DateTime value) {
  const weekdays = ['一', '二', '三', '四', '五', '六', '日'];
  final weekday = weekdays[value.weekday - 1];
  final month = value.month.toString().padLeft(2, '0');
  final day = value.day.toString().padLeft(2, '0');
  return '星期$weekday · $month.$day';
}

String _formatRecordTime(DateTime value) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final recordDay = DateTime(value.year, value.month, value.day);
  final time =
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

  if (recordDay == today) {
    return time;
  }
  if (recordDay == today.subtract(const Duration(days: 1))) {
    return '昨天';
  }
  return '${value.month}.${value.day}';
}
