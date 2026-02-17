import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flugo_chat/core/theme/app_colors.dart';

/// Design tokens de tipografia — Flugo
/// Fonte: Roboto (pesos 400, 500, 600, 700)
/// Line height: 1.5
class AppTypography {
  AppTypography._();

  static TextStyle get _base => GoogleFonts.roboto(
        color: AppColors.textPrimary,
        height: 1.5,
      );

  // Tamanhos (rem → px: xs 12, sm 14, md 15, base 16, lg 18, xl 20, 2xl 24)
  static TextStyle get xs => _base.copyWith(fontSize: 12);
  static TextStyle get sm => _base.copyWith(fontSize: 14);
  static TextStyle get md => _base.copyWith(fontSize: 15);
  static TextStyle get base => _base.copyWith(fontSize: 16);
  static TextStyle get lg => _base.copyWith(fontSize: 18);
  static TextStyle get xl => _base.copyWith(fontSize: 20);
  static TextStyle get xxl => _base.copyWith(fontSize: 24);

  // Pesos
  static TextStyle regular(TextStyle style) =>
      style.copyWith(fontWeight: FontWeight.w400);
  static TextStyle medium(TextStyle style) =>
      style.copyWith(fontWeight: FontWeight.w500);
  static TextStyle semibold(TextStyle style) =>
      style.copyWith(fontWeight: FontWeight.w600);
  static TextStyle bold(TextStyle style) =>
      style.copyWith(fontWeight: FontWeight.w700);

  // Variantes
  static TextStyle get body1 => base;
  static TextStyle get body2 => sm.copyWith(color: AppColors.textSecondary);
  static TextStyle get h4 => xxl.copyWith(fontWeight: FontWeight.w600);
  static TextStyle get h5 => xl.copyWith(fontWeight: FontWeight.w600);
}
