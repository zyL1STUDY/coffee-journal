import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_route.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';

class RecordFlowDismissController {
  Future<void> Function()? _dismiss;

  Future<void> dismiss() {
    return _dismiss?.call() ?? Future<void>.value();
  }

  void _attach(Future<void> Function() dismiss) {
    _dismiss = dismiss;
  }

  void _detach(Future<void> Function() dismiss) {
    if (_dismiss == dismiss) {
      _dismiss = null;
    }
  }
}

class RecordOverlayScaffold extends StatefulWidget {
  const RecordOverlayScaffold({
    required this.child,
    required this.sheetTop,
    required this.sheetHeight,
    required this.borderRadius,
    this.dismissController,
    super.key,
  });

  final Widget child;
  final double sheetTop;
  final double sheetHeight;
  final BorderRadius borderRadius;
  final RecordFlowDismissController? dismissController;

  @override
  State<RecordOverlayScaffold> createState() => _RecordOverlayScaffoldState();
}

class _RecordOverlayScaffoldState extends State<RecordOverlayScaffold> {
  bool _isDismissing = false;

  @override
  void initState() {
    super.initState();
    widget.dismissController?._attach(_dismissToHome);
  }

  @override
  void didUpdateWidget(RecordOverlayScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dismissController != widget.dismissController) {
      oldWidget.dismissController?._detach(_dismissToHome);
      widget.dismissController?._attach(_dismissToHome);
    }
  }

  @override
  void dispose() {
    widget.dismissController?._detach(_dismissToHome);
    super.dispose();
  }

  Future<void> _dismissToHome() async {
    if (_isDismissing) {
      return;
    }

    setState(() => _isDismissing = true);
    await Future<void>.delayed(AppDimensions.recordDismissDuration);

    if (mounted) {
      context.go(AppRoute.home.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: AppDimensions.mobileViewportWidth,
        height: AppDimensions.mobileViewportHeight,
        child: Stack(
          children: [
            const _RecordHomeBackdrop(),
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: _isDismissing ? 0 : 1,
                duration: AppDimensions.recordDismissDuration,
                curve: Curves.easeInCubic,
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: _isDismissing ? 0 : 1,
                duration: AppDimensions.recordDismissDuration,
                curve: Curves.easeInCubic,
                child: const ColoredBox(color: AppColors.dimOverlay),
              ),
            ),
            AnimatedPositioned(
              duration: AppDimensions.recordDismissDuration,
              curve: Curves.easeInCubic,
              left: 0,
              top: _isDismissing
                  ? AppDimensions.mobileViewportHeight + 20
                  : widget.sheetTop,
              child: RecordSheet(
                height: widget.sheetHeight,
                borderRadius: widget.borderRadius,
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecordSheet extends StatelessWidget {
  const RecordSheet({
    required this.height,
    required this.borderRadius,
    required this.child,
    super.key,
  });

  final double height;
  final BorderRadius borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.recordSheetWidth,
      height: height,
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.recordSheetHorizontalPadding,
        AppDimensions.recordSheetTopPadding,
        AppDimensions.recordSheetHorizontalPadding,
        AppDimensions.recordSheetBottomPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: borderRadius,
        boxShadow: const [
          BoxShadow(
            color: AppColors.recordSheetShadow,
            blurRadius: 34,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: child,
    );
  }
}

class RecordHandle extends StatelessWidget {
  const RecordHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.recordHandleWidth,
      height: AppDimensions.recordHandleHeight,
      decoration: BoxDecoration(
        color: AppColors.sheetHandle,
        borderRadius: BorderRadius.circular(AppDimensions.recordHandleRadius),
      ),
    );
  }
}

class RecordHeader extends StatelessWidget {
  const RecordHeader({
    required this.title,
    required this.onBack,
    this.onCancel,
    super.key,
  });

  final String title;
  final VoidCallback onBack;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.recordContentWidth,
      height: AppDimensions.recordHeaderHeight,
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onBack,
            child: const SizedBox(
              width: 12,
              height: AppDimensions.recordHeaderHeight,
              child: Text('‹', style: AppTypography.recordBack),
            ),
          ),
          const SizedBox(width: AppDimensions.recordHeaderGap),
          Text(title, style: AppTypography.recordDetailTitle),
          const Spacer(),
          if (onCancel != null) RecordCancelButton(onTap: onCancel!),
        ],
      ),
    );
  }
}

class RecordCancelButton extends StatefulWidget {
  const RecordCancelButton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  State<RecordCancelButton> createState() => _RecordCancelButtonState();
}

