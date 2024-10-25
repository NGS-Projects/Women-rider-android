import 'package:womentaxi/untils/export_file.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  final RouteController controller = Get.put(RouteController());
  MapBoxNavigationViewController? _controller;
  String? _instruction;
  bool _isMultipleStop = false;
  double? _distanceRemaining, _durationRemaining;
  bool _routeBuilt = false;
  bool _isNavigating = false;
  bool _arrived = false;
  late MapBoxOptions _navigationOption;
  MapBoxNavigation _navigation = MapBoxNavigation();

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<void> _onRouteEvent(e) async {
    _distanceRemaining = await MapBoxNavigation.instance.getDistanceRemaining();
    _durationRemaining = await MapBoxNavigation.instance.getDurationRemaining();

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        _arrived = progressEvent.arrived!;
        if (progressEvent.currentStepInstruction != null) {
          _instruction = progressEvent.currentStepInstruction;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        _routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        _routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        _isNavigating = true;
        break;
      case MapBoxEvent.on_arrival:
        _arrived = true;
        if (!_isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller?.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        _routeBuilt = false;
        _isNavigating = false;
        break;
      default:
        break;
    }
    setState(() {});
  }

  Future<void> initialize() async {
    if (!mounted) return;
    _navigationOption = MapBoxNavigation.instance.getDefaultOptions();
    _navigationOption.initialLatitude = 37.7749;
    _navigationOption.initialLongitude = -122.4194;
    _navigationOption.mode = MapBoxNavigationMode.driving;

    MapBoxNavigation.instance.registerRouteEventListener(_onRouteEvent);
  }

  Future<void> startNavigation() async {
    final cityHall = WayPoint(
        name: "City Hall",
        latitude: 17.458555308158175,
        longitude: 78.37066930213723);
    final downtown = WayPoint(
        name: "Downtown Buffalo",
        latitude: 17.463401056921214,
        longitude: 78.38292260686012);

    var wayPoints = <WayPoint>[cityHall, downtown];

    await MapBoxNavigation.instance.startNavigation(
      wayPoints: wayPoints,
      options: MapBoxOptions(
        initialLatitude: cityHall.latitude,
        initialLongitude: cityHall.longitude,
        // mode: MapBoxNavigationMode.driving,
        alternatives: false,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        simulateRoute: false,
        language: "en",
        units: VoiceUnits.metric,
        //  routeStyle: [
        //   RouteStyle(
        //     lineColor: Colors.red, // Set the desired color here
        //     lineWidth: 5.0, // Optional: set the width of the route line
        //   ),
        // ],
      ),
    );
    ///////////////////////////////////////////////////////////////
    // MapBoxNavigation.instance.setDefaultOptions(MapBoxOptions(
    //                  initialLatitude: 36.1175275,
    //                  initialLongitude: -115.1839524,
    //                  zoom: 13.0,
    //                  tilt: 0.0,
    //                  bearing: 0.0,
    //                  enableRefresh: false,
    //                  alternatives: true,
    //                  voiceInstructionsEnabled: true,
    //                  bannerInstructionsEnabled: true,
    //                  allowsUTurnAtWayPoints: true,
    //                  mode: MapBoxNavigationMode.drivingWithTraffic,
    //                  mapStyleUrlDay: "https://url_to_day_style",
    //                  mapStyleUrlNight: "https://url_to_night_style",
    //                  units: VoiceUnits.imperial,
    //                  simulateRoute: true,
    //                  language: "en"))
    ///////////////////////////////////////////////////
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Route Navigation')),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Container(
              color: Kpink.withOpacity(0.5),
              child: MapBoxNavigationView(
                options: _navigationOption,
                onRouteEvent: _onRouteEvent,
                onCreated: (MapBoxNavigationViewController controller) async {
                  _controller = controller;
                  controller.initialize();
                },
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  startNavigation();
                },
                child: const Text('Start Navigation'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// class RouteScreen extends StatefulWidget {
//   const RouteScreen({super.key});

//   @override
//   State<RouteScreen> createState() => _RouteScreenState();
// }

// class _RouteScreenState extends State<RouteScreen> {
//   final RouteController controller = Get.put(RouteController());
//   MapBoxNavigationViewController? _controller;
//   String? _instruction;
//   bool _isMultipleStop = false;
//   double? _distanceRemaining, _durationRemaining;
//   bool _routeBuilt = false;
//   bool _isNavigating = false;
//   bool _arrived = false;
//   late MapBoxOptions _navigationOption;
//   ////////////////////////////////////////////
//   Future<void> _onRouteEvent(e) async {
//     _distanceRemaining = await MapBoxNavigation.instance.getDistanceRemaining();
//     _durationRemaining = await MapBoxNavigation.instance.getDurationRemaining();

//     switch (e.eventType) {
//       case MapBoxEvent.progress_change:
//         var progressEvent = e.data as RouteProgressEvent;
//         _arrived = progressEvent.arrived!;
//         if (progressEvent.currentStepInstruction != null) {
//           _instruction = progressEvent.currentStepInstruction;
//         }
//         break;
//       case MapBoxEvent.route_building:
//       case MapBoxEvent.route_built:
//         _routeBuilt = true;
//         break;
//       case MapBoxEvent.route_build_failed:
//         _routeBuilt = false;
//         break;
//       case MapBoxEvent.navigation_running:
//         _isNavigating = true;
//         break;
//       case MapBoxEvent.on_arrival:
//         _arrived = true;
//         if (!_isMultipleStop) {
//           await Future.delayed(const Duration(seconds: 3));
//           await _controller?.finishNavigation();
//         } else {}
//         break;
//       case MapBoxEvent.navigation_finished:
//       case MapBoxEvent.navigation_cancelled:
//         _routeBuilt = false;
//         _isNavigating = false;
//         break;
//       default:
//         break;
//     }
//     //refresh UI
//     setState(() {});
//   }
//   //////////////////////////////////////

//   Future<void> initialize() async {
//     if (!mounted) return;
//     _navigationOption = MapBoxNavigation.instance.getDefaultOptions();
//     _navigationOption.initialLatitude = 37.7749;
//     _navigationOption.initialLongitude = -122.4194;
//     _navigationOption.mode = MapBoxNavigationMode.driving;
//     MapBoxNavigation.instance.registerRouteEventListener(_onRouteEvent);
//   }

//   @override
//   void initState() {
//     initialize();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 1,
//             child: Container(
//               color: Colors.grey[100],
//               child: MapBoxNavigationView(
//                 options: _navigationOption,
//                 onRouteEvent: _onRouteEvent,
//                 onCreated: (MapBoxNavigationViewController controller) async {
//                   _controller = controller;
//                   controller.initialize();
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
