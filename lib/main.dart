// import 'package:flutter/material.dart';
// import 'package:mapmyindia_gl/mapmyindia_gl.dart';
// import 'package:mappls_gl/mappls_gl.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:womentaxi/untils/export_file.dart';
// import 'package:rename/rename.dart';
// // import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:womentaxi/homepage.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // await initializeService();

//   MapmyIndiaAccountManager.setMapSDKKey("aef3a4251479410db64c841609a009e0");
//   MapmyIndiaAccountManager.setRestAPIKey("aef3a4251479410db64c841609a009e0");
//   MapmyIndiaAccountManager.setAtlasClientId(
//       "96dHZVzsAutemIzgPUlICh2lAnfqn2pKRMOIUJadMfX_faSbPM_eaA8mp4DwSMSyPCscCywuTfuPwYUBCEsX5A==");
//   MapmyIndiaAccountManager.setAtlasClientSecret(
//       "lrFxI-iSEg9alwfqx0lBkIMO4sA_1S4GQuH7U-IG49VXBAejPCaA-2co7Jyu4KdhOb-MazzZVOXfLXWYP-2Z8dRN5GF-RMF3");
//   //////////////////////////////////////////
//   MapplsAccountManager.setMapSDKKey("aef3a4251479410db64c841609a009e0");
//   MapplsAccountManager.setRestAPIKey("aef3a4251479410db64c841609a009e0");
//   MapplsAccountManager.setAtlasClientId(
//       "96dHZVzsAutemIzgPUlICh2lAnfqn2pKRMOIUJadMfX_faSbPM_eaA8mp4DwSMSyPCscCywuTfuPwYUBCEsX5A==");
//   MapplsAccountManager.setAtlasClientSecret(
//       "lrFxI-iSEg9alwfqx0lBkIMO4sA_1S4GQuH7U-IG49VXBAejPCaA-2co7Jyu4KdhOb-MazzZVOXfLXWYP-2Z8dRN5GF-RMF3");

//   // belo is original

//   // MapmyIndiaAccountManager.setMapSDKKey("033f942acd66a3157a6d52a22ee81f18");
//   // MapmyIndiaAccountManager.setRestAPIKey("033f942acd66a3157a6d52a22ee81f18");
//   // MapmyIndiaAccountManager.setAtlasClientId(
//   //     "96dHZVzsAusidhUytn28QkwAnZ6bRAtUugIE6qJQ_3uRKc1qwIl4NIkCiU-a1ttK5UqamKmzCI8DEyXQyTpnow==");
//   // MapmyIndiaAccountManager.setAtlasClientSecret(
//   //     "lrFxI-iSEg9BKENPQ6Yb1lZNFHGWKlr6U-sg5kRdNkAcI6tzAFS9OkmBhZNOQnvFJ9HedN6VELQKTDqsv7wP84qDhhRdyog-");
//   // //////////////////////////////////////////
//   // MapplsAccountManager.setMapSDKKey("033f942acd66a3157a6d52a22ee81f18");
//   // MapplsAccountManager.setRestAPIKey("033f942acd66a3157a6d52a22ee81f18");
//   // MapplsAccountManager.setAtlasClientId(
//   //     "96dHZVzsAusidhUytn28QkwAnZ6bRAtUugIE6qJQ_3uRKc1qwIl4NIkCiU-a1ttK5UqamKmzCI8DEyXQyTpnow==");
//   // MapplsAccountManager.setAtlasClientSecret(
//   //     "lrFxI-iSEg9BKENPQ6Yb1lZNFHGWKlr6U-sg5kRdNkAcI6tzAFS9OkmBhZNOQnvFJ9HedN6VELQKTDqsv7wP84qDhhRdyog-");

//   await UserSimplePreferences.init();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(MediaQuery.of(context).size.width,
//           MediaQuery.of(context).size.height),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return GetMaterialApp(
//             title: "WOR",
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//               fontFamily: 'Objectivity',
//               bottomSheetTheme: const BottomSheetThemeData(
//                   backgroundColor: Colors.transparent),
//             ),
//             getPages: Routes.routes,
//             initialRoute:
//                 // KDashboard,
//                 KSplash,
//             //  kAuth_Screen,
//             builder: (context, child) {
//               return MediaQuery(
//                   data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//                   child: child!);
//             });
//       },
//     );
//   }
// }

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:mappls_gl/mappls_gl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:womentaxi/firebase_options.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'package:rename/rename.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:womentaxi/homepage.dart';
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received in background...");
  }
}

void main() async {
  // await initializeService();

  // belo is original

  // MapmyIndiaAccountManager.setMapSDKKey("033f942acd66a3157a6d52a22ee81f18");
  // MapmyIndiaAccountManager.setRestAPIKey("033f942acd66a3157a6d52a22ee81f18");
  // MapmyIndiaAccountManager.setAtlasClientId(
  //     "96dHZVzsAusidhUytn28QkwAnZ6bRAtUugIE6qJQ_3uRKc1qwIl4NIkCiU-a1ttK5UqamKmzCI8DEyXQyTpnow==");
  // MapmyIndiaAccountManager.setAtlasClientSecret(
  //     "lrFxI-iSEg9BKENPQ6Yb1lZNFHGWKlr6U-sg5kRdNkAcI6tzAFS9OkmBhZNOQnvFJ9HedN6VELQKTDqsv7wP84qDhhRdyog-");
  // //////////////////////////////////////////
  // MapplsAccountManager.setMapSDKKey("033f942acd66a3157a6d52a22ee81f18");
  // MapplsAccountManager.setRestAPIKey("033f942acd66a3157a6d52a22ee81f18");
  // MapplsAccountManager.setAtlasClientId(
  //     "96dHZVzsAusidhUytn28QkwAnZ6bRAtUugIE6qJQ_3uRKc1qwIl4NIkCiU-a1ttK5UqamKmzCI8DEyXQyTpnow==");
  // MapplsAccountManager.setAtlasClientSecret(
  //     "lrFxI-iSEg9BKENPQ6Yb1lZNFHGWKlr6U-sg5kRdNkAcI6tzAFS9OkmBhZNOQnvFJ9HedN6VELQKTDqsv7wP84qDhhRdyog-");
//////////////
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();
  // await UserSimplePreferences.init();

// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await initializeService();
  PushNotifications.init();
  await PushNotifications.localNotiInit();
  //listen bcakgroun notification
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      Get.toNamed(KSplash);
    }
  });

// to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

  // for handling in terminated state
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
      Get.toNamed(KSplash);
      // navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }
  await UserSimplePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            title: "WOR",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Objectivity',
              bottomSheetTheme: const BottomSheetThemeData(
                  backgroundColor: Colors.transparent),
            ),
            getPages: Routes.routes,
            initialRoute:
                // KDashboard,
                KSplash,
            //  kAuth_Screen,
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!);
            });
      },
    );
  }
}
