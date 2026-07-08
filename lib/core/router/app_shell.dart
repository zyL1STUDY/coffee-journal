import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_radius.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _CoffeeBottomNavigation(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _CoffeeBottomNavigation extends StatelessWidget {
  const _CoffeeBottomNavigation({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  static const _items = [
    _CoffeeNavigationItem(
      semanticLabel: '今天',
      icon: _CoffeeNavigationIcon.drink,
    ),
    _CoffeeNavigationItem(
      semanticLabel: 'Journal',
      icon: _CoffeeNavigationIcon.anniversary,
    ),
    _CoffeeNavigationItem(
      semanticLabel: '我的',
      icon: _CoffeeNavigationIcon.profile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.mobileViewportWidth,
      height: AppDimensions.bottomNavigationHeight,
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.bottomNavigationPaddingLeft,
        AppDimensions.bottomNavigationPaddingTop,
        AppDimensions.bottomNavigationPaddingRight,
        AppDimensions.bottomNavigationPaddingBottom,
      ),
      color: AppColors.bottomNavigation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var index = 0; index < _items.length; index++) ...[
            _CoffeeNavigationTab(
              item: _items[index],
              isSelected: selectedIndex == index,
              onTap: () => onDestinationSelected(index),
            ),
            if (index != _items.length - 1)
              const SizedBox(width: AppDimensions.bottomNavigationTabGap),
          ],
        ],
      ),
    );
  }
}

class _CoffeeNavigationTab extends StatelessWidget {
  const _CoffeeNavigationTab({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final _CoffeeNavigationItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor = isSelected ? AppColors.accent : AppColors.textMuted;

    return Semantics(
      label: item.semanticLabel,
      selected: isSelected,
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          width: AppDimensions.bottomNavigationTabWidth,
          height: AppDimensions.bottomNavigationTabHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primarySoft72 : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: SizedBox(
            width: AppDimensions.bottomNavigationIconSize,
            height: AppDimensions.bottomNavigationIconSize,
            child: CustomPaint(
              painter: _CoffeeNavigationIconPainter(
                icon: item.icon,
                color: iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CoffeeNavigationItem {
  const _CoffeeNavigationItem({
    required this.semanticLabel,
    required this.icon,
  });

  final String semanticLabel;
  final _CoffeeNavigationIcon icon;
}

enum _CoffeeNavigationIcon { drink, anniversary, profile }

class _CoffeeNavigationIconPainter extends CustomPainter {
  const _CoffeeNavigationIconPainter({required this.icon, required this.color});

  final _CoffeeNavigationIcon icon;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 34;
    canvas.save();
    canvas.scale(scale, scale);

    switch (icon) {
      case _CoffeeNavigationIcon.drink:
        _paintDrink(canvas);
      case _CoffeeNavigationIcon.anniversary:
        _paintAnniversary(canvas);
      case _CoffeeNavigationIcon.profile:
        _paintProfile(canvas);
    }

    canvas.restore();
  }

  void _paintDrink(Canvas canvas) {
    final stroke = _stroke(2.2);
    final strawStroke = _stroke(2.6);
    final sleeveStroke = _stroke(2);

    canvas.drawLine(
      const Offset(14.8619, 5.00947),
      const Offset(13.6567, 1.30035),
      strawStroke,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(8.1, 9.44412, 17.8, 2.3),
        const Radius.circular(1.1),
      ),
      stroke,
    );

    final cup = Path()
      ..moveTo(10, 12.3441)
      ..lineTo(24, 12.3441)
      ..lineTo(22.2, 30.3441)
      ..lineTo(11.8, 30.3441)
      ..close();
    canvas.drawPath(cup, stroke);
    canvas.drawLine(
      const Offset(12, 18.3441),
      const Offset(22, 18.3441),
      sleeveStroke,
    );
    canvas.drawLine(
      const Offset(12.5, 22.3441),
      const Offset(21.5, 22.3441),
      sleeveStroke,
    );
  }

  void _paintAnniversary(Canvas canvas) {
    final stroke = _stroke(2.2);
    final thinStroke = _stroke(2);
    final fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(6.1, 8.1, 21.8, 20.8),
        const Radius.circular(3.9),
      ),
      stroke,
    );
    canvas.drawLine(const Offset(10, 12), const Offset(24, 12), thinStroke);
    canvas.drawLine(const Offset(13, 3), const Offset(11.0001, 9), thinStroke);
    canvas.drawLine(const Offset(23, 3), const Offset(21.0001, 9), thinStroke);

    final heart = Path()
      ..moveTo(17, 26.5)
      ..cubicTo(13.4, 23.3, 11, 20.6, 12.8, 18.5)
      ..cubicTo(14.1, 17, 16, 17.5, 17, 19)
      ..cubicTo(18, 17.5, 19.9, 17, 21.2, 18.5)
      ..cubicTo(23, 20.6, 20.6, 23.3, 17, 26.5)
      ..close();
    canvas.drawPath(heart, fill);
  }

  void _paintProfile(Canvas canvas) {
    final stroke = _stroke(2.5);

    canvas.drawCircle(const Offset(17, 10.6), 4.55, stroke);
    final ovalBase = Path()
      ..moveTo(17, 20.45)
      ..cubicTo(19.9133, 20.45, 22.492, 20.9466, 24.2959, 21.701)
      ..cubicTo(25.2004, 22.0793, 25.8513, 22.4973, 26.2568, 22.8982)
      ..cubicTo(26.6576, 23.2944, 26.7499, 23.5983, 26.75, 23.7996)
      ..cubicTo(26.75, 24.001, 26.6578, 24.3055, 26.2568, 24.702)
      ..cubicTo(25.8513, 25.1029, 25.2004, 25.521, 24.2959, 25.8992)
      ..cubicTo(22.492, 26.6536, 19.9133, 27.1502, 17, 27.1502)
      ..cubicTo(14.0867, 27.1502, 11.508, 26.6536, 9.7041, 25.8992)
      ..cubicTo(8.79961, 25.521, 8.14869, 25.1029, 7.74316, 24.702)
      ..cubicTo(7.34217, 24.3055, 7.25, 24.001, 7.25, 23.7996)
      ..cubicTo(7.25012, 23.5983, 7.34243, 23.2944, 7.74316, 22.8982)
      ..cubicTo(8.14867, 22.4973, 8.79957, 22.0793, 9.7041, 21.701)
      ..cubicTo(11.508, 20.9466, 14.0867, 20.45, 17, 20.45)
      ..close();
    canvas.drawPath(ovalBase, stroke);
  }

  Paint _stroke(double width) {
    return Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
  }

  @override
  bool shouldRepaint(covariant _CoffeeNavigationIconPainter oldDelegate) {
    return oldDelegate.icon != icon || oldDelegate.color != color;
  }
}
