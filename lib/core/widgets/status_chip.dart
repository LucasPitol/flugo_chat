import 'package:flutter/material.dart';

import 'package:flugo_chat/core/theme/app_colors.dart';

/// Chip de status — success/error (Ativo/Inativo)
enum StatusChipType { success, error }

class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.label,
    this.type = StatusChipType.success,
  });

  final String label;
  final StatusChipType type;

  @override
  Widget build(BuildContext context) {
    final isSuccess = type == StatusChipType.success;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isSuccess ? AppColors.successLight : AppColors.errorLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSuccess ? AppColors.successMain : AppColors.errorMain,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}
