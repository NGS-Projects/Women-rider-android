import 'package:flutter/foundation.dart';
import 'dart:async';

import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:geolocator/geolocator.dart';

import 'package:geocoding/geocoding.dart';

import 'package:intl/intl.dart';
import 'package:sliding_sheet_new/sliding_sheet_new.dart';
import 'package:womentaxi/Screens/User/User_Controllers/user_api_controllers.dart';
import 'package:womentaxi/Screens/captain/components/custom_button.dart';
import 'package:womentaxi/Screens/captain/controllers/api_controllers.dart';

import 'package:womentaxi/Screens/captain/controllers/service_controller.dart';

import 'package:womentaxi/untils/constants.dart';

import '../components/custom_form_field.dart';

// import '../Screens/captain/components/custom_button.dart';

// import '../Screens/captain/controllers/api_controllers.dart';

class ArrivedScreen extends StatefulWidget {
  const ArrivedScreen({super.key});

  @override
  State<ArrivedScreen> createState() => _ArrivedScreenState();
}

class _ArrivedScreenState extends State<ArrivedScreen> {
  ApiController apiController = Get.put(ApiController());
  /////////////////////////////////////////////////////////////////////////////////////////////////////////
  ServiceController serviceController = Get.put(ServiceController());

  double lat = 37.42796133580664;
  double lon = -122.085749655962;

  String? _captaincurrentAddress;

  var isLoading = "none";
  void _getCurrentLocation() async {
    setState(() {
      isLoading = "started";
    });
    Position? position = await _determinePosition();
    setState(() {
      serviceController.captainposition = position;
      serviceController.captainlatittude = serviceController.position!.latitude;
      serviceController.captainlongitude =
          serviceController.position!.longitude;
      _getAddressFromLatLng(position!);
    });
  }