class _RecordCancelButtonState extends State<RecordCancelButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapCancel: () => setState(() => _isPressed = false),
      onTapUp: (_) => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 130),
        curve: Curves.easeOutCubic,
        width: AppDimensions.recordCancelButtonSize,
        height: AppDimensions.recordCancelButtonSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _isPressed ? AppColors.surfaceTint : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.recordCancelButton),
        ),
        child: const Text('×', style: AppTypography.recordCancel),
      ),
    );
  }
}

class RecordOptionRow extends StatefulWidget {
  const RecordOptionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.height = AppDimensions.recordOptionHeight,
    super.key,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;
  final double height;

  @override
  State<RecordOptionRow> createState() => _RecordOptionRowState();
}

class _RecordOptionRowState extends State<RecordOptionRow> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isActive = _isHovered || _isPressed;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _isPressed = false;
      }),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapCancel: () => setState(() => _isPressed = false),
        onTapUp: (_) => setState(() => _isPressed = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 130),
          curve: Curves.easeOutCubic,
          scale: _isPressed ? 0.985 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOutCubic,
            width: AppDimensions.recordContentWidth,
            height: widget.height,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.recordOptionPaddingX,
            ),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.surfaceTint
                  : AppColors.recordOptionSurface,
              border: Border.all(
                color: isActive ? AppColors.primaryPressed : AppColors.outline,
              ),
              borderRadius: BorderRadius.circular(AppRadius.recordOption),
              boxShadow: [
                BoxShadow(
                  color: AppColors.recordOptionShadow,
                  blurRadius: isActive ? 12 : 6,
                  offset: Offset(0, isActive ? 7 : 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: AppDimensions.recordIconBubbleSize,
                  height: AppDimensions.recordIconBubbleSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.recordIconBubble,
                    borderRadius: BorderRadius.circular(AppRadius.recordChip),
                  ),
                  child: Text(widget.icon),
                ),
                const SizedBox(width: AppDimensions.recordOptionInternalGap),
                Expanded(
                  child: Text(
                    widget.label,
                    style: AppTypography.recordOptionLabel,
                  ),
                ),
                const Text('>', style: AppTypography.recordGentleNote),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecordSectionTitle extends StatelessWidget {
  const RecordSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.recordContentWidth,
      height: AppDimensions.recordSectionHeight,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: AppTypography.recordSectionTitle),
      ),
    );
  }
}

