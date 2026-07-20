import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_typography.dart';

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({required this.label, this.onPressed, super.key});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: AppDimensions.buttonHeight,
          decoration: const BoxDecoration(
            color: AppColors.homePrimaryButton,
            borderRadius: AppRadius.button,
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('+', style: AppTypography.ctaPlus),
                const SizedBox(width: AppDimensions.buttonContentGap),
                Text(
                  label.replaceFirst('+ ', ''),
                  style: AppTypography.ctaLabel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
