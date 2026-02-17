import 'package:get/get.dart';

import 'package:flugo_chat/features/auth/services/auth_service.dart';
import 'package:flugo_chat/features/chat/controllers/chat_controller.dart';
import 'package:flugo_chat/features/chat/services/chat_service.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthService>()) {
      Get.lazyPut<AuthService>(() => AuthService());
    }
    Get.lazyPut<ChatService>(() => ChatService());
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
