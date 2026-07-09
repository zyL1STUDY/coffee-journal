import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';

class LatteGlassCard extends StatelessWidget {
  const LatteGlassCard({
    required this.child,
    this.width,
    this.height,
    this.borderRadius = AppRadius.latteGlass,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: AppColors.latteGlassSurface,
            borderRadius: radius,
            border: Border.all(color: AppColors.latteGlassBorder),
            boxShadow: const [
              BoxShadow(
                color: AppColors.latteGlassShadow,
                blurRadius: 18,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radius,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.latteGlassHighlight,
                  AppColors.latteGlassTransparent,
                ],
                stops: [0, 0.42],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
