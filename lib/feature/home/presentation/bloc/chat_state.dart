import 'package:appro_chat/feature/home/data/models/get_chat.dart';

class ChatState {}

class ChatInitial extends ChatState {}
class ChatLoading extends ChatState {}
class ChatSuccess extends ChatState {
  GetChat chat;
  ChatSuccess(this.chat);
}
class ChatFailure extends ChatState {
  String error;
  ChatFailure(this.error);
}