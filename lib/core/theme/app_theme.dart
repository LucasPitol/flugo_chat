import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flugo_chat/core/theme/app_colors.dart';
import 'package:flugo_chat/core/theme/app_borders.dart';
import 'package:flugo_chat/core/theme/app_spacing.dart';

/// Tema Flugo — equivalente ao theme.ts MUI
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final colorScheme = ColorScheme.light(
      primary: AppColors.primaryMain,
      onPrimary: AppColors.primaryContrast,
      primaryContainer: AppColors.primaryLight,
      secondary: AppColors.secondaryMain,
      onSecondary: AppColors.primaryContrast,
      error: AppColors.errorMain,
      onError: AppColors.primaryContrast,
      surface: AppColors.background,
      onSurface: AppColors.textPrimary,
    );

    final textTheme = GoogleFonts.robotoTextTheme().copyWith(
      bodyLarge: GoogleFonts.roboto(fontSize: 16, height: 1.5),
      bodyMedium: GoogleFonts.roboto(fontSize: 14, height: 1.5),
      titleLarge: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w600),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      fontFamily: GoogleFonts.roboto().fontFamily,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleMedium,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryMain,
          foregroundColor: AppColors.primaryContrast,
          disabledForegroundColor: AppColors.textDisabled,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorders.lg),
          ),
          elevation: 2,
          shadowColor: Colors.black.withValues(alpha: 0.08),
        ).copyWith(
          textStyle: WidgetStateProperty.all(
            GoogleFonts.roboto(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.secondaryMain,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorders.lg),
          ),
          side: const BorderSide(color: AppColors.border),
        ).copyWith(
          textStyle: WidgetStateProperty.all(
            GoogleFonts.roboto(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.background,
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        hintStyle: const TextStyle(color: AppColors.textMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorders.md),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorders.md),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorders.md),
          borderSide: const BorderSide(color: AppColors.primaryMain, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorders.md),
          borderSide: const BorderSide(color: AppColors.errorMain),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorders.md),
          borderSide: const BorderSide(color: AppColors.errorMain, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.background,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorders.xl),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryMain;
          }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return null;
        }),
      ),
      chipTheme: ChipThemeData(
        labelStyle: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorders.lg),
        ),
      ),
    );
  }
}
