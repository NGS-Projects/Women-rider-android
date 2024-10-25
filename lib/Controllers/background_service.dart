import 'dart:async';
import 'dart:ui';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:womentaxi/untils/export_file.dart';
// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:womentaxi/untils/export_file.dart';

Future<void> initializeService() async {}
//   TimerController timercontroller = Get.put(TimerController());
//   final service = FlutterBackgroundService();
//   await service.configure(
//       androidConfiguration: AndroidConfiguration(
//         // onStart: onStart,
//         onStart: onStart,
//         autoStart: false,
//         isForegroundMode: true,
//         // isForegroundMode: true,
//         // autoStart: true,
//         // notificationChannelId: 'my_foreground',
//         // initialNotificationTitle: 'AWESOME SERVICE',
//         // initialNotificationContent: 'Initializing',
//         // foregroundServiceNotificationId: 888,
//       ),
//       iosConfiguration: IosConfiguration(
//           autoStart: true,
//           onForeground: onStart,
//           onBackground: onIosBackground));
// }

// @pragma('vm:entry-point')
// Future<bool> onIosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//   return true;
// }

// @pragma('vm:entry-point')
// onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });

//   // void _addData(String location, String latitude, String longitude) async {
//   //   Data newData = Data(name1: "ram", name2: "nayak", name3: "nayaka");
//   //   // Data newData = Data(
//   //   //   lat: location,
//   //   //   lon: latitude,
//   //   //   address: longitude,
//   //   // );
//   //   await _databaseHelper.insertData(newData);
//   // }

//   // void _addTask(String location, String latitude, String longitude) async {
//   //   Task newTask =
//   //       Task(location: location, latitude: latitude, longitude: longitude);
//   //   await _databaseHelper.insertTask(newTask);
//   //   //  _refreshTaskList();
//   // }
//   /// new code
//   timercontroller.startTimer();
//   // _addTask("Hyderabad");

//   debugPrint("background service running");
//   Fluttertoast.showToast(msg: "background service running");
//   //old
//   // Timer.periodic(const Duration(seconds: 40), (timer) async {
//   //   if (service is AndroidServiceInstance) {
//   //     service.setForegroundNotificationInfo(
//   //         title: "Vibho HCM", content: "App is running in background");
//   //     timercontroller.startTimer();
//   //     // _addTask("Hyderabad");
//   //   }
//   //   debugPrint("background service running");
//   //   Fluttertoast.showToast(msg: "Ram Nayak");
//   //   //
//   // });

//   // Timer.periodic(const Duration(seconds: 50), (timer) async {
//   //   if (service is AndroidServiceInstance) {
//   //     if (await service.isForegroundService()) {
//   //       service.setForegroundNotificationInfo(
//   //           title: "Vibho HCM", content: "App is running in background");
//   //       // _addTask("Hyderabad");
//   //       _getCurrentLocation();
//   //       // _addData(
//   //       //     serviceController.address.value,
//   //       //     serviceController.addressLatitude.value,
//   //       //     serviceController.addressLongitude.value
//   //       //     // serviceController.latittude.toString(),
//   //       //     // serviceController.longitude.toString()
//   //       //     );
//   //       // double.parse(serviceController.position!.latitude as String)
//   //       //     .toString(),
//   //       // double.parse(serviceController.position!.longitude as String)
//   //       //     .toString());
//   //       // serviceController.position!.longitude.toString());
//   //       // Fluttertoast.showToast(msg: serviceController.address.value);
//   //       // Fluttertoast.showToast(msg: "Added to Data Base Successfully");
//   //     }
//   //   }
//   //   debugPrint("background service running");
//   //   //   Fluttertoast.showToast(msg: "Ram Nayak");
//   // });

//   // if (service is AndroidServiceForegroundType) {
//   //   service.on('setAsForeground').listen
//   // }
//   // Fluttertoast.showToast(msg: "Ram Nayak");
// }
// // Future<void> initializeService() async {
// //   final service = FlutterBackgroundService();
// //   await service.configure(
// //       androidConfiguration: AndroidConfiguration(
// //         onStart: onStart,
// //         autoStart: false, // Set to true if you want the service to auto-start
// //         isForegroundMode: true,
// //         notificationChannelId: 'my_foreground',
// //         initialNotificationTitle: 'AWESOME SERVICE',
// //         initialNotificationContent: 'Initializing',
// //         foregroundServiceNotificationId: 888,
// //       ),
// //       iosConfiguration: IosConfiguration(
// //           autoStart: true,
// //           onForeground: onStart,
// //           onBackground: onIosBackground));
// // }

// // @pragma('vm:entry-point')
// // Future<bool> onIosBackground(ServiceInstance service) async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   DartPluginRegistrant.ensureInitialized();
// //   return true;
// // }

// // @pragma('vm:entry-point')
// // onStart(ServiceInstance service) async {
// //   DartPluginRegistrant.ensureInitialized();

