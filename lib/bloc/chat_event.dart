import 'package:equatable/equatable.dart';
import 'package:flutter_chat/models/message.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends ChatEvent {
  final String text;
  const SendMessage(this.text);
  @override
  List<Object> get props => [text];
}

class MessagesUpdated extends ChatEvent {
  final List<Message> messages;
  const MessagesUpdated(this.messages);

  @override
  List<Object> get props => [messages];
}

class MessagesError extends ChatEvent {
  final String error;
  const MessagesError(this.error);

  @override
  List<Object> get props => [error];
}
