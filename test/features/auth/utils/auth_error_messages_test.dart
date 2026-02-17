import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flugo_chat/features/auth/utils/auth_error_messages.dart';

class MockFirebaseAuthException extends Mock implements FirebaseAuthException {}

void main() {
  group('AuthErrorMessages', () {
    test('mapeia invalid-email para português', () {
      final e = MockFirebaseAuthException();
      when(() => e.code).thenReturn('invalid-email');
      expect(
        AuthErrorMessages.fromFirebaseAuthException(e),
        'O endereço de e-mail está em formato inválido.',
      );
    });

    test('mapeia wrong-password para português', () {
      final e = MockFirebaseAuthException();
      when(() => e.code).thenReturn('wrong-password');
      expect(
        AuthErrorMessages.fromFirebaseAuthException(e),
        'Senha incorreta. Tente novamente.',
      );
    });

    test('mapeia email-already-in-use para português (signUp)', () {
      final e = MockFirebaseAuthException();
      when(() => e.code).thenReturn('email-already-in-use');
      expect(
        AuthErrorMessages.fromFirebaseAuthException(e, isSignUp: true),
        'Este e-mail já está em uso. Faça login ou use outro e-mail.',
      );
    });

    test('retorna mensagem padrão para código desconhecido (login)', () {
      final e = MockFirebaseAuthException();
      when(() => e.code).thenReturn('unknown-code');
      expect(
        AuthErrorMessages.fromFirebaseAuthException(e),
        'Não foi possível fazer login. Tente novamente.',
      );
    });

    test('retorna mensagem padrão para código desconhecido (signUp)', () {
      final e = MockFirebaseAuthException();
      when(() => e.code).thenReturn('unknown-code');
      expect(
        AuthErrorMessages.fromFirebaseAuthException(e, isSignUp: true),
        'Não foi possível criar a conta. Tente novamente.',
      );
    });
  });
}
