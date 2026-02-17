import 'package:flutter/material.dart';
import 'package:flugo_chat/core/theme/app_colors.dart';
import 'package:flugo_chat/core/theme/app_borders.dart';
import 'package:flugo_chat/core/theme/app_spacing.dart';
import 'package:flugo_chat/features/chat/models/chat_message.dart';

/// Bolha de mensagem com diferenciação visual para o usuário atual.
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.currentUserId,
  });

  final ChatMessage message;
  final String currentUserId;

  bool get _isCurrentUser => message.userId == currentUserId;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: AppSpacing.xs,
          left: AppSpacing.sm,
          right: AppSpacing.sm,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: _isCurrentUser ? AppColors.primaryMain : AppColors.backgroundMuted,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppBorders.lg),
            topRight: const Radius.circular(AppBorders.lg),
            bottomLeft: Radius.circular(_isCurrentUser ? AppBorders.lg : 2),
            bottomRight: Radius.circular(_isCurrentUser ? 2 : AppBorders.lg),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!_isCurrentUser)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
                child: Text(
                  message.userName,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            Text(
              message.text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _isCurrentUser
                        ? AppColors.primaryContrast
                        : AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              _formatTime(message.createdAt),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _isCurrentUser
                        ? AppColors.primaryContrast.withValues(alpha: 0.8)
                        : AppColors.textMuted,
                    fontSize: 11,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
