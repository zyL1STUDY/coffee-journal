import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AppPaperBackground extends StatelessWidget {
  const AppPaperBackground({
    required this.child,
    this.textureOpacity = 0.46,
    super.key,
  });

  final Widget child;
  final double textureOpacity;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.homeMistBackground,
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: textureOpacity,
              child: Image.asset(
                'assets/images/backgrounds/warm_kraft_paper.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
