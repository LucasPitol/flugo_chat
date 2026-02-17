import 'package:get/get.dart';
import 'package:flugo_chat/features/auth/controllers/auth_controller.dart';
import 'package:flugo_chat/features/auth/services/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService());
    Get.lazyPut(() => AuthController());
  }
}
