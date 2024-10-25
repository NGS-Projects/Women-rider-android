import 'package:url_launcher/url_launcher.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
///////////////////Original code////////////////////////////////////
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   ApiController apiController = Get.put(ApiController());

// ////////////////////////////////////////////////////////////////

//   final StreamController<String> _streamController = StreamController<String>();
//   Stream<String> get messagesStream => _streamController.stream;

//   TextEditingController controller = TextEditingController();
//   ///////////////////////////////////////////////////////////////////////////////
//   List<Map<String, dynamic>> items = [];
//   IO.Socket? socket;

//   @override
//   void initState() {
//     super.initState();
//     apicontroller.getSocketiochat();

//     _setupSocketConnection();
//   }

//   void _setupSocketConnection() {
//     socket = IO.io('http://192.168.1.197:5050', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     socket?.connect();

//     socket?.onConnect((_) {
//       print('connected: ${socket?.id}');
//       socket?.emit('new-user-add', apicontroller.profileData["_id"]);
//     });

//     socket?.on('get-users', (data) {
//       print('Active users: $data');
//     });

//     socket?.onDisconnect((_) {
//       print('disconnected');
//     });

//     socket?.on('recieve-message', (data) {
//       print('New message: $data');
//     });
//   }

//   @override
//   void dispose() {
//     socket?.disconnect();
//     super.dispose();
//   }

//   ///////////////////////////////////////

