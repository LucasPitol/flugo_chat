import 'package:flutter/material.dart';
import 'package:flugo_chat/core/theme/app_spacing.dart';

/// Cabeçalho de página — título + ação opcional, mb: 3
class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    this.action,
  });

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          action ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
