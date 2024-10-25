import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:womentaxi/untils/export_file.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class DeliveryScreen extends StatefulWidget {
//   const DeliveryScreen({super.key});

//   @override
//   State<DeliveryScreen> createState() => _DeliveryScreenState();
// }

// class _DeliveryScreenState extends State<DeliveryScreen> {
//   DeliveryController controller = Get.put(DeliveryController());
//   getPolyLines() {
//     polyLine.add(Polyline(
//       polylineId: const PolylineId("route1"),
//       color: Colors.blue,
//       patterns: [PatternItem.dash(20.0), PatternItem.gap(10)],
//       width: 3,
//       points: [
//         LatLng(17.458676199872176, 78.37052385727912),
//         LatLng(17.45811678669201, 78.37317903104669),
//         LatLng(17.457007268408198, 78.37696671547528)
//       ],
//     ));
//   }

//   List<Polyline> polyLine = [];
//   void _fitBounds() {
//     if (polyLine.isNotEmpty) {
//       LatLngBounds bounds = _calculateBounds();
//       controller.mapController?.animateCamera(
//         CameraUpdate.newLatLngBounds(
//           bounds,
//           50.0, // Padding around bounds
//         ),
//       );
//     }
//   }

//   LatLngBounds _calculateBounds() {
//     double minLat = double.infinity;
//     double maxLat = -double.infinity;
//     double minLng = double.infinity;
//     double maxLng = -double.infinity;

//     for (LatLng point in [
//       LatLng(17.45811678669201, 78.37317903104669),
//       LatLng(17.457007268408198, 78.37696671547528)
//     ]) {
//       if (point.latitude < minLat) minLat = point.latitude;
//       if (point.latitude > maxLat) maxLat = point.latitude;
//       if (point.longitude < minLng) minLng = point.longitude;
//       if (point.longitude > maxLng) maxLng = point.longitude;
//     }

//     LatLng southwest = LatLng(minLat, minLng);
//     LatLng northeast = LatLng(maxLat, maxLng);

//     return LatLngBounds(southwest: southwest, northeast: northeast);
//   }

//   @override
//   void initState() {
//     getPolyLines();
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Delivery Screen')),
//       body: Obx(() => Stack(
//             children: [
//               GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                     target: controller.currentPosition.value, zoom: 14.4746),
//                 polylines: polyLine.toSet(),
//                 circles: {
//                   Circle(
//                     circleId: CircleId('currentPosition'),
//                     center: controller.currentPosition.value,
//                     radius: 30.r,
//                     fillColor: Colors.blue.withOpacity(0.5),
//                     strokeColor: Colors.blue,
//                     strokeWidth: 5,
//                   ),
//                   Circle(
//                     circleId: CircleId('startPoint'),
//                     center: controller.startPoint.value,
//                     radius: 30.r,
//                     fillColor: Colors.orange.withOpacity(0.5),
//                     strokeColor: Colors.orange,
//                     strokeWidth: 5,
//                   ),
//                   Circle(
//                     circleId: CircleId('endPoint'),
//                     center: controller.endPoint.value,
//                     radius: 30.r,
//                     fillColor: Colors.green.withOpacity(0.5),
//                     strokeColor: Colors.green,
//                     strokeWidth: 5,
//                   ),
//                 },
//                 onMapCreated: (GoogleMapController mapController) {
//                   controller.mapController = mapController;
//                 },
//               ),
//               Positioned(
//                 bottom: 50,
//                 left: 50,
//                 right: 50,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       primary: controller.buttonColor.value),
//                   onPressed: () {
//                     if (controller.buttonText.value == 'Go to Start Point') {
//                       controller.moveToStartPoint();
//                     } else if (controller.buttonText.value ==
//                         'Go to End Point') {
//                       controller.moveToEndPoint();
//                     }
//                   },
//                   child: Text(controller.buttonText.value),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }

// // class DeliveryScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final DeliveryController controller = Get.put(DeliveryController());

// //     return 
// //     Scaffold(
// //       appBar: AppBar(title: Text('Delivery Screen')),
// //       body: Obx(() => Stack(
// //             children: [
// //               GoogleMap(
// //                 initialCameraPosition: CameraPosition(
// //                     target: controller.currentPosition.value, zoom: 14.4746),
// //                 circles: {
// //                   Circle(
// //                     circleId: CircleId('currentPosition'),
// //                     center: controller.currentPosition.value,
// //                     radius: 30.r,
// //                     fillColor: Colors.blue.withOpacity(0.5),
// //                     strokeColor: Colors.blue,
// //                     strokeWidth: 5,
// //                   ),
// //                   Circle(
// //                     circleId: CircleId('startPoint'),
// //                     center: controller.startPoint.value,
// //                     radius: 30.r,
// //                     fillColor: Colors.orange.withOpacity(0.5),
// //                     strokeColor: Colors.orange,
// //                     strokeWidth: 5,
// //                   ),
// //                   Circle(
// //                     circleId: CircleId('endPoint'),
// //                     center: controller.endPoint.value,
// //                     radius: 30.r,
// //                     fillColor: Colors.green.withOpacity(0.5),
// //                     strokeColor: Colors.green,
// //                     strokeWidth: 5,
// //                   ),
// //                 },
// //                 onMapCreated: (GoogleMapController mapController) {
// //                   controller.mapController = mapController;
// //                 },
// //               ),
// //               Positioned(
// //                 bottom: 50,
// //                 left: 50,
// //                 right: 50,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                       primary: controller.buttonColor.value),
// //                   onPressed: () {
// //                     if (controller.buttonText.value == 'Go to Start Point') {
// //                       controller.moveToStartPoint();
// //                     } else if (controller.buttonText.value ==
// //                         'Go to End Point') {
// //                       controller.moveToEndPoint();
// //                     }
// //                   },
// //                   child: Text(controller.buttonText.value),
// //                 ),
// //               ),
// //             ],
// //           )),
// //     );
 
// //   }
// // }

 

// // working code
// // class DeliveryScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final DeliveryController controller = Get.put(DeliveryController());

// //     return Scaffold(
// //       appBar: AppBar(title: Text('Delivery Screen')),
// //       body: Obx(() => Stack(
// //             children: [
// //               GoogleMap(
// //                 initialCameraPosition: CameraPosition(
// //                     target: controller.currentPosition.value, zoom: 14.4746),
// //                 circles: {
// //                   Circle(
// //                     circleId: CircleId('currentPosition'),
// //                     center: controller.currentPosition.value,
// //                     radius: 20.r,
// //                     fillColor: Colors.blue.withOpacity(0.5),
// //                     strokeColor: Colors.blue,
// //                     strokeWidth: 3,
// //                   ),
// //                   Circle(
// //                     circleId: CircleId('startPoint'),
// //                     center: controller.startPoint.value,
// //                     radius: 20.r,
// //                     fillColor: Colors.orange.withOpacity(0.5),
// //                     strokeColor: Colors.orange,
// //                     strokeWidth: 3,
// //                   ),
// //                   Circle(
// //                     circleId: CircleId('endPoint'),
// //                     center: controller.endPoint.value,
// //                     radius: 20.r,
// //                     fillColor: Colors.green.withOpacity(0.5),
// //                     strokeColor: Colors.green,
// //                     strokeWidth: 3,
// //                   ),
// //                 },
// //                 polylines: {
// //                   Polyline(
// //                     polylineId: PolylineId('route'),
// //                     points: controller.polylineCoordinates,
// //                     color: Colors.blue,
// //                   ),
// //                 },
// //                 onMapCreated: (GoogleMapController mapController) {
// //                   controller.mapController = mapController;
// //                 },
// //               ),
// //               Positioned(
// //                 bottom: 50,
// //                 left: 50,
// //                 right: 50,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                       primary: controller.buttonColor.value),
// //                   onPressed: () {
// //                     if (controller.buttonText.value == 'Go to Start Point') {
// //                       controller.moveToStartPoint();
// //                     } else if (controller.buttonText.value ==
// //                         'Go to End Point') {
// //                       controller.moveToEndPoint();
// //                     }
// //                   },
// //                   child: Text(controller.buttonText.value),
// //                 ),
// //               ),
// //             ],
// //           )),
// //     );
// //   }
// // }
 


// // class DeliveryScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final DeliveryController controller = Get.put(DeliveryController());

// //     return Scaffold(
// //       appBar: AppBar(title: Text('Delivery Screen')),
// //       body: Obx(() => Stack(
// //             children: [
// //               GoogleMap(
// //                 initialCameraPosition: CameraPosition(
// //                     target: controller.currentPosition.value, zoom: 14.4746),
// //                 circles: {
// //                   Circle(
// //                     circleId: CircleId('currentPosition'),
// //                     center: controller.currentPosition.value,
// //                     radius: 10,
// //                     fillColor: Colors.blue.withOpacity(0.5),
// //                     strokeColor: Colors.blue,
// //                     strokeWidth: 1,
// //                   ),
// //                   Circle(
// //                     circleId: CircleId('startPoint'),
// //                     center: controller.startPoint.value,
// //                     radius: 10,
// //                     fillColor: Colors.orange.withOpacity(0.5),
// //                     strokeColor: Colors.orange,
// //                     strokeWidth: 1,
// //                   ),
// //                   Circle(
// //                     circleId: CircleId('endPoint'),
// //                     center: controller.endPoint.value,
// //                     radius: 10,
// //                     fillColor: Colors.green.withOpacity(0.5),
// //                     strokeColor: Colors.green,
// //                     strokeWidth: 1,
// //                   ),
// //                 },
// //                 polylines: {
// //                   Polyline(
// //                     polylineId: PolylineId('route'),
// //                     points: controller.polylineCoordinates,
// //                     color: Colors.blue,
// //                   ),
// //                 },
// //                 onMapCreated: (GoogleMapController mapController) {
// //                   controller.mapController = mapController;
// //                 },
// //               ),
// //               Positioned(
// //                 bottom: 50,
// //                 left: 50,
// //                 right: 50,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                       primary: controller.buttonColor.value),
// //                   onPressed: () {
// //                     if (controller.buttonText.value == 'Go to Start Point') {
// //                       controller.moveToStartPoint();
// //                     } else if (controller.buttonText.value ==
// //                         'Go to End Point') {
// //                       controller.moveToEndPoint();
// //                     }
// //                   },
// //                   child: Text(controller.buttonText.value),
// //                 ),
// //               ),
// //             ],
// //           )),
// //     );
// //   }
// // }
 


// // class DeliveryScreen extends StatefulWidget {
// //   const DeliveryScreen({super.key});

// //   @override
// //   State<DeliveryScreen> createState() => _DeliveryScreenState();
// // }

// // class _DeliveryScreenState extends State<DeliveryScreen> {
// //   final DeliveryController controller = Get.put(DeliveryController());
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Delivery Screen')),
// //       body: Obx(() => Stack(
// //             children: [
// //               GoogleMap(
// //                 initialCameraPosition: CameraPosition(
// //                     target: controller.currentPosition.value, zoom: 14.4746),
// //                 circles: {
// //                   Circle(
// //                     circleId: CircleId('currentPosition'),
// //                     center: controller.currentPosition.value,
// //                     radius: 10,
// //                     fillColor: Colors.blue.withOpacity(0.5),
// //                     strokeColor: Colors.blue,
// //                     strokeWidth: 1,
// //                   ),
// //                   Circle(
// //                     circleId: CircleId('startPoint'),
// //                     center: controller.startPoint.value,
// //                     radius: 10,
// //                     fillColor: Colors.orange.withOpacity(0.5),
// //                     strokeColor: Colors.orange,
// //                     strokeWidth: 1,
// //                   ),
// //                   Circle(
// //                     circleId: CircleId('endPoint'),
// //                     center: controller.endPoint.value,
// //                     radius: 10,
// //                     fillColor: Colors.green.withOpacity(0.5),
// //                     strokeColor: Colors.green,
// //                     strokeWidth: 1,
// //                   ),
// //                 },
// //                 polylines: {
// //                   Polyline(
// //                     polylineId: PolylineId('route'),
// //                     points: controller.polylineCoordinates,
// //                     color: Colors.blue,
// //                   ),
// //                 },
// //                 onMapCreated: (GoogleMapController mapController) {
// //                   controller.mapController = mapController;
// //                 },
// //               ),
// //               Positioned(
// //                 bottom: 50,
// //                 left: 50,
// //                 right: 50,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                       primary: controller.buttonColor.value),
// //                   onPressed: () {
// //                     if (controller.buttonText.value == 'Go to Start Point') {
// //                       controller.moveToStartPoint();
// //                     } else if (controller.buttonText.value ==
// //                         'Go to End Point') {
// //                       controller.moveToEndPoint();
// //                     }
// //                   },
// //                   child: Text(controller.buttonText.value),
// //                 ),
// //               ),
// //             ],
// //           )),
// //     );
// //   }
// // }
// // import 'delivery_controller.dart';
// // old worked
// // class DeliveryScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final DeliveryController controller = Get.put(DeliveryController());

// //     return Scaffold(
// //       appBar: AppBar(title: Text('Delivery Screen')),
// //       body: Obx(() => Stack(
// //             children: [
// //               GoogleMap(
// //                 initialCameraPosition: CameraPosition(
// //                     target: controller.currentPosition.value, zoom: 14.4746),
// //                 polylines: {
// //                   Polyline(
// //                     polylineId: PolylineId('route'),
// //                     points: controller.polylineCoordinates,
// //                     color: Colors.blue,
// //                   ),
// //                 },
// //                 onMapCreated: (GoogleMapController mapController) {
// //                   controller.mapController = mapController;
// //                 },
// //               ),
// //               Positioned(
// //                 bottom: 50,
// //                 left: 50,
// //                 right: 50,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                       primary: controller.buttonColor.value),
// //                   onPressed: () {
// //                     if (controller.buttonText.value == 'Go to Start Point') {
// //                       controller.moveToStartPoint();
// //                     } else if (controller.buttonText.value ==
// //                         'Go to End Point') {
// //                       controller.moveToEndPoint();
// //                     }
// //                   },
// //                   child: Text(controller.buttonText.value),
// //                 ),
// //               ),
// //             ],
// //           )),
// //     );
// //   }
// // }

 
 


// // class DeliveryScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final DeliveryController controller = Get.put(DeliveryController());

// //     return Scaffold(
// //       appBar: AppBar(title: Text('Delivery Screen')),
// //       body: Obx(() => Stack(
// //         children: [
// //           GoogleMap(
// //             initialCameraPosition: CameraPosition(target: controller.currentPosition.value, zoom: 14.4746),
// //             markers: {
// //               // ignore: prefer_const_constructors
// //               Marker(markerId: MarkerId('currentPosition'), position: controller.currentPosition.value),
// //               Marker(markerId: MarkerId('startPoint'), position: controller.startPoint.value),
// //               Marker(markerId: MarkerId('endPoint'), position: controller.endPoint.value),
// //             },
// //             polylines: {
// //               Polyline(
// //                 polylineId: PolylineId('route'),
// //                 points: controller.polylineCoordinates,
// //                 color: Colors.blue,
// //               ),
// //             },
// //             onMapCreated: (GoogleMapController mapController) {
// //               controller.mapController = mapController;
// //             },
// //           ),
// //           Positioned(
// //             bottom: 50,
// //             left: 50,
// //             right: 50,
// //             child: ElevatedButton(
// //               style: ElevatedButton.styleFrom(primary: controller.buttonColor.value),
// //               onPressed: () {
// //                 if (controller.buttonText.value == 'Go to Start Point') {
// //                   controller.moveToStartPoint();
// //                 } else if (controller.buttonText.value == 'Go to End Point') {
// //                   controller.moveToEndPoint();
// //                 }
// //               },
// //               child: Text(controller.buttonText.value),
// //             ),
// //           ),
// //         ],
// //       )),
// //     );
// //   }
// // }
