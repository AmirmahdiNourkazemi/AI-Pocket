import 'package:appro_chat/core/usecase/use_case.dart';

class ChatEvent {}

class SendMessageEvent extends ChatEvent {
  StoreMessage message;

  SendMessageEvent(this.message);
}
class ClearChatEvent extends ChatEvent {}