import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String text;
  final String senderEmail;
  final DateTime timestamp;

  const Message({
    required this.id,
    required this.text,
    required this.senderEmail,
    required this.timestamp,
  });

  @override
  List<Object> get props => [id, text, senderEmail, timestamp];
}
