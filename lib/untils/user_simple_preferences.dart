// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:womentaxi/untils/export_file.dart';

// // class UserSimplePreferences {
// //   static late SharedPreferences _preferences;
// //   static const String isUserLoggedIn = 'isuserloggedin';
// //   static const String isToken = 'token';

// //   static const String userDataLocal = 'userData';
// //   static const String isRefreshToken = 'refresh_token';
// //   static const String isFingerprint = 'true';
// //   static const String fcmToken = 'fcmToken';
// //   static const String uniquecode = 'uniquecode';

// //   ///
// //   static const String isUserId = 'userId';

// //   static Future init() async {
// //     _preferences = await SharedPreferences.getInstance();
// //   }

// //   static Future setLoginStatus({required bool loginStatus}) async {
// //     await _preferences.setBool(isUserLoggedIn, loginStatus);
// //   }

// //   static bool? getLoginStatus() {
// //     return _preferences.getBool(isUserLoggedIn);
// //   }

// //   static Future setfcmToken(String? token) async {
// //     await _preferences.setString(fcmToken, token!);
// //   }

// //   static String? getfcmToken() {
// //     return (_preferences.getString(fcmToken));
// //   }

// //   static Future setuniquecode(String? identifier) async {
// //     await _preferences.setString(uniquecode, identifier!);
// //   }

// //   static String? getuniquecode() {
// //     return (_preferences.getString(uniquecode));
// //   }

// //   static Future setUserdata({required String userData}) async {
// //     await _preferences.setString(userDataLocal, userData);
// //   }

// //   static String? getUserdata() {
// //     return (_preferences.getString(userDataLocal));
// //   }

// //   static Future setfingerprintdata({required String userData}) async {
// //     await _preferences.setString(isFingerprint, userData);
// //   }

// //   static Future setRefreshToken({required String refreshToken}) async {
// //     await _preferences.setString(isRefreshToken, refreshToken);
// //   }

// //   static String? getRefreshToken() {
// //     return _preferences.getString(isRefreshToken);
// //   }

// //   static String? getfingerprintdata() {
// //     return (_preferences.getString(isFingerprint));
// //   }

// //   static Future setToken({required String token}) async {
// //     await _preferences.setString(isToken, token);
// //   }

// //   static String? getToken() {
// //     return _preferences.getString(isToken);
// //   }

// //   /////
// //   static Future setUserid({required String userId}) async {
// //     await _preferences.setString(isUserId, userId);
// //   }

// //   static String? getUserid() {
// //     return _preferences.getString(isUserId);
// //   }

// //   static void clearAllData() {
// //     _preferences.clear();
// //   }
// // }

// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:womentaxi/untils/export_file.dart';

// // class UserSimplePreferences {
// //   static late SharedPreferences _preferences;
// //   static const String isUserLoggedIn = 'isuserloggedin';
// //   static const String isToken = 'token';
// //   static const String isfbToken = 'fbtoken';
// //   static const String isNotification = 'notification';
// //   static const String isfbNotification = 'fbnotification';
// //   static const String userDataLocal = 'userData';
// //   static const String isRefreshToken = 'refresh_token';
// //   static const String isFingerprint = 'true';
// //   static const String fcmToken = 'fcmToken';
// //   static const String uniquecode = 'uniquecode';

// //   ///
// //   static const String isUserId = 'userId';

// //   static Future init() async {
// //     _preferences = await SharedPreferences.getInstance();
// //   }

// //   static Future setLoginStatus({required bool loginStatus}) async {
// //     await _preferences.setBool(isUserLoggedIn, loginStatus);
// //   }

// //   static bool? getLoginStatus() {
// //     return _preferences.getBool(isUserLoggedIn);
// //   }

// //   static Future setfcmToken(String? token) async {
// //     await _preferences.setString(fcmToken, token!);
// //   }

// //   static String? getfcmToken() {
// //     return (_preferences.getString(fcmToken));
// //   }

// //   static Future setuniquecode(String? identifier) async {
// //     await _preferences.setString(uniquecode, identifier!);
// //   }

// //   static String? getuniquecode() {
// //     return (_preferences.getString(uniquecode));
// //   }

// //   static Future setUserdata({required String userData}) async {
// //     await _preferences.setString(userDataLocal, userData);
// //   }

// //   static String? getUserdata() {
// //     return (_preferences.getString(userDataLocal));
// //   }

// //   static Future setfingerprintdata({required String userData}) async {
// //     await _preferences.setString(isFingerprint, userData);
// //   }

// //   static Future setRefreshToken({required String refreshToken}) async {
// //     await _preferences.setString(isRefreshToken, refreshToken);
// //   }

// //   static String? getRefreshToken() {
// //     return _preferences.getString(isRefreshToken);
// //   }

// //   static String? getfingerprintdata() {
// //     return (_preferences.getString(isFingerprint));
// //   }

// //   static Future setToken({required String token}) async {
// //     await _preferences.setString(isToken, token);
// //   }