class RecordChip extends StatelessWidget {
  const RecordChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.width = AppDimensions.recordChipWidth,
    super.key,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: width,
        height: AppDimensions.recordChipHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectedChip : AppColors.unselectedChip,
          border: isSelected ? null : Border.all(color: AppColors.outline),
          borderRadius: BorderRadius.circular(AppRadius.recordChip),
        ),
        child: Text(
          label,
          style: AppTypography.recordChip.copyWith(
            color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class RecordTextField extends StatelessWidget {
  const RecordTextField({
    required this.controller,
    required this.hintText,
    this.readOnly = false,
    this.onTap,
    this.trailing,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.recordContentWidth,
      height: AppDimensions.recordFieldHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.recordFieldPaddingX,
      ),
      decoration: BoxDecoration(
        color: AppColors.recordOptionSurface,
        border: Border.all(color: AppColors.outline),
        borderRadius: BorderRadius.circular(AppRadius.recordField),
        boxShadow: const [
          BoxShadow(
            color: AppColors.recordOptionShadow,
            blurRadius: 6,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              cursorColor: AppColors.accent,
              style: AppTypography.recordField,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
                hintStyle: AppTypography.recordField,
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class RecordPhotoEntry extends StatelessWidget {
  const RecordPhotoEntry({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return RecordOptionRow(
      icon: '📷',
      label: '添加照片',
      height: AppDimensions.recordPhotoOptionHeight,
      onTap: onTap,
    );
  }
}

class RecordSaveButton extends StatelessWidget {
  const RecordSaveButton({
    required this.onTap,
    this.isEnabled = true,
    super.key,
  });

  final VoidCallback onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isEnabled ? onTap : null,
      child: Container(
        width: AppDimensions.recordContentWidth,
        height: AppDimensions.recordSaveButtonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.accent : AppColors.disabledButton,
          borderRadius: BorderRadius.circular(AppRadius.recordSaveButton),
          boxShadow: const [
            BoxShadow(
              color: AppColors.recordOptionShadow,
              blurRadius: 12,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Text(
          '保存这一杯',
          style: AppTypography.recordSaveButton.copyWith(
            color: isEnabled
                ? AppColors.background
                : AppColors.disabledButtonText,
          ),
        ),
      ),
    );
  }
}

class RecordDiscardDialog extends StatelessWidget {
  const RecordDiscardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: AppDimensions.recordDiscardDialogWidth,
        padding: const EdgeInsets.all(AppDimensions.recordDiscardDialogPadding),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.recordDiscardDialog),
          boxShadow: const [
            BoxShadow(
              color: AppColors.recordSheetShadow,
              blurRadius: 30,
              offset: Offset(0, 14),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('放弃这次记录？', style: AppTypography.recordDialogTitle),
            const SizedBox(height: 8),
            const Text(
              '已经填写的内容不会保存。',
              textAlign: TextAlign.center,
              style: AppTypography.recordDialogBody,
            ),
            const SizedBox(height: 20),
            _RecordDiscardAction(
              label: '继续记录',
              isPrimary: true,
              onTap: () => Navigator.of(context).pop(false),
            ),
            const SizedBox(height: AppDimensions.recordDiscardDialogActionGap),
            _RecordDiscardAction(
              label: '放弃',
              isPrimary: false,
              onTap: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecordDiscardAction extends StatefulWidget {
  const _RecordDiscardAction({
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  State<_RecordDiscardAction> createState() => _RecordDiscardActionState();
}

class _RecordDiscardActionState extends State<_RecordDiscardAction> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final background = widget.isPrimary
        ? AppColors.accent
        : AppColors.recordOptionSurface;
    final pressedBackground = widget.isPrimary
        ? AppColors.textSecondary
        : AppColors.surfaceTint;
    final textColor = widget.isPrimary
        ? AppColors.background
        : AppColors.textSecondary;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapCancel: () => setState(() => _isPressed = false),
      onTapUp: (_) => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 130),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        height: AppDimensions.recordDiscardDialogActionHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _isPressed ? pressedBackground : background,
          border: widget.isPrimary
              ? null
              : Border.all(color: AppColors.outline),
          borderRadius: BorderRadius.circular(
            AppRadius.recordDiscardDialogAction,
          ),
        ),
        child: Text(
          widget.label,
          style: AppTypography.recordSaveButton.copyWith(color: textColor),
        ),
      ),
    );
  }
}

class RecordStickerPreview extends StatelessWidget {
  const RecordStickerPreview({this.onChangeTap, super.key});

  static const assetPath = 'assets/images/home/coffee_sticker.png';

  final VoidCallback? onChangeTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.recordContentWidth,
      height: AppDimensions.recordPhotoPreviewHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: AppDimensions.recordPhotoPreviewSize,
            height: AppDimensions.recordPhotoPreviewSize,
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
                            assetPath,
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
                    assetPath,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ],
            ),
          ),
          if (onChangeTap != null)
            Positioned(
              top: AppDimensions.recordPhotoPreviewSize - 4,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onChangeTap,
                child: Container(
                  height: AppDimensions.recordPhotoChangeButtonHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.recordOptionSurface,
                    border: Border.all(color: AppColors.outline),
                    borderRadius: BorderRadius.circular(
                      AppRadius.recordPhotoChangeButton,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.recordOptionShadow,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    '更换照片',
                    style: AppTypography.recordGentleNote,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RecordHomeBackdrop extends StatelessWidget {
  const _RecordHomeBackdrop();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          left: 24,
          top: 36,
          child: Text('早安', style: AppTypography.greeting),
        ),
        const Positioned(
          left: 24,
          top: 78,
          child: Text('2026年6月26日\n星期五', style: AppTypography.date),
        ),
        Positioned(
          left: 24,
          top: 150,
          child: Container(
            width: AppDimensions.homeTodayCardWidth,
            height: AppDimensions.homeTodayCardHeight,
            decoration: const BoxDecoration(
              color: AppColors.homeTodayCard,
              borderRadius: AppRadius.todayCardBorder,
            ),
          ),
        ),
        const Positioned(
          left: 24,
          top: 415,
          child: Text('最近记录', style: AppTypography.sectionTitle),
        ),
        for (final top in const [452.0, 530.0, 608.0])
          Positioned(
            left: 24,
            top: top,
            child: Container(
              width: AppDimensions.homeCoffeeCardWidth,
              height: 68,
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.outline),
                borderRadius: AppRadius.cardBorder,
              ),
            ),
          ),
        const Positioned(
          left: 0,
          top: 762,
          child: ColoredBox(
            color: AppColors.bottomNavigation,
            child: SizedBox(
              width: AppDimensions.mobileViewportWidth,
              height: AppDimensions.bottomNavigationHeight,
            ),
          ),
        ),
      ],
    );
  }
}
