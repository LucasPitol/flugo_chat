import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flugo_chat/core/theme/app_colors.dart';
import 'package:flugo_chat/core/theme/app_spacing.dart';
import 'package:flugo_chat/core/theme/app_borders.dart';

/// Bottom sheet para exibição de erros ao usuário.
/// Usa tokens do design system Flugo.
class ErrorBottomSheet extends StatelessWidget {
  const ErrorBottomSheet({
    super.key,
    required this.message,
    this.title = 'Erro',
  });

  final String message;
  final String title;

  /// Exibe a bottom sheet de erro.
  static void show({
    required String message,
    String title = 'Erro',
  }) {
    Get.bottomSheet(
      ErrorBottomSheet(message: message, title: title),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      ignoreSafeArea: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppBorders.lg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: AppColors.errorMain,
                    size: 28,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.errorMain,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Get.back(),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primaryMain,
                    foregroundColor: AppColors.primaryContrast,
                  ),
                  child: const Text('Entendi'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
