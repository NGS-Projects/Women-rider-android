// FOr getting Current location
// import 'dart:async';

// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// import 'package:mappls_gl/mappls_gl.dart';
// import 'package:womentaxi/untils/export_file.dart';
// import 'package:flutter/material.dart';

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   static const CameraPosition _kInitialPosition = CameraPosition(
//     target: LatLng(25.321684, 82.987289),
//     zoom: 14.0,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Map & Geolocation Demo'),
//         ),
//         body: MapplsMap(
//           initialCameraPosition: _kInitialPosition,
//           myLocationEnabled: true,
//           myLocationTrackingMode: MyLocationTrackingMode.Tracking,
//           onUserLocationUpdated: (location) {
//             print('onUserLocationUpdated ${location.position.toJson()}');
//           },
//         ));
//   }
// }

// Directions get

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mappls_direction_plugin/mappls_direction_plugin.dart';
import 'package:womentaxi/untils/constants.dart';
import 'package:womentaxi/untils/export_file.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State {
  ApiController apicontroller = Get.put(ApiController());
  DirectionCallback _directionCallback = DirectionCallback(null, null);

  List pickAnddrop = [];
  Map<String, dynamic>? searchedData;
  @override
  void initState() {
    openMapplsDirectionWidget();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Kwhite,
          title: const Text('Get Directions'),
        ),
        body: Center(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Text(_directionCallback.selectedIndex == null
                ? 'Selected Index: '
                : 'Selected Index: ${_directionCallback.selectedIndex}'),
            const SizedBox(
              height: 20,
            ),
            Text(_directionCallback.directionResponse?.routes == null
                ? 'Distance: '
                : 'Distance: ${_directionCallback.directionResponse?.routes![0].distance}'),
            const SizedBox(
              height: 20,
            ),
            Text(_directionCallback.directionResponse?.routes == null
                ? 'Duration: '
                : 'Duration: ${_directionCallback.directionResponse?.routes![0].duration}'),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                child: const Text('Open Direction Widget'),
                onPressed: () => {openMapplsDirectionWidget()})
          ]),
        ));
  }

  Future<void> openMapplsDirectionWidget() async {
    DirectionCallback directionCallback;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      directionCallback = await openDirectionWidget();
    } on PlatformException {
      directionCallback = DirectionCallback(null, null);
    }
    if (kDebugMode) {
      print("//////////////////ram111111111111111111111////");
      setState(() {
        searchedData = directionCallback.directionResponse?.toMap();
        apicontroller.updateSearchedData(
            directionCallback.directionResponse?.toMap() ?? {});
      });
      print(json.encode(directionCallback.directionResponse?.toMap()));
      print("//////////////////ram1111111111111111111111////");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _directionCallback = directionCallback;
    });
  }
}
