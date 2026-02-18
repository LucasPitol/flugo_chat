# Flugo Chat

Aplicativo de chat em tempo real desenvolvido em Flutter com Firebase (Authentication + Realtime Database), GetX e design system Flugo.

## Pré-requisitos

- [Flutter](https://flutter.dev/docs/get-started/install) (SDK ^3.11.0)
- Conta no [Firebase](https://console.firebase.google.com/)
- Projeto Firebase configurado com:
  - **Authentication** (Email/Senha habilitado)
  - **Realtime Database** (regras configuradas)

## Como rodar o projeto

1. **Clone o repositório** (se ainda não tiver):
   ```bash
   git clone <url-do-repositorio>
   cd flugo_chat
   ```

2. **Instale as dependências**:
   ```bash
   flutter pub get
   ```

3. **Configure o Firebase** (se for rodar em um projeto novo):
   - Adicione `google-services.json` em `android/app/`
   - Adicione `GoogleService-Info.plist` em `ios/Runner/`
   - Ou use o FlutterFire CLI: `dart run flutterfire_cli:flutterfire configure`

4. **Execute o app**:
   ```bash
   flutter run
   ```

   Para um dispositivo/emulador específico:
   ```bash
   flutter devices          # lista dispositivos disponíveis
   flutter run -d <device>  # ex: flutter run -d chrome
   ```

## Estrutura do projeto

```
lib/
├── core/
│   ├── config/
│   ├── routes/
│   ├── theme/
│   └── bindings/
│
├── features/
│   ├── auth/
│   │   ├── controllers/
│   │   ├── utils/
│   │   ├── views/
│   │   └── widgets/
│   │
│   └── chat/
│       ├── controllers/
│       ├── models/
│       ├── services/
│       ├── views/
│       └── widgets/
│
└── main.dart
```

## Arquitetura

O projeto segue uma arquitetura **modular feature-first** com separação clara entre:

| Camada | Local | Responsabilidade |
|--------|-------|------------------|
| **Views** | `features/**/views` | UI, layout, delegar ações ao Controller, reagir a estados (`Obx`) |
| **Controllers** | `features/**/controllers` | Estado reativo, orquestrar serviços, ciclo de vida |
| **Services** | `features/**/services` | Comunicação com Firebase, encapsular acesso ao Realtime Database |
| **Models** | `features/**/models` | Estrutura do domínio (imutáveis e serializáveis) |

### Fluxo de dados

**Envio de mensagem:**
1. Usuário digita → View chama `ChatController.sendMessage()`
2. Controller delega para `ChatService`
3. Service envia para Firebase
4. Firebase dispara atualização → stream atualiza lista
5. UI reage automaticamente via `Obx`

**Recebimento em tempo real:**
1. `ChatService` escuta Realtime Database (`onChildAdded`)
2. Controller recebe stream e atualiza `RxList<ChatMessage>`
3. UI reconstrói automaticamente

### Tecnologias

- **GetX** – state management, injeção de dependência e rotas
- **Firebase Auth** – autenticação por email/senha
- **Firebase Realtime Database** – mensagens em tempo real

### Estrutura de dados (Realtime Database)

```
messages/
  messageId:
    text: string
    userId: string
    userName: string
    createdAt: timestamp
```

### Testes

```bash
flutter test
```

Possível testar controllers isoladamente, services com mocks do Firebase e lógica de diferenciação de usuário.

---

Para mais detalhes, consulte [architecture.md](architecture.md).
