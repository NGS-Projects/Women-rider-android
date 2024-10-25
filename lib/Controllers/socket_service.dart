import 'package:womentaxi/untils/export_file.dart';

import 'package:get/get.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io';

class SocketService {
  late IO.Socket _socket;

  void connect() {
    _socket = IO.io('http://192.168.1.198:5050', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.connect();
    ///////////////////////////////////////////////////////////////////////

    // main() {
    //   // Dart client
    //   IO.Socket socket = IO.io('http://192.168.1.198:5050');
    //   socket.onConnect((_) {
    //     print('connect');
    //     socket.emit('msg', 'test');
    //   });
    //   socket.on('event', (data) => print(data));
    //   socket.onDisconnect((_) => print('disconnect'));
    //   socket.on('fromServer', (_) => print(_));
    // }
    ////////////////////////////////////////
    _socket.onConnect((data) => print('connected'));
    // _socket.onConnect('connection', (_) {
    //   print('connected');
    // });

    _socket.on('disconnect', (_) {
      print('disconnected');
    });
  }

  void sendMessage(String message) {
    _socket.emit('chat message', message);
  }

  void onMessageReceived(Function(String) callback) {
    _socket.on('chat message', (data) {
      callback(data);
    });
  }
}
// class HomeController extends GetxController {
//   late IO.Socket _socket;
//   // var messages = <Messaged>[].obs;
//   final TextEditingController messageInputController = TextEditingController();

//   @override
//   void onInit() {
//     super.onInit();
//     _connectSocket();
//   }

//   void _connectSocket() {
//     _socket = IO.io(
//       'http://192.168.1.109:5050',
//       // Platform.isIOS ? 'http://localhost:3000' : 'http://10.0.2.2:3000',
//       IO.OptionBuilder()
//           .setTransports(['websocket']).setQuery({'username': "Ram"}).build(),
//     );
//     _socket.onConnect((data) => print('Connection established'));
//     _socket.onConnectError((data) => print('Connect Error: $data'));
//     _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
//     _socket.on('message', (data) {
//       // messages.add(Messaged.fromJson(data));
//     });
//   }

//   void sendMessage(String username) {
//     _socket.emit('message', {
//       'message': messageInputController.text.trim(),
//       'sender': username,
//       'sentAt': DateTime.now().toIso8601String(),
//     });
//     messageInputController.clear();
//   }

//   @override
//   void dispose() {
//     messageInputController.dispose();
//     super.dispose();
//   }
// }

// class SocketService {
//   late IO.Socket _socket;

//   void connect() {
//     _socket = IO.io('http://192.168.1.198:5050', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     _socket.connect();

//     _socket.on('connect', (_) {
//       print('connected');
//     });

//     _socket.on('disconnect', (_) {
//       print('disconnected');
//     });
//   }

//   void sendMessage(String message) {
//     _socket.emit('chat message', message);
//   }

//   void onMessageReceived(Function(String) callback) {
//     _socket.on('chat message', (data) {
//       callback(data);
//     });
//   }
// }

// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketService {
//   late IO.Socket _socket;

//   void connect() {
//     _socket = IO.io('http://192.168.1.198:5050', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     _socket.connect();

//     _socket.onConnect((_) {
//       print('connect');
//       _socket.emit('msg', 'test');
//     });
//     // _socket.on('connection', (ram) {
//     //   print(
//     //       '/////////////////////////////connected///////////////////////////////////////////////');
//     //   print('connected');
//     //   ram.emit('new-user-add', 'test'); // test == userID
//     // });

//     _socket.on('disconnect', (_) {
//       print('disconnected');
//     });
//   }

//   void sendMessage(String message) {
//     _socket.emit('chat message', message);
//   }

//   void onMessageReceived(Function(String) callback) {
//     _socket.on('chat message', (data) {
//       callback(data);
//     });
//   }
// }
