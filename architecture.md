# Arquitetura – Flugo Chat (Flutter + GetX)

## 1. Visão Geral

O projeto segue uma arquitetura modular baseada em **feature-first organization**, com separação clara entre:

* Apresentação (UI)
* Estado e regras de orquestração (Controllers)
* Serviços (acesso a Firebase)
* Modelos de domínio

A arquitetura prioriza:

* Simplicidade
* Escalabilidade futura
* Testabilidade
* Baixo acoplamento entre camadas

Não foi aplicada Clean Architecture completa (UseCases/Repositories abstratos) para evitar complexidade desnecessária para o escopo do desafio.

---

# Estrutura de Pastas

```
lib/
 ├── core/
 │    ├── config/
 │    ├── routes/
 │    ├── theme/
 │    └── bindings/
 │
 ├── features/
 │    ├── auth/
 │    │    ├── controllers/
 │    │    ├── views/
 │    │    └── widgets/
 │    │
 │    └── chat/
 │         ├── controllers/
 │         ├── models/
 │         ├── services/
 │         ├── views/
 │         └── widgets/
 │
 └── main.dart
```

---

# Camadas e Responsabilidades

## 1 Views (UI Layer)

Local: `features/**/views`

Responsável por:

* Construção da interface
* Layout
* Delegar ações ao Controller
* Reagir a estados observáveis (`Obx`)

Não contém:

* Lógica de negócio
* Acesso direto ao Firebase
* Manipulação de dados complexos

---

## 2 Controllers (GetxController)

Local: `features/**/controllers`

Responsável por:

* Gerenciar estado reativo (`Rx`)
* Orquestrar chamadas aos serviços
* Controlar ciclo de vida
* Reagir a eventos do usuário
* Expor estados como:

  * loading
  * error
  * data

Exemplo de responsabilidades no ChatController:

* Escutar mensagens em tempo real
* Enviar mensagens
* Controlar scroll
* Validar campo vazio

---

## 3 Services

Local: `features/**/services`

Responsável por:

* Comunicação com Firebase
* Encapsular regras de acesso ao Realtime Database
* Isolar dependência externa

A UI nunca acessa Firebase diretamente.

Exemplo:

```
ChatService
  - sendMessage()
  - subscribeToMessages()
```

---

## 4 Models

Local: `features/chat/models`

Representam estrutura do domínio:

```
ChatMessage
- id
- text
- userId
- userName
- createdAt
```

Modelos são imutáveis e serializáveis.

---

# Fluxo de Dados

### Envio de mensagem

1. Usuário digita mensagem
2. View chama `ChatController.sendMessage()`
3. Controller delega para `ChatService`
4. Service envia para Firebase
5. Firebase dispara atualização
6. Subscription ativa atualiza lista
7. UI reage automaticamente via `Obx`

---

### Recebimento de mensagem

1. `ChatService` escuta Realtime Database
2. Controller recebe stream
3. Atualiza `RxList<ChatMessage>`
4. UI reconstrói automaticamente

---

# Por que GetX?

GetX foi escolhido porque:

* Unifica:

  * State management
  * Dependency injection
  * Routing
* Reduz boilerplate
* Permite arquitetura modular simples
* Ideal para escopo pequeno/médio

Evita necessidade de:

* Provider
* Bloc (alta complexidade pro objetivo do projeto)
* Riverpod
* GetIt

---

# Injeção de Dependência

Utilizado `Bindings` do GetX:

```
class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatService());
    Get.lazyPut(() => ChatController(Get.find()));
  }
}
```

Permite:

* Baixo acoplamento
* Testabilidade futura
* Instanciação controlada

---

# Autenticação

* Firebase Authentication
* AuthController centraliza estado do usuário
* Redirecionamento automático após login
* Chat só acessível com usuário autenticado

---

# Realtime Database

Estrutura de dados:

```
messages/
  messageId:
    text: string
    userId: string
    userName: string
    createdAt: timestamp
```

Mensagens são:

* Ordenadas por `createdAt`
* Escutadas via `onValue`
* Atualizadas em tempo real

---

# Separação de Widgets

Widgets pequenos e reutilizáveis:

```
MessageBubble
MessageInput
MessageList
ChatHeader
```

Isso garante:

* Melhor legibilidade
* Testabilidade
* Manutenção simples

---

# Testabilidade

Possível testar:

* Controllers isoladamente
* Services mockando Firebase
* Lógica de diferenciação de usuário atual

A UI permanece desacoplada da infraestrutura.

---

# Decisões Conscientes (Importante para entrevista)

Não foi utilizada Clean Architecture completa porque:

* Escopo pequeno
* Não há múltiplas fontes de dados
* Não há regras de negócio complexas

Foi priorizada:

* Clareza
* Manutenibilidade
* Separação de responsabilidades
* Organização modular

---

# Resultado

Arquitetura:

✔ Clara
✔ Escalável
✔ Modular
✔ Sustentável
✔ Sem overengineering
