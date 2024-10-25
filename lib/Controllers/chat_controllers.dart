import 'package:womentaxi/untils/export_file.dart';

// Message model
class Messagez {
  final String text;
  final String senderId;
  final String receiverId;

  Messagez(
      {required this.text, required this.senderId, required this.receiverId});
}

class ChatController extends GetxController {
  var messages = <Messagez>[].obs;
  var messageController = TextEditingController();
  final String senderId;
  final String receiverId;

  ChatController({required this.senderId, required this.receiverId});

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      messages.add(Messagez(
        text: messageController.text,
        senderId: senderId,
        receiverId: receiverId,
      ));
      messageController.clear();
    }
  }
}
