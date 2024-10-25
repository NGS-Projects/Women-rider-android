import 'package:flutter/foundation.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:womentaxi/Screens/User/User_Controllers/user_api_controllers.dart';
import 'package:womentaxi/Screens/captain/components/custom_button.dart';
import 'package:womentaxi/Screens/captain/components/custom_form_field.dart';
import 'package:womentaxi/Screens/captain/controllers/api_controllers.dart';

import 'package:womentaxi/Screens/captain/controllers/service_controller.dart';

import 'package:womentaxi/untils/constants.dart';

class DropScreen extends StatefulWidget {
  const DropScreen({super.key});

  @override
  State<DropScreen> createState() => _DropScreenState();
}

class _DropScreenState extends State<DropScreen> {
  ApiController apiController = Get.put(ApiController());
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(25.321684, 82.987289),
    zoom: 10.0,
  );
  ApiController apicontroller = Get.put(ApiController());
  UserApiController userapicontroller = Get.put(UserApiController());
  ApiController authentication = Get.put(ApiController());
  // late MapplsMapController controller;
  // List<String> profile = [
  //   DirectionCriteria.PROFILE_DRIVING,
  //   DirectionCriteria.PROFILE_BIKING,
  //   DirectionCriteria.PROFILE_WALKING,
  // ];
  // List<ResourceList> resource = [
  //   ResourceList(DirectionCriteria.RESOURCE_ROUTE, "Non Traffic"),
  //   ResourceList(DirectionCriteria.RESOURCE_ROUTE_ETA, "Route ETA"),
  //   ResourceList(DirectionCriteria.RESOURCE_ROUTE_TRAFFIC, "Traffic"),
  // ];
  int selectedIndex = 0;
  // late ResourceList selectedResource;
  // DirectionsRoute? route;
  int _rating = 4;
  /////////////////////////////////////////
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
  ///////////////////////////////////
  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(apiController.acceptOrderData["pickup"]["coordinates"][1],
          apiController.acceptOrderData["pickup"]["coordinates"][0]
          // double.parse(serviceController.addressLatitude.value),
          // double.parse(serviceController.addressLongitude.value),
          ),
      zoom: 14.4746,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initializeCoordinates();

      await initializeMap();
    });
    ////////////////////////
    setState(() {});
  }

  ///////////////////
  /////////////////////////
  void initializeCoordinates() {
    setState(() {
      mountainView = LatLng(
          apiController.acceptOrderData["pickup"]["coordinates"][1],
          apiController.acceptOrderData["pickup"]["coordinates"][0]
          // apicontroller.searchedDataV2latittude.value,
          // apicontroller.searchedDataV2longitude.value,
          );

      googlePlex = LatLng(
          apiController.acceptOrderData["drop"]["coordinates"][1],
          apiController.acceptOrderData["drop"]["coordinates"][0]
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
  /////////////

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
          "Go to Drop zone",
          style: GoogleFonts.roboto(
              fontSize: kEighteenFont, fontWeight: kFW500, color: kcarden),
        ),
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
                              apiController.acceptOrderData["dropAddress"] ??
                                  "No Address",

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
                              label: "Start Ride",
                              isLoading: false,
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              7,
                                          child: CustomFormField(
                                            enabled: true,
                                            controller: apicontroller
                                                .rideStartPinController,
                                            obscureText: false,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 16,
                                                    horizontal: 8),
                                            fontSize: kFourteenFont,
                                            fontWeight: FontWeight.w500,
                                            hintText: "Enter PIN",
                                            maxLines: 1,
                                            readOnly: false,
                                            label: 'Enter',
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter PIN';
                                              }
                                              return null;
                                            },
                                          ),
                                          //     CustomFormFields(
                                          //   // controller:
                                          //   //     apiController
                                          //   //         .donorHealthreasonController,
                                          //   labelColor:
                                          //       KText,
                                          //   enabled: true,
                                          //   obscureText:
                                          //       false,
                                          //   contentPadding: const EdgeInsets
                                          //       .symmetric(
                                          //       vertical:
                                          //           16,
                                          //       horizontal:
                                          //           8),
                                          //   fontSize:
                                          //       kFourteenFont,
                                          //   fontWeight:
                                          //       FontWeight
                                          //           .w500,
                                          //   hintText:
                                          //       "Enter Reason",
                                          //   maxLines: 1,
                                          //   readOnly:
                                          //       false,
                                          //   label:
                                          //       'Reason',
                                          // ),
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
                                            child: Text('Cancel',
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
                                              var payload = {
                                                "otp": apicontroller
                                                    .rideStartPinController
                                                    .text,
                                              };

                                              apiController
                                                  .confirmcaptainStartedNavigation(
                                                      apiController
                                                              .acceptOrderData[
                                                          "_id"],
                                                      payload);
                                              Get.back();
                                            },
                                            child: Text('Submit',
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
                                // apicontroller.captainStartedNavigation(
                                //     apiController.acceptOrderData["_id"]);
                              }),
                          CustomButton(
                              margin: EdgeInsets.only(top: 35.h),
                              width: 250.w,
                              height: 42.h,
                              fontSize: kFourteenFont,
                              fontWeight: kFW700,
                              textColor: Kwhite,
                              borderRadius: BorderRadius.circular(30.r),
                              label: "Arrived",
                              isLoading: false,
                              onTap: () async {
                                Get.toNamed(kCollectAmount);
                                //  KOtpVerification ///
                                //  await Get.toNamed(kOtpVerify);
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

///////////////////
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
////////////////////
}

// class DropScreen extends StatefulWidget {
//   const DropScreen({super.key});

//   @override
//   State<DropScreen> createState() => _DropScreenState();
// }

// class _DropScreenState extends State<DropScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: InkWell(
//           onTap: () {
//             Get.back();
//           },
//           child: Icon(
//             Icons.arrow_back_ios,
//             color: kcarden,
//             size: 20.sp,
//           ),
//         ),
//         titleSpacing: 0,
//         title: Text(
//           "Go to Drop zone",
//           style: GoogleFonts.roboto(
//               fontSize: kEighteenFont, fontWeight: kFW500, color: kcarden),
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height / 1.5,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.r),
//               color: Kwhite,
//             ),
//             child: ClipRRect(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(8.r),
//                     topRight: Radius.circular(8.r)),
//                 child: const Google_map()),
//           ),
//           SizedBox(
//             height: 12.h,
//           ),
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.all(10.r),
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Ktextcolor.withOpacity(0.5),
//                   blurRadius: 5.r,
//                   offset: Offset(1, 1),
//                   spreadRadius: 1.r,
//                 )
//               ],
//               color: Kwhite,
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Ktextcolor,
//                   radius: 15.r,
//                   child: Icon(Icons.person),
//                 ),
//                 SizedBox(
//                   width: 20.w,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Sridhar Babu",
//                       style: GoogleFonts.roboto(
//                           fontSize: kFourteenFont,
//                           color: kcarden,
//                           fontWeight: kFW500),
//                     ),
//                     SizedBox(
//                       height: 8.h,
//                     ),
//                     SizedBox(
//                       width: 220.w,
//                       child: Text(
//                         "325, High Tension Line Rd, Srinivas Colony, Aditya Nagar, Kukatpally, Hyderabad, Telangana 500072",
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: GoogleFonts.roboto(
//                             fontSize: kTwelveFont,
//                             color: Ktextcolor,
//                             fontWeight: kFW500),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15.h,
//                     ),
//                     CustomButton(
//                         width: 250.w,
//                         height: 42.h,
//                         fontSize: kFourteenFont,
//                         fontWeight: kFW700,
//                         textColor: Kwhite,
//                         borderRadius: BorderRadius.circular(30.r),
//                         label: "Drop",
//                         isLoading: false,
//                         onTap: () async {
//                           Get.toNamed(kCollectAmount);
//                           //  KOtpVerification
//                           //  await Get.toNamed(kOtpVerify);
//                         }),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
