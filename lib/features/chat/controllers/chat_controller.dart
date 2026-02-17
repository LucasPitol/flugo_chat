import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flugo_chat/features/auth/services/auth_service.dart';
import 'package:flugo_chat/features/chat/models/chat_message.dart';
import 'package:flugo_chat/features/chat/services/chat_service.dart';

class ChatController extends GetxController {
  final ChatService _chatService = Get.find<ChatService>();
  final AuthService _authService = Get.find<AuthService>();

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();

  StreamSubscription<ChatMessage>? _messagesSubscription;

  @override
  void onInit() {
    super.onInit();
    _subscribeToMessages();
  }

  @override
  void onClose() {
    _messagesSubscription?.cancel();
    scrollController.dispose();
    messageController.dispose();
    super.onClose();
  }

  void _subscribeToMessages() {
    _messagesSubscription = _chatService.streamMessages().listen((message) {
      messages.add(message);
      _scrollToBottom();
    });
  }

  /// Mensagens ordenadas por createdAt (ascendente).
  List<ChatMessage> get sortedMessages {
    final list = List<ChatMessage>.from(messages);
    list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return list;
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final user = _authService.currentUser;
    if (user == null) return;

    try {
      isLoading.value = true;
      await _chatService.sendMessage(
        text: text,
        userId: user.uid,
        userName: user.email ?? user.uid,
      );
      messageController.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
