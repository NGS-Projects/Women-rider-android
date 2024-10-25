// import 'package:womentaxi/untils/export_file.dart';

// class RaidOtp extends StatefulWidget {
//   const RaidOtp({super.key});

//   @override
//   State<RaidOtp> createState() => _RaidOtpState();
// }

// ignore_for_file: depend_on_referenced_packages

// class _RaidOtpState extends State<RaidOtp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_sheet_new/sliding_sheet_new.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:womentaxi/Controllers/Order_status_controller.dart';
import 'package:womentaxi/Screens/User/User_Controllers/user_api_controllers.dart';
import 'package:womentaxi/Screens/captain/controllers/api_controllers.dart';

import 'package:womentaxi/untils/constants.dart';
//import 'package:womentaxi/untils/export_file.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:mappls_flutter_sdk/utils/color.dart';
// import 'package:mappls_flutter_sdk/utils/polyline.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

import 'package:womentaxi/Screens/captain/controllers/service_controller.dart';

import 'package:womentaxi/untils/constants.dart';

import '../captain/components/auth_screen.dart';
import '../captain/components/custom_button.dart';
// import 'package:shimmer/shimmer.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

import '../captain/components/custom_form_field.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:womentaxi/untils/export_file.dart';
// import 'package:womentaxi/untils/export_file.dart';
// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mappls_direction_plugin/mappls_direction_plugin.dart';
// import 'package:womentaxi/untils/constants.dart';
// import 'package:womentaxi/untils/export_file.dart';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:mappls_flutter_sdk/utils/color.dart';
// // import 'package:mappls_flutter_sdk/utils/polyline.dart';
// import 'package:mappls_gl/mappls_gl.dart';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:mappls_gl/mappls_gl.dart';
// import 'package:womentaxi/untils/export_file.dart';

class RaidOtp extends StatefulWidget {
  const RaidOtp({super.key});

  @override
  State<RaidOtp> createState() => _RaidOtpState();
}

