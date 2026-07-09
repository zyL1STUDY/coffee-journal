import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AiCandyGlassCard extends StatelessWidget {
  const AiCandyGlassCard({required this.child, this.radius = 22, super.key});

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 9, sigmaY: 9),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.aiCandyGlassBase,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: AppColors.aiCandyGlassBorder),
            boxShadow: const [
              BoxShadow(
                color: AppColors.aiCandyGlassShadow,
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.aiCandyGlassPink,
                        AppColors.aiCandyGlassCream,
                        AppColors.aiCandyGlassCoffee,
                      ],
                      stops: [0, 0.68, 1],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -24,
                top: -22,
                width: 128,
                height: 86,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    gradient: const RadialGradient(
                      colors: [
                        AppColors.aiCandyGlassHighlight,
                        AppColors.latteGlassTransparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -18,
                bottom: -28,
                width: 96,
                height: 76,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(66),
                    gradient: const RadialGradient(
                      colors: [
                        AppColors.aiCandyGlassCoffee,
                        AppColors.latteGlassTransparent,
                      ],
                    ),
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
