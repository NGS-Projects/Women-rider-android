import 'package:womentaxi/untils/export_file.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';

class UserDropRouteScreen extends StatefulWidget {
  const UserDropRouteScreen({Key? key}) : super(key: key);

  @override
  State<UserDropRouteScreen> createState() => _UserDropRouteScreenState();
}

class _UserDropRouteScreenState extends State<UserDropRouteScreen> {
  ApiController apiController = Get.put(ApiController());
  UserApiController userapicontroller = Get.put(UserApiController());
  final RouteController controller = Get.put(RouteController());
  ServiceController serviceController = Get.put(ServiceController());
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
    startNavigation();
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
    // 17.46400973055945, 78.35909953626442
    _navigationOption.initialLatitude = 37.7749;
    _navigationOption.initialLongitude = -122.4194;
    _navigationOption.mode = MapBoxNavigationMode.drivingWithTraffic;

    MapBoxNavigation.instance.registerRouteEventListener(_onRouteEvent);
  }

  Future<void> startNavigation() async {
    final cityHall = WayPoint(
        name: userapicontroller.lastPlacedRide["pickupAddress"] ?? "No Name",
        latitude: apicontroller.searchedData["waypoints"][0]["location"][0],
        longitude: apicontroller.searchedData["waypoints"][0]["location"][1]
        // name:
        //  serviceController.captainaddress.value,
        // latitude: double.parse(serviceController.captainaddressLatitude.value),

        // longitude: double.parse(serviceController.captainaddressLongitude.value)

        );

    final downtown = WayPoint(
      name: userapicontroller.lastPlacedRide["dropAddress"] ?? "No Name",
      latitude: apicontroller.searchedData["waypoints"][1]["location"][0],
      longitude: apicontroller.searchedData["waypoints"][1]["location"][1],

      // name: apiController.acceptOrderData["pickupAddress"] ?? "No Name",
      // latitude: apiController.acceptOrderData["pickup"]["coordinates"][1],
      // longitude: apiController.acceptOrderData["pickup"]["coordinates"][0]
    );

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
      ),
    );
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
