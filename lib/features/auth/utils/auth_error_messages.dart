import 'package:firebase_auth/firebase_auth.dart';

/// Mapeamento de códigos de erro do Firebase Auth para mensagens em português.
/// Referência: https://firebase.google.com/docs/auth/flutter/errors
class AuthErrorMessages {
  AuthErrorMessages._();

  static const _defaultLogin = 'Não foi possível fazer login. Tente novamente.';
  static const _defaultSignUp = 'Não foi possível criar a conta. Tente novamente.';

  static const Map<String, String> _messages = {
    // Email/senha — login
    'invalid-email': 'O endereço de e-mail está em formato inválido.',
    'user-disabled': 'Esta conta foi desativada. Entre em contato com o suporte.',
    'user-not-found': 'Nenhuma conta encontrada com este e-mail.',
    'wrong-password': 'Senha incorreta. Tente novamente.',
    'invalid-credential':
        'As credenciais fornecidas são inválidas ou expiraram. Verifique e-mail e senha.',
    'invalid-login-credentials':
        'E-mail ou senha incorretos. Verifique e tente novamente.',

    // Email/senha — cadastro
    'email-already-in-use': 'Este e-mail já está em uso. Faça login ou use outro e-mail.',
    'weak-password': 'A senha é muito fraca. Use pelo menos 6 caracteres.',
    'operation-not-allowed':
        'O método de login não está habilitado. Entre em contato com o suporte.',

    // Geral
    'too-many-requests':
        'Muitas tentativas. Aguarde alguns minutos e tente novamente.',
    'network-request-failed':
        'Erro de conexão. Verifique sua internet e tente novamente.',
    'requires-recent-login':
        'Por segurança, faça login novamente antes de continuar.',
    'app-not-authorized':
        'Este aplicativo não está autorizado. Entre em contato com o suporte.',
  };

  /// Retorna mensagem em português para o erro de autenticação.
  /// [isSignUp] diferencia mensagem padrão entre login e cadastro.
  static String fromFirebaseAuthException(
    FirebaseAuthException e, {
    bool isSignUp = false,
  }) {
    final message = _messages[e.code];
    if (message != null) return message;
    return isSignUp ? _defaultSignUp : _defaultLogin;
  }
}