// //   static String? getfbToken() {
// //     return _preferences.getString(isfbToken);
// //   }

// //   static Future setfbToken({required String? fbtoken}) async {
// //     await _preferences.setString(isfbToken, fbtoken!);
// //   }

// //   static String? getToken() {
// //     return _preferences.getString(isToken);
// //   }

// //   static Future setNotification({required String notification}) async {
// //     await _preferences.setString(isNotification, notification);
// //   }

// //   static String? getNotification() {
// //     return _preferences.getString(isNotification);
// //   }

// //   ///////////////////////////////////////////////////////////////////////////////
// //   static Future setfbNotification({required String fbnotification}) async {
// //     await _preferences.setString(isfbNotification, fbnotification);
// //   }

// //   static String? getfbNotification() {
// //     return _preferences.getString(isfbNotification);
// //   }
// //   ///////////////////////////////////////////////////////////////////

// //   //static const String isNotification = 'notification';
// //   /////
// //   static Future setUserid({required String userId}) async {
// //     await _preferences.setString(isUserId, userId);
// //   }

// //   static String? getUserid() {
// //     return _preferences.getString(isUserId);
// //   }

// //   static void clearAllData() {
// //     _preferences.clear();
// //   }
// // }

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:womentaxi/untils/export_file.dart';

// class UserSimplePreferences {
//   static late SharedPreferences _preferences;
//   static const String isUserLoggedIn = 'isuserloggedin';
//   static const String isToken = 'token';

//   static const String userDataLocal = 'userData';
//   static const String isRefreshToken = 'refresh_token';
//   static const String isFingerprint = 'true';
//   static const String fcmToken = 'fcmToken';
//   static const String uniquecode = 'uniquecode';

//   ///
//   static const String isUserId = 'userId';

//   static Future init() async {
//     _preferences = await SharedPreferences.getInstance();
//   }

//   static Future setLoginStatus({required bool loginStatus}) async {
//     await _preferences.setBool(isUserLoggedIn, loginStatus);
//   }

//   static bool? getLoginStatus() {
//     return _preferences.getBool(isUserLoggedIn);
//   }

//   static Future setfcmToken(String? token) async {
//     await _preferences.setString(fcmToken, token!);
//   }

//   static String? getfcmToken() {
//     return (_preferences.getString(fcmToken));
//   }

//   static Future setuniquecode(String? identifier) async {
//     await _preferences.setString(uniquecode, identifier!);
//   }

//   static String? getuniquecode() {
//     return (_preferences.getString(uniquecode));
//   }

//   static Future setUserdata({required String userData}) async {
//     await _preferences.setString(userDataLocal, userData);
//   }

//   static String? getUserdata() {
//     return (_preferences.getString(userDataLocal));
//   }

//   static Future setfingerprintdata({required String userData}) async {
//     await _preferences.setString(isFingerprint, userData);
//   }

//   static Future setRefreshToken({required String refreshToken}) async {
//     await _preferences.setString(isRefreshToken, refreshToken);
//   }

//   static String? getRefreshToken() {
//     return _preferences.getString(isRefreshToken);
//   }

//   static String? getfingerprintdata() {
//     return (_preferences.getString(isFingerprint));
//   }

//   static Future setToken({required String token}) async {
//     await _preferences.setString(isToken, token);
//   }

//   static String? getToken() {
//     return _preferences.getString(isToken);
//   }

//   /////
//   static Future setUserid({required String userId}) async {
//     await _preferences.setString(isUserId, userId);
//   }

//   static String? getUserid() {
//     return _preferences.getString(isUserId);
//   }

//   static void clearAllData() {
//     _preferences.clear();
//   }
// }

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:womentaxi/untils/export_file.dart';

// class UserSimplePreferences {
//   static late SharedPreferences _preferences;
//   static const String isUserLoggedIn = 'isuserloggedin';
//   static const String isToken = 'token';

//   static const String userDataLocal = 'userData';
//   static const String isRefreshToken = 'refresh_token';
//   static const String isFingerprint = 'true';
//   static const String fcmToken = 'fcmToken';
//   static const String uniquecode = 'uniquecode';

//   ///
//   static const String isUserId = 'userId';

//   static Future init() async {
//     _preferences = await SharedPreferences.getInstance();
//   }

//   static Future setLoginStatus({required bool loginStatus}) async {
//     await _preferences.setBool(isUserLoggedIn, loginStatus);
//   }

//   static bool? getLoginStatus() {
//     return _preferences.getBool(isUserLoggedIn);
//   }

//   static Future setfcmToken(String? token) async {
//     await _preferences.setString(fcmToken, token!);
//   }

//   static String? getfcmToken() {
//     return (_preferences.getString(fcmToken));
//   }

//   static Future setuniquecode(String? identifier) async {
//     await _preferences.setString(uniquecode, identifier!);
//   }

//   static String? getuniquecode() {
//     return (_preferences.getString(uniquecode));
//   }

