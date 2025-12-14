import 'package:flutter_chat/models/message.dart';

abstract class Contracts {
  Stream<List<Message>> getMessages();
  Future<void> sendMessage(String text);
}
