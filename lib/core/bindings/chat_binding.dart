import 'package:get/get.dart';
import 'package:flugo_chat/features/chat/controllers/chat_controller.dart';
import 'package:flugo_chat/features/chat/services/chat_service.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatService>(() => ChatService());
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
