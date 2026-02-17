import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flugo_chat/core/routes/app_routes.dart';
import 'package:flugo_chat/core/widgets/error_bottom_sheet.dart';
import 'package:flugo_chat/features/auth/services/auth_service.dart';
import 'package:flugo_chat/features/auth/utils/auth_error_messages.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final RxBool isLoading = false.obs;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAllNamed(AppRoutes.chat);
    } on FirebaseAuthException catch (e) {
      final message = AuthErrorMessages.fromFirebaseAuthException(e);
      ErrorBottomSheet.show(message: message);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAllNamed(AppRoutes.chat);
    } on FirebaseAuthException catch (e) {
      final message = AuthErrorMessages.fromFirebaseAuthException(
        e,
        isSignUp: true,
      );
      ErrorBottomSheet.show(message: message);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
    Get.offAllNamed(AppRoutes.login);
  }
}
