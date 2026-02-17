import 'package:flutter/material.dart';

/// Design tokens de cores — Flugo
/// Equivalente ao tokens.ts do projeto React
class AppColors {
  AppColors._();

  // Primary
  static const Color primaryMain = Color(0xFF2ECC71);
  static const Color primaryLight = Color(0xFF58D68D);
  static const Color primaryDark = Color(0xFF27AE60);
  static const Color primaryContrast = Color(0xFFFFFFFF);

  // Secondary
  static const Color secondaryMain = Color(0xFF6B7280);
  static const Color secondaryLight = Color(0xFF9CA3AF);
  static const Color secondaryDark = Color(0xFF374151);

  // Success
  static const Color successMain = Color(0xFF2ECC71);
  static const Color successLight = Color(0xFFE6F7ED);

  // Error
  static const Color errorMain = Color(0xFFE74C3C);
  static const Color errorLight = Color(0xFFFEEEEE);

  // Warning
  static const Color warningMain = Color(0xFFF39C12);
  static const Color warningLight = Color(0xFFFEF5E7);

  // Neutral text
  static const Color textPrimary = Color(0xFF374151);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color textDisabled = Color(0xFF9E9E9E);

  // Neutral border
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFEEEEEE);

  // Neutral background
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundAlt = Color(0xFFF8F9FA);
  static const Color backgroundMuted = Color(0xFFF9FAFB);
}
