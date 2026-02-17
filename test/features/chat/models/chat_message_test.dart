import 'package:flutter_test/flutter_test.dart';

import 'package:flugo_chat/features/chat/models/chat_message.dart';

void main() {
  group('ChatMessage', () {
    group('fromMap', () {
      test('converte mapa completo corretamente', () {
        final map = {
          'text': 'Olá',
          'userId': 'uid123',
          'userName': 'João',
          'createdAt': 1700000000000,
        };
        final message = ChatMessage.fromMap('msg1', map);

        expect(message.id, 'msg1');
        expect(message.text, 'Olá');
        expect(message.userId, 'uid123');
        expect(message.userName, 'João');
        expect(message.createdAt, DateTime.fromMillisecondsSinceEpoch(1700000000000));
      });

      test('usa valores default para campos ausentes', () {
        final message = ChatMessage.fromMap('msg2', {});

        expect(message.id, 'msg2');
        expect(message.text, '');
        expect(message.userId, '');
        expect(message.userName, '');
        expect(message.createdAt, isA<DateTime>());
      });

      test('converte timestamp double', () {
        final map = {
          'text': 'Test',
          'userId': 'u1',
          'userName': 'User',
          'createdAt': 1700000000000.0,
        };
        final message = ChatMessage.fromMap('m1', map);
        expect(message.createdAt, DateTime.fromMillisecondsSinceEpoch(1700000000000));
      });
    });

    group('toMap', () {
      test('serializa corretamente', () {
        final message = ChatMessage(
          id: 'id',
          text: 'Texto',
          userId: 'uid',
          userName: 'Nome',
          createdAt: DateTime.fromMillisecondsSinceEpoch(1700000000000),
        );

        final map = message.toMap();

        expect(map['text'], 'Texto');
        expect(map['userId'], 'uid');
        expect(map['userName'], 'Nome');
        expect(map['createdAt'], 1700000000000);
      });

      test('round-trip fromMap toMap preserva dados', () {
        final original = {
          'text': 'Mensagem',
          'userId': 'user1',
          'userName': 'Maria',
          'createdAt': 1700000000000,
        };
        final message = ChatMessage.fromMap('msg-id', original);
        final map = message.toMap();

        expect(map['text'], original['text']);
        expect(map['userId'], original['userId']);
        expect(map['userName'], original['userName']);
        expect(map['createdAt'], original['createdAt']);
      });
    });

    group('isFromUser', () {
      test('retorna true quando userId coincide', () {
        final message = ChatMessage(
          id: '1',
          text: 'Oi',
          userId: 'user123',
          userName: 'João',
          createdAt: DateTime.now(),
        );
        expect(message.isFromUser('user123'), isTrue);
      });

      test('retorna false quando userId difere', () {
        final message = ChatMessage(
          id: '1',
          text: 'Oi',
          userId: 'user123',
          userName: 'João',
          createdAt: DateTime.now(),
        );
        expect(message.isFromUser('outro-user'), isFalse);
      });
    });
  });
}
