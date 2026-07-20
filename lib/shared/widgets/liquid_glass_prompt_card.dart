import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class LiquidGlassPromptCard extends StatelessWidget {
  const LiquidGlassPromptCard({
    required this.child,
    this.radius,
    this.blurSigma = 14,
    super.key,
  });

  final Widget child;
  final double? radius;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final resolvedRadius = BorderRadius.circular(
          radius ?? constraints.maxHeight / 2,
        );

        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: resolvedRadius,
            boxShadow: const [
              BoxShadow(
                color: AppColors.homeAiLiquidGlassShadow,
                blurRadius: 22,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: resolvedRadius,
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.homeAiLiquidGlassBase,
                  borderRadius: resolvedRadius,
                  border: Border.all(color: AppColors.homeAiLiquidGlassBorder),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: resolvedRadius,
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.homeAiLiquidGlassBlush,
                              AppColors.homeAiLiquidGlassMilk,
                              AppColors.homeAiLiquidGlassWarmEdge,
                            ],
                            stops: [0, 0.56, 1],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: resolvedRadius,
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.homeAiLiquidGlassInnerLine,
                              AppColors.latteGlassTransparent,
                            ],
                            stops: [0, 0.42],
                          ),
                        ),
                      ),
                    ),
                    child,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
