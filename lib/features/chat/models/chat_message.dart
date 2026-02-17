/// Modelo de domínio para mensagem do chat.
/// Imutável e serializável.
class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.text,
    required this.userId,
    required this.userName,
    required this.createdAt,
  });

  final String id;
  final String text;
  final String userId;
  final String userName;
  final DateTime createdAt;

  /// Cria instância a partir do mapa (ex.: Firebase Realtime Database).
  factory ChatMessage.fromMap(String id, Map<String, dynamic> map) {
    return ChatMessage(
      id: id,
      text: map['text'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      userName: map['userName'] as String? ?? '',
      createdAt: _timestampToDateTime(map['createdAt']),
    );
  }

  /// Verifica se a mensagem é do usuário informado.
  bool isFromUser(String userId) => this.userId == userId;

  /// Converte para mapa (ex.: envio ao Firebase).
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'userId': userId,
      'userName': userName,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  static DateTime _timestampToDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    if (value is double) {
      return DateTime.fromMillisecondsSinceEpoch(value.toInt());
    }
    return DateTime.now();
  }
}
