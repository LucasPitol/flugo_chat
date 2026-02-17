import 'package:flutter/material.dart';

import 'package:flugo_chat/core/theme/app_colors.dart';

/// Botão padrão Flugo — suporta loading
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.loading = false,
    this.primary = true,
  });

  final VoidCallback? onPressed;
  final String label;
  final bool loading;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    if (primary) {
      return ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryMain,
          disabledBackgroundColor: AppColors.primaryMain.withValues(alpha: 0.6),
        ),
        child: loading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primaryContrast,
                ),
              )
            : Text(label),
      );
    }

    return OutlinedButton(
      onPressed: loading ? null : onPressed,
      child: loading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(label),
    );
  }
}
