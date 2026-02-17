import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flugo_chat/core/theme/app_colors.dart';
import 'package:flugo_chat/core/theme/app_spacing.dart';
import 'package:flugo_chat/core/widgets/app_button.dart';
import 'package:flugo_chat/features/auth/controllers/auth_controller.dart';
import 'package:flugo_chat/features/auth/services/auth_service.dart';

class ProfileView extends GetView<AuthController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<AuthService>().currentUser;
    final email = user?.email ?? '—';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.lg),
              Text(
                'E-mail',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                email,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                onPressed: () => controller.logout(),
                label: 'Sair',
                primary: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
