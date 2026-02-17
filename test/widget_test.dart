import 'package:flutter_test/flutter_test.dart';

import 'package:flugo_chat/features/chat/models/chat_message.dart';

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    // Verifica que o modelo ChatMessage pode ser instanciado.
    final message = ChatMessage(
      id: '1',
      text: 'Test',
      userId: 'u1',
      userName: 'User',
      createdAt: DateTime.now(),
    );
    expect(message.text, 'Test');
  });
}
