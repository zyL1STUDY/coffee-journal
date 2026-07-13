import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_route.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/latte_glass_card.dart';
import '../../record/application/coffee_record_repository.dart';
import '../../record/domain/coffee_record.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const _items = [
    _ProfileMenuItemData(
      label: '个人信息',
      icon: _ProfileMenuIcon.person,
      route: AppRoute.profileInfo,
    ),
    _ProfileMenuItemData(
      label: '语言',
      icon: _ProfileMenuIcon.language,
      route: AppRoute.profileLanguage,
    ),
    _ProfileMenuItemData(
      label: '桌面小组件',
      icon: _ProfileMenuIcon.widget,
      route: AppRoute.profileWidgets,
    ),
    _ProfileMenuItemData(
      label: '数据与隐私',
      icon: _ProfileMenuIcon.privacy,
      route: AppRoute.profilePrivacy,
    ),
    _ProfileMenuItemData(
      label: '关于 Coffee Journal',
      icon: _ProfileMenuIcon.about,
      route: AppRoute.profileAbout,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: SizedBox(
        width: AppDimensions.profileContentWidth,
        height: AppDimensions.profileContentHeight,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.profileContentHorizontalPadding,
            AppDimensions.profileContentTopPadding,
            AppDimensions.profileContentHorizontalPadding,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ProfileBrand(),
              const SizedBox(height: AppDimensions.profileBrandToMenuGap),
              const _ProfileMenu(items: _items),
              const SizedBox(height: AppDimensions.profileVersionTopGap),
              const Center(
                child: Text('版本MVP V1.0', style: AppTypography.profileVersion),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileBrand extends StatelessWidget {
  const _ProfileBrand();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppDimensions.profileBrandNameHeight,
          child: Text('Coffee Journal', style: AppTypography.profileBrandName),
        ),
        SizedBox(height: AppDimensions.profileBrandLineGap),
        SizedBox(
          height: AppDimensions.profileBrandSloganHeight,
          child: Text(
            'More than coffee. More than memories.',
            style: AppTypography.profileBrandSlogan,
          ),
        ),
      ],
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  const _ProfileMenu({required this.items});

  final List<_ProfileMenuItemData> items;

  @override
  Widget build(BuildContext context) {
    return LatteGlassCard(
      width: AppDimensions.profileMenuWidth,
      height: AppDimensions.profileMenuHeight,
      borderRadius: AppRadius.latteGlass,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.profileMenuPaddingX,
          vertical: AppDimensions.profileMenuPaddingY,
        ),
        child: Column(
          children: [
            for (var index = 0; index < items.length; index++) ...[
              _ProfileMenuItem(item: items[index]),
              if (index != items.length - 1)
                const SizedBox(height: AppDimensions.profileMenuItemGap),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({required this.item});

  final _ProfileMenuItemData item;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: item.label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.push(item.route.path),
        child: SizedBox(
          width: AppDimensions.profileMenuItemWidth,
          height: AppDimensions.profileMenuItemHeight,
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Row(
              children: [
                SizedBox(
                  width: AppDimensions.profileMenuIconSlot,
                  height: AppDimensions.profileMenuIconSlot,
                  child: Center(
                    child: SizedBox(
                      width: AppDimensions.profileMenuIconSize,
                      height: AppDimensions.profileMenuIconSize,
                      child: CustomPaint(
                        painter: _ProfileMenuIconPainter(icon: item.icon),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: AppDimensions.profileMenuLabelWidth,
                  child: Text(
                    item.label,
                    style: AppTypography.profileMenuLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                const SizedBox(
                  width: AppDimensions.profileChevronWidth,
                  child: Text('›', style: AppTypography.profileChevron),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileMenuItemData {
  const _ProfileMenuItemData({
    required this.label,
    required this.icon,
    required this.route,
  });

  final String label;
  final _ProfileMenuIcon icon;
  final AppRoute route;
}

enum _ProfileMenuIcon { person, language, widget, privacy, about }

class _ProfileMenuIconPainter extends CustomPainter {
  const _ProfileMenuIconPainter({required this.icon});

  final _ProfileMenuIcon icon;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / AppDimensions.profileMenuIconSize;
    canvas.save();
    canvas.scale(scale, scale);

    switch (icon) {
      case _ProfileMenuIcon.person:
        _paintPerson(canvas);
      case _ProfileMenuIcon.language:
        _paintLanguage(canvas);
      case _ProfileMenuIcon.widget:
        _paintWidget(canvas);
      case _ProfileMenuIcon.privacy:
        _paintPrivacy(canvas);
      case _ProfileMenuIcon.about:
        _paintAbout(canvas);
    }

    canvas.restore();
  }

  void _paintPerson(Canvas canvas) {
    final stroke = _stroke(1.7);

    canvas.drawCircle(const Offset(11, 6.4), 3.3, stroke);
    final body = Path()
      ..moveTo(4.8, 19)
      ..cubicTo(5.7, 14.8, 8, 12.8, 11, 12.8)
      ..cubicTo(14, 12.8, 16.3, 14.8, 17.2, 19);
    canvas.drawPath(body, stroke);
  }

  void _paintLanguage(Canvas canvas) {
    final stroke = _stroke(1.6);

    canvas.drawCircle(const Offset(11, 11), 8, stroke);
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(11, 11), width: 7, height: 16),
      stroke,
    );
    canvas.drawLine(const Offset(3, 11), const Offset(19, 11), stroke);
    canvas.drawLine(const Offset(5, 7), const Offset(17, 7), stroke);
    canvas.drawLine(const Offset(5, 15), const Offset(17, 15), stroke);
  }

  void _paintWidget(Canvas canvas) {
    final stroke = _stroke(1.6);
    const radius = Radius.circular(2.5);
    const cells = [
      Rect.fromLTWH(4, 4, 5.5, 5.5),
      Rect.fromLTWH(12.5, 4, 5.5, 5.5),
      Rect.fromLTWH(4, 12.5, 5.5, 5.5),
      Rect.fromLTWH(12.5, 12.5, 5.5, 5.5),
    ];

    for (final rect in cells) {
      canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), stroke);
    }
  }

  void _paintPrivacy(Canvas canvas) {
    final stroke = _stroke(1.7);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(5, 9.2, 12, 9.8),
        const Radius.circular(3),
      ),
      stroke,
    );
    final shackle = Path()
      ..moveTo(7.2, 9.2)
      ..lineTo(7.2, 7.3)
      ..cubicTo(7.2, 4.8, 8.8, 3.2, 11, 3.2)
      ..cubicTo(13.2, 3.2, 14.8, 4.8, 14.8, 7.3)
      ..lineTo(14.8, 9.2);
    canvas.drawPath(shackle, stroke);
    canvas.drawLine(const Offset(11, 13), const Offset(11, 15.5), stroke);
  }

  void _paintAbout(Canvas canvas) {
    final stroke = _stroke(1.7);
    final fill = Paint()
      ..color = AppColors.textSecondary
      ..style = PaintingStyle.fill;

    canvas.drawCircle(const Offset(11, 11), 8, stroke);
    canvas.drawCircle(const Offset(11, 7), 1, fill);
    canvas.drawLine(const Offset(11, 10.5), const Offset(11, 15.5), stroke);
  }

  Paint _stroke(double width) {
    return Paint()
      ..color = AppColors.textSecondary
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
  }

  @override
  bool shouldRepaint(covariant _ProfileMenuIconPainter oldDelegate) {
    return oldDelegate.icon != icon;
  }
}

class ProfileInfoPage extends ConsumerStatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  ConsumerState<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends ConsumerState<ProfileInfoPage> {
  late final TextEditingController _nicknameController;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(text: 'Coffee Lover');
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final records = ref.watch(coffeeRecordRepositoryProvider);
    final activeRecords = [
      for (final record in records)
        if (!record.isDeleted) record,
    ];

    return _ProfileDetailScaffold(
      title: '个人信息',
      children: [
        LatteGlassCard(
          width: AppDimensions.profileDetailCardWidth,
          child: Padding(
            padding: const EdgeInsets.all(
              AppDimensions.profileDetailCardPadding,
            ),
            child: Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: const _CoffeeAvatar(),
                ),
                const SizedBox(height: 6),
                const Text('点击可修改头像', style: AppTypography.profileDetailMeta),
                const SizedBox(height: 14),
                _ProfileTextField(label: '昵称', controller: _nicknameController),
                const SizedBox(height: 12),
                const Divider(height: 1, color: AppColors.latteGlassBorder),
                _ProfileDetailRow(
                  data: const _ProfileDetailRowData(
                    title: '加入 Coffee Journal 时间',
                    trailing: '2026.06',
                  ),
                ),
                const Divider(height: 1, color: AppColors.latteGlassBorder),
                _ProfileDetailRow(
                  data: _ProfileDetailRowData(
                    title: '累计记录杯数',
                    trailing: '${activeRecords.length} 杯',
                  ),
                ),
                const Divider(height: 1, color: AppColors.latteGlassBorder),
                _ProfileDetailRow(
                  data: _ProfileDetailRowData(
                    title: '连续记录天数',
                    trailing: '${_recordingStreak(activeRecords)} 天',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
}

class ProfileLanguagePage extends StatelessWidget {
  const ProfileLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileDetailScaffold(
      title: '语言',
      children: [
        _ProfileListCard(
          rows: [
            _ProfileDetailRowData(
              title: '简体中文',
              trailing: '当前',
              isSelected: true,
            ),
            _ProfileDetailRowData(
              title: 'English',
              trailing: 'Coming Soon',
              isDisabled: true,
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileWidgetsPage extends StatelessWidget {
  const ProfileWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _ProfileDetailScaffold(
      title: '桌面小组件',
      children: [
        LatteGlassCard(
          width: AppDimensions.profileDetailCardWidth,
          child: Padding(
            padding: const EdgeInsets.all(
              AppDimensions.profileDetailCardPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Small Widget',
                  style: AppTypography.profileDetailSectionTitle,
                ),
                SizedBox(height: 12),
                Center(child: _SmallWidgetPreview()),
                SizedBox(height: 16),
                Divider(height: 1, color: AppColors.latteGlassBorder),
                SizedBox(height: 16),
                Text(
                  'Medium Widget',
                  style: AppTypography.profileDetailSectionTitle,
                ),
                SizedBox(height: 12),
                Center(child: _MediumWidgetPreview()),
                SizedBox(height: 16),
                Divider(height: 1, color: AppColors.latteGlassBorder),
                _ProfileDetailRow(
                  data: _ProfileDetailRowData(title: '如何添加到桌面', trailing: '›'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProfilePrivacyPage extends StatefulWidget {
  const ProfilePrivacyPage({super.key});

  @override
  State<ProfilePrivacyPage> createState() => _ProfilePrivacyPageState();
}

class _ProfilePrivacyPageState extends State<ProfilePrivacyPage> {
  bool _autoBackup = false;

  @override
  Widget build(BuildContext context) {
    return _ProfileDetailScaffold(
      title: '数据与隐私',
      children: [
        LatteGlassCard(
          width: AppDimensions.profileDetailCardWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.profileDetailCardPadding,
              vertical: 8,
            ),
            child: Column(
              children: [
                _ProfileSwitchRow(
                  title: '自动备份',
                  value: _autoBackup,
                  onChanged: (value) => setState(() => _autoBackup = value),
                ),
                const Divider(height: 1, color: AppColors.latteGlassBorder),
                const _ProfileDetailRow(
                  data: _ProfileDetailRowData(
                    title: '导出数据',
                    trailing: 'Coming Soon',
                    isDisabled: true,
                  ),
                ),
                const Divider(height: 1, color: AppColors.latteGlassBorder),
                const _ProfileDetailRow(
                  data: _ProfileDetailRowData(title: '隐私政策', trailing: '›'),
                ),
                const Divider(height: 1, color: AppColors.latteGlassBorder),
                const _ProfileDetailRow(
                  data: _ProfileDetailRowData(title: '用户协议', trailing: '›'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileAboutPage extends StatelessWidget {
  const ProfileAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileDetailScaffold(
      title: '关于 Coffee Journal',
      children: [
        LatteGlassCard(
          width: AppDimensions.profileDetailCardWidth,
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.profileDetailCardPadding),
            child: Column(
              children: [
                _CoffeeLogoMark(size: 72),
                SizedBox(height: 12),
                Text('Coffee Journal', style: AppTypography.profileBrandName),
                SizedBox(height: 6),
                Text(
                  'More than coffee. More than memories.',
                  textAlign: TextAlign.center,
                  style: AppTypography.profileDetailBody,
                ),
                SizedBox(height: 14),
                Text(
                  'Version MVP v1.0',
                  style: AppTypography.profileDetailMeta,
                ),
                SizedBox(height: 4),
                Text(
                  'Designed with ☕ in Australia.',
                  style: AppTypography.profileDetailMeta,
                ),
                SizedBox(height: 16),
                Divider(height: 1, color: AppColors.latteGlassBorder),
                SizedBox(height: 14),
                Text(
                  '感谢使用 Coffee Journal，希望每一杯咖啡，都值得被记住。',
                  textAlign: TextAlign.center,
                  style: AppTypography.profileDetailBody,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileDetailScaffold extends StatelessWidget {
  const _ProfileDetailScaffold({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SizedBox(
          width: AppDimensions.mobileViewportWidth,
          height: AppDimensions.mobileViewportHeight,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.profileDetailHorizontalPadding,
              AppDimensions.profileDetailTopPadding,
              AppDimensions.profileDetailHorizontalPadding,
              32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProfileDetailHeader(title: title),
                const SizedBox(
                  height: AppDimensions.profileDetailHeaderToContentGap,
                ),
                for (var index = 0; index < children.length; index++) ...[
                  children[index],
                  if (index != children.length - 1)
                    const SizedBox(height: AppDimensions.profileDetailCardGap),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileDetailHeader extends StatelessWidget {
  const _ProfileDetailHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.profileDetailCardWidth,
      height: AppDimensions.profileDetailHeaderHeight,
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRoute.profile.path);
              }
            },
            child: const SizedBox(
              width: AppDimensions.profileDetailBackSize,
              height: AppDimensions.profileDetailBackSize,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('‹', style: AppTypography.profileDetailBack),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: AppTypography.profileDetailTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTextField extends StatelessWidget {
  const _ProfileTextField({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.profileDetailMeta),
        const SizedBox(height: 8),
        Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.latteGlassHighlight,
            borderRadius: BorderRadius.circular(AppRadius.memoryNote),
            border: Border.all(
              color: AppColors.latteGlassBorder.withAlpha(120),
            ),
          ),
          child: TextField(
            controller: controller,
            maxLines: 1,
            cursorColor: AppColors.accent,
            style: AppTypography.profileMenuLabel,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isCollapsed: true,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileListCard extends StatelessWidget {
  const _ProfileListCard({required this.rows});

  final List<_ProfileDetailRowData> rows;

  @override
  Widget build(BuildContext context) {
    return LatteGlassCard(
      width: AppDimensions.profileDetailCardWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.profileDetailCardPadding,
          vertical: 8,
        ),
        child: Column(
          children: [
            for (var index = 0; index < rows.length; index++) ...[
              _ProfileDetailRow(data: rows[index]),
              if (index != rows.length - 1)
                const Divider(height: 1, color: AppColors.latteGlassBorder),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProfileDetailRow extends StatelessWidget {
  const _ProfileDetailRow({required this.data});

  final _ProfileDetailRowData data;

  @override
  Widget build(BuildContext context) {
    final titleStyle = AppTypography.profileMenuLabel.copyWith(
      color: data.isDisabled ? AppColors.textMuted : AppColors.textPrimary,
    );

    return SizedBox(
      height: AppDimensions.profileDetailRowHeight,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(data.title, style: titleStyle)],
            ),
          ),
          if (data.isSelected)
            const _SelectedDot()
          else if (data.trailing != null)
            Text(
              data.trailing!,
              style: data.trailing == '›'
                  ? AppTypography.profileChevron
                  : AppTypography.profileDetailMeta.copyWith(
                      color: data.isDisabled
                          ? AppColors.textMuted
                          : AppColors.textSecondary,
                      fontSize: data.isDisabled ? 12 : null,
                    ),
            ),
        ],
      ),
    );
  }
}

class _ProfileDetailRowData {
  const _ProfileDetailRowData({
    required this.title,
    this.trailing,
    this.isSelected = false,
    this.isDisabled = false,
  });

  final String title;
  final String? trailing;
  final bool isSelected;
  final bool isDisabled;
}

class _ProfileSwitchRow extends StatelessWidget {
  const _ProfileSwitchRow({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.profileDetailRowHeight,
      child: Row(
        children: [
          Expanded(child: Text(title, style: AppTypography.profileMenuLabel)),
          Transform.scale(
            scale: 0.74,
            alignment: Alignment.centerRight,
            child: Switch(
              value: value,
              activeThumbColor: AppColors.textSecondary,
              activeTrackColor: AppColors.primarySoft,
              inactiveThumbColor: AppColors.surface,
              inactiveTrackColor: AppColors.latteGlassBorder,
              trackOutlineColor: WidgetStateProperty.all(
                AppColors.latteGlassBorder,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedDot extends StatelessWidget {
  const _SelectedDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: const BoxDecoration(
        color: AppColors.primarySoft72,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            color: AppColors.accent,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _CoffeeAvatar extends StatelessWidget {
  const _CoffeeAvatar();

  @override
  Widget build(BuildContext context) {
    return const _CoffeeLogoMark(size: AppDimensions.profileAvatarSize);
  }
}

class _CoffeeLogoMark extends StatelessWidget {
  const _CoffeeLogoMark({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primarySoft,
        shape: BoxShape.circle,
      ),
      child: Text(
        '☕',
        style: TextStyle(
          fontSize: size * 0.36,
          height: 1,
          color: AppColors.accent,
          fontFamilyFallback: AppTypography.fontFamilyFallback,
        ),
      ),
    );
  }
}

class _SmallWidgetPreview extends StatelessWidget {
  const _SmallWidgetPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.profileWidgetSmallSize,
      height: AppDimensions.profileWidgetSmallSize,
      padding: const EdgeInsets.all(14),
      decoration: _widgetDecoration(AppRadius.recordField),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              _CoffeeLogoMark(size: 28),
              Spacer(),
              Text('Today', style: AppTypography.profileDetailMeta),
            ],
          ),
          const Spacer(),
          const Text('1', style: AppTypography.profileWidgetValue),
          const SizedBox(height: 2),
          const Text('杯咖啡', style: AppTypography.profileDetailSectionTitle),
          const SizedBox(height: 8),
          Container(
            width: 58,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.primarySoft72,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
          ),
        ],
      ),
    );
  }
}

class _MediumWidgetPreview extends StatelessWidget {
  const _MediumWidgetPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.profileWidgetMediumWidth,
      height: AppDimensions.profileWidgetMediumHeight,
      padding: const EdgeInsets.all(14),
      decoration: _widgetDecoration(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              _CoffeeLogoMark(size: 34),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Coffee Journal',
                  style: AppTypography.profileDetailSectionTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text('今日', style: AppTypography.profileDetailMeta),
            ],
          ),
          SizedBox(height: 12),
          Text('一杯热拿铁，刚刚好。', style: AppTypography.profileDetailBody),
          Spacer(),
          Row(
            children: [
              _WidgetMetric(value: '1', label: '今日'),
              SizedBox(width: 8),
              _WidgetMetric(value: '3', label: '连续'),
              SizedBox(width: 8),
              _WidgetMetric(value: '18', label: '本月'),
            ],
          ),
        ],
      ),
    );
  }
}

class _WidgetMetric extends StatelessWidget {
  const _WidgetMetric({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.latteGlassHighlight,
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: AppTypography.profileMenuLabel.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 3),
            Text(label, style: AppTypography.profileDetailMeta),
          ],
        ),
      ),
    );
  }
}

BoxDecoration _widgetDecoration(double radius) {
  return BoxDecoration(
    color: AppColors.surfaceTint,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: AppColors.outline.withAlpha(130)),
    boxShadow: const [
      BoxShadow(
        color: AppColors.homeCardShadow,
        blurRadius: 12,
        offset: Offset(0, 6),
      ),
    ],
  );
}