//   static Future setUserdata({required String userData}) async {
//     await _preferences.setString(userDataLocal, userData);
//   }

//   static String? getUserdata() {
//     return (_preferences.getString(userDataLocal));
//   }

//   static Future setfingerprintdata({required String userData}) async {
//     await _preferences.setString(isFingerprint, userData);
//   }

//   static Future setRefreshToken({required String refreshToken}) async {
//     await _preferences.setString(isRefreshToken, refreshToken);
//   }

//   static String? getRefreshToken() {
//     return _preferences.getString(isRefreshToken);
//   }

//   static String? getfingerprintdata() {
//     return (_preferences.getString(isFingerprint));
//   }

//   static Future setToken({required String token}) async {
//     await _preferences.setString(isToken, token);
//   }

//   static String? getToken() {
//     return _preferences.getString(isToken);
//   }

//   /////
//   static Future setUserid({required String userId}) async {
//     await _preferences.setString(isUserId, userId);
//   }

//   static String? getUserid() {
//     return _preferences.getString(isUserId);
//   }

//   static void clearAllData() {
//     _preferences.clear();
//   }
// }

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:womentaxi/untils/export_file.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;
  static const String isUserLoggedIn = 'isuserloggedin';
  static const String isToken = 'token';
  static const String isfbToken = 'fbtoken';
  static const String isNotification = 'notification';
  static const String isfbNotification = 'fbnotification';
  static const String userDataLocal = 'userData';
  static const String isRefreshToken = 'refresh_token';
  static const String isFingerprint = 'true';
  static const String fcmToken = 'fcmToken';
  static const String uniquecode = 'uniquecode';
  static const String orderDetailsKey = 'orderDetails';

  ///
  static const String isUserId = 'userId';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setOrderDetails(Map<String, dynamic> orderDetails) async {
    String orderDetailsJson = jsonEncode(orderDetails); // Convert Map to JSON
    await _preferences?.setString(
        orderDetailsKey, orderDetailsJson); // Save JSON string
  }

  // Retrieve order details (return as Map<String, dynamic>)
  static Map<String, dynamic>? getOrderDetails() {
    String? orderDetailsJson = _preferences?.getString(orderDetailsKey);
    if (orderDetailsJson != null) {
      return jsonDecode(orderDetailsJson); // Convert JSON string back to Map
    }
    return null;
  }

  static Future<void> clearNotification() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('notification');
  }

  static Future removeOrderDetails() async {
    await _preferences?.remove(orderDetailsKey);
  }

  static Future setLoginStatus({required bool loginStatus}) async {
    await _preferences.setBool(isUserLoggedIn, loginStatus);
  }

  static bool? getLoginStatus() {
    return _preferences.getBool(isUserLoggedIn);
  }

  static Future setfcmToken(String? token) async {
    await _preferences.setString(fcmToken, token!);
  }

  static String? getfcmToken() {
    return (_preferences.getString(fcmToken));
  }

  static Future setuniquecode(String? identifier) async {
    await _preferences.setString(uniquecode, identifier!);
  }

  static String? getuniquecode() {
    return (_preferences.getString(uniquecode));
  }

  static Future setUserdata({required String userData}) async {
    await _preferences.setString(userDataLocal, userData);
  }

  static String? getUserdata() {
    return (_preferences.getString(userDataLocal));
  }

  static Future setfingerprintdata({required String userData}) async {
    await _preferences.setString(isFingerprint, userData);
  }

  static Future setRefreshToken({required String refreshToken}) async {
    await _preferences.setString(isRefreshToken, refreshToken);
  }

  static String? getRefreshToken() {
    return _preferences.getString(isRefreshToken);
  }

  static String? getfingerprintdata() {
    return (_preferences.getString(isFingerprint));
  }

  static Future setToken({required String token}) async {
    await _preferences.setString(isToken, token);
  }

  static String? getfbToken() {
    return _preferences.getString(isfbToken);
  }

  static Future setfbToken({required String? fbtoken}) async {
    await _preferences.setString(isfbToken, fbtoken!);
  }

  static String? getToken() {
    return _preferences.getString(isToken);
  }

  static Future setNotification({required String notification}) async {
    await _preferences.setString(isNotification, notification);
  }

  static String? getNotification() {
    return _preferences.getString(isNotification);
  }

  ///////////////////////////////////////////////////////////////////////////////
  static Future setfbNotification({required String fbnotification}) async {
    await _preferences.setString(isfbNotification, fbnotification);
  }

  static String? getfbNotification() {
    return _preferences.getString(isfbNotification);
  }
  ///////////////////////////////////////////////////////////////////

  //static const String isNotification = 'notification';
  /////
  static Future setUserid({required String userId}) async {
    await _preferences.setString(isUserId, userId);
  }

  static String? getUserid() {
    return _preferences.getString(isUserId);
  }

  static void clearAllData() {
    _preferences.clear();
  }
}
