import 'package:womentaxi/untils/export_file.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String text;

  Message(
      {required this.senderId, required this.receiverId, required this.text});

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      text: map['text'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
    };
  }
}