class _RaidOtpState extends State<RaidOtp> {
  StatusTimerController statustimercontroller =
      Get.put(StatusTimerController());
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(25.321684, 82.987289),
    zoom: 10.0,
  );
  ApiController apicontroller = Get.put(ApiController());
  UserApiController userapicontroller = Get.put(UserApiController());
  ApiController authentication = Get.put(ApiController());
  final ProgressController progressController = Get.put(ProgressController());
  /////////
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  ServiceController serviceController = Get.put(ServiceController());

  LatLng? mountainView;

  LatLng? googlePlex;

  LatLng? currentPosition;

  Map<PolylineId, Polyline> polylines = {};

  double distance = 0.0;

  double estimatedTime = 0.0;

  String arrivalTime = '';

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(17.470766577190037, 78.36709472827017),
    zoom: 14.4746,
  );
  ///////
  double totalDistance = 0.0; // Variable to store total distance
  double totalTime = 0.0;
  int selectedIndex = 0;
  late ResourceList selectedResource;

  int _rating = 4;
  @override
  void initState() {
    setState(() {
      authentication.emergencyContactController.text =
          apicontroller.profileData["personalContact"] ?? "";
      //  apicontroller.profileData["mobile"] ?? "";
      // authentication.registerworemergencyController.value =
      //     "${apicontroller.profileData["mobile"]}" as TextEditingValue;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: MediaQuery.of(context).size.height / 7,
                child: CustomFormField(
                  enabled: true,
                  controller: apicontroller.emergencyContactController,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Enter Share Live Contact",
                  maxLines: 1,
                  readOnly: false,
                  label: 'Mobile Number',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter mobile number';
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
                    // Construct the live tracking URL to be shared
                    String liveTrackingUrl =
                        "https://livetrackingtest.nuhvin.com/live-tracking/${apicontroller.emergencyContactController.text}?startLat=${apicontroller.searchedData["waypoints"][0]["location"][0]}&startLng=${apicontroller.searchedData["waypoints"][0]["location"][1]}&destLat=${apicontroller.searchedData["waypoints"][1]["location"][0]}&destLng=${apicontroller.searchedData["waypoints"][1]["location"][1]}";

                    // URL-encode the live tracking URL to ensure it is sent properly
                    String encodedUrl = Uri.encodeComponent(liveTrackingUrl);

                    // Phone number to which the message should be sent
                    String phoneNumber =
                        apicontroller.emergencyContactController.text;

                    // WhatsApp API link to send a pre-filled message (with encoded URL)
                    String whatsappUrl =
                        "https://wa.me/$phoneNumber?text=Check%20out%20this%20live%20tracking%20link:%20$encodedUrl";

                    // Launch WhatsApp with the constructed URL
                    if (await canLaunch(whatsappUrl)) {
                      await launch(whatsappUrl);
                    } else {
                      throw 'Could not launch $whatsappUrl';
                    }

                    // Optionally navigate back or perform any other actions after sending
                    Get.back();
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initializeCoordinates();

      await initializeMap();
    });
    setState(() {});
    statustimercontroller.startTimer();
  }

  ////////////////
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

  /////////////
  void calculateDistanceAndTime(List<LatLng> coordinates) {
    for (int i = 0; i < coordinates.length - 1; i++) {
      final start = coordinates[i];
      final end = coordinates[i + 1];
      totalDistance += Geolocator.distanceBetween(
        start.latitude,
        start.longitude,
        end.latitude,
        end.longitude,
      );
    }

    // Simulate time calculation (example: assuming 1 minute per kilometer)
    totalTime =
        totalDistance / 1000.0; // Convert distance from meters to kilometers

    // Convert distance and time to string values
    String totalDistanceStr = totalDistance.toStringAsFixed(2);
    String totalTimeStr = totalTime.toStringAsFixed(2);

    // Print total distance and time
    setState(() {
      userapicontroller.totalDistanceStr.value = totalDistanceStr;
      userapicontroller.totalTimeStr.value = totalTimeStr;
    });
    print("Total Distance: $totalDistanceStr km");
    print("Total Time: $totalTimeStr minutes");
  }
  ///////////

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("dd-MM-yyyy").format(now);
    String formattedTime = DateFormat("hh:mm a").format(now);
    List<String> otpDigits =
        userapicontroller.lastPlacedRide["orderOtp"].toString().split('');
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Kwhite,
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
                    child:
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
                        currentPosition == null ||
                                googlePlex == null ||
                                mountainView == null
                            ? const Center(child: CircularProgressIndicator())
                            : Expanded(
                                child: GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition: _kGooglePlex,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                  markers: {
                                    Marker(
                                      markerId:
                                          const MarkerId('currentLocation'),
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
                              ),
                  ),
                )
              ],
            ),
          ),
          builder: (context, state) {
            return Container(
              // margin: EdgeInsets.all(15.r),

              color: kPinkBackGroundColur.withOpacity(0.1),
              height: MediaQuery.of(context).size.height,
              child: Container(
                margin: EdgeInsets.all(15.r),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8.h),
                          height: 4.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kLinegrey),
                        ),
                      ],
                    ),
                    Obx(() => userapicontroller.listenOrders["message"] ==
                            "Your Ride is completed...!"

                        // ramcompletedfor deployment
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                width: double.infinity,
                                // padding: EdgeInsets.symmetric(
                                //     vertical: 10, horizontal: 16.w.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Kwhite,
                                    boxShadow: [
                                      BoxShadow(
                                        color: KdarkText.withOpacity(0.2),
                                        blurRadius: 5,
                                        offset: Offset(2, 1),
                                        spreadRadius: 1,
                                      )
                                    ]),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 16.w.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Kwhite,
                                          boxShadow: [
                                            BoxShadow(
                                              color: KdarkText.withOpacity(0.2),
                                              blurRadius: 5,
                                              offset: Offset(2, 1),
                                              spreadRadius: 1,
                                            )
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Ride Detail",

                                                style: GoogleFonts.roboto(
                                                    fontSize: kFourteenFont,
                                                    color: kcarden,
                                                    fontWeight: kFW500),
                                                // GoogleFonts.roboto(
                                                //     fontSize: kFourteenFont,
                                                //     color: KdarkText,
                                                //     fontWeight: kFW500),
                                              ),
                                              InkWell(
                                                  onTap: () async {
                                                    userapicontroller
                                                        .userAddtoFavourite(
                                                            userapicontroller
                                                                .lastPlacedId
                                                                .value
                                                            // userapiController
                                                            //         .userSavedOrders[
                                                            //     index]["_id"]
                                                            );
                                                  },
                                                  child: Icon(
                                                    Icons.favorite_outline,
                                                    size: kEighteenFont,
                                                    color: Kpink,
                                                  ))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/images/location_green.png",
                                                height: 20.h,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(
                                                width: 16.w,
                                              ),
                                              Text(
                                                userapicontroller
                                                        .listenOrders["order"]
                                                    ["pickupAddress"],

                                                style: GoogleFonts.roboto(
                                                    fontSize: kFourteenFont,
                                                    color: kcarden,
                                                    fontWeight: kFW500),
                                                // GoogleFonts.roboto(
                                                //     fontSize: kFourteenFont,
                                                //     color: KdarkText,
                                                //     fontWeight: kFW500),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Divider(),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/images/pink_corner_arrow.png",
                                                height: 16.h,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(
                                                width: 16.w,
                                              ),
                                              Text(
                                                userapicontroller.listenOrders[
                                                            "order"]
                                                        ["dropAddress"] ??
                                                    "",
                                                style: GoogleFonts.roboto(
                                                    fontSize: kFourteenFont,
                                                    color: kcarden,
                                                    fontWeight: kFW500),
                                                //  GoogleFonts.roboto(
                                                //     fontSize: kFourteenFont,
                                                //     color: KdarkText,
                                                //     fontWeight: kFW500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 16.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                userapicontroller.listenOrders[
                                                        "order"]["distance"] ??
                                                    "No Data",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: GoogleFonts.roboto(
                                                    fontSize: kFourteenFont,
                                                    color: KdarkText,
                                                    fontWeight: kFW600),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text(
                                                "Total Ride distance",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: GoogleFonts.roboto(
                                                    fontSize: kTenFont,
                                                    color: KText,
                                                    fontWeight: kFW600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: VerticalDivider(
                                              color: KlightText,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                userapicontroller.listenOrders[
                                                        "order"]["rideTime"] ??
                                                    "No Data",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: GoogleFonts.roboto(
                                                    fontSize: kFourteenFont,
                                                    color: KdarkText,
                                                    fontWeight: kFW600),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text(
                                                "Total Ride Time",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: GoogleFonts.roboto(
                                                    fontSize: kTenFont,
                                                    color: KText,
                                                    fontWeight: kFW600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: VerticalDivider(
                                              color: KlightText,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "₹ ${userapicontroller.listenOrders["order"]["price"]}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: GoogleFonts.roboto(
                                                    fontSize: kFourteenFont,
                                                    color: KdarkText,
                                                    fontWeight: kFW600),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text(
                                                "Total Fare price",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: GoogleFonts.roboto(
                                                    fontSize: kTenFont,
                                                    color: KText,
                                                    fontWeight: kFW600),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     Image.asset(
                              //       "assets/images/location_green.png",
                              //       height: 20.h,
                              //     ),
                              //     SizedBox(
                              //       width: 10.w,
                              //     ),
                              //     Text(
                              //       userapicontroller.listenOrders["order"]
                              //           ["pickupAddress"],
                              //       //  userapicontroller.lastPlacedRide["pickupAddress"],
                              //       style: GoogleFonts.roboto(
                              //           fontSize: kFourteenFont,
                              //           color: KText,
                              //           fontWeight: kFW600),
                              //     ),
                              //   ],
                              // ),
                              // Divider(),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     Image.asset(
                              //       "assets/images/right_arrow_pink.png",
                              //       height: 20.h,
                              //     ),
                              //     SizedBox(
                              //       width: 10.w,
                              //     ),
                              //     Text(
                              //       userapicontroller.listenOrders["order"]
                              //               ["dropAddress"] ??
                              //           "",
                              //       // userapicontroller.lastPlacedRide["dropAddress"] ??
                              //       //     "",
                              //       overflow: TextOverflow.ellipsis,
                              //       maxLines: 1,
                              //       style: GoogleFonts.roboto(
                              //           fontSize: kFourteenFont,
                              //           color: KText,
                              //           fontWeight: kFW600),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 30.h,
                              // ),

                              SizedBox(
                                height: 20.h,
                              ),
                              ////////////////////////////////////////////////////////////////////////////

                              //////////////////////////////////////////////////////////////////////////////////////////////////////
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      SizedBox(),
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: 43,
                                          bottom: 6.h,
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Kpink,
                                          radius: 32.r,
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(left: 2, top: 2),
                                        margin: EdgeInsets.only(right: 40),
                                        child: CircleAvatar(
                                          backgroundColor: Kwhite,
                                          radius: 30.r,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(200.r),
                                            child:
                                                // userapicontroller
                                                //                     .listenOrders[
                                                //                 "acceptCaptain"]
                                                userapicontroller.listenOrders[
                                                                    "order"][
                                                                "acceptCaptain"]
                                                            ["profilePic"] ==
                                                        null
                                                    ? Image.asset(
                                                        "assets/images/profileImageStatic.png",
                                                        height: 100.h,
                                                        width: 100.w,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : CircleAvatar(
                                                        backgroundColor: Kwhite,
                                                        radius: 55.r,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      200.r),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: kBaseImageUrl +
                                                                userapicontroller.listenOrders["order"]["acceptCaptain"]
                                                                    // userapicontroller
                                                                    //             .listenOrders[
                                                                    //         "acceptCaptain"]
                                                                    ["profilePic"],
                                                            // authentication
                                                            //     .profileData["profile"],
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    SizedBox(
                                                              height: 100.h,
                                                              width: 100.w,
                                                              child: Shimmer
                                                                  .fromColors(
                                                                baseColor: Colors
                                                                    .black12,
                                                                highlightColor:
                                                                    Colors.white
                                                                        .withOpacity(
                                                                            0.5),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Kwhite
                                                                        .withOpacity(
                                                                            0.5),
                                                                  ),
                                                                  height: 100.h,
                                                                  width: 100.w,
                                                                ),
                                                              ),
                                                            ),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                CircleAvatar(
                                                              backgroundColor:
                                                                  Kwhite,
                                                              radius: 50.r,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            200.r),
                                                                child:
                                                                    Image.asset(
                                                                  "assets/images/profileImageStatic.png",
                                                                  // height: 150.h,
                                                                  height: 100.h,
                                                                  width: 100.w,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            height: 100.h,
                                                            width: 100.w,
                                                            //   fit: BoxFit.cover,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          // Image.asset(
                                                          //   "assets/images/profileImageStatic.png",
                                                          //   // height: 150.h,
                                                          //   height: 100.h,
                                                          //   width: 100.w,
                                                          //   fit: BoxFit.cover,
                                                          // ),
                                                        ),
                                                      ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 35.h,
                                        right: 25.w,
                                        child: CircleAvatar(
                                          backgroundColor: Kwhite,
                                          radius: 20.r,
                                          child: ClipOval(
                                            child: Image.asset(
                                              userapicontroller.listenOrders[
                                                              "order"]
                                                          ["vehicleType"] ==
                                                      "scooty"
                                                  ? "assets/images/scooty_anime.png"
                                                  // ? "assets/images/pink_scooty.jpeg"
                                                  : userapicontroller.listenOrders[
                                                                  "order"]
                                                              ["vehicleType"] ==
                                                          "cab"
                                                      ? "assets/images/car_anime.png"
                                                      // ? "assets/images/pink_car.jpeg"
                                                      : userapicontroller.listenOrders[
                                                                      "order"][
                                                                  "vehicleType"] ==
                                                              "auto"
                                                          ? "assets/images/auto_anime.png"
                                                          // ? "assets/images/pinkish_autos.jpeg"
                                                          : "assets/images/parcel_box_anime.png",
                                              height: 50.h,
                                              width: 50.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        userapicontroller.listenOrders["order"]
                                                ["acceptCaptain"]["name"] ??
                                            "No Name",
                                        style: GoogleFonts.roboto(
                                            fontSize: kTwelveFont,
                                            color: KlightText,
                                            fontWeight: kFW500), // KlightText
                                      ),
                                      // InkWell(
                                      //   onTap: () async {
                                      //     launch("tel://7995649958"
                                      //         // "tel://${apiController.contactData[0]["phone"]}"
                                      //         );
                                      //   },
                                      //   child: Text(
                                      //     userapicontroller
                                      //             .listenOrders["acceptCaptain"]
                                      //         ["mobile"],
                                      //     style: GoogleFonts.roboto(
                                      //         fontSize: kTwelveFont,
                                      //         color: Ktextcolor,
                                      //         fontWeight: kFW500),
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Text(
                                        "AP 21 BK0221",
                                        style: GoogleFonts.roboto(
                                            fontSize: kFourteenFont,
                                            color: kcarden,
                                            fontWeight: kFW500), // KlightText
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Text(
                                        "Passion X pro",
                                        style: GoogleFonts.roboto(
                                            fontSize: kTwelveFont,
                                            color: KlightText,
                                            fontWeight: kFW500), // KlightText
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       "5 ",
                                      //       // userapicontroller
                                      //       //     .listenOrders["acceptCaptain"]["name"],
                                      //       style: GoogleFonts.roboto(
                                      //           fontSize: kTwelveFont,
                                      //           color: KlightText,
                                      //           fontWeight: kFW500), // KlightText
                                      //     ),
                                      //     Icon(
                                      //       Icons.star,
                                      //       size: 18.sp,
                                      //       color: Kpink,
                                      //     )
                                      //   ],
                                      // ),
                                    ],
                                  ),

                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       "Rate your Rider with",
                                  //       overflow: TextOverflow.ellipsis,
                                  //       maxLines: 1,
                                  //       style: GoogleFonts.roboto(
                                  //           fontSize: kSixteenFont,
                                  //           color: KdarkText,
                                  //           fontWeight: kFW600),
                                  //     ),
                                  //     Text(
                                  //       userapicontroller.listenOrders["order"]
                                  //               ["acceptCaptain"]["name"] ??
                                  //           "No Name",
                                  //       overflow: TextOverflow.ellipsis,
                                  //       maxLines: 1,
                                  //       style: GoogleFonts.roboto(
                                  //           fontSize: kTwelveFont,
                                  //           color: kblack,
                                  //           fontWeight: kFW600),
                                  //     ),
                                  //     Text(
                                  //       "AP 21 BK 0221",
                                  //       overflow: TextOverflow.ellipsis,
                                  //       maxLines: 1,
                                  //       style: GoogleFonts.roboto(
                                  //           fontSize: kTwelveFont,
                                  //           color: Ktextcolor,
                                  //           fontWeight: kFW600),
                                  //     ),
                                  //   ],
                                  // ),

                                  // Stack(
                                  //   children: [
                                  //     CircleAvatar(
                                  //       backgroundColor: Kwhite,
                                  //       radius: 50.r,
                                  //       child: ClipRRect(
                                  //         borderRadius: BorderRadius.circular(200.r),
                                  //         child: apicontroller
                                  //                     .profileData["profilePic"] ==
                                  //                 null
                                  //             ? Image.asset(
                                  //                 "assets/images/profileImageStatic.png",
                                  //                 height: 100.h,
                                  //                 width: 100.w,
                                  //                 fit: BoxFit.cover,
                                  //               )
                                  //             : CircleAvatar(
                                  //                 backgroundColor: Kwhite,
                                  //                 radius: 50.r,
                                  //                 child: ClipRRect(
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(200.r),
                                  //                   child: CachedNetworkImage(
                                  //                     imageUrl: kBaseImageUrl +
                                  //                         apicontroller.profileData[
                                  //                             "profilePic"],

                                  //                     placeholder: (context, url) =>
                                  //                         SizedBox(
                                  //                       height: 100.h,
                                  //                       width: 100.w,
                                  //                       child: Shimmer.fromColors(
                                  //                         baseColor: Colors.black12,
                                  //                         highlightColor: Colors.white
                                  //                             .withOpacity(0.5),
                                  //                         child: Container(
                                  //                           decoration: BoxDecoration(
                                  //                             shape: BoxShape.circle,
                                  //                             color: Kwhite.withOpacity(
                                  //                                 0.5),
                                  //                           ),
                                  //                           height: 100.h,
                                  //                           width: 100.w,
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                     errorWidget:
                                  //                         (context, url, error) =>
                                  //                             CircleAvatar(
                                  //                       backgroundColor: Kwhite,
                                  //                       radius: 50.r,
                                  //                       child: ClipRRect(
                                  //                         borderRadius:
                                  //                             BorderRadius.circular(
                                  //                                 200.r),
                                  //                         child: Image.asset(
                                  //                           "assets/images/profileImageStatic.png",
                                  //                           // height: 150.h,
                                  //                           height: 100.h,
                                  //                           width: 100.w,
                                  //                           fit: BoxFit.cover,
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                     height: 100.h,
                                  //                     width: 100.w,
                                  //                     //   fit: BoxFit.cover,
                                  //                     fit: BoxFit.cover,
                                  //                   ),
                                  //                   // Image.asset(
                                  //                   //   "assets/images/profileImageStatic.png",
                                  //                   //   // height: 150.h,
                                  //                   //   height: 100.h,
                                  //                   //   width: 100.w,
                                  //                   //   fit: BoxFit.cover,
                                  //                   // ),
                                  //                 ),
                                  //               ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Was Vehicle number Correct?",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.roboto(
                                        fontSize: kFourteenFont,
                                        color: KdarkText,
                                        fontWeight: kFW400),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            apicontroller
                                                .captainVehicleNumberCorrect
                                                .value = true;
                                          });
                                        },
                                        child: Text(
                                          "Yes",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: GoogleFonts.roboto(
                                              fontSize: kSixteenFont,
                                              color: apicontroller
                                                          .captainVehicleNumberCorrect
                                                          .value ==
                                                      true
                                                  ? Kpink
                                                  : KText,
                                              fontWeight: kFW600),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            apicontroller
                                                .captainVehicleNumberCorrect
                                                .value = false;
                                          });
                                        },
                                        child: Text(
                                          "No",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: GoogleFonts.roboto(
                                              fontSize: kSixteenFont,
                                              color: apicontroller
                                                          .captainVehicleNumberCorrect
                                                          .value !=
                                                      true
                                                  ? Kpink
                                                  : KText,
                                              fontWeight: kFW600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                "Rate the ride",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                    fontSize: 17.sp,
                                    color: KdarkText,
                                    fontWeight: kFW400),
                              ),

                              SizedBox(
                                height: 12.h,
                              ),
                              StarRating(
                                rating: _rating,
                                onRatingChanged: (rating) {
                                  setState(() {
                                    _rating = rating;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              CustomFormField(
                                enabled: true,
                                controller: authentication
                                    .registerDonorfirstNameController,
                                obscureText: false,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 8),
                                fontSize: kFourteenFont,
                                fontWeight: FontWeight.w500,
                                hintText: "Share Experience",
                                maxLines: 1,
                                readOnly: false,
                                label: 'Experience',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter Experience';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: 20),
                              CustomButton(
                                  margin: EdgeInsets.only(top: 35.h),
                                  width: double.infinity,
                                  height: 42,
                                  fontSize: kFourteenFont,
                                  fontWeight: kFW700,
                                  textColor: Kwhite,
                                  borderRadius: BorderRadius.circular(30.r),
                                  label: "Give Rating",
                                  isLoading: false,
                                  onTap: () async {
                                    var payload = {
                                      "reviewRating": _rating,
                                      "reviewTest": authentication
                                          .registerDonorfirstNameController
                                          .text,
                                      "giveVehicleNumber": apicontroller
                                          .captainVehicleNumberCorrect.value
                                    };
                                    userapicontroller.reviewOrder(payload);
                                    // Get.toNamed(kUserDashboard);
                                    //  KOtpVerification
                                    //  await Get.toNamed(kOtpVerify);
                                  }),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "Thanks for choosing us.",
                                style: GoogleFonts.roboto(
                                    fontSize: kEighteenFont,
                                    color: Kpink,
                                    fontWeight: kFW500),
                              ),
                              // CustomButton(
                              //     margin: EdgeInsets.only(top: 35.h),
                              //     width: double.infinity,
                              //     height: 42,
                              //     fontSize: kFourteenFont,
                              //     fontWeight: kFW700,
                              //     textColor: Kwhite,
                              //     borderRadius: BorderRadius.circular(30.r),
                              //     label: "Save Ride",
                              //     isLoading: false,
                              //     onTap: () async {
                              //       userapicontroller.userAddtoSave();
                              //       // Get.toNamed(kUserDashboard);
                              //       //  KOtpVerification
                              //       //  await Get.toNamed(kOtpVerify);
                              //     }),
                              // CustomButton(
                              //     margin: EdgeInsets.only(top: 35.h),
                              //     width: double.infinity,
                              //     height: 42,
                              //     fontSize: kFourteenFont,
                              //     fontWeight: kFW700,
                              //     textColor: Kwhite,
                              //     borderRadius: BorderRadius.circular(30.r),
                              //     label: "Add to Favourites",
                              //     isLoading: false,
                              //     onTap: () async {
                              //       userapicontroller.userAddtoFavourite(
                              //           userapicontroller.lastPlacedId.value
                              //           // userapiController
                              //           //         .userSavedOrders[
                              //           //     index]["_id"]
                              //           );
                              //     }
                              //     ),
                            ],
                          )

                        // Text(
                        //     "Review Screen",
                        //     style: GoogleFonts.roboto(
                        //         fontSize: kSixteenFont,
                        //         color: Kpink,
                        //         fontWeight: kFW500),
                        //   )
                        : userapicontroller.listenOrders["message"] ==
                                "Your Order still Pending...!"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),

                                  Text(
                                    "Searching For Rider...",
                                    style: GoogleFonts.roboto(
                                        fontSize: kFourteenFont,
                                        color: Kpink,
                                        fontWeight: kFW600),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Obx(() => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: List.generate(5, (index) {
                                          return Container(
                                            width: index == 2
                                                ? 100
                                                : 50.w, // Adjust the width for each progress bar
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                color: Kpink),
                                            // decoration: BoxDecoration(
                                            //   borderRadius: BorderRadius.circular(20.r),
                                            //   color: Colors.white,
                                            // ),

                                            margin: EdgeInsets.only(right: 5.w),
                                            child: index <=
                                                    progressController
                                                        .activeProgressIndex
                                                        .value
                                                ? TweenAnimationBuilder<double>(
                                                    duration: Duration(
                                                        seconds:
                                                            36), // Each progress bar runs for 36 seconds
                                                    curve: Curves.easeInOut,
                                                    tween: Tween<double>(
                                                      begin: 0,
                                                      end:
                                                          1, // Use 1 as the end value for a normalized progress
                                                    ),
                                                    builder: (context, value,
                                                            _) =>
                                                        LinearProgressIndicator(
                                                      backgroundColor:
                                                          Colors.grey[300],
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(Kpink),
                                                      value: value,
                                                    ),
                                                    onEnd: () {
                                                      progressController
                                                          .startNextAnimation();
                                                    },
                                                  )
                                                : LinearProgressIndicator(
                                                    backgroundColor:
                                                        Colors.grey[300],
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(Kpink),
                                                    value: 0,
                                                  ),
                                          );
                                        }),
                                      )),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Container(
                                  //       width: 50.w,
                                  //       // width: double.infinity,
                                  //       decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(20.r),
                                  //         color: Kpink,
                                  //       ),
                                  //       padding: EdgeInsets.all(3.r),
                                  //       margin: EdgeInsets.only(right: 5.w),
                                  //     ),
                                  //     Container(
                                  //       width: 50.w,
                                  //       // width: double.infinity,
                                  //       decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(20.r),
                                  //         color: Kpink,
                                  //       ),
                                  //       padding: EdgeInsets.all(3.r),
                                  //       margin: EdgeInsets.only(right: 5.w),
                                  //     ),
                                  //     Container(
                                  //       width: 100.w,
                                  //       // width: double.infinity,
                                  //       decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(20.r),
                                  //         color: Kwhite,
                                  //       ),
                                  //       padding: EdgeInsets.all(3.r),
                                  //       margin: EdgeInsets.only(right: 5.w),
                                  //       child: TweenAnimationBuilder<double>(
                                  //         duration: const Duration(minutes: 3),
                                  //         curve: Curves.easeInOut,
                                  //         tween: Tween<double>(
                                  //           begin: 0,
                                  //           end: 60,
                                  //         ),
                                  //         builder: (context, value, _) =>
                                  //             AnimatedProgressBar(
                                  //                 height: 5.h,
                                  //                 width: 280.w,
                                  //                 value: value,
                                  //                 duration: const Duration(minutes: 3),
                                  //                 gradient: const LinearGradient(
                                  //                   colors: [Kpink, Kwhite],
                                  //                 ),
                                  //                 backgroundColor: Kwhite),
                                  //         // LinearProgressIndicator(
                                  //         //     backgroundColor: Kwhite, value: value),
                                  //       ),
                                  //     ),
                                  //     Container(
                                  //       width: 50.w,
                                  //       // width: double.infinity,
                                  //       decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(20.r),
                                  //         color: Kpink,
                                  //       ),
                                  //       padding: EdgeInsets.all(3.r),
                                  //       margin: EdgeInsets.only(right: 5.w),
                                  //     ),
                                  //     Container(
                                  //       width: 50.w,
                                  //       // width: double.infinity,
                                  //       decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(20.r),
                                  //         color: Kpink,
                                  //       ),
                                  //       padding: EdgeInsets.all(3.r),
                                  //     ),
                                  //   ],
                                  // ),

                                  Container(
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          "assets/images/wor_frame_two.png",
                                          height: 200.h,
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          bottom: 0,
                                          right: 0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.center,
                                            children: [
                                              Obx(
                                                () => Image.asset(
                                                  userapicontroller
                                                                  .lastPlacedRide[
                                                              "vehicleType"] ==
                                                          "scooty"
                                                      ? "assets/images/scooty_anime.png"
                                                      : userapicontroller
                                                                      .lastPlacedRide[
                                                                  "vehicleType"] ==
                                                              "cab"
                                                          ? "assets/images/car_anime.png"
                                                          : userapicontroller
                                                                          .lastPlacedRide[
                                                                      "vehicleType"] ==
                                                                  "auto"
                                                              ? "assets/images/auto_anime.png"
                                                              : "assets/images/parcel_box_anime.png",
                                                  height: 80.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                              // Image.asset(
                                              //   // "assets/images/scooty_anime.png",
                                              //   // "assets/images/auto_anime.png",
                                              //   // "assets/images/car_anime.png",
                                              //   "assets/images/parcel_box_anime.png",
                                              //   height: 80.h,
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Obx(() => progressController
                                              .ProgressCompleted ==
                                          true
                                      ? CustomButton(
                                          // margin: EdgeInsets.only(top: 35.h),
                                          width: double.infinity,
                                          height: 42,
                                          fontSize: kFourteenFont,
                                          fontWeight: kFW700,
                                          textColor: Kwhite,
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          label: "Book Again",
                                          isLoading: false,
                                          onTap: () async {
                                            var payload = {
                                              "orderPlaceTime": formattedTime,
                                              "orderPlaceDate": formattedDate
                                            };

                                            // {"mobile": _phoneController.text};
                                            userapicontroller
                                                .userReorder(payload);
                                            // Get.toNamed(kUserDashboard);
                                            //  KOtpVerification
                                            //  await Get.toNamed(kOtpVerify);
                                          })
                                      : SizedBox()),
                                  Obx(
                                    () =>
                                        progressController.ProgressCompleted ==
                                                true
                                            ? SizedBox(
                                                height: 15.h,
                                              )
                                            : SizedBox(),
                                  ),
                                  Obx(
                                    () => progressController
                                                .ProgressCompleted ==
                                            true
                                        ? Custom_OutlineButton(
                                            // margin: EdgeInsets.only(top: 20.h),
                                            width: double.infinity,
                                            height: 42.h,
                                            fontSize: kFourteenFont,
                                            Color: Kpink,
                                            fontWeight: kFW700,
                                            textColor: kcarden,
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                            label: "Cancel Raid",
                                            isLoading: false,
                                            onTap: () async {
                                              showModalBottomSheet(
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              25.0)),
                                                ),
                                                builder: (context) {
                                                  return StatefulBottomSheet();
                                                },
                                              );
                                              // showModalBottomSheet(
                                              //     context: context,
                                              //     backgroundColor: Kwhite,
                                              //     shape: RoundedRectangleBorder(
                                              //       borderRadius: BorderRadius.vertical(
                                              //           top: Radius.circular(25.0)),
                                              //     ),
                                              //     builder: (BuildContext context) {
                                              //       return StatefulBuilder(
                                              //         builder: (BuildContext context,
                                              //             StateSetter setState) {
                                              //           return Container(
                                              //               width: double.infinity,
                                              //               height: MediaQuery.of(context)
                                              //                       .size
                                              //                       .height /
                                              //                   2.5,
                                              //               child:
                                              //                   Center(child: Text("data")));
                                              //         },
                                              //       );
                                              //     });

                                              // var payload = {"Reason": "Long pick up"};

                                              // userapicontroller.userCancelRaid(payload);
                                            })
                                        : CustomButton(
                                            margin: EdgeInsets.only(top: 20.h),
                                            width: double.infinity,
                                            height: 42.h,
                                            fontSize: kFourteenFont,
                                            fontWeight: kFW700,
                                            textColor: Kwhite,
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                            label: "Cancel Raid",
                                            isLoading: false,
                                            onTap: () async {
                                              showModalBottomSheet(
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              25.0)),
                                                ),
                                                builder: (context) {
                                                  return StatefulBottomSheet();
                                                },
                                              );
                                              // showModalBottomSheet(
                                              //     context: context,
                                              //     backgroundColor: Kwhite,
                                              //     shape: RoundedRectangleBorder(
                                              //       borderRadius: BorderRadius.vertical(
                                              //           top: Radius.circular(25.0)),
                                              //     ),
                                              //     builder: (BuildContext context) {
                                              //       return StatefulBuilder(
                                              //         builder: (BuildContext context,
                                              //             StateSetter setState) {
                                              //           return Container(
                                              //               width: double.infinity,
                                              //               height: MediaQuery.of(context)
                                              //                       .size
                                              //                       .height /
                                              //                   2.5,
                                              //               child:
                                              //                   Center(child: Text("data")));
                                              //         },
                                              //       );
                                              //     });

                                              // var payload = {"Reason": "Long pick up"};

                                              // userapicontroller.userCancelRaid(payload);
                                            }),
                                  ),

                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/green_address.png",
                                        height: 20.h,
                                        // width: 100.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      SizedBox(
                                        width: 200.w,
                                        child: Text(
                                          userapicontroller.lastPlacedRide[
                                                  "pickupAddress"] ??
                                              "",

                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: GoogleFonts.roboto(
                                              fontSize: kTwelveFont,
                                              color: KlightText,
                                              fontWeight: kFW500), // KlightText
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset(
                                        "assets/images/dot_arrow_down.png",
                                        height: 40.h,
                                        // width: 100.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/pink_arrow.png",
                                        height: 20.h,
                                        // width: 100.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      SizedBox(
                                        width: 200.w,
                                        child: Text(
                                          userapicontroller
                                              .lastPlacedRide["dropAddress"],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: GoogleFonts.roboto(
                                              fontSize: kTwelveFont,
                                              color: KlightText,
                                              fontWeight: kFW500), // KlightText
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Fare charges :",
                                            style: GoogleFonts.roboto(
                                                fontSize: kTwelveFont,
                                                color: Ktextcolor,
                                                fontWeight: kFW500),
                                          ),
                                          SizedBox(
                                            width: 8.h,
                                          ),
                                          Text(
                                            "₹  ${userapicontroller.lastPlacedRide["price"]}",
                                            style: GoogleFonts.roboto(
                                                fontSize: kTwelveFont,
                                                color: kcarden,
                                                fontWeight:
                                                    kFW500), // KlightText
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Ride Type :",
                                            style: GoogleFonts.roboto(
                                                fontSize: kTwelveFont,
                                                color: Ktextcolor,
                                                fontWeight: kFW500),
                                          ),
                                          SizedBox(
                                            width: 8.h,
                                          ),
                                          Text(
                                            userapicontroller.lastPlacedRide[
                                                    "vehicleType"] ??
                                                "",
                                            style: GoogleFonts.roboto(
                                                fontSize: kTwelveFont,
                                                color: kcarden,
                                                fontWeight:
                                                    kFW500), // KlightText
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Row(
                                  //   children: [
                                  //     Column(
                                  //       mainAxisAlignment: MainAxisAlignment.start,
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         Text(
                                  //           "Pick up from",
                                  //           style: GoogleFonts.roboto(
                                  //               fontSize: kTwelveFont,
                                  //               color: Ktextcolor,
                                  //               fontWeight: kFW500),
                                  //         ),
                                  //         SizedBox(
                                  //           height: 8.h,
                                  //         ),
                                  //         SizedBox(
                                  //           width: 200.w,
                                  //           child: Text(
                                  //             userapicontroller
                                  //                 .lastPlacedRide["pickupAddress"],
                                  //             overflow: TextOverflow.ellipsis,
                                  //             maxLines: 2,
                                  //             style: GoogleFonts.roboto(
                                  //                 fontSize: kTwelveFont,
                                  //                 color: KlightText,
                                  //                 fontWeight: kFW500), // KlightText
                                  //           ),
                                  //         ),
                                  //         SizedBox(
                                  //           height: 16.h,
                                  //         ),
                                  //         Text(
                                  //           "Drop from",
                                  //           style: GoogleFonts.roboto(
                                  //               fontSize: kTwelveFont,
                                  //               color: Ktextcolor,
                                  //               fontWeight: kFW500),
                                  //         ),
                                  //         SizedBox(
                                  //           height: 8.h,
                                  //         ),
                                  //         SizedBox(
                                  //           width: 200.w,
                                  //           child: Text(
                                  //             userapicontroller
                                  //                 .lastPlacedRide["dropAddress"],
                                  //             overflow: TextOverflow.ellipsis,
                                  //             maxLines: 2,
                                  //             style: GoogleFonts.roboto(
                                  //                 fontSize: kTwelveFont,
                                  //                 color: KlightText,
                                  //                 fontWeight: kFW500), // KlightText
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     SizedBox(
                                  //       width: 20.w,
                                  //     ),
                                  //     Column(
                                  //       mainAxisAlignment: MainAxisAlignment.start,
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         Text(
                                  //           "Price",
                                  //           style: GoogleFonts.roboto(
                                  //               fontSize: kTwelveFont,
                                  //               color: Ktextcolor,
                                  //               fontWeight: kFW500),
                                  //         ),
                                  //         SizedBox(
                                  //           height: 8.h,
                                  //         ),
                                  //         Text(
                                  //           "₹  ${userapicontroller.lastPlacedRide["price"]}",
                                  //           style: GoogleFonts.roboto(
                                  //               fontSize: kTwelveFont,
                                  //               color: KlightText,
                                  //               fontWeight: kFW500), // KlightText
                                  //         ),
                                  //         SizedBox(
                                  //           height: 16.h,
                                  //         ),
                                  //         Text(
                                  //           "Type",
                                  //           style: GoogleFonts.roboto(
                                  //               fontSize: kTwelveFont,
                                  //               color: Ktextcolor,
                                  //               fontWeight: kFW500),
                                  //         ),
                                  //         SizedBox(
                                  //           height: 8.h,
                                  //         ),
                                  //         Text(
                                  //           userapicontroller
                                  //                   .lastPlacedRide["vehicleType"] ??
                                  //               "",
                                  //           style: GoogleFonts.roboto(
                                  //               fontSize: kTwelveFont,
                                  //               color: KlightText,
                                  //               fontWeight: kFW500), // KlightText
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              )

                            //    "message": "Your Order still Pending...!"
                            :
                            //ramltest
                            userapicontroller.listenOrders["message"] ==
                                    "Your Order is escaped"
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        "Rider Has exited from Ride and Searching For Another  Rider...",
                                        style: GoogleFonts.roboto(
                                            fontSize: kFourteenFont,
                                            color: Kpink,
                                            fontWeight: kFW600),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Obx(() => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: List.generate(5, (index) {
                                              return Container(
                                                width: index == 2
                                                    ? 100
                                                    : 50.w, // Adjust the width for each progress bar
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
                                                    color: Kpink),
                                                // decoration: BoxDecoration(
                                                //   borderRadius: BorderRadius.circular(20.r),
                                                //   color: Colors.white,
                                                // ),

                                                margin:
                                                    EdgeInsets.only(right: 5.w),
                                                child: index <=
                                                        progressController
                                                            .activeProgressIndex
                                                            .value
                                                    ? TweenAnimationBuilder<
                                                        double>(
                                                        duration: Duration(
                                                            seconds:
                                                                36), // Each progress bar runs for 36 seconds
                                                        curve: Curves.easeInOut,
                                                        tween: Tween<double>(
                                                          begin: 0,
                                                          end:
                                                              1, // Use 1 as the end value for a normalized progress
                                                        ),
                                                        builder: (context,
                                                                value, _) =>
                                                            LinearProgressIndicator(
                                                          backgroundColor:
                                                              Colors.grey[300],
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(Kpink),
                                                          value: value,
                                                        ),
                                                        onEnd: () {
                                                          progressController
                                                              .startNextAnimation();
                                                        },
                                                      )
                                                    : LinearProgressIndicator(
                                                        backgroundColor:
                                                            Colors.grey[300],
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(Kpink),
                                                        value: 0,
                                                      ),
                                              );
                                            }),
                                          )),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Container(
                                      //       width: 50.w,
                                      //       // width: double.infinity,
                                      //       decoration: BoxDecoration(
                                      //         borderRadius: BorderRadius.circular(20.r),
                                      //         color: Kpink,
                                      //       ),
                                      //       padding: EdgeInsets.all(3.r),
                                      //       margin: EdgeInsets.only(right: 5.w),
                                      //     ),
                                      //     Container(
                                      //       width: 50.w,
                                      //       // width: double.infinity,
                                      //       decoration: BoxDecoration(
                                      //         borderRadius: BorderRadius.circular(20.r),
                                      //         color: Kpink,
                                      //       ),
                                      //       padding: EdgeInsets.all(3.r),
                                      //       margin: EdgeInsets.only(right: 5.w),
                                      //     ),
                                      //     Container(
                                      //       width: 100.w,
                                      //       // width: double.infinity,
                                      //       decoration: BoxDecoration(
                                      //         borderRadius: BorderRadius.circular(20.r),
                                      //         color: Kwhite,
                                      //       ),
                                      //       padding: EdgeInsets.all(3.r),
                                      //       margin: EdgeInsets.only(right: 5.w),
                                      //       child: TweenAnimationBuilder<double>(
                                      //         duration: const Duration(minutes: 3),
                                      //         curve: Curves.easeInOut,
                                      //         tween: Tween<double>(
                                      //           begin: 0,
                                      //           end: 60,
                                      //         ),
                                      //         builder: (context, value, _) =>
                                      //             AnimatedProgressBar(
                                      //                 height: 5.h,
                                      //                 width: 280.w,
                                      //                 value: value,
                                      //                 duration: const Duration(minutes: 3),
                                      //                 gradient: const LinearGradient(
                                      //                   colors: [Kpink, Kwhite],
                                      //                 ),
                                      //                 backgroundColor: Kwhite),
                                      //         // LinearProgressIndicator(
                                      //         //     backgroundColor: Kwhite, value: value),
                                      //       ),
                                      //     ),
                                      //     Container(
                                      //       width: 50.w,
                                      //       // width: double.infinity,
                                      //       decoration: BoxDecoration(
                                      //         borderRadius: BorderRadius.circular(20.r),
                                      //         color: Kpink,
                                      //       ),
                                      //       padding: EdgeInsets.all(3.r),
                                      //       margin: EdgeInsets.only(right: 5.w),
                                      //     ),
                                      //     Container(
                                      //       width: 50.w,
                                      //       // width: double.infinity,
                                      //       decoration: BoxDecoration(
                                      //         borderRadius: BorderRadius.circular(20.r),
                                      //         color: Kpink,
                                      //       ),
                                      //       padding: EdgeInsets.all(3.r),
                                      //     ),
                                      //   ],
                                      // ),

                                      Container(
                                        child: Stack(
                                          children: [
                                            Image.asset(
                                              "assets/images/wor_frame_two.png",
                                              height: 200.h,
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              bottom: 0,
                                              right: 0,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                // crossAxisAlignment:
                                                //     CrossAxisAlignment.center,
                                                children: [
                                                  Obx(
                                                    () => Image.asset(
                                                      userapicontroller
                                                                      .lastPlacedRide[
                                                                  "vehicleType"] ==
                                                              "scooty"
                                                          ? "assets/images/scooty_anime.png"
                                                          : userapicontroller
                                                                          .lastPlacedRide[
                                                                      "vehicleType"] ==
                                                                  "cab"
                                                              ? "assets/images/car_anime.png"
                                                              : userapicontroller
                                                                              .lastPlacedRide[
                                                                          "vehicleType"] ==
                                                                      "auto"
                                                                  ? "assets/images/auto_anime.png"
                                                                  : "assets/images/parcel_box_anime.png",
                                                      height: 80.h,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                  // Image.asset(
                                                  //   // "assets/images/scooty_anime.png",
                                                  //   // "assets/images/auto_anime.png",
                                                  //   // "assets/images/car_anime.png",
                                                  //   "assets/images/parcel_box_anime.png",
                                                  //   height: 80.h,
                                                  //   fit: BoxFit.cover,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Obx(() => progressController
                                                  .ProgressCompleted ==
                                              true
                                          ? CustomButton(
                                              // margin: EdgeInsets.only(top: 35.h),
                                              width: double.infinity,
                                              height: 42,
                                              fontSize: kFourteenFont,
                                              fontWeight: kFW700,
                                              textColor: Kwhite,
                                              borderRadius:
                                                  BorderRadius.circular(30.r),
                                              label: "Book Again",
                                              isLoading: false,
                                              onTap: () async {
                                                var payload = {
                                                  "orderPlaceTime":
                                                      formattedTime,
                                                  "orderPlaceDate":
                                                      formattedDate
                                                };

                                                // {"mobile": _phoneController.text};
                                                userapicontroller
                                                    .userReorder(payload);
                                                // Get.toNamed(kUserDashboard);
                                                //  KOtpVerification
                                                //  await Get.toNamed(kOtpVerify);
                                              })
                                          : SizedBox()),
                                      Obx(
                                        () => progressController
                                                    .ProgressCompleted ==
                                                true
                                            ? SizedBox(
                                                height: 15.h,
                                              )
                                            : SizedBox(),
                                      ),
                                      Obx(
                                        () => progressController
                                                    .ProgressCompleted ==
                                                true
                                            ? Custom_OutlineButton(
                                                // margin: EdgeInsets.only(top: 20.h),
                                                width: double.infinity,
                                                height: 42.h,
                                                fontSize: kFourteenFont,
                                                Color: Kpink,
                                                fontWeight: kFW700,
                                                textColor: kcarden,
                                                borderRadius:
                                                    BorderRadius.circular(30.r),
                                                label: "Cancel Raid",
                                                isLoading: false,
                                                onTap: () async {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      25.0)),
                                                    ),
                                                    builder: (context) {
                                                      return StatefulBottomSheet();
                                                    },
                                                  );
                                                  // showModalBottomSheet(
                                                  //     context: context,
                                                  //     backgroundColor: Kwhite,
                                                  //     shape: RoundedRectangleBorder(
                                                  //       borderRadius: BorderRadius.vertical(
                                                  //           top: Radius.circular(25.0)),
                                                  //     ),
                                                  //     builder: (BuildContext context) {
                                                  //       return StatefulBuilder(
                                                  //         builder: (BuildContext context,
                                                  //             StateSetter setState) {
                                                  //           return Container(
                                                  //               width: double.infinity,
                                                  //               height: MediaQuery.of(context)
                                                  //                       .size
                                                  //                       .height /
                                                  //                   2.5,
                                                  //               child:
                                                  //                   Center(child: Text("data")));
                                                  //         },
                                                  //       );
                                                  //     });

                                                  // var payload = {"Reason": "Long pick up"};

                                                  // userapicontroller.userCancelRaid(payload);
                                                })
                                            : CustomButton(
                                                margin:
                                                    EdgeInsets.only(top: 20.h),
                                                width: double.infinity,
                                                height: 42.h,
                                                fontSize: kFourteenFont,
                                                fontWeight: kFW700,
                                                textColor: Kwhite,
                                                borderRadius:
                                                    BorderRadius.circular(30.r),
                                                label: "Cancel Raid",
                                                isLoading: false,
                                                onTap: () async {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      25.0)),
                                                    ),
                                                    builder: (context) {
                                                      return StatefulBottomSheet();
                                                    },
                                                  );
                                                  // showModalBottomSheet(
                                                  //     context: context,
                                                  //     backgroundColor: Kwhite,
                                                  //     shape: RoundedRectangleBorder(
                                                  //       borderRadius: BorderRadius.vertical(
                                                  //           top: Radius.circular(25.0)),
                                                  //     ),
                                                  //     builder: (BuildContext context) {
                                                  //       return StatefulBuilder(
                                                  //         builder: (BuildContext context,
                                                  //             StateSetter setState) {
                                                  //           return Container(
                                                  //               width: double.infinity,
                                                  //               height: MediaQuery.of(context)
                                                  //                       .size
                                                  //                       .height /
                                                  //                   2.5,
                                                  //               child:
                                                  //                   Center(child: Text("data")));
                                                  //         },
                                                  //       );
                                                  //     });

                                                  // var payload = {"Reason": "Long pick up"};

                                                  // userapicontroller.userCancelRaid(payload);
                                                }),
                                      ),

                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/green_address.png",
                                            height: 20.h,
                                            // width: 100.w,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          SizedBox(
                                            width: 200.w,
                                            child: Text(
                                              userapicontroller.lastPlacedRide[
                                                  "pickupAddress"],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: GoogleFonts.roboto(
                                                  fontSize: kTwelveFont,
                                                  color: KlightText,
                                                  fontWeight:
                                                      kFW500), // KlightText
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset(
                                            "assets/images/dot_arrow_down.png",
                                            height: 40.h,
                                            // width: 100.w,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/pink_arrow.png",
                                            height: 20.h,
                                            // width: 100.w,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          SizedBox(
                                            width: 200.w,
                                            child: Text(
                                              userapicontroller.lastPlacedRide[
                                                  "dropAddress"],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: GoogleFonts.roboto(
                                                  fontSize: kTwelveFont,
                                                  color: KlightText,
                                                  fontWeight:
                                                      kFW500), // KlightText
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Fare charges :",
                                                style: GoogleFonts.roboto(
                                                    fontSize: kTwelveFont,
                                                    color: Ktextcolor,
                                                    fontWeight: kFW500),
                                              ),
                                              SizedBox(
                                                width: 8.h,
                                              ),
                                              Text(
                                                "₹  ${userapicontroller.lastPlacedRide["price"]}",
                                                style: GoogleFonts.roboto(
                                                    fontSize: kTwelveFont,
                                                    color: kcarden,
                                                    fontWeight:
                                                        kFW500), // KlightText
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Ride Type :",
                                                style: GoogleFonts.roboto(
                                                    fontSize: kTwelveFont,
                                                    color: Ktextcolor,
                                                    fontWeight: kFW500),
                                              ),
                                              SizedBox(
                                                width: 8.h,
                                              ),
                                              Text(
                                                userapicontroller
                                                            .lastPlacedRide[
                                                        "vehicleType"] ??
                                                    "",
                                                style: GoogleFonts.roboto(
                                                    fontSize: kTwelveFont,
                                                    color: kcarden,
                                                    fontWeight:
                                                        kFW500), // KlightText
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      // Row(
                                      //   children: [
                                      //     Column(
                                      //       mainAxisAlignment: MainAxisAlignment.start,
                                      //       crossAxisAlignment: CrossAxisAlignment.start,
                                      //       children: [
                                      //         Text(
                                      //           "Pick up from",
                                      //           style: GoogleFonts.roboto(
                                      //               fontSize: kTwelveFont,
                                      //               color: Ktextcolor,
                                      //               fontWeight: kFW500),
                                      //         ),
                                      //         SizedBox(
                                      //           height: 8.h,
                                      //         ),
                                      //         SizedBox(
                                      //           width: 200.w,
                                      //           child: Text(
                                      //             userapicontroller
                                      //                 .lastPlacedRide["pickupAddress"],
                                      //             overflow: TextOverflow.ellipsis,
                                      //             maxLines: 2,
                                      //             style: GoogleFonts.roboto(
                                      //                 fontSize: kTwelveFont,
                                      //                 color: KlightText,
                                      //                 fontWeight: kFW500), // KlightText
                                      //           ),
                                      //         ),
                                      //         SizedBox(
                                      //           height: 16.h,
                                      //         ),
                                      //         Text(
                                      //           "Drop from",
                                      //           style: GoogleFonts.roboto(
                                      //               fontSize: kTwelveFont,
                                      //               color: Ktextcolor,
                                      //               fontWeight: kFW500),
                                      //         ),
                                      //         SizedBox(
                                      //           height: 8.h,
                                      //         ),
                                      //         SizedBox(
                                      //           width: 200.w,
                                      //           child: Text(
                                      //             userapicontroller
                                      //                 .lastPlacedRide["dropAddress"],
                                      //             overflow: TextOverflow.ellipsis,
                                      //             maxLines: 2,
                                      //             style: GoogleFonts.roboto(
                                      //                 fontSize: kTwelveFont,
                                      //                 color: KlightText,
                                      //                 fontWeight: kFW500), // KlightText
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     SizedBox(
                                      //       width: 20.w,
                                      //     ),
                                      //     Column(
                                      //       mainAxisAlignment: MainAxisAlignment.start,
                                      //       crossAxisAlignment: CrossAxisAlignment.start,
                                      //       children: [
                                      //         Text(
                                      //           "Price",
                                      //           style: GoogleFonts.roboto(
                                      //               fontSize: kTwelveFont,
                                      //               color: Ktextcolor,
                                      //               fontWeight: kFW500),
                                      //         ),
                                      //         SizedBox(
                                      //           height: 8.h,
                                      //         ),
                                      //         Text(
                                      //           "₹  ${userapicontroller.lastPlacedRide["price"]}",
                                      //           style: GoogleFonts.roboto(
                                      //               fontSize: kTwelveFont,
                                      //               color: KlightText,
                                      //               fontWeight: kFW500), // KlightText
                                      //         ),
                                      //         SizedBox(
                                      //           height: 16.h,
                                      //         ),
                                      //         Text(
                                      //           "Type",
                                      //           style: GoogleFonts.roboto(
                                      //               fontSize: kTwelveFont,
                                      //               color: Ktextcolor,
                                      //               fontWeight: kFW500),
                                      //         ),
                                      //         SizedBox(
                                      //           height: 8.h,
                                      //         ),
                                      //         Text(
                                      //           userapicontroller
                                      //                   .lastPlacedRide["vehicleType"] ??
                                      //               "",
                                      //           style: GoogleFonts.roboto(
                                      //               fontSize: kTwelveFont,
                                      //               color: KlightText,
                                      //               fontWeight: kFW500), // KlightText
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rider on the way",
                                            style: GoogleFonts.roboto(
                                                fontSize: kSixteenFont,
                                                color: Kpink,
                                                fontWeight: kFW500),
                                          ),
                                          CustomButton(
                                              width: 80.w,
                                              height: 32.h,
                                              fontSize: kFourteenFont,
                                              fontWeight: kFW700,
                                              textColor: Kwhite,
                                              borderRadius:
                                                  BorderRadius.circular(30.r),
                                              label: "3 min",
                                              isLoading: false,
                                              onTap: () async {}),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Start your order with PIN",
                                            style: GoogleFonts.roboto(
                                                fontSize: 15.sp,
                                                color: kcarden,
                                                fontWeight: kFW500),
                                          ),
                                          Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.center,
                                            children: otpDigits.map((digit) {
                                              return Container(
                                                margin:
                                                    EdgeInsets.only(right: 2.w),
                                                padding: EdgeInsets.all(10.r),
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Ktextcolor
                                                          .withOpacity(0.5),
                                                      blurRadius: 5.r,
                                                      offset: Offset(1, 1),
                                                      spreadRadius: 1.r,
                                                    )
                                                  ],
                                                  color: Kwhite,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: Text(
                                                  digit,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: kFourteenFont,
                                                      color: kcarden,
                                                      fontWeight: kFW400),
                                                ),
                                              );
                                              // Padding(
                                              //   padding: const EdgeInsets.symmetric(
                                              //       horizontal: 4.0),
                                              //   child: Text(
                                              //     digit,
                                              //     style: TextStyle(
                                              //         fontSize: 32,
                                              //         fontWeight: FontWeight.bold),
                                              //   ),
                                              // );
                                            }).toList(),
                                          ),
                                          // Row(
                                          //   children: [
                                          //     Container(
                                          //       margin: EdgeInsets.only(
                                          //           right: 10.w),
                                          //       padding: EdgeInsets.all(10.r),
                                          //       decoration: BoxDecoration(
                                          //         boxShadow: [
                                          //           BoxShadow(
                                          //             color: Ktextcolor
                                          //                 .withOpacity(0.5),
                                          //             blurRadius: 5.r,
                                          //             offset: Offset(1, 1),
                                          //             spreadRadius: 1.r,
                                          //           )
                                          //         ],
                                          //         color: Kwhite,
                                          //         borderRadius:
                                          //             BorderRadius.circular(
                                          //                 10.r),
                                          //       ),
                                          //       child: Text(
                                          //         "4",
                                          //         style: GoogleFonts.roboto(
                                          //             fontSize: kFourteenFont,
                                          //             color: kcarden,
                                          //             fontWeight: kFW400),
                                          //       ),
                                          //     ),
                                          //     Container(
                                          //       margin: EdgeInsets.only(
                                          //           right: 10.w),
                                          //       padding: EdgeInsets.all(10.r),
                                          //       decoration: BoxDecoration(
                                          //         boxShadow: [
                                          //           BoxShadow(
                                          //             color: Ktextcolor
                                          //                 .withOpacity(0.5),
                                          //             blurRadius: 5.r,
                                          //             offset: Offset(1, 1),
                                          //             spreadRadius: 1.r,
                                          //           )
                                          //         ],
                                          //         color: Kwhite,
                                          //         borderRadius:
                                          //             BorderRadius.circular(
                                          //                 10.r),
                                          //       ),
                                          //       child: Text(
                                          //         "4",
                                          //         style: GoogleFonts.roboto(
                                          //             fontSize: kFourteenFont,
                                          //             color: kcarden,
                                          //             fontWeight: kFW400),
                                          //       ),
                                          //     ),
                                          //     Container(
                                          //       margin: EdgeInsets.only(
                                          //           right: 10.w),
                                          //       padding: EdgeInsets.all(10.r),
                                          //       decoration: BoxDecoration(
                                          //         boxShadow: [
                                          //           BoxShadow(
                                          //             color: Ktextcolor
                                          //                 .withOpacity(0.5),
                                          //             blurRadius: 5.r,
                                          //             offset: Offset(1, 1),
                                          //             spreadRadius: 1.r,
                                          //           )
                                          //         ],
                                          //         color: Kwhite,
                                          //         borderRadius:
                                          //             BorderRadius.circular(
                                          //                 10.r),
                                          //       ),
                                          //       child: Text(
                                          //         "4",
                                          //         style: GoogleFonts.roboto(
                                          //             fontSize: kFourteenFont,
                                          //             color: kcarden,
                                          //             fontWeight: kFW400),
                                          //       ),
                                          //     ),
                                          //     Container(
                                          //       padding: EdgeInsets.all(10.r),
                                          //       decoration: BoxDecoration(
                                          //         boxShadow: [
                                          //           BoxShadow(
                                          //             color: Ktextcolor
                                          //                 .withOpacity(0.5),
                                          //             blurRadius: 5.r,
                                          //             offset: Offset(1, 1),
                                          //             spreadRadius: 1.r,
                                          //           )
                                          //         ],
                                          //         color: Kwhite,
                                          //         borderRadius:
                                          //             BorderRadius.circular(
                                          //                 10.r),
                                          //       ),
                                          //       child: Text(
                                          //         "4",
                                          //         style: GoogleFonts.roboto(
                                          //             fontSize: kFourteenFont,
                                          //             color: kcarden,
                                          //             fontWeight: kFW400),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                      ////////////////new one

                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 20.h,
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Stack(
                                            children: [
                                              SizedBox(),
                                              Container(
                                                margin: EdgeInsets.only(
                                                  right: 43,
                                                  bottom: 6.h,
                                                ),
                                                child: CircleAvatar(
                                                  backgroundColor: Kpink,
                                                  radius: 32.r,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 2, top: 2),
                                                margin:
                                                    EdgeInsets.only(right: 40),
                                                child: CircleAvatar(
                                                  backgroundColor: Kwhite,
                                                  radius: 30.r,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            200.r),
                                                    child: userapicontroller
                                                                        .listenOrders[
                                                                    "acceptCaptain"]
                                                                [
                                                                "profilePic"] ==
                                                            null
                                                        ? Image.asset(
                                                            "assets/images/profileImageStatic.png",
                                                            height: 100.h,
                                                            width: 100.w,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : CircleAvatar(
                                                            backgroundColor:
                                                                Kwhite,
                                                            radius: 55.r,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          200.r),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: kBaseImageUrl +
                                                                    userapicontroller
                                                                            .listenOrders["acceptCaptain"]
                                                                        [
                                                                        "profilePic"],
                                                                // authentication
                                                                //     .profileData["profile"],
                                                                placeholder:
                                                                    (context,
                                                                            url) =>
                                                                        SizedBox(
                                                                  height: 100.h,
                                                                  width: 100.w,
                                                                  child: Shimmer
                                                                      .fromColors(
                                                                    baseColor:
                                                                        Colors
                                                                            .black12,
                                                                    highlightColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.5),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Kwhite.withOpacity(
                                                                            0.5),
                                                                      ),
                                                                      height:
                                                                          100.h,
                                                                      width:
                                                                          100.w,
                                                                    ),
                                                                  ),
                                                                ),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      Kwhite,
                                                                  radius: 50.r,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            200.r),
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/images/profileImageStatic.png",
                                                                      // height: 150.h,
                                                                      height:
                                                                          100.h,
                                                                      width:
                                                                          100.w,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                height: 100.h,
                                                                width: 100.w,
                                                                //   fit: BoxFit.cover,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              // Image.asset(
                                                              //   "assets/images/profileImageStatic.png",
                                                              //   // height: 150.h,
                                                              //   height: 100.h,
                                                              //   width: 100.w,
                                                              //   fit: BoxFit.cover,
                                                              // ),
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 35.h,
                                                right: 25.w,
                                                child: CircleAvatar(
                                                  backgroundColor: Kwhite,
                                                  radius: 20.r,
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      userapicontroller
                                                                      .listenOrders[
                                                                  "vehicleType"] ==
                                                              "scooty"
                                                          ? "assets/images/scooty_anime.png"
                                                          // ? "assets/images/pink_scooty.jpeg"
                                                          : userapicontroller
                                                                          .listenOrders[
                                                                      "vehicleType"] ==
                                                                  "cab"
                                                              ? "assets/images/car_anime.png"
                                                              // ? "assets/images/pink_car.jpeg"
                                                              : userapicontroller
                                                                              .listenOrders[
                                                                          "vehicleType"] ==
                                                                      "auto"
                                                                  ? "assets/images/auto_anime.png"
                                                                  // ? "assets/images/pinkish_autos.jpeg"
                                                                  : "assets/images/parcel_box_anime.png",
                                                      height: 50.h,
                                                      width: 50.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          // CircleAvatar(
                                          //   backgroundColor: Kwhite,
                                          //   radius: 35.r,
                                          //   child: ClipRRect(
                                          //     borderRadius: BorderRadius.circular(200.r),
                                          //     child: Image.asset(
                                          //       "assets/images/profileImageStatic.png",
                                          //       height: 100.h,
                                          //       width: 100.w,
                                          //       fit: BoxFit.cover,
                                          //     ),
                                          //   ),
                                          // ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                userapicontroller.listenOrders[
                                                    "acceptCaptain"]["name"],
                                                style: GoogleFonts.roboto(
                                                    fontSize: kTwelveFont,
                                                    color: KlightText,
                                                    fontWeight:
                                                        kFW500), // KlightText
                                              ),
                                              // InkWell(
                                              //   onTap: () async {
                                              //     launch("tel://7995649958"
                                              //         // "tel://${apiController.contactData[0]["phone"]}"
                                              //         );
                                              //   },
                                              //   child: Text(
                                              //     userapicontroller
                                              //             .listenOrders["acceptCaptain"]
                                              //         ["mobile"],
                                              //     style: GoogleFonts.roboto(
                                              //         fontSize: kTwelveFont,
                                              //         color: Ktextcolor,
                                              //         fontWeight: kFW500),
                                              //   ),
                                              // ),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              Text(
                                                "AP 21 BK0221",
                                                style: GoogleFonts.roboto(
                                                    fontSize: kFourteenFont,
                                                    color: kcarden,
                                                    fontWeight:
                                                        kFW500), // KlightText
                                              ),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              Text(
                                                "Passion X pro",
                                                style: GoogleFonts.roboto(
                                                    fontSize: kTwelveFont,
                                                    color: KlightText,
                                                    fontWeight:
                                                        kFW500), // KlightText
                                              ),
                                              // Row(
                                              //   children: [
                                              //     Text(
                                              //       "5 ",
                                              //       // userapicontroller
                                              //       //     .listenOrders["acceptCaptain"]["name"],
                                              //       style: GoogleFonts.roboto(
                                              //           fontSize: kTwelveFont,
                                              //           color: KlightText,
                                              //           fontWeight: kFW500), // KlightText
                                              //     ),
                                              //     Icon(
                                              //       Icons.star,
                                              //       size: 18.sp,
                                              //       color: Kpink,
                                              //     )
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(25.r),
                                                border:
                                                    Border.all(color: Kpink)),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 18.sp,
                                                  color: Kpink.withOpacity(
                                                    0.5,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "5 ",
                                                  // userapicontroller
                                                  //     .listenOrders["acceptCaptain"]["name"],
                                                  style: GoogleFonts.roboto(
                                                      fontSize: kTwelveFont,
                                                      color: KlightText,
                                                      fontWeight:
                                                          kFW500), // KlightText
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Icon(
                                          //   Icons.phone,
                                          //   color: Kpink.withOpacity(
                                          //     0.5,
                                          //   ),
                                          //   size: 18.sp,
                                          // ),

                                          InkWell(
                                            onTap: () async {
                                              apicontroller.getSocketiochat();
                                            },
                                            child: Container(
                                              width: 240.w,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(25.r),
                                                  border:
                                                      Border.all(color: Kpink)),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.message,
                                                    color: Kpink.withOpacity(
                                                      0.5,
                                                    ),
                                                    size: 18.sp,
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    "Message Sandeep",
                                                    style: GoogleFonts.roboto(
                                                        fontSize: kTwelveFont,
                                                        color: Ktextcolor,
                                                        fontWeight: kFW500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(25.r),
                                                border:
                                                    Border.all(color: Kpink)),
                                            child: InkWell(
                                              onTap: () async {
                                                launch("tel://7995649958"
                                                    // "tel://${apiController.contactData[0]["phone"]}"
                                                    );
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.phone,
                                                    color: Kpink.withOpacity(
                                                      0.5,
                                                    ),
                                                    size: 18.sp,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 20.h,
                                      ),

                                      Container(
                                        decoration: BoxDecoration(
                                            color: Kwhite,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Ride Details",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: kTwelveFont,
                                                      color: Ktextcolor,
                                                      fontWeight: kFW500),
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                SizedBox(
                                                  width: 180.w,
                                                  child: Text(
                                                    "Meet your rider at " +
                                                            userapicontroller
                                                                    .listenOrders[
                                                                "pickupAddress"] ??
                                                        "",
                                                    maxLines: 2,
                                                    style: GoogleFonts.roboto(
                                                        fontSize: kTwelveFont,
                                                        color: kcarden,
                                                        fontWeight:
                                                            kFW500), // KlightText
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                showModalBottomSheet(
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    25.0)),
                                                  ),
                                                  builder: (context) {
                                                    return StatefulBottomMore();
                                                  },
                                                );
                                                // showModalBottomSheet(
                                                //     context: context,
                                                //     backgroundColor: Kwhite,
                                                //     shape: RoundedRectangleBorder(
                                                //       borderRadius: BorderRadius.vertical(
                                                //           top: Radius.circular(25.0)),
                                                //     ),
                                                //     builder: (BuildContext context) {
                                                //       return StatefulBuilder(
                                                //         builder: (BuildContext context,
                                                //             StateSetter setState) {
                                                //           return Container(
                                                //               width: double.infinity,
                                                //               height: MediaQuery.of(context)
                                                //                       .size
                                                //                       .height /
                                                //                   2.5,
                                                //               child:
                                                //                   Center(child: Text("data")));
                                                //         },
                                                //       );
                                                //     });

                                                // var payload = {"Reason": "Long pick up"};

                                                // userapicontroller.userCancelRaid(payload);
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 35.w),
                                                  padding: EdgeInsets.only(
                                                      left: 3.w, right: 3.w),
                                                  decoration: BoxDecoration(
                                                      color: Kpink.withOpacity(
                                                          0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r)),
                                                  child:
                                                      Icon(Icons.more_horiz)),
                                            )
                                          ],
                                        ),
                                      ),
                                      // CustomButton(
                                      //     margin: EdgeInsets.only(top: 35.h),
                                      //     width: double.infinity,
                                      //     height: 42.h,
                                      //     fontSize: kFourteenFont,
                                      //     fontWeight: kFW700,
                                      //     textColor: Kwhite,
                                      //     borderRadius: BorderRadius.circular(30.r),
                                      //     label: "Cancel Raid",
                                      //     isLoading: false,
                                      //     onTap: () async {
                                      //       showModalBottomSheet(
                                      //         context: context,
                                      //         shape: RoundedRectangleBorder(
                                      //           borderRadius: BorderRadius.vertical(
                                      //               top: Radius.circular(25.0)),
                                      //         ),
                                      //         builder: (context) {
                                      //           return StatefulBottomSheet();
                                      //         },
                                      //       );
                                      //     }),

                                      // CustomButton(
                                      //     margin: EdgeInsets.only(top: 35.h),
                                      //     width: double.infinity,
                                      //     height: 42.h,
                                      //     fontSize: kFourteenFont,
                                      //     fontWeight: kFW700,
                                      //     textColor: Kwhite,
                                      //     borderRadius: BorderRadius.circular(30.r),
                                      //     label: "Cancel Raid",
                                      //     isLoading: false,
                                      //     onTap: () async {
                                      //       var payload = {"Reason": "Long pick up"};

                                      //       // {"mobile": _phoneController.text};
                                      //       userapicontroller.userCancelRaid(payload);
                                      //       // Get.toNamed(kUserDashboard);
                                      //       //  KOtpVerification
                                      //       //  await Get.toNamed(kOtpVerify);
                                      //     }),

                                      // CustomButton(
                                      //     margin: EdgeInsets.only(top: 35.h),
                                      //     width: 150.w,
                                      //     height: 42,
                                      //     fontSize: kFourteenFont,
                                      //     fontWeight: kFW700,
                                      //     textColor: Kwhite,
                                      //     borderRadius: BorderRadius.circular(30.r),
                                      //     label: "Re Load",
                                      //     isLoading: false,
                                      //     onTap: () async {
                                      //       userapicontroller.listenUserOrders();

                                      //     }),
                                    ],
                                  )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  //////////////////////////////////////////////////////////////////////////////////////////

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

  // void calculateDistanceAndTime(List<LatLng> coordinates) {
  //   if (coordinates.isNotEmpty) {
  //     distance = _calculateDistance(coordinates.first, coordinates.last);

  //     estimatedTime = (distance / 50) * 60;

  //     DateTime now = DateTime.now()
  //         .toUtc()
  //         .add(const Duration(hours: 5, minutes: 30)); // UTC to IST

  //     DateTime arrival = now.add(Duration(minutes: estimatedTime.round()));

  //     setState(() {
  //       arrivalTime = DateFormat('hh:mm a').format(arrival);
  //     });
  //   }
  // }

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
  /////////////////////////////////////////////////////////////////////////////////
}

