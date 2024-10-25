import 'dart:async';


import 'dart:math';


import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:get/get.dart';


import 'package:google_fonts/google_fonts.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:flutter/material.dart';


import 'package:flutter_polyline_points/flutter_polyline_points.dart';


import 'package:geolocator/geolocator.dart';


import 'package:geocoding/geocoding.dart';


import 'package:intl/intl.dart';

import 'package:womentaxi/Screens/User/User_Controllers/user_api_controllers.dart';


import 'package:womentaxi/Screens/captain/controllers/service_controller.dart';


import 'package:womentaxi/untils/constants.dart';


import '../Screens/captain/components/custom_button.dart';


import '../Screens/captain/controllers/api_controllers.dart';


class GoogleMapPage extends StatefulWidget {

  const GoogleMapPage({super.key});


  @override

  State<GoogleMapPage> createState() => GoogleMapPageState();

}


class GoogleMapPageState extends State<GoogleMapPage> {

  final Completer<GoogleMapController> _controller =

      Completer<GoogleMapController>();


  ServiceController serviceController = Get.put(ServiceController());


  ApiController apicontroller = Get.put(ApiController());


  LatLng? mountainView;


  LatLng? googlePlex;


  LatLng? currentPosition;


  Map<PolylineId, Polyline> polylines = {};


  double distance = 0.0;


  double estimatedTime = 0.0;


  CameraPosition? _kGooglePlex;


  String arrivalTime = '';


  // static   CameraPosition _kGooglePlex = CameraPosition(


  //    target: LatLng(  double.parse(serviceController.addressLatitude.value),


  //       double.parse(serviceController.addressLongitude.value),),


  // //  target: LatLng(17.470766577190037, 78.36709472827017),


  //   zoom: 14.4746,


  // );


  // @override


  // void initState() {


  //   super.initState();


  //   WidgetsBinding.instance.addPostFrameCallback((_) async {


  //     initializeCoordinates();


  //     await initializeMap();


  //   });


  // }

  UserApiController userapicontroller = Get.put(UserApiController());

  @override

  void initState() {

    super.initState();


    _kGooglePlex = CameraPosition(

      target: LatLng(

        double.parse(serviceController.addressLatitude.value),

        double.parse(serviceController.addressLongitude.value),

      ),

      zoom: 14.4746,

    );


    WidgetsBinding.instance.addPostFrameCallback((_) async {

      initializeCoordinates();


      await initializeMap();

    });


    ////// Latest changes


    setState(() {

      apicontroller.searchedData.value = {

        "waypoints": [

          {

            "name": serviceController.address.value == "" ||

                    serviceController.position == null

                ? "no name"

                : serviceController.address.value,

            "location": [

              double.parse(serviceController.addressLatitude.value),


              double.parse(serviceController.addressLongitude.value)


              // apicontroller.searchedDataV2longitude.value

            ]

          },

          {

            "name": apicontroller.searchedDataV2.value,

            "location": [

              apicontroller.searchedDataV2latittude.value,

              apicontroller.searchedDataV2longitude.value

            ]

          }

        ]

      };


      ///


      apicontroller.searchedDataPickupAddress.value =

          serviceController.address.value == "" ||

                  serviceController.position == null

              ? "no name"

              : serviceController.address.value;


      ///

    });


    apicontroller.updateSearchedDataGmapsV2Bookride();


    Future.delayed(const Duration(seconds: 0), () async {

      Get.back();


      Get.toNamed(kUserBookRide);

    });

  }


  void initializeCoordinates() {

    setState(() {

      mountainView = LatLng(

        apicontroller.searchedDataV2latittude.value,

        apicontroller.searchedDataV2longitude.value,

      );


      googlePlex = LatLng(

        double.parse(serviceController.addressLatitude.value),

        double.parse(serviceController.addressLongitude.value),

      );

    });

  }


  Future<void> initializeMap() async {

    await fetchLocationUpdates();


    final coordinates = await fetchPolylinePoints();


    if (coordinates.isNotEmpty) {

      generatePolyLineFromPoints(coordinates);


      calculateDistanceAndTime(coordinates);

    } else {

      debugPrint('No polyline coordinates found.');

    }

  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      bottomNavigationBar: Container(

        padding: EdgeInsets.all(16.r),

        height: 200.h,

        color: Kwhite,

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            //   Text('Distance: ${distance.toStringAsFixed(2)} km',),


            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text(

                  "Distance: ${distance.toStringAsFixed(2)} km",

                  style: GoogleFonts.roboto(

                      fontSize: kSixteenFont,

                      color: kcarden,

                      fontWeight: kFW500),

                ),

                Text(

                  "Estd Time: ${estimatedTime.toStringAsFixed(2)} mins",

                  style: GoogleFonts.roboto(

                      fontSize: kSixteenFont,

                      color: kcarden,

                      fontWeight: kFW500),

                ),

              ],

            ),


