import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flugo_chat/core/routes/app_routes.dart';
import 'package:flugo_chat/core/theme/app_colors.dart';
import 'package:flugo_chat/core/theme/app_spacing.dart';
import 'package:flugo_chat/features/chat/controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Flugo Chat'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        actions: [
          if (user != null)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.profile),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primaryMain,
                  child: Text(
                    user.email?.isNotEmpty == true
                        ? user.email!.substring(0, 1).toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: AppColors.primaryContrast,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Center(
          child: Text('Chat'),
        ),
      ),
    );
  }
}
