import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import 'package:flugo_chat/features/chat/models/chat_message.dart';

/// Serviço de chat — comunicação com Firebase Realtime Database.
class ChatService {
  static const String _messagesPath = 'messages';

  final DatabaseReference _messagesRef =
      FirebaseDatabase.instance.ref(_messagesPath);

  /// Envia mensagem para o Firebase.
  /// Usa push com timestamp do servidor.
  Future<void> sendMessage({
    required String text,
    required String userId,
    required String userName,
  }) async {
    await _messagesRef.push().set({
      'text': text,
      'userId': userId,
      'userName': userName,
      'createdAt': ServerValue.timestamp,
    });
  }

  /// Stream de mensagens ordenadas por createdAt.
  /// Usa onChildAdded para receber cada nova mensagem em tempo real.
  Stream<ChatMessage> streamMessages() {
    return _messagesRef
        .orderByChild('createdAt')
        .onChildAdded
        .map((event) => _eventToChatMessage(event));
  }

  ChatMessage _eventToChatMessage(DatabaseEvent event) {
    final key = event.snapshot.key ?? '';
    final value = event.snapshot.value;
    final map = value is Map ? Map<String, dynamic>.from(value) : <String, dynamic>{};
    return ChatMessage.fromMap(key, map);
  }
}
