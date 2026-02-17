/// Design tokens de espaçamento — Flugo
/// Base: 8px
/// spacing(factor) → factor * 8
class AppSpacing {
  AppSpacing._();

  static const double base = 8;

  static double spacing(double factor) => factor * base;

  // Atalhos comuns
  static const double xxs = 4; // 0.5
  static const double xs = 8; // 1
  static const double sm = 16; // 2
  static const double md = 24; // 3
  static const double lg = 32; // 4
  static const double xl = 40; // 5
  static const double xxl = 48; // 6
}
