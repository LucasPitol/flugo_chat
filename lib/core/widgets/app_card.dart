import 'package:flutter/material.dart';

import 'package:flugo_chat/core/theme/app_borders.dart';
import 'package:flugo_chat/core/theme/app_colors.dart';
import 'package:flugo_chat/core/theme/app_shadows.dart';

/// Card Flugo — bordas arredondadas e sombra (tema)
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppBorders.xl),
        boxShadow: AppShadows.md,
      ),
      padding: padding ?? const EdgeInsets.all(24),
      child: child,
    );
  }
}
