// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:womentaxi/untils/export_file.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'dart:async';

// class PushNotifications {
//   static final _firebaseMessaging = FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   static Future init() async {
//     await _firebaseMessaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true);
//     final token = await _firebaseMessaging.getToken();
//     print("device token : $token");

//     // UserSimplePreferences.setfbNotification(fbnotification: "");
//     UserSimplePreferences.setfbNotification(fbnotification: token!);

//     print("object");
//     // UserSimplePreferences.setNotification(notification: token!);

//     // UserSimplePreferences.setNotification(notification: token!);
//   }

//   static Future localNotiInit() async {
//     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings(
//       '@mipmap/ic_launcher',
//     );
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       onDidReceiveLocalNotification: (id, title, body, payload) => null,
//     );
//     final LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(defaultActionName: 'Open notification');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsDarwin,
//             linux: initializationSettingsLinux);

//     // request notification permissions for android 13 or above
//     _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .requestNotificationsPermission();

//     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: onNotificationTap,
//         onDidReceiveBackgroundNotificationResponse: onNotificationTap);
//   }

//   // on tap local notification in foreground
//   static void onNotificationTap(NotificationResponse notificationResponse) {
//     // Get.toNamed(kAcceptOrders);
//     UserSimplePreferences.setNotification(notification: payloads!["title"]);
//     //  UserSimplePreferences.setNotification(notification: token!);
//     Get.toNamed(KSplash);

//     // navigatorKey.currentState!
//     //     .pushNamed("/message", arguments: notificationResponse);
//   }

//   // show a simple notification
//   static Future showSimpleNotification({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await _flutterLocalNotificationsPlugin
//         .show(0, title, body, notificationDetails, payload: payload);
//   }
// }

// /////////////////////////////////////////////////////////////////////////////////////////////////
// org

// import 'dart:convert'; // Add this to use jsonDecode
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:womentaxi/untils/export_file.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'dart:async';

// class PushNotifications {
//   static final _firebaseMessaging = FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   static Future init() async {
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     final token = await _firebaseMessaging.getToken();
//     print("device token : $token");

//     // Store the notification token in preferences
//     UserSimplePreferences.setfbNotification(fbnotification: token!);
//   }

//   static Future localNotiInit() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//             onDidReceiveLocalNotification: (id, title, body, payload) => null);
//     final LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(defaultActionName: 'Open notification');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//       linux: initializationSettingsLinux,
//     );

//     _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .requestNotificationsPermission();

//     _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onNotificationTap,
//       onDidReceiveBackgroundNotificationResponse: onNotificationTap,
//     );
//   }

//   // on tap local notification in foreground
//   static void onNotificationTap(NotificationResponse notificationResponse) {
//     String? payload = notificationResponse.payload;

//     if (payload != null) {
//       // Parse the payload from JSON string to a Map
//       Map<String, dynamic> payloadMap = jsonDecode(payload);

//       // Extract the "title" field and save it to shared preferences
//       String title = payloadMap["title"] ?? "No Title";

//       UserSimplePreferences.setNotification(notification: "$title");
//       UserSimplePreferences.setOrderDetails(payloadMap["orderDetails"]);
//       print("object");
//       // Navigate to the desired screen
//     } else {
//       print("Payload is null");
//     }
//   }

//   // Show a simple notification
//   static Future showSimpleNotification({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'your channel id',
//       'your channel name',
//       channelDescription: 'your channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await _flutterLocalNotificationsPlugin
//         .show(0, title, body, notificationDetails, payload: payload);
//   }
// }

import 'dart:convert'; // For jsonDecode and jsonEncode
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialize Firebase Push Notifications
  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final token = await _firebaseMessaging.getToken();
    print("device token : $token");

    // Store the notification token in preferences
    UserSimplePreferences.setfbNotification(fbnotification: token!);
  }

  // Initialize Local Notifications
  static Future localNotiInit() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: (id, title, body, payload) => null);
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
  }

  // Handle notification tap in foreground or background
  // static void onNotificationTap(NotificationResponse notificationResponse) {
  //   String? payload = notificationResponse.payload;

  //   if (payload != null) {
  //     // Parse the payload from JSON string to a Map
  //     Map<String, dynamic> payloadMap = jsonDecode(payload);

  //     // Debug: Print the entire payloadMap to verify its content
  //     print('Payload Map: $payloadMap');

  //     if (payloadMap.containsKey("orderDetails")) {
  //       // Debug: Print orderDetails specifically to verify it's correct
  //       print('Order Details: ${payloadMap["orderDetails"]}');

  //       // Extract the "title" field and save it to shared preferences
  //       String title = payloadMap["title"] ?? "No Title";
  //       UserSimplePreferences.setNotification(notification: "$title");

  //       // Save orderDetails to Shared Preferences if it's a valid Map
  //       if (payloadMap["orderDetails"] is Map) {
  //         UserSimplePreferences.setOrderDetails(
  //             "${payloadMap["orderDetails"]}" as Map<String, dynamic>);
  //         print("Order details saved successfully");
  //       } else {
  //         print("orderDetails is not a valid Map");
  //       }
  //     } else {
  //       print("orderDetails not found in the payload");
  //     }
  //   } else {
  //     print("Payload is null");
  //   }
  // }
  static void onNotificationTap(NotificationResponse notificationResponse) {
    String? payload = notificationResponse.payload;

    if (payload != null) {
      // Parse the payload from JSON string to a Map
      Map<String, dynamic> payloadMap = jsonDecode(payload);

      // Debug: Print the entire payloadMap to verify its content
      print('Payload Map: $payloadMap');

      if (payloadMap.containsKey("orderDetails")) {
        // Debug: Print orderDetails specifically to verify it's correct
        print('Order Details: ${payloadMap["orderDetails"]}');

        // Extract the "title" field and save it to shared preferences
        String title = payloadMap["title"] ?? "No Title";
        UserSimplePreferences.setNotification(notification: "NA");
        UserSimplePreferences.setNotification(notification: "$title");

        // Save orderDetails to Shared Preferences if it's a valid Map
        if (payloadMap["orderDetails"] is String) {
          // Assuming orderDetails is a JSON string, decode it
          Map<dynamic, dynamic> orderDetailsMap =
              jsonDecode(payloadMap["orderDetails"]);

          // Cast Map<dynamic, dynamic> to Map<String, dynamic>
          Map<String, dynamic> orderDetails =
              orderDetailsMap.cast<String, dynamic>();

          // Save the orderDetails in Shared Preferences
          UserSimplePreferences.setOrderDetails(orderDetails);
          print("Order details saved successfully");
        } else {
          print("orderDetails is not a valid JSON string");
        }
      } else {
        print("orderDetails not found in the payload");
      }
    } else {
      print("Payload is null");
    }
    Get.toNamed(KSplash);
  }

  // Show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
}