// //////////////////////////////
//   /////////////
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Text("heloo"),
//       // body: Text(apiController.socketioData[]),
//     );
//   }
// }
////////////////////////
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ApiController apicontroller = Get.put(ApiController());
  UserApiController userapicontroller = Get.put(UserApiController());
  final StreamController<String> _streamController = StreamController<String>();
  final ScrollController _scrollController = ScrollController();
  Stream<String> get messagesStream => _streamController.stream;

  TextEditingController controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  List<Map<String, dynamic>> activeUsers = [];
  IO.Socket? socket;

  @override
  void initState() {
    super.initState();
    // apicontroller.getSocketiochat();
    apicontroller.socketioGetpreviousChat(apicontroller.socketioData[0]["_id"]);
    //  apicontroller.socketioGetpreviousChat(apicontroller.socketioChatID.value);
    // apicontroller.socketioGetpreviousChat(apicontroller.socketioData[0]["_id"]);
    _setupSocketConnection();
    ever(apicontroller.previousChatData, (_) {
      _scrollToBottom();
    });
  }

  void _setupSocketConnection() {
    socket = IO.io('https://womenrapido.nuhvin.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket?.connect();

    socket?.onConnect((_) {
      print('connected: ${socket?.id}');
      socket?.emit('new-user-add', apicontroller.profileData["_id"]);
    });

    socket?.on('get-users', (data) {
      setState(() {
        activeUsers = List<Map<String, dynamic>>.from(data);
      });
      print('Active users: $activeUsers');
    });

    socket?.onDisconnect((_) {
      print('disconnected');
    });

    socket?.on('recieve-message', (data) {
      // setState(() {
      //   apicontroller.previousChatData.add({
      //     'message': data['message'],
      //     'senderId': data['senderId'],
      //     // 'isMe': true,
      //     'chatId': data['chatId']
      //   });
      // });
      //   print(apicontroller.previousChatData.value);
      apicontroller
          .socketioGetpreviousChat(apicontroller.socketioData[0]["_id"]);
      //  apicontroller.updateMessage(data);
      // setState(() {
      //   apicontroller.previousChatData.add({
      //     'message': data['message'],
      //     'senderId': data['senderId'],
      //     // 'isMe': data['senderId'] == apicontroller.profileData["_id"],
      //   });
      // });
    });
  }

  void _sendMessage() {
    if (controller.text.trim().isEmpty) return;
    final message = controller.text.trim();
    final senderId = apicontroller.profileData["_id"];

    final chatId = apicontroller.socketioData[0]["_id"];
    // final chatId = apicontroller.socketioData[0]["_id"];
    final receiverId = apicontroller.socketioReceiverID.value;
    // apicontroller.socketioData[0]["members"]
    //     [1]; // Replace with the actual receiver ID

    socket?.emit('send-message', {
      'message': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'chatId': chatId
    });
    /////////////////////
    var payload = {
      "chatId": chatId,
      "message": message,
    };
    apicontroller.socketioCreateMessaage(payload);
    ///////////////

    // setState(() {
    //   apicontroller.previousChatData.add({
    //     'message': message,
    //     'senderId': senderId,
    //     // 'isMe': true,
    //     'chatId': chatId
    //   });
    // });
    // print(apicontroller.previousChatData.value);
    controller.clear();
  }

//////
  void _scrollToBottom() {
    // Delay to allow the ListView to build items before scrolling
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

////////////
  @override
  void dispose() {
    socket?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      appBar: AppBar(
        backgroundColor: KChatColor,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios)),
        titleSpacing: 0.w,
        title: SizedBox(
            width: 200.w,
            child: Obx(() => Text(
                  apicontroller.profileData["role"] == "captain"
                      ? apicontroller.chattingUser.value
                      : userapicontroller.chattingCaptain.value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                      fontSize: kSixteenFont,
                      color: KdarkText,
                      fontWeight: kFW600),
                ))),
      ),
      // appBar:
      // AppBar(
      //   title: InkWell(
      //       onTap: () {
      //         apicontroller.socketioGetpreviousChat(
      //             apicontroller.socketioData[0]["_id"]);
      //       },
      //       child: Text("Chat")),
      // ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          // Image.asset(
          //   "assets/images/chat_bg.png",
          //   // height: 150.h,
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.cover,
          // ),
          Column(
            children: [
              Expanded(
                child: Obx(() => apicontroller.previousChatData.isEmpty
                    ? Text(
                        "",
                        style: TextStyle(color: KdarkText),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        // itemCount: messages.length,
                        itemCount: apicontroller.previousChatData.length,
                        itemBuilder: (context, index) {
                          final message = apicontroller.previousChatData[index]
                                  ["message"] ??
                              "";
                          final bool containsGmail =
                              message.contains('@gmail.com');
                          final bool containsPhone = RegExp(
                            r'(\+?\d{1,3}[-.\s]?)?(\(?\d{3}\)?[-.\s]?)?[\d\s.-]{7,10}',
                            caseSensitive: false,
                          ).hasMatch(message);
                          //messages[index];
                          //  final isMe = message['isMe'];
                          return Align(
                            alignment: apicontroller.previousChatData[index]
                                        ["senderId"] !=
                                    apicontroller.profileData["_id"]
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                bool hasPhoneNumber = containsPhoneNumber(
                                    apicontroller.previousChatData[index]
                                        ["message"]);
                                bool hasGmailAddress = containsGmailAddress(
                                    apicontroller.previousChatData[index]
                                        ["message"]);
                                if (hasPhoneNumber) {
                                  launch(
                                      "tel://${apicontroller.previousChatData[index]["message"]}");
                                  // print(" phone number ${message}");
                                }

                                // if (apicontroller.previousChatData[index]["message"]
                                //     .contains("gmail.com")) {
                                else if (hasGmailAddress) {
                                  launch(Uri(
                                    scheme: 'mailto',
                                    path: apicontroller.previousChatData[index]
                                        ["message"],
                                    // queryParameters: {
                                    //   'subject': 'HI',
                                    //   'body': 'Hello',
                                    // },
                                  ).toString());

                                  //    launch(params.toString());
                                }
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     content: Text(
                                //       hasPhoneNumber
                                //           ? 'Phone number found!'
                                //           : 'No phone number found.',
                                //     ),
                                //   ),
                                // );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: apicontroller.previousChatData[index]
                                              ["senderId"] !=
                                          apicontroller.profileData["_id"]
                                      //   apicontroller.profileData["_id"]
                                      // isMe
                                      //   ? Colors.grey[300]
                                      ? Kpink.withOpacity(0.7)
                                      : KdarkText.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  message,
                                  style: TextStyle(
                                      color: containsGmail || containsPhone
                                          ? Colors.blue
                                          : apicontroller.previousChatData[
                                                      index]["senderId"] !=
                                                  apicontroller
                                                      .profileData["_id"]
                                              // apicontroller.profileData["_id"]
                                              //  isMe
                                              ? KdarkText
                                              : Kwhite),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomFormField(
                        ontap: () {},
                        enabled: true,
                        controller: controller,
                        obscureText: false,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        fontSize: kFourteenFont,
                        fontWeight: FontWeight.w500,
                        hintText: 'Type a message...',
                        maxLines: 1,
                        readOnly: false,
                        label: '',
                        validator: (value) {},
                      ),
                      // Container(
                      //   color: Kwhite,
                      //   child: TextField(
                      //     controller: controller,
                      //     decoration: InputDecoration(
                      //       hintText: 'Type a message...',
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(12),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.h),
                      child: IconButton(
                        icon: Icon(Icons.send),
                        color: Kpink,
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ////////////////////
  bool containsPhoneNumber(String text) {
    final RegExp phoneNumberRegex = RegExp(
      r'(\+?\d{1,3}[-.\s]?)?(\(?\d{3}\)?[-.\s]?)?[\d\s.-]{7,10}',
      caseSensitive: false,
    );
    return phoneNumberRegex.hasMatch(text);
  }

  /////////////////
  bool containsGmailAddress(String text) {
    final RegExp gmailRegex = RegExp(
      r'[a-zA-Z0-9._%+-]+@gmail\.com',
      caseSensitive: false,
    );
    return gmailRegex.hasMatch(text);
  }
}

// import 'dart:io';

// import 'package:flutter/material.dart';

// import 'package:intl/intl.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'dart:async';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   ApiController apicontroller = Get.put(ApiController());
//   final StreamController<String> _streamController = StreamController<String>();
//   Stream<String> get messagesStream => _streamController.stream;

//   TextEditingController controller = TextEditingController();
//   List<Map<String, dynamic>> messages = [];
//   List<Map<String, dynamic>> activeUsers = [];
//   IO.Socket? socket;

//   @override
//   void initState() {
//     super.initState();
//     // apicontroller.getSocketiochat();
//     apicontroller.socketioGetpreviousChat(apicontroller.socketioData[0]["_id"]);
//     // apicontroller.socketioGetpreviousChat(apicontroller.socketioData[0]["_id"]);
//     _setupSocketConnection();
//   }

//   void _setupSocketConnection() {
//     socket = IO.io('http://192.168.1.197:5050', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     socket?.connect();

//     socket?.onConnect((_) {
//       print('connected: ${socket?.id}');
//       socket?.emit('new-user-add', apicontroller.profileData["_id"]);
//     });

//     socket?.on('get-users', (data) {
//       setState(() {
//         activeUsers = List<Map<String, dynamic>>.from(data);
//       });
//       print('Active users: $activeUsers');
//     });

//     socket?.onDisconnect((_) {
//       print('disconnected');
//     });

//     socket?.on('recieve-message', (data) {
//       print('New message: $data');
//       setState(() {
//         messages.add({
//           'message': data['message'],
//           'senderId': data['senderId'],
//           'isMe': data['senderId'] == apicontroller.profileData["_id"],
//         });
//       });
//     });
//   }

//   void _sendMessage() {
//     if (controller.text.trim().isEmpty) return;
//     final message = controller.text.trim();
//     final senderId = apicontroller.profileData["_id"];
//     final chatId = apicontroller.socketioData[0]["_id"];
//     final receiverId = apicontroller.socketioReceiverID.value;
//     // apicontroller.socketioData[0]["members"]
//     //     [1]; // Replace with the actual receiver ID

//     socket?.emit('send-message', {
//       'message': message,
//       'senderId': senderId,
//       'receiverId': receiverId,
//       'chatId': chatId
//     });
//     /////////////////////
//     var payload = {
//       "chatId": chatId,
//       "message": message,
//     };
//     apicontroller.socketioCreateMessaage(payload);
//     ///////////////

//     // setState(() {
//     //   apicontroller.previousChatData.add({
//     //     'message': message,
//     //     'senderId': senderId,
//     //     // 'isMe': true,
//     //     'chatId': chatId
//     //   });
//     // });
//     // print(apicontroller.previousChatData.value);
//     controller.clear();
//   }

//   @override
//   void dispose() {
//     socket?.disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: InkWell(
//             onTap: () {
//               apicontroller.socketioGetpreviousChat(
//                   apicontroller.socketioData[0]["_id"]);
//             },
//             child: Text("Chat")),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() => ListView.builder(
//                   // itemCount: messages.length,
//                   itemCount: apicontroller.previousChatData.length,
//                   itemBuilder: (context, index) {
//                     final message =
//                         apicontroller.previousChatData[index]["message"];
//                     //messages[index];
//                     //  final isMe = message['isMe'];
//                     return Align(
//                       alignment: apicontroller.previousChatData[index]
//                                   ["senderId"] !=
//                               apicontroller.profileData["_id"]
//                           // isMe
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: apicontroller.previousChatData[index]
//                                       ["senderId"] !=
//                                   apicontroller.profileData["_id"]
//                               // isMe

//                               ? Colors.blue
//                               : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           message,
//                           style: TextStyle(
//                               color: apicontroller.previousChatData[index]
//                                           ["senderId"] !=
//                                       apicontroller.profileData["_id"]
//                                   //  isMe

//                                   ? Colors.white
//                                   : Colors.black),
//                         ),
//                       ),
//                     );
//                   },
//                 )),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: controller,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