  Future<Position?> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      } else {
        await _showMyDialog();
        if (isPermissionGiven == true) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            return Future.error('Location permissions are denied');
          }
        } else {
          Fluttertoast.showToast(
            msg: "Denined Location Will Failed To Upload Attendance",
          );
        }
      }
    } else {
      setState(() {
        isPermissionGiven = true;
      });
    }
    Position? positionData;
    try {
      positionData = await Geolocator.getCurrentPosition();
      serviceController.loacationIsEnabled(true);
      debugPrint(positionData.toString());
    } catch (e) {
      debugPrint("$e");
      serviceController.loacationIsEnabled(false);
    }
    setState(() {
      isLoading = "ended";
    });
    return positionData;
  }

  bool isPermissionGiven = false;
  Future<void> _showMyDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 350.h,
              width: double.infinity,
              padding: EdgeInsets.all(10.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('Location Permission',
                      style: GoogleFonts.roboto(
                          color: KdarkText,
                          fontSize: 14.sp,
                          fontWeight: kFW900)),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                      'Woman Taxi wants collects Your Location Info to display',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: KdarkText,
                          fontSize: kTenFont,
                          fontWeight: kFW500)),
                  SizedBox(
                    height: 15.h,
                  ),
                  Image.asset(
                    "assets/images/location.png",
                    width: 150.w,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Custom_OutlineButton(
                          borderRadius: BorderRadius.circular(15.r),
                          margin: EdgeInsets.all(10.r),
                          width: 110.w,
                          height: 35.h,
                          Color: Kpink,
                          textColor: Kpink,
                          fontSize: 12.sp,
                          fontWeight: kFW700,
                          label: "Cancel",
                          isLoading: false,
                          onTap: () {
                            setState(() {
                              isPermissionGiven = false;
                            });
                            Navigator.of(context).pop();
                          }),
                      CustomButton(
                          borderRadius: BorderRadius.circular(15.r),
                          margin: EdgeInsets.all(10.r),
                          width: 110.w,
                          height: 35.h,
                          Color: Kpink,
                          textColor: Kwhite,
                          fontSize: 12.sp,
                          fontWeight: kFW700,
                          label: "Accept",
                          isLoading: false,
                          onTap: () {
                            setState(() {
                              isPermissionGiven = true;
                            });
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(serviceController.captainposition!.latitude,
            serviceController.captainposition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _captaincurrentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},${place.postalCode}';
        serviceController.captainaddress.value =
            _captaincurrentAddress.toString();
        serviceController.captainaddressLatitude.value =
            serviceController.captainposition!.latitude.toString();
        serviceController.captainaddressLongitude.value =
            serviceController.captainposition!.longitude.toString();
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  /////////////
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(25.321684, 82.987289),
    zoom: 10.0,
  );
  ApiController apicontroller = Get.put(ApiController());
  UserApiController userapicontroller = Get.put(UserApiController());
  ApiController authentication = Get.put(ApiController());

  int selectedIndex = 0;

  int _rating = 4;
  ////////////////////////////////////////////////
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // ServiceController serviceController = Get.put(ServiceController());

  // ApiController apicontroller = Get.put(ApiController());

  LatLng? mountainView;

  LatLng? googlePlex;

  LatLng? currentPosition;

  Map<PolylineId, Polyline> polylines = {};

  double distance = 0.0;

  double estimatedTime = 0.0;

  CameraPosition? _kGooglePlex;

  String arrivalTime = '';
  ////////////////////////////////////////////
  @override
  void initState() {
    if (serviceController.captainaddress.value == "" &&
        serviceController.captainposition == null) {
      _getCurrentLocation();
    } else if (!isPermissionGiven) {
      _getCurrentLocation();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: MediaQuery.of(context).size.height / 7,
                child: Text('Do you have problem with Men Passengers ?',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                        fontSize: 12.sp, fontWeight: kFW700, color: KdarkText)),
              ),
              // Text(
              //     'How is your health ?',
              //     maxLines: 2,
              //     overflow:
              //         TextOverflow
              //             .ellipsis,
              //     style: GoogleFonts.roboto(
              //         fontSize:
              //             12.sp,
              //         fontWeight:
              //             kFW700,
              //         color:
              //             KdarkText)),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('No',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                          fontWeight: kFW700,
                          color: KdarkText)),
                ),
                TextButton(
                  // textColor: Color(0xFF6200EE),
                  //  import 'dart:convert';  // For Uri.encodeComponent

                  onPressed: () async {
                    // Optionally navigate back or perform any other actions after sending
                    apiController
                        .escapeOrder(apiController.acceptOrderData["_id"]);
                  }

                  // String whatsappUrl =
                  //     "http://localhost:3000/live-tracking/${apicontroller.emergencyContactController.text}?startLat=${apicontroller.searchedData["waypoints"][0]["location"][0]}&startLng=${apicontroller.searchedData["waypoints"][0]["location"][1]}&destLat=${apicontroller.searchedData["waypoints"][1]["location"][0]}&destLng=${apicontroller.searchedData["waypoints"][1]["location"][1]}";
                  // if (await canLaunch(whatsappUrl)) {
                  //   await launch(whatsappUrl);
                  // } else {
                  //   throw 'Could not launch $whatsappUrl';
                  // }

                  // // Get.back();

                  // Get.back();
                  // Get.back();
                  // Get.toNamed(
                  //     KBottom_navigation);
                  // Navigator.pop(context);
                  ,
                  child: Text('Yes',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                          fontWeight: kFW700,
                          color: KdarkText)),
                )
              ],
            );
          });

      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text('Dialog Title'),
      //       content: Text('This dialog was shown in initState.'),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: Text('OK'),
      //         ),
      //       ],
      //     );
      //   },
      // );
    });
    super.initState();
    /////////////////////////////////////////
    _kGooglePlex = CameraPosition(
      target: LatLng(
        // apiController.acceptOrderData["pickup"]["coordinates"][1],
        //   apiController.acceptOrderData["pickup"]["coordinates"][0]
        double.parse(serviceController.addressLatitude.value),
        double.parse(serviceController.addressLongitude.value),
      ),
      zoom: 14.4746,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initializeCoordinates();

      await initializeMap();
    });
    ////////////////////////
    setState(() {
      // selectedResource = resource[0];
    });
  }

  /////////////////////////
  void initializeCoordinates() {
    setState(() {
      mountainView = LatLng(
        double.parse(serviceController.addressLatitude.value),
        double.parse(serviceController.addressLongitude.value),
        // apiController.acceptOrderData["pickup"]["coordinates"][1],
        // apiController.acceptOrderData["pickup"]["coordinates"][0]
        // apicontroller.searchedDataV2latittude.value,
        // apicontroller.searchedDataV2longitude.value,
      );

      googlePlex = LatLng(
          apiController.acceptOrderData["pickup"]["coordinates"][1],
          apiController.acceptOrderData["pickup"]["coordinates"][0]
          // apiController.acceptOrderData["drop"]["coordinates"][1],
          // apiController.acceptOrderData["drop"]["coordinates"][0]
          // double.parse(serviceController.addressLatitude.value),
          // double.parse(serviceController.addressLongitude.value),
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

  ////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: kcarden,
            size: 20.sp,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          "Go to pickup zone",
          style: GoogleFonts.roboto(
              fontSize: kEighteenFont, fontWeight: kFW500, color: kcarden),
        ),
        actions: [
          InkWell(
            onTap: () async {
              apicontroller.getSocketiochat();
            },
            child: Icon(
              Icons.chat,
              color: kcarden,
              size: 24.sp,
            ),
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: SlidingSheet(
        elevation: 8,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.4, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Kwhite,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      topRight: Radius.circular(8.r)),
                  child: Column(
                    children: [
                      currentPosition == null ||
                              googlePlex == null ||
                              mountainView == null
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                  // Column(children: [
                  //   Expanded(
                  //       child: Stack(children: [
                  //     MapplsMap(
                  //       initialCameraPosition: _kInitialPosition,
                  //       onMapCreated: (map) => {
                  //         controller = map,
                  //       },
                  //       onStyleLoadedCallback: () => {callDirection()},
                  //     ),
                  //     SizedBox(
                  //       height: 0.h,
                  //       child: Column(
                  //         children: [
                  //           Container(
                  //               padding:
                  //                   const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  //               decoration: const BoxDecoration(
                  //                 color: Colors.white,
                  //               ),
                  //               child: DefaultTabController(
                  //                 length: 3,
                  //                 child: TabBar(
                  //                   tabs: const [
                  //                     Tab(
                  //                       icon: Icon(Icons.directions_car),
                  //                       text: "Driving",
                  //                     ),
                  //                     Tab(
                  //                       icon: Icon(Icons.directions_bike),
                  //                       text: "Biking",
                  //                     ),
                  //                     Tab(
                  //                       icon: Icon(Icons.directions_walk),
                  //                       text: "Walking",
                  //                     )
                  //                   ],
                  //                   onTap: (value) => {
                  //                     setState(() {
                  //                       selectedIndex = value;
                  //                     }),
                  //                     if (value != 0)
                  //                       {selectedResource = resource[0]},
                  //                     callDirection()
                  //                   },
                  //                   labelColor: Colors.blue,
                  //                   unselectedLabelColor: Colors.black,
                  //                 ),
                  //               )),
                  //           const SizedBox(
                  //             height: 10,
                  //           ),
                  //           selectedIndex == 0
                  //               ? Container(
                  //                   padding:
                  //                       const EdgeInsets.fromLTRB(2, 0, 2, 0),
                  //                   decoration: const BoxDecoration(
                  //                     color: Colors.white,
                  //                   ),
                  //                   child: Row(
                  //                     children: resource
                  //                         .map((data) => Expanded(
                  //                             child: RadioListTile(
                  //                                 title: Text(
                  //                                   data.text,
                  //                                   style: const TextStyle(
                  //                                       fontSize: 10),
                  //                                 ),
                  //                                 value: selectedResource,
                  //                                 groupValue: data,
                  //                                 onChanged: (val) {
                  //                                   setState(() {
                  //                                     selectedResource = data;
                  //                                   });
                  //                                   callDirection();
                  //                                 })))
                  //                         .toList(),
                  //                   ),
                  //                 )
                  //               : Container()
                  //         ],
                  //       ),
                  //     )
                  //   ])),
                  //   route != null
                  //       ? Container(
                  //           padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                  //           decoration: const BoxDecoration(
                  //             color: Colors.white,
                  //           ),
                  //           child: Text(
                  //             getDurationAndDistance(),
                  //             style: const TextStyle(fontSize: 18),
                  //           ),
                  //         )
                  //       : Container()
                  // ]),
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ),
              )
            ],
          ),
        ),
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.all(15.r),
            color: Kwhite,
            height: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Ktextcolor.withOpacity(0.5),
                        blurRadius: 5.r,
                        offset: Offset(1, 1),
                        spreadRadius: 1.r,
                      )
                    ],
                    color: Kwhite,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Ktextcolor,
                        radius: 15.r,
                        child: Icon(Icons.person),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            apiController.acceptOrderData["head"]["name"] ??
                                "No Name",
                            style: GoogleFonts.roboto(
                                fontSize: kFourteenFont,
                                color: kcarden,
                                fontWeight: kFW500),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          SizedBox(
                            width: 220.w,
                            child: Text(
                              apiController.acceptOrderData["pickupAddress"] ??
                                  "No Name",

                              //    "325, High Tension Line Rd, Srinivas Colony, Aditya Nagar, Kukatpally, Hyderabad, Telangana 500072",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  fontSize: kTwelveFont,
                                  color: Ktextcolor,
                                  fontWeight: kFW500),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustomButton(
                              width: 250.w,
                              height: 42.h,
                              fontSize: kFourteenFont,
                              fontWeight: kFW700,
                              textColor: Kwhite,
                              borderRadius: BorderRadius.circular(30.r),
                              label: "Go to Pick Up",
                              isLoading: false,
                              onTap: () async {
                                Get.toNamed(kCaptainPickUpNavigation);
                                // Get.toNamed(kDropScreen);
                              }),
                          CustomButton(
                              width: 250.w,
                              height: 42.h,
                              margin: EdgeInsets.only(top: 15.h),
                              fontSize: kFourteenFont,
                              fontWeight: kFW700,
                              textColor: Kwhite,
                              borderRadius: BorderRadius.circular(30.r),
                              label: "Arrived",
                              isLoading: false,
                              onTap: () async {
                                Get.toNamed(kDropScreen);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),

      // Column(
      //   children: [
      //     Container(
      //       height: MediaQuery.of(context).size.height / 1.5,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10.r),
      //         color: Kwhite,
      //       ),
      //       child: ClipRRect(
      //           borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(8.r),
      //               topRight: Radius.circular(8.r)),
      //           child: const Google_map()),
      //     ),
      //     SizedBox(
      //       height: 12.h,
      //     ),
      //     Container(
      //       width: double.infinity,
      //       padding: EdgeInsets.all(10.r),
      //       decoration: BoxDecoration(
      //         boxShadow: [
      //           BoxShadow(
      //             color: Ktextcolor.withOpacity(0.5),
      //             blurRadius: 5.r,
      //             offset: Offset(1, 1),
      //             spreadRadius: 1.r,
      //           )
      //         ],
      //         color: Kwhite,
      //         borderRadius: BorderRadius.circular(10.r),
      //       ),
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           CircleAvatar(
      //             backgroundColor: Ktextcolor,
      //             radius: 15.r,
      //             child: Icon(Icons.person),
      //           ),
      //           SizedBox(
      //             width: 20.w,
      //           ),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 "Sridhar Babu",
      //                 style: GoogleFonts.roboto(
      //                     fontSize: kFourteenFont,
      //                     color: kcarden,
      //                     fontWeight: kFW500),
      //               ),
      //               SizedBox(
      //                 height: 8.h,
      //               ),
      //               SizedBox(
      //                 width: 220.w,
      //                 child: Text(
      //                   "325, High Tension Line Rd, Srinivas Colony, Aditya Nagar, Kukatpally, Hyderabad, Telangana 500072",
      //                   maxLines: 2,
      //                   overflow: TextOverflow.ellipsis,
      //                   style: GoogleFonts.roboto(
      //                       fontSize: kTwelveFont,
      //                       color: Ktextcolor,
      //                       fontWeight: kFW500),
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 15.h,
      //               ),
      //               CustomButton(
      //                   width: 250.w,
      //                   height: 42.h,
      //                   fontSize: kFourteenFont,
      //                   fontWeight: kFW700,
      //                   textColor: Kwhite,
      //                   borderRadius: BorderRadius.circular(30.r),
      //                   label: "Arrived",
      //                   isLoading: false,
      //                   onTap: () async {
      //                     Get.toNamed(kDropScreen);
      //                     //  KOtpVerification
      //                     //  await Get.toNamed(kOtpVerify);
      //                   }),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  ////
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
  //////
}
