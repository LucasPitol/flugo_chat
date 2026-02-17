import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flugo_chat/core/theme/app_borders.dart';
import 'package:flugo_chat/core/theme/app_colors.dart';
import 'package:flugo_chat/core/theme/app_shadows.dart';
import 'package:flugo_chat/core/theme/app_spacing.dart';
import 'package:flugo_chat/core/widgets/app_button.dart';
import 'package:flugo_chat/features/auth/controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppBorders.sm),
                  boxShadow: AppShadows.lg,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo central: altura 40px, mb: 2
                    Image.asset(
                      'assets/icons/flugo.jpeg',
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      autocorrect: false,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Obx(
                      () => AppButton(
                        onPressed: () => _authController.signInWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password: _passwordController.text,
                            ),
                        label: 'Login',
                        loading: _authController.isLoading.value,
                        primary: true,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Obx(
                      () => AppButton(
                        onPressed: () =>
                            _authController.createUserWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
                        ),
                        label: 'Criar conta',
                        loading: _authController.isLoading.value,
                        primary: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AuthController get _authController => Get.find<AuthController>();
}