// //   if (service is AndroidServiceInstance) {
// //     service.on('setAsForeground').listen((event) {
// //       service.setAsForegroundService();
// //     });

// //     service.on('setAsBackground').listen((event) {
// //       service.setAsBackgroundService();
// //     });
// //   }

// //   service.on('stopService').listen((event) {
// //     service.stopSelf();
// //   });

// //   Timer.periodic(const Duration(seconds: 20), (timer) async {
// //     if (service is AndroidServiceInstance) {
// //       service.setForegroundNotificationInfo(
// //           title: "WoR", content: "App is running in background");
// //     }
// //     debugPrint("background service running");
// //   });
// // }


// // Future<void> initializeService() async {
// //   final service = FlutterBackgroundService();
// //   await service.configure(
// //       androidConfiguration: AndroidConfiguration(
// //         // onStart: onStart,
// //         onStart: onStart,
// //         autoStart: false,
// //         isForegroundMode: true,
// //         // isForegroundMode: true,
// //         //  autoStart: true,
// //         notificationChannelId: 'my_foreground',
// //         initialNotificationTitle: 'AWESOME SERVICE',
// //         initialNotificationContent: 'Initializing',
// //         foregroundServiceNotificationId: 888,
// //       ),
// //       iosConfiguration: IosConfiguration(
// //           autoStart: true,
// //           onForeground: onStart,
// //           onBackground: onIosBackground));
// // }

// // @pragma('vm:entry-point')
// // Future<bool> onIosBackground(ServiceInstance service) async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   DartPluginRegistrant.ensureInitialized();
// //   return true;
// // }

// // @pragma('vm:entry-point')
// // onStart(ServiceInstance service) async {
// //   DartPluginRegistrant.ensureInitialized();
// //   if (service is AndroidServiceInstance) {
// //     service.on('setAsForeground').listen((event) {
// //       service.setAsForegroundService();
// //     });
// //     service.on('setAsBackground').listen((event) {
// //       service.setAsBackgroundService();
// //     });
// //   }
// //   service.on('stopService').listen((event) {
// //     service.stopSelf();
// //   });

// //   // void _addData(String location, String latitude, String longitude) async {
// //   //   Data newData = Data(name1: "ram", name2: "nayak", name3: "nayaka");
// //   //   // Data newData = Data(
// //   //   //   lat: location,
// //   //   //   lon: latitude,
// //   //   //   address: longitude,
// //   //   // );
// //   //   await _databaseHelper.insertData(newData);
// //   // }

// //   // void _addTask(String location, String latitude, String longitude) async {
// //   //   Task newTask =
// //   //       Task(location: location, latitude: latitude, longitude: longitude);
// //   //   await _databaseHelper.insertTask(newTask);
// //   //   //  _refreshTaskList();
// //   // }
// //   /// new code
// //   Timer.periodic(const Duration(seconds: 20), (timer) async {
// //     if (service is AndroidServiceInstance) {
// //       service.setForegroundNotificationInfo(
// //           title: "WoR", content: "App is running in background");
// //       // _addTask("Hyderabad");
// //       Fluttertoast.showToast(
// //         msg: "sevice Started",
// //       );
// //     }
// //     debugPrint("background service running");
// //     //   Fluttertoast.showToast(msg: "Ram Nayak");
// //   });

// //   // Timer.periodic(const Duration(seconds: 50), (timer) async {
// //   //   if (service is AndroidServiceInstance) {
// //   //     if (await service.isForegroundService()) {
// //   //       service.setForegroundNotificationInfo(
// //   //           title: "Vibho HCM", content: "App is running in background");
// //   //       // _addTask("Hyderabad");
// //   //       _getCurrentLocation();
// //   //       // _addData(
// //   //       //     serviceController.address.value,
// //   //       //     serviceController.addressLatitude.value,
// //   //       //     serviceController.addressLongitude.value
// //   //       //     // serviceController.latittude.toString(),
// //   //       //     // serviceController.longitude.toString()
// //   //       //     );
// //   //       // double.parse(serviceController.position!.latitude as String)
// //   //       //     .toString(),
// //   //       // double.parse(serviceController.position!.longitude as String)
// //   //       //     .toString());
// //   //       // serviceController.position!.longitude.toString());
// //   //       // Fluttertoast.showToast(msg: serviceController.address.value);
// //   //       // Fluttertoast.showToast(msg: "Added to Data Base Successfully");
// //   //     }
// //   //   }
// //   //   debugPrint("background service running");
// //   //   //   Fluttertoast.showToast(msg: "Ram Nayak");
// //   // });

// //   // if (service is AndroidServiceForegroundType) {
// //   //   service.on('setAsForeground').listen
// //   // }
// //   // Fluttertoast.showToast(msg: "Ram Nayak");
// // }
