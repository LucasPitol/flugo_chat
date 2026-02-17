import 'package:flutter/material.dart';
import 'package:flugo_chat/core/theme/app_spacing.dart';

/// Campo de entrada de mensagem.
/// Layout apenas — lógica de envio no controller.
class MessageInput extends StatelessWidget {
  const MessageInput({
    super.key,
    required this.controller,
    this.onSubmitted,
    this.enabled = true,
  });

  final TextEditingController controller;
  final VoidCallback? onSubmitted;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              decoration: const InputDecoration(
                hintText: 'Digite uma mensagem...',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSubmitted?.call(),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          IconButton(
            onPressed: enabled ? onSubmitted : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
