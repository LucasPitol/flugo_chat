import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flugo_chat/core/bindings/auth_binding.dart';
import 'package:flugo_chat/core/bindings/chat_binding.dart';
import 'package:flugo_chat/core/bindings/initial_binding.dart';
import 'package:flugo_chat/core/routes/app_routes.dart';
import 'package:flugo_chat/core/theme/app_theme.dart';
import 'package:flugo_chat/features/auth/views/login_view.dart';
import 'package:flugo_chat/features/auth/views/profile_view.dart';
import 'package:flugo_chat/features/chat/views/chat_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final isLoggedIn = FirebaseAuth.instance.currentUser != null;
  runApp(MyApp(initialRoute: isLoggedIn ? AppRoutes.chat : AppRoutes.login));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flugo Chat',
      theme: AppTheme.light,
      initialBinding: InitialBinding(),
      initialRoute: initialRoute,
      getPages: [
        GetPage(
          name: AppRoutes.login,
          page: () => const LoginView(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: AppRoutes.chat,
          page: () => const ChatView(),
          binding: ChatBinding(),
        ),
        GetPage(
          name: AppRoutes.profile,
          page: () => const ProfileView(),
          binding: AuthBinding(),
        ),
      ],
    );
  }
}
