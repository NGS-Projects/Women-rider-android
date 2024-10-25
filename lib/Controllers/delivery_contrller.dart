import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'package:womentaxi/untils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mappls_gl/mappls_gl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class DeliveryController extends GetxController {
  var currentPosition = LatLng(37.42796133580664, -122.085749655962).obs;
  var startPoint = LatLng(17.45811678669201, 78.37317903104669).obs;
  var endPoint = LatLng(17.457007268408198, 78.37696671547528).obs;
  var buttonText = 'Go to Start Point'.obs;
  var buttonColor = Colors.blue.obs;
  var polylineCoordinates = <LatLng>[].obs;

  MapplsMapController? mapController;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition.value = LatLng(position.latitude, position.longitude);
    mapController?.animateCamera(CameraUpdate.newLatLng(currentPosition.value));
    drawPolyline();
    // Track location changes
    Geolocator.getPositionStream().listen((position) {
      currentPosition.value = LatLng(position.latitude, position.longitude);
      checkProximity();
      drawPolyline();
    });
  }

  void checkProximity() {
    double distanceToStart = Geolocator.distanceBetween(
      currentPosition.value.latitude,
      currentPosition.value.longitude,
      startPoint.value.latitude,
      startPoint.value.longitude,
    );

    double distanceToEnd = Geolocator.distanceBetween(
      currentPosition.value.latitude,
      currentPosition.value.longitude,
      endPoint.value.latitude,
      endPoint.value.longitude,
    );

    if (distanceToStart < 50) {
      if (buttonText.value != 'Arrived at Start Point') {
        Fluttertoast.showToast(msg: 'Arrived at Start Point');
        buttonText.value = 'Arrived at Start Point';
        buttonColor.value = Colors.orange;
      }
    } else if (distanceToEnd < 50) {
      if (buttonText.value != 'Delivered') {
        Fluttertoast.showToast(msg: 'Delivered');
        buttonText.value = 'Delivered';
        buttonColor.value = Colors.green;
      }
    } else {
      if (buttonText.value != 'Go to Start Point') {
        buttonText.value = 'Go to Start Point';
        buttonColor.value = Colors.blue;
      }
    }
  }

  void drawPolyline() {
    polylineCoordinates.clear();
    polylineCoordinates.add(startPoint.value);
    polylineCoordinates.add(currentPosition.value);
    polylineCoordinates.add(endPoint.value);
  }
}

// Google maps code
// class DeliveryController extends GetxController {
//   var currentPosition = LatLng(37.42796133580664, -122.085749655962).obs;
//   var startPoint = LatLng(17.45811678669201, 78.37317903104669).obs;
// // //   //LatLng(37.42796133580664, -122.085749655962).obs;  //
//   var endPoint = LatLng(17.457007268408198, 78.37696671547528).obs;
//   var buttonText = 'Go to Start Point'.obs;
//   var buttonColor = Colors.blue.obs;

//   GoogleMapController? mapController;

//   @override
//   void onInit() {
//     super.onInit();
//     getCurrentLocation();
//   }

//   void getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     currentPosition.value = LatLng(position.latitude, position.longitude);
//     mapController?.animateCamera(CameraUpdate.newLatLng(currentPosition.value));

//     // Track location changes
//     Geolocator.getPositionStream().listen((position) {
//       currentPosition.value = LatLng(position.latitude, position.longitude);
//       checkProximity();
//     });
//   }

//   void checkProximity() {
//     double distanceToStart = Geolocator.distanceBetween(
//       currentPosition.value.latitude,
//       currentPosition.value.longitude,
//       startPoint.value.latitude,
//       startPoint.value.longitude,
//     );

//     double distanceToEnd = Geolocator.distanceBetween(
//       currentPosition.value.latitude,
//       currentPosition.value.longitude,
//       endPoint.value.latitude,
//       endPoint.value.longitude,
//     );

//     if (distanceToStart < 50) {
//       if (buttonText.value != 'Arrived at Start Point') {
//         Fluttertoast.showToast(msg: 'Arrived at Start Point');
//         Fluttertoast.showToast(msg: 'Arrived at Start Point');
//         Fluttertoast.showToast(msg: 'Arrived at Start Point');
//         Fluttertoast.showToast(msg: 'Arrived at Start Point');
//         Fluttertoast.showToast(msg: 'Arrived at Start Point');
//         buttonText.value = 'Arrived at Start Point';
//         buttonColor.value = Colors.orange;
//       }
//     } else if (distanceToEnd < 50) {
//       if (buttonText.value != 'Delivered') {
//         Fluttertoast.showToast(msg: 'Delivered');
//         Fluttertoast.showToast(msg: 'Delivered');
//         Fluttertoast.showToast(msg: 'Delivered');
//         Fluttertoast.showToast(msg: 'Delivered');
//         Fluttertoast.showToast(msg: 'Delivered');
//         Fluttertoast.showToast(msg: 'Delivered');
//         buttonText.value = 'Delivered';
//         buttonColor.value = Colors.green;
//       }
//     } else {
//       if (buttonText.value != 'Go to Start Point') {
//         buttonText.value = 'Go to Start Point';
//         buttonColor.value = Colors.blue;
//       }
//     }
//   }

