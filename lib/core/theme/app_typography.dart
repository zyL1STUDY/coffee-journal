import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  const AppTypography._();

  static const fontFamilyFallback = <String>[
    'PingFang SC',
    'SF Pro Text',
    'Helvetica Neue',
    'Arial',
  ];

  static const greeting = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    height: 35 / 30,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const date = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 22 / 15,
    letterSpacing: 0,
    color: AppColors.textMuted,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const todayCardSentence = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 31 / 18,
    letterSpacing: 0,
    color: AppColors.aiPromptText,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const sectionTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 26 / 20,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const coffeeCardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 21 / 16,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const coffeeCardMeta = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 18 / 13,
    letterSpacing: 0,
    color: AppColors.textMuted,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const homeCoffeeAction = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 18 / 13,
    letterSpacing: 0,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const ctaPlus = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 26 / 22,
    letterSpacing: 0,
    color: AppColors.background,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const ctaLabel = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 20 / 16,
    letterSpacing: 0,
    color: AppColors.background,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const recordSheetTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 29 / 24,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const recordDetailTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 28 / 22,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const recordBack = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 28 / 28,
    letterSpacing: 0,
    color: AppColors.textSecondary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const recordCancel = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w300,
    height: 26 / 24,
    letterSpacing: 0,
    color: AppColors.textMuted,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const recordSubcopy = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 22 / 15,
    letterSpacing: 0,
    color: AppColors.textSecondary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const recordOptionLabel = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 20 / 18,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const recordGentleNote = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0,
    color: AppColors.textMuted,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const recordSectionTitle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 21 / 17,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const recordChip = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 15 / 14,
    letterSpacing: 0,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const recordField = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 20 / 16,
    letterSpacing: 0,
    color: AppColors.textSecondary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const recordSaveButton = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 19 / 16,
    letterSpacing: 0,
    color: AppColors.background,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const recordDialogTitle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 22 / 17,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const journalMonthTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 34 / 26,
    letterSpacing: 0,
    color: AppColors.journalMonthLabel,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const journalMonthSubtitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 34 / 26,
    letterSpacing: 0,
    color: AppColors.journalMonthLabel,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const journalDescription = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 22 / 15,
    letterSpacing: 0,
    color: AppColors.journalMonthLabel,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const journalArrow = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 28 / 28,
    letterSpacing: 0,
    color: AppColors.journalMonthLabel,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const journalWeekday = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 18 / 13,
    letterSpacing: 0,
    color: AppColors.journalMonthLabel,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const journalDay = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 18 / 14,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const journalToday = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 18 / 14,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const journalTodayLabel = TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.w500,
    height: 10 / 8,
    letterSpacing: 0,
    color: AppColors.journalMonthLabel,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const journalBadge = TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w700,
    height: 16 / 9,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const memoryAiMessage = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 22 / 15,
    letterSpacing: 0,
    color: AppColors.aiPromptText,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const memoryDrinkName = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 32 / 24,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const memorySource = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 20 / 13,
    letterSpacing: 0,
    color: AppColors.journalMonthLabel,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const memoryTime = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 19 / 13,
    letterSpacing: 0,
    color: AppColors.journalMonthLabel,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const memoryNoteTitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 18 / 13,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const memoryNoteBody = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 22 / 14,
    letterSpacing: 0,
    color: AppColors.journalMonthLabel,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const memoryAction = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 22 / 15,
    letterSpacing: 0,
    fontFamilyFallback: fontFamilyFallback,
  );

  static const recordDialogBody = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0,
    color: AppColors.textSecondary,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextTheme get textTheme {
    return const TextTheme(
      displaySmall: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        height: 35 / 30,
        color: AppColors.textPrimary,
        fontFamilyFallback: fontFamilyFallback,
      ),
      headlineMedium: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w600,
        height: 29 / 23,
        color: AppColors.textPrimary,
        fontFamilyFallback: fontFamilyFallback,
      ),
      titleLarge: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w600,
        height: 25 / 19,
        color: AppColors.textPrimary,
        fontFamilyFallback: fontFamilyFallback,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 23 / 16,
        color: AppColors.textSecondary,
        fontFamilyFallback: fontFamilyFallback,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 21 / 14,
        color: AppColors.textSecondary,
        fontFamilyFallback: fontFamilyFallback,
      ),
      labelMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 18 / 13,
        color: AppColors.textMuted,
        fontFamilyFallback: fontFamilyFallback,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 20 / 16,
        fontFamilyFallback: fontFamilyFallback,
      ),
    );
  }
}
