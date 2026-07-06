import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_radius.dart';

class MobileAppFrame extends StatelessWidget {
  const MobileAppFrame({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shouldUseMobileFrame =
            constraints.maxWidth >= AppDimensions.mobileViewportBreakpoint;

        if (!shouldUseMobileFrame) {
          return child;
        }

        return ColoredBox(
          color: AppColors.previewBackground,
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.large),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.previewShadow,
                    blurRadius: 24,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.large),
                child: SizedBox(
                  width: AppDimensions.mobileViewportWidth,
                  height: AppDimensions.mobileViewportHeight,
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
