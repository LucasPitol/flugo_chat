import 'package:flutter/material.dart';
import 'package:flugo_chat/core/theme/app_colors.dart';
import 'package:flugo_chat/core/theme/app_spacing.dart';

/// Estado vazio — lista vazia: mensagem, descrição, ação
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.message,
    this.description,
    this.action,
  });

  final String message;
  final String? description;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (description != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: AppSpacing.md),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