//   void moveToStartPoint() {
//     mapController?.animateCamera(CameraUpdate.newLatLng(startPoint.value));
//   }

//   void moveToEndPoint() {
//     mapController?.animateCamera(CameraUpdate.newLatLng(endPoint.value));
//   }
// }
/////////////////////////////////////////////

// old code

// class DeliveryController extends GetxController {
//   var currentPosition = LatLng(37.42796133580664, -122.085749655962).obs;
//   var startPoint = LatLng(17.45811678669201, 78.37317903104669).obs;
// //   //LatLng(37.42796133580664, -122.085749655962).obs;  //
//   var endPoint = LatLng(17.457007268408198, 78.37696671547528).obs;
//   // var startPoint = LatLng(37.42796133580664, -122.085749655962).obs;
//   // var endPoint = LatLng(37.42496133180663, -122.081743655960).obs;
//   var polylineCoordinates = <LatLng>[].obs;
//   var buttonText = 'Go to Start Point'.obs;
//   var buttonColor = Colors.blue.obs;

//   GoogleMapController? mapController;

//   @override
//   void onInit() {
//     super.onInit();
//     getCurrentLocation();
//   }

//   void getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     currentPosition.value = LatLng(position.latitude, position.longitude);
//     mapController?.animateCamera(CameraUpdate.newLatLng(currentPosition.value));

//     // Track location changes
//     Geolocator.getPositionStream().listen((position) {
//       currentPosition.value = LatLng(position.latitude, position.longitude);
//       checkProximity();
//     });
//   }

//   void checkProximity() {
//     double distanceToStart = Geolocator.distanceBetween(
//       currentPosition.value.latitude,
//       currentPosition.value.longitude,
//       startPoint.value.latitude,
//       startPoint.value.longitude,
//     );

//     double distanceToEnd = Geolocator.distanceBetween(
//       currentPosition.value.latitude,
//       currentPosition.value.longitude,
//       endPoint.value.latitude,
//       endPoint.value.longitude,
//     );

//     if (distanceToStart < 100) {
//       if (buttonText.value != 'Arrived at Start Point') {
//         Fluttertoast.showToast(msg: 'Arrived at Start Point');
//         buttonText.value = 'Arrived at Start Point';
//         buttonColor.value = Colors.orange;
//       }
//     } else if (distanceToEnd < 100) {
//       if (buttonText.value != 'Delivered') {
//         Fluttertoast.showToast(msg: 'Delivered');
//         buttonText.value = 'Delivered';
//         buttonColor.value = Colors.green;
//       }
//     } else {
//       if (buttonText.value != 'Go to Start Point') {
//         buttonText.value = 'Go to Start Point';
//         buttonColor.value = Colors.blue;
//       }
//     }
//   }

//   Future<void> moveToStartPoint() async {
//     List<LatLng> polylinePoints =
//         await getPolylinePoints(currentPosition.value, startPoint.value);
//     polylineCoordinates.assignAll(polylinePoints);

//     for (LatLng point in polylinePoints) {
//       currentPosition.value = point;
//       mapController
//           ?.animateCamera(CameraUpdate.newLatLng(currentPosition.value));
//       await Future.delayed(
//           Duration(milliseconds: 500)); // Simulating movement delay
//     }
//     buttonText.value = 'Go to End Point';
//   }

//   Future<void> moveToEndPoint() async {
//     List<LatLng> polylinePoints =
//         await getPolylinePoints(startPoint.value, endPoint.value);
//     polylineCoordinates.assignAll(polylinePoints);

//     for (LatLng point in polylinePoints) {
//       currentPosition.value = point;
//       mapController
//           ?.animateCamera(CameraUpdate.newLatLng(currentPosition.value));
//       await Future.delayed(
//           Duration(milliseconds: 500)); // Simulating movement delay
//     }
//     buttonText.value = 'Delivered';
//   }

//   Future<List<LatLng>> getPolylinePoints(LatLng start, LatLng end) async {
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       'AIzaSyBBqQ4qmiRZD_z_MSSzS_rJ7K4TbRral68',
//       // 'AIzaSyBBqQ4qmiRZD_z_MSSzS_rJ7K4TbRral68',
//       PointLatLng(start.latitude, start.longitude),
//       PointLatLng(end.latitude, end.longitude),
//     );

