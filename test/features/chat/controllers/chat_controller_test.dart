import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flugo_chat/features/auth/services/auth_service.dart';
import 'package:flugo_chat/features/chat/controllers/chat_controller.dart';
import 'package:flugo_chat/features/chat/models/chat_message.dart';
import 'package:flugo_chat/features/chat/services/chat_service.dart';

class MockChatService extends Mock implements ChatService {}

class MockAuthService extends Mock implements AuthService {}

class FakeUser extends Fake implements User {
  FakeUser({this.uid = 'uid1', this.email = 'user@test.com'});
  @override
  final String uid;
  @override
  final String? email;
}

void main() {
  late ChatController controller;
  late MockChatService mockChatService;
  late MockAuthService mockAuthService;
  late StreamController<ChatMessage> streamController;

  setUp(() {
    Get.testMode = true;
    streamController = StreamController<ChatMessage>.broadcast();
    mockChatService = MockChatService();
    mockAuthService = MockAuthService();

    when(() => mockChatService.streamMessages())
        .thenAnswer((_) => streamController.stream);

    Get.replace<ChatService>(mockChatService);
    Get.replace<AuthService>(mockAuthService);

    controller = Get.put(ChatController());
  });

  tearDown(() async {
    await streamController.close();
    Get.reset();
  });

  group('ChatController', () {
    group('inserção na lista reativa', () {
      test('adiciona mensagem quando stream emite', () async {
        final message = ChatMessage(
          id: '1',
          text: 'Olá',
          userId: 'u1',
          userName: 'João',
          createdAt: DateTime.now(),
        );

        streamController.add(message);
        await Future<void>.delayed(const Duration(milliseconds: 50));

        expect(controller.messages.length, 1);
        expect(controller.messages.first.text, 'Olá');
      });

      test('sortedMessages retorna em ordem cronológica', () async {
        final older = ChatMessage(
          id: '1',
          text: 'Primeira',
          userId: 'u1',
          userName: 'A',
          createdAt: DateTime(2024, 1, 1, 10, 0),
        );
        final newer = ChatMessage(
          id: '2',
          text: 'Segunda',
          userId: 'u2',
          userName: 'B',
          createdAt: DateTime(2024, 1, 1, 11, 0),
        );

        streamController.add(newer);
        streamController.add(older);
        await Future<void>.delayed(const Duration(milliseconds: 50));

        final sorted = controller.sortedMessages;
        expect(sorted.length, 2);
        expect(sorted.first.text, 'Primeira');
        expect(sorted.last.text, 'Segunda');
      });
    });

    group('sendMessage', () {
      test('não envia quando texto vazio', () async {
        when(() => mockAuthService.currentUser).thenReturn(FakeUser());

        controller.messageController.text = '   ';
        await controller.sendMessage();

        verifyNever(() => mockChatService.sendMessage(
              text: any(named: 'text'),
              userId: any(named: 'userId'),
              userName: any(named: 'userName'),
            ));
      });

      test('chama ChatService quando usuário logado', () async {
        when(() => mockAuthService.currentUser).thenReturn(FakeUser());
        when(() => mockChatService.sendMessage(
              text: any(named: 'text'),
              userId: any(named: 'userId'),
              userName: any(named: 'userName'),
            )).thenAnswer((_) async {});

        controller.messageController.text = 'Mensagem';
        await controller.sendMessage();

        verify(() => mockChatService.sendMessage(
              text: 'Mensagem',
              userId: 'uid1',
              userName: 'user@test.com',
            )).called(1);
      });
    });
  });
}
