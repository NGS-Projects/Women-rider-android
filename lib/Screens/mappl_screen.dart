import 'package:womentaxi/untils/export_file.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:mappls_nearby_plugin/mappls_nearby_plugin.dart';
import 'package:mappls_gl/mappls_gl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mappls_gl/mappls_gl.dart';

// class MapplScreen extends StatefulWidget {
//   const MapplScreen({super.key});

//   @override
//   State<MapplScreen> createState() => _MapplScreenState();
// }

// class _MapplScreenState extends State<MapplScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

// class MapplScreen extends StatefulWidget {
//   const MapplScreen({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return _MapplScreenState();
//   }
// }

// class _MapplScreenState extends State {
//   static const CameraPosition _kInitialPosition = CameraPosition(
//     target: LatLng(28.705436, 77.100462),
//     zoom: 14.0,
//   );

//   late MapplsMapController mapController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Kwhite,
//           title: const Text('Add Polyline'),
//         ),
//         body: MapplsMap(
//           initialCameraPosition: _kInitialPosition,
//           onMapCreated: (mapController) {
//             this.mapController = mapController;
//           },
//           onStyleLoadedCallback: () {
//             addPolyline();
//           },
//         ));
//   }

//   void addPolyline() async {
//     List<LatLng> latlng = const <LatLng>[
//       LatLng(28.705436, 77.100462),
//       LatLng(28.705191, 77.100784),
//       LatLng(28.704646, 77.101514),
//       LatLng(28.704194, 77.101171),
//       LatLng(28.704083, 77.101066),
//       LatLng(28.703900, 77.101318)
//     ];
//     LatLngBounds latLngBounds = boundsFromLatLngList(latlng);
//     mapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds));
//     mapController.addLine(
//         LineOptions(geometry: latlng, lineColor: "#3bb2d0", lineWidth: 4));
//   }

//   boundsFromLatLngList(List<LatLng> list) {
//     assert(list.isNotEmpty);
//     double? x0, x1, y0, y1;
//     for (LatLng latLng in list) {
//       if (x0 == null || x1 == null || y0 == null || y1 == null) {
//         x0 = x1 = latLng.latitude;
//         y0 = y1 = latLng.longitude;
//       } else {
//         if (latLng.latitude > x1) x1 = latLng.latitude;
//         if (latLng.latitude < x0) x0 = latLng.latitude;
//         if (latLng.longitude > y1) y1 = latLng.longitude;
//         if (latLng.longitude < y0) y0 = latLng.longitude;
//       }
//     }
//     return LatLngBounds(
//         northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
//   }
// }

//  Worked below
// class MapplScreen extends StatefulWidget {
//   const MapplScreen({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return _MapplScreenState();
//   }
// }

// class _MapplScreenState extends State<MapplScreen> {
//   static const CameraPosition _kInitialPosition = CameraPosition(
//     target: LatLng(28.705436, 77.100462),
//     zoom: 14.0,
//   );

//   late MapplsMapController mapController;
//   final TextEditingController latController = TextEditingController();
//   final TextEditingController lngController = TextEditingController();
//   List<LatLng> latlngList = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text('Add Polyline'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: MapplsMap(
//               initialCameraPosition: _kInitialPosition,
//               onMapCreated: (mapController) {
//                 this.mapController = mapController;
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: latController,
//                     decoration: InputDecoration(
//                       labelText: 'Latitude',
//                     ),
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 Expanded(
//                   child: TextField(
//                     controller: lngController,
//                     decoration: InputDecoration(
//                       labelText: 'Longitude',
//                     ),
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     addCoordinate();
//                   },
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     addPolyline();
//                   },
//                   child: Text("Draw Polyline"),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void addCoordinate() {
//     double? lat = double.tryParse(latController.text);
//     double? lng = double.tryParse(lngController.text);
//     if (lat != null && lng != null) {
//       setState(() {
//         latlngList.add(LatLng(lat, lng));
//         latController.clear();
//         lngController.clear();
//       });
//     }
//   }

//   void addPolyline() {
//     if (latlngList.isNotEmpty) {
//       LatLngBounds latLngBounds = boundsFromLatLngList(latlngList);
//       mapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds));
//       mapController.addLine(
//         LineOptions(geometry: latlngList, lineColor: "#3bb2d0", lineWidth: 4),
//       );
//     }
//   }

//   LatLngBounds boundsFromLatLngList(List<LatLng> list) {
//     assert(list.isNotEmpty);
//     double? x0, x1, y0, y1;
//     for (LatLng latLng in list) {
//       if (x0 == null || x1 == null || y0 == null || y1 == null) {
//         x0 = x1 = latLng.latitude;
//         y0 = y1 = latLng.longitude;
//       } else {
//         if (latLng.latitude > x1) x1 = latLng.latitude;
//         if (latLng.latitude < x0) x0 = latLng.latitude;
//         if (latLng.longitude > y1) y1 = latLng.longitude;
//         if (latLng.longitude < y0) y0 = latLng.longitude;
//       }
//     }
//     return LatLngBounds(
//       northeast: LatLng(x1!, y1!),
//       southwest: LatLng(x0!, y0!),
//     );
//   }
// }

class MapplScreen extends StatefulWidget {
  const MapplScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MapplScreenState();
  }
}

class _MapplScreenState extends State<MapplScreen> {
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(28.705436, 77.100462),
    zoom: 14.0,
  );

  late MapplsMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Add Polyline'),
      ),
      body: MapplsMap(
        initialCameraPosition: _kInitialPosition,
        onMapCreated: (mapController) {
          this.mapController = mapController;
        },
        onStyleLoadedCallback: () {
          addPolyline();
        },
      ),
    );
  }

  void addPolyline() async {
    List<LatLng> latlng = const <LatLng>[
      LatLng(17.45661925876409, 78.35950987277769),
      LatLng(17.4735172962377, 78.36825365842945),
    ];
    LatLngBounds latLngBounds = boundsFromLatLngList(latlng);
    mapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds));
    mapController.addLine(
      LineOptions(geometry: latlng, lineColor: "#3bb2d0", lineWidth: 4),
    );
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null || x1 == null || y0 == null || y1 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }
}