// class ResourceList {
//   final String value;
//   final String text;

//   ResourceList(this.value, this.text);
// }

class StarRating extends StatelessWidget {
  final int rating;
  final int starCount;
  final Function(int) onRatingChanged;

  StarRating({
    required this.rating,
    this.starCount = 5,
    required this.onRatingChanged,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index < rating) {
      icon = Icon(
        Icons.star,
        color: Colors.amber,
      );
    } else {
      icon = Icon(
        Icons.star_border,
        color: Kpink.withOpacity(0.5),
      );
    }
    return InkResponse(
      onTap: () => onRatingChanged(index + 1),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            List.generate(starCount, (index) => buildStar(context, index)),
      ),
    );
  }
}

/////////////////////////////////////////////////////////

class StatefulBottomSheet extends StatefulWidget {
  @override
  _StatefulBottomSheetState createState() => _StatefulBottomSheetState();
}

class _StatefulBottomSheetState extends State<StatefulBottomSheet> {
  UserApiController userapicontroller = Get.put(UserApiController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Kwhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2,
      child: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Cancel Ride ?",
            style: GoogleFonts.roboto(
                fontSize: kSixteenFont, color: KdarkText, fontWeight: kFW500),
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            color: KdarkText.withOpacity(0.5),
          ),
          SizedBox(
            height: 10.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Why do you want to cancel ?",
              style: GoogleFonts.roboto(
                  fontSize: kFourteenFont,
                  color: KdarkText,
                  fontWeight: kFW500),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          InkWell(
            onTap: () {
              setState(() {
                apicontroller.selectedCancelReason.value =
                    "Waiting time was too long.";
              });
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Image.asset(
                  "assets/images/timer.png",
                  height: 25.h,
                ),
                SizedBox(
                  width: 25.w,
                ),
                Text(
                  "Waiting time was too long.",
                  style: GoogleFonts.roboto(
                      fontSize: kFourteenFont,
                      color: apicontroller.selectedCancelReason.value ==
                              "Waiting time was too long."
                          ? Kpink
                          : KText,
                      fontWeight: kFW500),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          apicontroller.selectedCancelReason.value ==
                  "Waiting time was too long."
              ? Divider(
                  color: Kpink.withOpacity(0.5),
                )
              : Divider(),
          SizedBox(
            height: 5.h,
          ),
          InkWell(
            onTap: () {
              setState(() {
                apicontroller.selectedCancelReason.value =
                    "Selected wrong pickup.";
              });
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Image.asset(
                  "assets/images/threecaution.png",
                  height: 18.h,
                ),
                SizedBox(
                  width: 25.w,
                ),
                Text(
                  "Selected wrong pickup.",
                  style: GoogleFonts.roboto(
                      fontSize: kFourteenFont,
                      color: apicontroller.selectedCancelReason.value ==
                              "Selected wrong pickup."
                          ? Kpink
                          : KText,
                      fontWeight: kFW500),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          apicontroller.selectedCancelReason.value == "Selected wrong pickup."
              ? Divider(
                  color: Kpink.withOpacity(0.5),
                )
              : Divider(),
          SizedBox(
            height: 5.h,
          ),
          InkWell(
            onTap: () {
              setState(() {
                apicontroller.selectedCancelReason.value =
                    "Requested by accident.";
              });
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Image.asset(
                  "assets/images/pentagon.png",
                  height: 18.h,
                ),
                SizedBox(
                  width: 25.w,
                ),
                Text(
                  "Requested by accident.",
                  style: GoogleFonts.roboto(
                      fontSize: kFourteenFont,
                      color: apicontroller.selectedCancelReason.value ==
                              "Requested by accident."
                          ? Kpink
                          : KText,
                      fontWeight: kFW500),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          apicontroller.selectedCancelReason.value == "Requested by accident."
              ? Divider(
                  color: Kpink.withOpacity(0.5),
                )
              : Divider(),
          SizedBox(
            height: 5.h,
          ),
          InkWell(
            onTap: () {
              setState(() {
                apicontroller.selectedCancelReason.value =
                    "Requested wrong vehicle.";
              });
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Image.asset(
                  "assets/images/carimage.png",
                  height: 20.h,
                ),
                SizedBox(
                  width: 25.w,
                ),
                Text(
                  "Requested wrong vehicle.",
                  style: GoogleFonts.roboto(
                      fontSize: kFourteenFont,
                      color: apicontroller.selectedCancelReason.value ==
                              "Requested wrong vehicle."
                          ? Kpink
                          : KText,
                      fontWeight: kFW500),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          apicontroller.selectedCancelReason.value == "Requested wrong vehicle."
              ? Divider(
                  color: Kpink.withOpacity(0.5),
                )
              : Divider(),
          SizedBox(
            height: 5.h,
          ),
          InkWell(
            onTap: () {
              setState(() {
                apicontroller.selectedCancelReason.value =
                    "Selected wrong drop off.";
              });
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Image.asset(
                  "assets/images/locationimage.png",
                  height: 22.h,
                ),
                SizedBox(
                  width: 25.w,
                ),
                Text(
                  "Selected wrong drop off.",
                  style: GoogleFonts.roboto(
                      fontSize: kFourteenFont,
                      color: apicontroller.selectedCancelReason.value ==
                              "Selected wrong drop off."
                          ? Kpink
                          : KText,
                      fontWeight: kFW500),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          apicontroller.selectedCancelReason.value == "Selected wrong drop off."
              ? Divider(
                  color: Kpink.withOpacity(0.5),
                )
              : Divider(),
          SizedBox(
            height: 20.h,
          ),
          CustomButton(
              margin: EdgeInsets.only(top: 15.h),
              width: double.infinity,
              height: 42.h,
              fontSize: kFourteenFont,
              fontWeight: kFW700,
              textColor: Kwhite,
              borderRadius: BorderRadius.circular(30.r),
              label: "Cancel Raid",
              isLoading: false,
              onTap: () async {
                var payload = {
                  "Reason": apicontroller.selectedCancelReason.value
                };

                userapicontroller.userCancelRaid(payload);
              }),
          SizedBox(
            height: 50.h,
          )
        ],
      )),
    );
  }
}

///////////////////////More Details sheet
class StatefulBottomMore extends StatefulWidget {
  @override
  _StatefulBottomMoreState createState() => _StatefulBottomMoreState();
}

class _StatefulBottomMoreState extends State<StatefulBottomMore> {
  UserApiController userapicontroller = Get.put(UserApiController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Kwhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2,
      child: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: kPinkBackGroundColur,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        // color: kPinkBackGroundColur.withOpacity(0.1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Ride Details",
                  style: GoogleFonts.roboto(
                      fontSize: kSixteenFont,
                      color: KdarkText,
                      fontWeight: kFW500),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.all(
                10.r,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Kwhite,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3FD3D1D8),
                      blurRadius: 8,
                      offset: Offset(5, 5),
                      spreadRadius: 0,
                    )
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/green_address.png",
                        height: 20.h,
                        // width: 100.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pick up from:",

                            style: GoogleFonts.roboto(
                                fontSize: 11.sp,
                                color: KlightText,
                                fontWeight: kFW500), // KlightText
                          ),
                          SizedBox(
                            width: 200.w,
                            child: Text(
                              userapicontroller.lastPlacedRide["pickupAddress"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.roboto(
                                  fontSize: kTwelveFont,
                                  color: kcarden,
                                  fontWeight: kFW500), // KlightText
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        "assets/images/dot_arrow_down.png",
                        height: 40.h,
                        // width: 100.w,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/pink_arrow.png",
                        height: 20.h,
                        // width: 100.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Drop off :",

                            style: GoogleFonts.roboto(
                                fontSize: 11.sp,
                                color: KlightText,
                                fontWeight: kFW500), // KlightText
                          ),
                          SizedBox(
                            width: 200.w,
                            child: Text(
                              userapicontroller.lastPlacedRide["dropAddress"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.roboto(
                                  fontSize: kTwelveFont,
                                  color: kcarden,
                                  fontWeight: kFW500), // KlightText
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150.w,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Ride Type :",
                                  style: GoogleFonts.roboto(
                                      fontSize: kTwelveFont,
                                      color: Ktextcolor,
                                      fontWeight: kFW500),
                                ),
                                SizedBox(
                                  width: 8.h,
                                ),
                                Text(
                                  userapicontroller
                                          .lastPlacedRide["vehicleType"] ??
                                      "",
                                  style: GoogleFonts.roboto(
                                      fontSize: kTwelveFont,
                                      color: kcarden,
                                      fontWeight: kFW500), // KlightText
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Ride Distance :",
                                  style: GoogleFonts.roboto(
                                      fontSize: kTwelveFont,
                                      color: Ktextcolor,
                                      fontWeight: kFW500),
                                ),
                                SizedBox(
                                  width: 8.h,
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    userapicontroller.totalDistanceStr.value,
                                    maxLines: 1,
                                    // "2.8 km",
                                    style: GoogleFonts.roboto(
                                        fontSize: kTwelveFont,
                                        color: kcarden,
                                        fontWeight: kFW500), // KlightText
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 150.w,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Rider Arrive in:",
                                  style: GoogleFonts.roboto(
                                      fontSize: kTwelveFont,
                                      color: Ktextcolor,
                                      fontWeight: kFW500),
                                ),
                                SizedBox(
                                  width: 8.h,
                                ),
                                Text(
                                  "8mins",
                                  // userapicontroller.userRideArrivalTime.value,
                                  // "₹  ${userapicontroller.lastPlacedRide["price"]}",
                                  style: GoogleFonts.roboto(
                                      fontSize: kTwelveFont,
                                      color: kcarden,
                                      fontWeight: kFW500), // KlightText
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Rider Time:",
                                  style: GoogleFonts.roboto(
                                      fontSize: kTwelveFont,
                                      color: Ktextcolor,
                                      fontWeight: kFW500),
                                ),
                                SizedBox(
                                  width: 8.h,
                                ),
                                Text(
                                  userapicontroller.totalTimeStr.value,
                                  // "₹  ${userapicontroller.lastPlacedRide["price"]}",
                                  style: GoogleFonts.roboto(
                                      fontSize: kTwelveFont,
                                      color: kcarden,
                                      fontWeight: kFW500), // KlightText
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              padding: EdgeInsets.all(
                10.r,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Kwhite,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3FD3D1D8),
                      blurRadius: 6,
                      offset: Offset(5, 5),
                      spreadRadius: 0,
                    )
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Fare:",
                        style: GoogleFonts.roboto(
                            fontSize: kTwelveFont,
                            color: Ktextcolor,
                            fontWeight: kFW500),
                      ),
                      SizedBox(
                        width: 8.h,
                      ),
                      Text(
                        "₹  ${userapicontroller.lastPlacedRide["price"]}",
                        style: GoogleFonts.roboto(
                            fontSize: kTwelveFont,
                            color: kcarden,
                            fontWeight: kFW500), // KlightText
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Divider(),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Mode:",
                        style: GoogleFonts.roboto(
                            fontSize: kTwelveFont,
                            color: Ktextcolor,
                            fontWeight: kFW500),
                      ),
                      SizedBox(
                        width: 8.h,
                      ),
                      Text(
                        "Cash",
                        // "₹  ${userapicontroller.lastPlacedRide["price"]}",
                        style: GoogleFonts.roboto(
                            fontSize: kTwelveFont,
                            color: kcarden,
                            fontWeight: kFW500), // KlightText
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CustomButton(
                margin: EdgeInsets.only(top: 35.h),
                width: double.infinity,
                height: 42.h,
                fontSize: kFourteenFont,
                fontWeight: kFW700,
                textColor: Kwhite,
                borderRadius: BorderRadius.circular(30.r),
                label: "Cancel Raid",
                isLoading: false,
                onTap: () async {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    builder: (context) {
                      return StatefulBottomSheet();
                    },
                  );
                }),
          ],
        ),
      )),
    );
  }
}

//////////////////////////////////////////////////////////
// class StatefulBottomSheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(
//       builder: (BuildContext context, StateSetter setState) {
//         int counter = 0;

//         return

//       },
//     );
//   }
// }
class ResourceList {
  final String value;
  final String text;

  ResourceList(this.value, this.text);
}

// class ProgressController extends GetxController {
//   // To track the currently active progress bar
//   var activeProgressIndex = 0.obs;

//   // Method to start the next animation
//   void startNextAnimation() {
//     if (activeProgressIndex < 4) {
//       activeProgressIndex.value++;
//     }
//   }
// }
class ProgressController extends GetxController {
  // To track the currently active progress bar
  var activeProgressIndex = 0.obs;
  var ProgressCompleted = false.obs;
  // Method to start the next animation
  void startNextAnimation() {
    if (activeProgressIndex < 4) {
      activeProgressIndex.value++;
    } else {
      ProgressCompleted.value = true;
      // All progress bars completed
      print('Completed');
    }
  }
}