//     if (result.points.isNotEmpty) {
//       return result.points.map((e) => LatLng(e.latitude, e.longitude)).toList();
//     } else {
//       return [];
//     }
//   }
// }
// class DeliveryController extends GetxController {
//   var currentPosition = LatLng(37.42796133580664, -122.085749655962).obs;
//   var startPoint = LatLng(17.45811678669201, 78.37317903104669).obs;
// //   //LatLng(37.42796133580664, -122.085749655962).obs;  //
//   var endPoint = LatLng(17.457007268408198, 78.37696671547528).obs;
//   var polylineCoordinates = <LatLng>[].obs;
//   var buttonText = 'Go to Start Point'.obs;
//   var buttonColor = Colors.blue.obs;

//   GoogleMapController? mapController;

//   @override
//   void onInit() {
//     super.onInit();
//     getCurrentLocation();
//   }

//   void getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     currentPosition.value = LatLng(position.latitude, position.longitude);
//     mapController?.animateCamera(CameraUpdate.newLatLng(currentPosition.value));

//     // Track location changes
//     Geolocator.getPositionStream().listen((position) {
//       currentPosition.value = LatLng(position.latitude, position.longitude);
//       checkProximity();
//     });
//   }

//   void checkProximity() {
//     double distanceToStart = Geolocator.distanceBetween(
//       currentPosition.value.latitude,
//       currentPosition.value.longitude,
//       startPoint.value.latitude,
//       startPoint.value.longitude,
//     );

//     double distanceToEnd = Geolocator.distanceBetween(
//       currentPosition.value.latitude,
//       currentPosition.value.longitude,
//       endPoint.value.latitude,
//       endPoint.value.longitude,
//     );

//     if (distanceToStart < 50) {
//       if (buttonText.value != 'Arrived at Start Point') {
//         Fluttertoast.showToast(msg: 'Arrived at Start Point');
//         Fluttertoast.showToast(msg: 'Arrived at Start Point');
//         Fluttertoast.showToast(msg: 'Arrived at Start Point');
//         Fluttertoast.showToast(msg: 'Arrived at Start Point');
//         Fluttertoast.showToast(msg: 'Arrived at Start Point');
//         Fluttertoast.showToast(msg: 'Arrived at Start Point');
//         Fluttertoast.showToast(msg: 'Arrived at Start Point');
//         buttonText.value = 'Arrived at Start Point';
//         buttonColor.value = Colors.orange;
//       }
//     } else if (distanceToEnd < 50) {
//       if (buttonText.value != 'Delivered') {
//         Fluttertoast.showToast(msg: 'Delivered');
//         Fluttertoast.showToast(msg: 'Delivered');
//         Fluttertoast.showToast(msg: 'Delivered');
//         Fluttertoast.showToast(msg: 'Delivered');
//         Fluttertoast.showToast(msg: 'Delivered');
//         Fluttertoast.showToast(msg: 'Delivered');
//         Fluttertoast.showToast(msg: 'Delivered');

//         buttonText.value = 'Delivered';
//         buttonColor.value = Colors.green;
//       }
//     } else {
//       if (buttonText.value != 'Go to Start Point') {
//         buttonText.value = 'Go to Start Point';
//         buttonColor.value = Colors.blue;
//       }
//     }
//   }

//   Future<void> moveToStartPoint() async {
//     List<LatLng> polylinePoints =
//         await getPolylinePoints(currentPosition.value, startPoint.value);
//     polylineCoordinates.assignAll(polylinePoints);

//     for (LatLng point in polylinePoints) {
//       currentPosition.value = point;
//       mapController
//           ?.animateCamera(CameraUpdate.newLatLng(currentPosition.value));
//       await Future.delayed(
//           Duration(milliseconds: 500)); // Simulating movement delay
//     }
//     buttonText.value = 'Go to End Point';
//   }

//   Future<void> moveToEndPoint() async {
//     List<LatLng> polylinePoints =
//         await getPolylinePoints(startPoint.value, endPoint.value);
//     polylineCoordinates.assignAll(polylinePoints);

//     for (LatLng point in polylinePoints) {
//       currentPosition.value = point;
//       mapController
//           ?.animateCamera(CameraUpdate.newLatLng(currentPosition.value));
//       await Future.delayed(
//           Duration(milliseconds: 500)); // Simulating movement delay
//     }
//     buttonText.value = 'Delivered';
//   }

//   Future<List<LatLng>> getPolylinePoints(LatLng start, LatLng end) async {
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       'AIzaSyBBqQ4qmiRZD_z_MSSzS_rJ7K4TbRral68', // Provide your Google API Key here
//       PointLatLng(start.latitude, start.longitude),
//       PointLatLng(end.latitude, end.longitude),
//     );

//     if (result.points.isNotEmpty) {
//       return result.points.map((e) => LatLng(e.latitude, e.longitude)).toList();
//     } else {
//       return [];
//     }
//   }
// }