            SizedBox(

              height: 10.h,

            ),


            Text(

              "Arrival Time: $arrivalTime (IST)",

              style: GoogleFonts.roboto(

                  fontSize: kSixteenFont, color: kcarden, fontWeight: kFW500),

            ),


            CustomButton(

                margin: EdgeInsets.only(top: 25.h),

                width: double.infinity,

                height: 42.h,

                fontSize: kFourteenFont,

                fontWeight: kFW700,

                textColor: Kwhite,

                borderRadius: BorderRadius.circular(30.r),

                label: "Start",

                isLoading: false,

                onTap: () {

                  setState(() {

                    apicontroller.searchedData.value = {

                      "waypoints": [

                        {

                          "name": serviceController.address.value == "" ||

                                  serviceController.position == null

                              ? "no name"

                              : serviceController.address.value,

                          "location": [

                            double.parse(

                                serviceController.addressLatitude.value),


                            double.parse(

                                serviceController.addressLongitude.value)


                            // apicontroller.searchedDataV2longitude.value

                          ]

                        },

                        {

                          "name": apicontroller.searchedDataV2.value,

                          "location": [

                            apicontroller.searchedDataV2latittude.value,

                            apicontroller.searchedDataV2longitude.value

                          ]

                        }

                      ]

                    };


                    ///


                    apicontroller.searchedDataPickupAddress.value =

                        serviceController.address.value == "" ||

                                serviceController.position == null

                            ? "no name"

                            : serviceController.address.value;


                    ///

                  });


                  ///////////////////


                  // mountainView = LatLng(


                  //   apicontroller.searchedDataV2latittude.value,


                  //   apicontroller.searchedDataV2longitude.value,


                  // );


                  // googlePlex = LatLng(


                  //   double.parse(serviceController.addressLatitude.value),


                  //   double.parse(serviceController.addressLongitude.value),


                  // );


                  ////////////


                  apicontroller.updateSearchedDataGmapsV2Bookride();


                  // setState(() {


                  //   apicontroller.userRideAutenticationBody.value = {


                  //     "dropLangitude":


                  //         "${apicontroller.searchedData["waypoints"][1]["location"][0]}",


                  //     "dropLongitude":


                  //         "${apicontroller.searchedData["waypoints"][1]["location"][1]}",


                  //     "pickupLangitude":


                  //         "${apicontroller.searchedData["waypoints"][0]["location"][0]}",


                  //     "pickupLongitude":


                  //         "${apicontroller.searchedData["waypoints"][0]["location"][1]}",


                  //     "pickupAddress":


                  //         apicontroller.searchedDataPickupAddress.value,


                  //     "dropAddress":


                  //         apicontroller.searchedDataDropAddress.value,


                  //     "price": "250",


                  //     "orderPlaceTime": formattedTime,


                  //     "orderPlaceDate": formattedDate,


                  //     "vehicleType": apicontroller.selectedVehicle.value


                  //   };


                  // });


                  // if (apicontroller


                  //         .profileData["authenticationImage"] ==


                  //     null) {


                  //   Get.toNamed(kUserUploadDocs);


                  // } else {


                  //   authenticateWithBiometrics();


                  // }


                  // userapicontroller.placeOrdersUser(payload);

                }),

          ],

        ),

      ),

      appBar: AppBar(

        backgroundColor: Kwhite,

        leading: GestureDetector(

          onTap: () {

            Get.back();

          },

          child: Icon(

            Icons.arrow_back_ios,

            color: KTextdark,

          ),

        ),

        titleSpacing: 0,

        title: Text(

          "Route Details",

          style: TextStyle(fontSize: 18.sp, color: kcarden, fontWeight: kFW600),

        ),

      ),

      body: Column(

        children: [

          currentPosition == null || googlePlex == null || mountainView == null

              ? const Center(child: CircularProgressIndicator())

              : Expanded(

                  child: GoogleMap(

                    mapType: MapType.normal,

                    initialCameraPosition: _kGooglePlex!,

                    onMapCreated: (GoogleMapController controller) {

                      _controller.complete(controller);

                    },

                    markers: {

                      Marker(

                        markerId: const MarkerId('currentLocation'),

                        icon: BitmapDescriptor.defaultMarker,

                        position: currentPosition!,

                      ),

                      Marker(

                        markerId: MarkerId('sourceLocation'),

                        icon: BitmapDescriptor.defaultMarker,

                        position: googlePlex!,

                      ),

                      Marker(

                        markerId: MarkerId('destinationLocation'),

                        icon: BitmapDescriptor.defaultMarker,

                        position: mountainView!,

                      ),

                    },

                    polylines: Set<Polyline>.of(polylines.values),

                  ),


                  // GoogleMap(


                  //   mapType: MapType.normal,


                  //   initialCameraPosition: CameraPosition,


                  //   onMapCreated: (GoogleMapController controller) {


                  //     _controller.complete(controller);


                  //   },


                  //   markers: {


                  //     Marker(


                  //       markerId: const MarkerId('currentLocation'),


                  //       icon: BitmapDescriptor.defaultMarker,


                  //       position: currentPosition!,


                  //     ),


                  //     Marker(


                  //       markerId: MarkerId('sourceLocation'),


                  //       icon: BitmapDescriptor.defaultMarker,


                  //       position: googlePlex!,


                  //     ),


                  //     Marker(


                  //       markerId: MarkerId('destinationLocation'),


                  //       icon: BitmapDescriptor.defaultMarker,


                  //       position: mountainView!,


                  //     ),


                  //   },


                  //   polylines: Set<Polyline>.of(polylines.values),


                  // ),

                ),


//           Padding(


//             padding: const EdgeInsets.all(8.0),


//             child:


//             Column(


//               crossAxisAlignment: CrossAxisAlignment.start,


//               children: [


//                 //   Text('Distance: ${distance.toStringAsFixed(2)} km',),


//                 Row(


//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,


//                   children: [


//                     Text(


//                       "Distance: ${distance.toStringAsFixed(2)} km",


//                       style: GoogleFonts.roboto(


//                           fontSize: kSixteenFont,


//                           color: kcarden,


//                           fontWeight: kFW500),


//                     ),


//                     Text(


//                       "Estd Time: ${estimatedTime.toStringAsFixed(2)} mins",


//                       style: GoogleFonts.roboto(


//                           fontSize: kSixteenFont,


//                           color: kcarden,


//                           fontWeight: kFW500),


//                     ),


//                   ],


//                 ),


//                 SizedBox(


//                   height: 10.h,


//                 ),


//                 Text(


//                   "Arrival Time: $arrivalTime (IST)",


//                   style: GoogleFonts.roboto(


//                       fontSize: kSixteenFont,


//                       color: kcarden,


//                       fontWeight: kFW500),


//                 ),


//                 CustomButton(


//                     margin: EdgeInsets.only(top: 25.h),


//                     width: double.infinity,


//                     height: 42.h,


//                     fontSize: kFourteenFont,


//                     fontWeight: kFW700,


//                     textColor: Kwhite,


//                     borderRadius: BorderRadius.circular(30.r),


//                     label: "Start",


//                     isLoading: false,


//                     onTap: () {


//                       setState(() {


//                         apicontroller.searchedData.value = {


//                           "waypoints": [


//                             {


//                               "name": serviceController.address.value == "" ||


//                                       serviceController.position == null


//                                   ? "no name"


//                                   : serviceController.address.value,


//                               "location": [


//                                 double.parse(


//                                     serviceController.addressLatitude.value),


//                                 double.parse(


//                                     serviceController.addressLongitude.value)


//                                 // apicontroller.searchedDataV2longitude.value


//                               ]


//                             },


//                             {


//                               "name": apicontroller.searchedDataV2.value,


//                               "location": [


//                                 apicontroller.searchedDataV2latittude.value,


//                                 apicontroller.searchedDataV2longitude.value


//                               ]


//                             }


//                           ]


//                         };


//                         ///


//                         apicontroller.searchedDataPickupAddress.value =


//                             serviceController.address.value == "" ||


//                                     serviceController.position == null


//                                 ? "no name"


//                                 : serviceController.address.value;


//                         ///


//                       });


// ///////////////////


//                       // mountainView = LatLng(


//                       //   apicontroller.searchedDataV2latittude.value,


//                       //   apicontroller.searchedDataV2longitude.value,


//                       // );


//                       // googlePlex = LatLng(


//                       //   double.parse(serviceController.addressLatitude.value),


//                       //   double.parse(serviceController.addressLongitude.value),


//                       // );


// ////////////


//                       apicontroller.updateSearchedDataGmapsV2Bookride();


//                       // setState(() {


//                       //   apicontroller.userRideAutenticationBody.value = {


//                       //     "dropLangitude":


//                       //         "${apicontroller.searchedData["waypoints"][1]["location"][0]}",


//                       //     "dropLongitude":


//                       //         "${apicontroller.searchedData["waypoints"][1]["location"][1]}",


//                       //     "pickupLangitude":


//                       //         "${apicontroller.searchedData["waypoints"][0]["location"][0]}",


//                       //     "pickupLongitude":


//                       //         "${apicontroller.searchedData["waypoints"][0]["location"][1]}",


//                       //     "pickupAddress":


//                       //         apicontroller.searchedDataPickupAddress.value,


//                       //     "dropAddress":


//                       //         apicontroller.searchedDataDropAddress.value,


//                       //     "price": "250",


//                       //     "orderPlaceTime": formattedTime,


//                       //     "orderPlaceDate": formattedDate,


//                       //     "vehicleType": apicontroller.selectedVehicle.value


//                       //   };


//                       // });


//                       // if (apicontroller


//                       //         .profileData["authenticationImage"] ==


//                       //     null) {


//                       //   Get.toNamed(kUserUploadDocs);


//                       // } else {


//                       //   authenticateWithBiometrics();


//                       // }


//                       // userapicontroller.placeOrdersUser(payload);


//                     }),


//               ],


//             ),


//           ),

        ],

      ),

    );

  }


  Future<void> fetchLocationUpdates() async {

    bool serviceEnabled;


    LocationPermission permissionGranted;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();


    if (!serviceEnabled) {

      await Geolocator.openLocationSettings();


      return;

    }


    permissionGranted = await Geolocator.checkPermission();


    if (permissionGranted == LocationPermission.denied) {

      permissionGranted = await Geolocator.requestPermission();


      if (permissionGranted != LocationPermission.whileInUse &&

          permissionGranted != LocationPermission.always) {

        return;

      }

    }


    Position position = await Geolocator.getCurrentPosition(

        desiredAccuracy: LocationAccuracy.high);


    setState(() {

      currentPosition = LatLng(position.latitude, position.longitude);

    });

  }


  Future<List<LatLng>> fetchPolylinePoints() async {

    final polylinePoints = PolylinePoints();


    final result = await polylinePoints.getRouteBetweenCoordinates(

      googleMapsApiKey,

      PointLatLng(googlePlex!.latitude, googlePlex!.longitude),

      PointLatLng(mountainView!.latitude, mountainView!.longitude),

    );


    if (result.points.isNotEmpty) {

      final coordinates = result.points

          .map((point) => LatLng(point.latitude, point.longitude))

          .toList();


      debugPrint('Polyline points fetched: ${coordinates.length} points');


      return coordinates;

    } else {

      debugPrint('Failed to fetch polyline points: ${result.errorMessage}');


      return [];

    }

  }


  Future<void> generatePolyLineFromPoints(

      List<LatLng> polylineCoordinates) async {

    const id = PolylineId('polyline');


    final polyline = Polyline(

      polylineId: id,

      color: Kpink,

      points: polylineCoordinates,

      width: 5,

    );


    setState(() => polylines[id] = polyline);


    debugPrint('Polyline added with ${polylineCoordinates.length} points.');

  }


  void calculateDistanceAndTime(List<LatLng> coordinates) {

    if (coordinates.isNotEmpty) {

      distance = _calculateDistance(coordinates.first, coordinates.last);


      estimatedTime = (distance / 50) * 60;


      DateTime now = DateTime.now()

          .toUtc()

          .add(const Duration(hours: 5, minutes: 30)); // UTC to IST


      DateTime arrival = now.add(Duration(minutes: estimatedTime.round()));


      setState(() {

        arrivalTime = DateFormat('hh:mm a').format(arrival);

      });

    }

  }


  double _calculateDistance(LatLng start, LatLng end) {

    const double earthRadiusKm = 6371.0;


    double dLat = _degreesToRadians(end.latitude - start.latitude);


    double dLon = _degreesToRadians(end.longitude - start.longitude);


    double lat1 = _degreesToRadians(start.latitude);


    double lat2 = _degreesToRadians(end.latitude);


    double a = (sin(dLat / 2) * sin(dLat / 2)) +

        (sin(dLon / 2) * sin(dLon / 2)) * cos(lat1) * cos(lat2);


    double c = 2 * atan2(sqrt(a), sqrt(1 - a));


    return earthRadiusKm * c;

  }


  double _degreesToRadians(double degrees) {

    return degrees * pi / 180;

  }

}

