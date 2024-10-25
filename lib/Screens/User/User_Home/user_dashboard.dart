import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'package:geolocator/geolocator.dart';
//////////////////////////////////////////////
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mappls_direction_plugin/mappls_direction_plugin.dart';
import 'package:womentaxi/untils/constants.dart';
import 'package:womentaxi/untils/export_file.dart';
///////////////////////////////////////

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  /////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  // UserApiController
  UserApiController userapicontroller = Get.put(UserApiController());
  //////////////////////////////////////////////////////////////////////////////////////////Mappls
  ApiController apicontroller = Get.put(ApiController());
  DirectionCallback _directionCallback = DirectionCallback(null, null);
  UserApiController userapiController = Get.put(UserApiController());

  List pickAnddrop = [];
  Map<String, dynamic>? searchedData;
  String _cityName = "Unknown";
  /////////////////////////////////////////////////////
  final List<String> _metropolitanCities = [
    'Hyderabad',
    'Bengaluru',
    'Mumbai',
    'Delhi',
    'Kolkata',
    'Chennai',
    'Ahmedabad',
    'Pune',
    'Visakhapatnam',
    'Surat',
    'Vijayawada'
  ];
  ///////////////////////////////////////////////////////////
  //     serviceController.addressLatitude.value =
  //         serviceController.position!.latitude.toString();
  //     serviceController.addressLongitude.value =
  Future<void> _getCityName(double latitude, double longitude) async {
    try {
      // Use placemarkFromCoordinates to get a list of placemarks

      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        // Get the first placemark and use the 'locality' for the city name

        Placemark placemark = placemarks.first;

        String cityName = placemark.locality ?? "Unknown City";

        // Check if the city is in the list of metropolitan cities

        if (_metropolitanCities.contains(cityName)) {
          setState(() {
            _cityName = cityName;
          });

          Get.toNamed(kSearchPlacesV2);

          print(_cityName);
        } else {
          setState(() {
            _cityName = "Out of main city";
          });

          Fluttertoast.showToast(
            msg: "We don't provide service out side of Cities.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Kpink,
            textColor: Kwhite,
            fontSize: 16.0,
          );
        }
      } else {
        setState(() {
          _cityName = "City not found";
        });

        Fluttertoast.showToast(
          msg: "City not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print("Error occurred: $e");

      setState(() {
        _cityName = "Error: $e";
      });

      Fluttertoast.showToast(
        msg: "Error occurred: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  //////////////////////////////////////////////////////////////////////////////////
  bool _switchValue = false;
  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) async {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
    // UserSimplePreferences().setMapShowSTatuc(isSwitched);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Are you sure?',
              style: GoogleFonts.roboto(
                  fontSize: kEighteenFont,
                  fontWeight: kFW600,
                  color: Ktextcolor),
            ),
            content: Text(
              'Do you want to exit this App',
              style:
                  TextStyle(fontSize: 13.sp, fontWeight: kFW600, color: KText),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: GoogleFonts.roboto(
                      fontSize: kTwelveFont,
                      fontWeight: kFW600,
                      color: kcarden),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                // <-- SEE HERE
                child: Text(
                  'Yes',
                  style: GoogleFonts.roboto(
                      fontSize: kTwelveFont, fontWeight: kFW600, color: Kpink),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  /////////////////////////////////////////////////////////
  ServiceController serviceController = Get.put(ServiceController());
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();
  double lat = 37.42796133580664;
  double lon = -122.085749655962;

  String? _currentAddress;

  var isLoading = "none";
  void _getCurrentLocation() async {
    setState(() {
      isLoading = "started";
    });
    Position? position = await _determinePosition();
    setState(() {
      serviceController.position = position;
      serviceController.latittude = serviceController.position!.latitude;
      serviceController.longitude = serviceController.position!.longitude;
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
    await placemarkFromCoordinates(serviceController.position!.latitude,
            serviceController.position!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},${place.postalCode}';
        serviceController.address.value = _currentAddress.toString();
        serviceController.addressLatitude.value =
            serviceController.position!.latitude.toString();
        serviceController.addressLongitude.value =
            serviceController.position!.longitude.toString();
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  ApiController authentication = Get.put(ApiController());
  @override
  void initState() {
    if (serviceController.address.value == "" &&
        serviceController.position == null) {
      _getCurrentLocation();
    } else if (!isPermissionGiven) {
      _getCurrentLocation();
    }
    // setState(() {
    //   authentication.registerworemergencyController.text =
    //       apicontroller.profileData["mobile"] ?? "";
    //   // authentication.registerworemergencyController.value =
    //   //     "${apicontroller.profileData["mobile"]}" as TextEditingValue;
    // });

    //ramwork
    //   apicontroller.profileData["name"] ?? ""
    userapiController.getUserSavedOrders();
    userapicontroller.getUserOrders();
    userapicontroller.getUserfavourites();
    var payload = {
      "fbtoken": UserSimplePreferences.getfbNotification(),
    };

    authentication.uploadFbToken(payload);
    isRaid();
    // _getCurrentLocation();
    super.initState();
  }

  void isRaid() {
    if (UserSimplePreferences.getNotification() == "Ride Booked") {
      // UserSimplePreferences.clearNotification();

      final orderDetails = UserSimplePreferences.getOrderDetails();

      // Set the state after fetching data
      setState(() {
        String title = "No Title";

        UserSimplePreferences.setNotification(notification: "$title");
        userapiController.lastPlacedRide.value = orderDetails!;
        userapiController.lastPlacedId.value =
            userapiController.lastPlacedRide["_id"];
      });

      print("object");
      Get.toNamed(kUserRaidOtp);
      // Get.toNamed(kAcceptOrders);
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  void getPlaceDetails(Map selectedOrder) async {
    setState(() {
      apicontroller.searchedDataV2latittude.value =
          selectedOrder["drop"]["coordinates"][1];

      apicontroller.searchedDataV2longitude.value =
          selectedOrder["drop"]["coordinates"][0];
    });
    apicontroller.updateSearchedDataGmapsV2();
    // Uri uri = Uri.https("maps.googleapis.com", 'maps/api/place/details/json',
    //     {"place_id": placeId, "key": apiKey});

    // String? response = await NetworkUtility.fetchUrl(uri);

    // if (response != null) {
    //   var json = jsonDecode(response);

    //   double lat = json['result']['geometry']['location']['lat'];

    //   double lng = json['result']['geometry']['location']['lng'];

    //   // Do something with the latitude and longitude

    //   apicontroller.updateSearchedDataGmapsV2();

    //   print("Latitude: $lat, Longitude: $lng");
    // }
  }

///////////////////////////
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Kwhite,
        floatingActionButton: Container(
          margin: EdgeInsets.only(right: 25.w),
          child: FloatingActionButton(
            onPressed: () {
              launch("tel://100"
                  // "tel://${apiController.contactData[0]["phone"]}"
                  );
            },
            child: Icon(Icons.phone),
          ),
        ),
        floatingActionButtonLocation: CustomFabLocation(),
        drawer: new Drawer(
          child: new ListView(
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              SizedBox(
                height: 60.h,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(kUserProfile);
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 30.w,
                    ),
                    CircleAvatar(
                        backgroundColor: Ktextcolor.withOpacity(0.5),
                        child: Icon(Icons.person)),
                    SizedBox(
                      width: 30.w,
                    ),
                    Text(
                      "Profile",
                      style: GoogleFonts.roboto(
                          fontSize: kEighteenFont,
                          fontWeight: kFW400,
                          color: kcarden),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 26.sp,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              new ListTile(
                title: new Text('Notifications'),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Kpink.withOpacity(
                    0.5,
                  ),
                  size: 24.sp,
                ),
                onTap: () {
                  Get.toNamed(kUserNotifications);
                },
              ),
              ListTile(
                title: new Text('Rides History'),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Kpink.withOpacity(
                    0.5,
                  ),
                  size: 24.sp,
                ),
                onTap: () {
                  Get.toNamed(kUserRideHistory);
                },
              ),
              ListTile(
                title: new Text('Favourites'),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Kpink.withOpacity(
                    0.5,
                  ),
                  size: 24.sp,
                ),
                onTap: () {
                  Get.toNamed(kUserFavourites);
                },
              ),
              // ListTile(
              //   title: new Text('User Payments'),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: Kpink.withOpacity(
              //       0.5,
              //     ),
              //     size: 24.sp,
              //   ),
              //   onTap: () {
              //     Get.toNamed(kUserPayments);
              //   },
              // ),
              // ListTile(
              //   title: new Text('User Parcel'),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: Kpink.withOpacity(
              //       0.5,
              //     ),
              //     size: 24.sp,
              //   ),
              //   onTap: () {
              //     Get.toNamed(kUserParcel);
              //   },
              // ),
              // ListTile(
              //   title: new Text('Restaurants'),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: Kpink.withOpacity(
              //       0.5,
              //     ),
              //     size: 24.sp,
              //   ),
              //   onTap: () {
              //     Get.toNamed(kUserRestaurantList);
              //   },
              // ),
              // ListTile(
              //   title: new Text('Cart'),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: Kpink.withOpacity(
              //       0.5,
              //     ),
              //     size: 24.sp,
              //   ),
              //   onTap: () {
              //     Get.toNamed(kUserCart);
              //   },
              // ),
              // ListTile(
              //   title: new Text('Upload Biometrics'),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: Kpink.withOpacity(
              //       0.5,
              //     ),
              //     size: 24.sp,
              //   ),
              //   onTap: () {
              //     Get.toNamed(kUserUploadDocs);
              //   },
              // ),
              // ListTile(
              //   title: new Text('Adhaar verify'),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: Kpink.withOpacity(
              //       0.5,
              //     ),
              //     size: 24.sp,
              //   ),
              //   onTap: () {
              //     Get.toNamed(kAdhaarScreen);
              //   },
              // ),
              // ListTile(
              //   title: new Text('Pan verify'),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: Kpink.withOpacity(
              //       0.5,
              //     ),
              //     size: 24.sp,
              //   ),
              //   onTap: () {
              //     Get.toNamed(kPanScreen);
              //   },
              // ),
              // ListTile(
              //   title: new Text('RC verify'),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: Kpink.withOpacity(
              //       0.5,
              //     ),
              //     size: 24.sp,
              //   ),
              //   onTap: () {
              //     Get.toNamed(kRCScreen);
              //   },
              // ),
              // kRCScreen
              ListTile(
                title: new Text('Help Desk'),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Kpink.withOpacity(
                    0.5,
                  ),
                  size: 24.sp,
                ),
                onTap: () {
                  Get.toNamed(kHelpDesk);
                },
              ),
              // ListTile(
              //   title: new Text('Test razorpay'),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: Kpink.withOpacity(
              //       0.5,
              //     ),
              //     size: 24.sp,
              //   ),
              //   onTap: () {
              //     Get.toNamed(kRazorPay);
              //   },
              // ),
              // ListTile(
              //   title: new Text('Test Qr Image'),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: Kpink.withOpacity(
              //       0.5,
              //     ),
              //     size: 24.sp,
              //   ),
              //   onTap: () {
              //     Get.toNamed(kTestRazorQRScreen);
              //   },
              // ),
              // ListTile(
              //   title: new Text('Privacy Policy'),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: Kpink.withOpacity(
              //       0.5,
              //     ),
              //     size: 24.sp,
              //   ),
              //   onTap: () {
              //     Get.toNamed(kPrivacyPolicies);
              //   },
              // ),
              // ListTile(
              //   title: new Text('kUserOrdersHistory'),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: Kpink.withOpacity(
              //       0.5,
              //     ),
              //     size: 24.sp,
              //   ),
              //   onTap: () {
              //     Get.toNamed(kUserOrdersHistory);
              //   },
              // ),
              // ListTile(
              //   title: new Text('Log Out'),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: Kpink.withOpacity(
              //       0.5,
              //     ),
              //     size: 24.sp,
              //   ),
              //   onTap: () {
              //     showDialog(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return AlertDialog(
              //             title: Text('Are You Sure',
              //                 maxLines: 1,
              //                 overflow: TextOverflow.ellipsis,
              //                 style: GoogleFonts.roboto(
              //                     fontSize: 12.sp,
              //                     fontWeight: kFW700,
              //                     color: KdarkText)),
              //             content: Text('You Want To LogOut ?',
              //                 maxLines: 2,
              //                 overflow: TextOverflow.ellipsis,
              //                 style: GoogleFonts.roboto(
              //                     fontSize: 12.sp,
              //                     fontWeight: kFW700,
              //                     color: KdarkText.withOpacity(0.7))),
              //             actions: [
              //               TextButton(
              //                 onPressed: () {
              //                   Get.back();
              //                 },
              //                 child: Text('No',
              //                     maxLines: 1,
              //                     overflow: TextOverflow.ellipsis,
              //                     style: GoogleFonts.roboto(
              //                         fontSize: 12.sp,
              //                         fontWeight: kFW700,
              //                         color: KdarkText)),
              //               ),
              //               TextButton(
              //                 onPressed: () async {
              //                   ///
              //                   /// Delete the database at the given path.
              //                   ///
              //                   // Future<void> deleteDatabase(String path) =>
              //                   //     _databaseHelper.database;
              //                   UserSimplePreferences.clearAllData();
              //                   Get.toNamed(kSelectType);
              //                 },
              //                 child: Text('Yes',
              //                     maxLines: 1,
              //                     overflow: TextOverflow.ellipsis,
              //                     style: GoogleFonts.roboto(
              //                         fontSize: 12.sp,
              //                         fontWeight: kFW700,
              //                         color: KdarkText)),
              //               )
              //             ],
              //           );
              //         });
              //   },
              // ),
            ],
          ),
        ),
        drawerEnableOpenDragGesture: false,
        body: SlidingSheet(
          elevation: 8,
          cornerRadius: 16,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.4, 0.7, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                    // height: 500.h,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Kwhite,
                    ),
                    child:
                        //////////////////////////////////////////////////////////////////////
                        ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.r),
                                topRight: Radius.circular(8.r)),
                            child: isLoading == "ended"
                                ? Obx(
                                    () => isPermissionGiven == true &&
                                            serviceController
                                                    .loacationIsEnabled.value !=
                                                false
                                        ? serviceController.position != null &&
                                                serviceController
                                                        .loacationIsEnabled
                                                        .value !=
                                                    false
                                            ? Expanded(
                                                child:
                                                    // MapplsMap(
                                                    //   initialCameraPosition:
                                                    //       CameraPosition(
                                                    //     target: LatLng(
                                                    //         serviceController
                                                    //             .position!.latitude,
                                                    //         serviceController
                                                    //             .position!
                                                    //             .longitude),
                                                    //     zoom: 14.0,
                                                    //   ),
                                                    //   myLocationEnabled: true,
                                                    //   myLocationRenderMode:
                                                    //       MyLocationRenderMode.GPS,
                                                    //   onMapCreated:
                                                    //       (MapplsMapController
                                                    //           controller) {
                                                    //     controller.animateCamera(
                                                    //       CameraUpdate.newLatLng(
                                                    //         LatLng(
                                                    //             serviceController
                                                    //                 .position!
                                                    //                 .latitude,
                                                    //             serviceController
                                                    //                 .position!
                                                    //                 .longitude),
                                                    //       ),
                                                    //     );
                                                    //   },
                                                    // ),

                                                    Google_map())

                                            // GoogleMap(
                                            //     myLocationButtonEnabled: true,
                                            //     myLocationEnabled: true,
                                            //     zoomControlsEnabled: true,
                                            //     scrollGesturesEnabled: true,
                                            //     mapType: MapType.normal,
                                            //     // initialCameraPosition: CameraPosition(
                                            //     //   target: LatLng( serviceController.position!.latitude,
                                            //     //       serviceController.position!.longitude),
                                            //     //   zoom: 15.0000,
                                            //     // ),
                                            //     onMapCreated: (GoogleMapController controller) {
                                            //       _controller.complete(controller);
                                            //     }, initialCameraPosition:  (){},
                                            //   )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Kgreen,
                                                ),
                                              )
                                        : Image.asset(
                                            "assets/images/nolocation.png",
                                            fit: BoxFit.contain,
                                          ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(top: 200.h),
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          "assets/images/locationBanner.png",
                                          fit: BoxFit.contain,
                                        ),
                                        Container(
                                          width: 150.w,
                                          // alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(
                                              left: 15.h, top: 20.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              Text("Location ",
                                                  style: GoogleFonts.roboto(
                                                    color: Kpink,
                                                    fontSize: 25.sp,
                                                    fontWeight: kFW900,
                                                  )),
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              Text("Loading...",
                                                  style: GoogleFonts.roboto(
                                                      color: kcarden,
                                                      fontSize: 15.sp,
                                                      fontWeight: kFW900)),
                                              AnimatedTextKit(animatedTexts: [
                                                TyperAnimatedText(
                                                    "Please Wait Untill It Loads...",
                                                    textStyle:
                                                        GoogleFonts.roboto(
                                                      color: kcarden,
                                                      fontSize: 10.sp,
                                                      fontWeight: kFW900,
                                                    ))
                                              ]),
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                            // serviceController.address.value == null
                            //     ? Center(child: CircularProgressIndicator())
                            //     :
                            //     Column(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         crossAxisAlignment: CrossAxisAlignment.center,
                            //         children: <Widget>[
                            //             SizedBox(height: 20),
                            //             Expanded(
                            //               child: MapplsMap(
                            //                 initialCameraPosition: CameraPosition(
                            //                   target: LatLng(
                            //                       serviceController
                            //                           .position!.latitude,
                            //                       serviceController
                            //                           .position!.longitude),
                            //                   zoom: 14.0,
                            //                 ),
                            //                 myLocationEnabled: true,
                            //                 myLocationRenderMode:
                            //                     MyLocationRenderMode.GPS,
                            //                 onMapCreated:
                            //                     (MapplsMapController controller) {
                            //                   controller.animateCamera(
                            //                     CameraUpdate.newLatLng(
                            //                       LatLng(
                            //                           serviceController
                            //                               .position!.latitude,
                            //                           serviceController
                            //                               .position!.longitude),
                            //                     ),
                            //                   );
                            //                 },
                            //               ),

                            //               // Google_map()
                            //             ),
                            //           ])
                            )

                    ////////////////////////////////
                    // ClipRRect(
                    //     borderRadius: BorderRadius.only(
                    //         topLeft: Radius.circular(8.r),
                    //         topRight: Radius.circular(8.r)),
                    //     child:

                    //     //  const Google_map()
                    //      ),
                    ),
                Container(
                  margin: EdgeInsets.only(top: 40.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (context) => Container(
                          margin: EdgeInsets.only(left: 20.w),
                          child: InkWell(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: CircleAvatar(
                              backgroundColor: Kwhite,
                              radius: 20.r,
                              child: Image.asset(
                                "assets/images/three_lines.png",
                                height: 12.h,
                                fit: BoxFit.cover,
                              ),
                              // IconButton(
                              //     icon: Icon(Icons.more_vert),
                              //     onPressed: () => Scaffold.of(context).openDrawer()),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Kwhite,
                            borderRadius: BorderRadius.circular(25.r)),
                        height: 42.h,
                        width: 200.w,
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        margin: EdgeInsets.only(left: 20.w),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            RotateAnimatedText(
                              "Welcome to WoR",
                              alignment: Alignment.centerLeft,
                              textStyle: GoogleFonts.roboto(
                                  fontWeight: kFW500,
                                  fontSize: 17.sp,
                                  color: KdarkText),
                            ),
                            RotateAnimatedText(
                              apicontroller.profileData["name"] ?? "",
                              alignment: Alignment.centerLeft,
                              textStyle: GoogleFonts.roboto(
                                  fontWeight: kFW500,
                                  fontSize: kEighteenFont,
                                  color: KdarkText),
                            )
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                          repeatForever: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15.r),
                  // height: MediaQuery.of(context).size.height,
                  color: kPinkBackGroundColur.withOpacity(0.1),
                  // height: MediaQuery.of(context).size.height / 1.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                // BoxShadow(
                                //   color: Color(0x3FD3D1D8),
                                //   blurRadius: 30,
                                //   offset: Offset(15, 15),
                                //   spreadRadius: 0,
                                // )
                              ]),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16.w.h),
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
                                    InkWell(
                                      onTap: () {
                                        Fluttertoast.showToast(
                                            msg:
                                                'You cannot change pick up Location');
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/location_green.png",
                                            height: 20.h,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            width: 16.w,
                                          ),
                                          SizedBox(
                                            width: 230.w,
                                            child: Obx(() => Text(
                                                  serviceController.address
                                                                  .value ==
                                                              "" ||
                                                          serviceController
                                                                  .position ==
                                                              null
                                                      ? "Loading..."
                                                      : serviceController
                                                          .address.value,
                                                  maxLines: 1,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: kFourteenFont,
                                                      color: kcarden,
                                                      fontWeight: kFW500),
                                                  // GoogleFonts.roboto(
                                                  //     fontSize: kFourteenFont,
                                                  //     color: KdarkText,
                                                  //     fontWeight: kFW500),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        ///////////////////////////////////////////////////////////
                                        //     serviceController.addressLatitude.value =
                                        //         serviceController.position!.latitude.toString();
                                        //     serviceController.addressLongitude.value =
                                        _getCityName(
                                            double.parse(serviceController
                                                .addressLatitude.value),
                                            double.parse(serviceController
                                                .addressLongitude.value));
                                        // Get.toNamed(kSearchPlacesV2); // recent change

                                        // showDialog(
                                        //     context: context,
                                        //     builder: (BuildContext context) {
                                        //       return AlertDialog(
                                        //         title: Text('Note:',
                                        //             maxLines: 1,
                                        //             overflow: TextOverflow.ellipsis,
                                        //             style: GoogleFonts.roboto(
                                        //                 fontSize: 12.sp,
                                        //                 fontWeight: kFW700,
                                        //                 color: KdarkText)),
                                        //         content: Text(
                                        //             'please select drop location only!!',
                                        //             maxLines: 2,
                                        //             overflow: TextOverflow.ellipsis,
                                        //             style: GoogleFonts.roboto(
                                        //                 fontSize: 12.sp,
                                        //                 fontWeight: kFW700,
                                        //                 color:
                                        //                     KdarkText.withOpacity(0.7))),
                                        //         actions: [
                                        //           TextButton(
                                        //             onPressed: () {
                                        //               Get.back();
                                        //             },
                                        //             child: Text('No',
                                        //                 maxLines: 1,
                                        //                 overflow: TextOverflow.ellipsis,
                                        //                 style: GoogleFonts.roboto(
                                        //                     fontSize: 12.sp,
                                        //                     fontWeight: kFW700,
                                        //                     color: KdarkText)),
                                        //           ),
                                        //           TextButton(
                                        //             // textColor: Color(0xFF6200EE),
                                        //             onPressed: () async {
                                        //               Get.toNamed(kSearchPlacesV2);
                                        //               //   openMapplsDirectionWidget();
                                        //             },
                                        //             child: Text('Yes',
                                        //                 maxLines: 1,
                                        //                 overflow: TextOverflow.ellipsis,
                                        //                 style: GoogleFonts.roboto(
                                        //                     fontSize: 12.sp,
                                        //                     fontWeight: kFW700,
                                        //                     color: KdarkText)),
                                        //           )
                                        //         ],
                                        //       );
                                        //     });
                                        // timercontroller.stopTimer();
                                        // UserSimplePreferences.clearAllData();
                                        // Get.toNamed(kSelectType);

                                        // openMapplsDirectionWidget();

                                        //Get.toNamed(kMergeMapplsScreen);
                                        //   Get.toNamed(kUserSelectDrop);
                                      },
                                      child: Row(
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
                                            "Enter Drop Location",
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
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    )
                                  ],
                                ),
                              ),

                              // ramsaved
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16.w.h),
                                  child: Obx(
                                    () =>
                                        // write main code here
                                        userapiController
                                                            .userOrdersDataLoading ==
                                                        true &&
                                                    userapiController
                                                            .favouriteOrdersDataLoading ==
                                                        true ||
                                                userapiController
                                                        .userOrdersDataLoading ==
                                                    true ||
                                                userapiController
                                                        .favouriteOrdersDataLoading ==
                                                    true
                                            ? Container(
                                                alignment: Alignment.center,
                                                margin:
                                                    EdgeInsets.only(top: 50.h),
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Kpink,
                                                ),
                                              )
                                            : userapiController
                                                    .favouriteOrders.isEmpty
                                                ? Column(
                                                    children: [
                                                      Obx(() => userapiController
                                                                  .userOrdersDataLoading ==
                                                              true
                                                          ? Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 100
                                                                          .h),
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Kpink,
                                                              ),
                                                            )
                                                          : userapiController
                                                                      .userOrders
                                                                      .isEmpty ||
                                                                  userapiController.userOrders ==
                                                                      null
                                                              ? SizedBox()
                                                              : Obx(() => ListView
                                                                  .builder(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: userapiController
                                                                          .userOrders
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return index <=
                                                                                2
                                                                            ? InkWell(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    apicontroller.searchedDataV2.value = userapiController.userOrders[index]["dropAddress"] ?? "";
                                                                                    // placePredictions[index].description!;
                                                                                  });

                                                                                  getPlaceDetails(userapiController.userOrders[index]);

                                                                                  // apicontroller.updateSearchedDataGmapsV2();
                                                                                },
                                                                                child: Column(
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Row(
                                                                                          children: [
                                                                                            Icon(
                                                                                              Icons.location_searching,
                                                                                              color: Kpink.withOpacity(
                                                                                                0.5,
                                                                                              ),
                                                                                              size: 18.sp,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 10.w,
                                                                                            ),
                                                                                            Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                SizedBox(
                                                                                                  width: 220.w,
                                                                                                  child: Text(
                                                                                                    userapiController.userOrders[index]["dropAddress"],
                                                                                                    // userapiController.userSavedOrders[index]["dropAddress"] ?? "",
                                                                                                    maxLines: 1,
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                    style: GoogleFonts.roboto(fontSize: kFourteenFont, color: kcarden, fontWeight: kFW500),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 2.h,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 220.w,
                                                                                                  child: Text(
                                                                                                    userapiController.userOrders[index]["pickupAddress"],
                                                                                                    // userapiController.userSavedOrders[index]["pickupAddress"] ?? "",
                                                                                                    //     "Survey No. 1050, Balanagar Mandal, Rd Number 3, Kukatpally Housing Board Colony, Kukatpally, Hyderabad, Telangana 500072",
                                                                                                    maxLines: 1,
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                    style: GoogleFonts.roboto(fontSize: kTwelveFont, color: Ktextcolor, fontWeight: kFW500),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),

                                                                                        // userAddtoFavourite
                                                                                        Obx(() => userapiController.userOrders[index]["favorite"] == false
                                                                                            ? InkWell(
                                                                                                onTap: () {
                                                                                                  userapicontroller.userAddtoFavouriteinHistory(userapiController.userOrders[index]["_id"]);
                                                                                                },
                                                                                                child: Icon(
                                                                                                  Icons.favorite_outline,
                                                                                                  color: KlightText,
                                                                                                  //  Kpink.withOpacity(
                                                                                                  //   0.5,

                                                                                                  size: 18.sp,
                                                                                                ),
                                                                                              )
                                                                                            : InkWell(
                                                                                                onTap: () {
                                                                                                  userapicontroller.userAddtoFavouriteinHistory(userapiController.userOrders[index]["_id"]);
                                                                                                },
                                                                                                child: Icon(
                                                                                                  Icons.favorite,
                                                                                                  color: Kpink,
                                                                                                  //  Kpink.withOpacity(
                                                                                                  //   0.5,

                                                                                                  size: 18.sp,
                                                                                                ),
                                                                                              ))
                                                                                      ],
                                                                                    ),
                                                                                    Divider()
                                                                                  ],
                                                                                ),

                                                                                // Container(
                                                                                //   margin: EdgeInsets.only(top: 12.h),
                                                                                //   width: double.infinity,
                                                                                //   padding: EdgeInsets.all(10.r),
                                                                                //   decoration: BoxDecoration(
                                                                                //     boxShadow: [
                                                                                //       BoxShadow(
                                                                                //         color: Ktextcolor.withOpacity(0.5),
                                                                                //         blurRadius: 5.r,
                                                                                //         offset: Offset(1, 1),
                                                                                //         spreadRadius: 1.r,
                                                                                //       )
                                                                                //     ],
                                                                                //     color: Kwhite,
                                                                                //     borderRadius: BorderRadius.circular(10.r),
                                                                                //   ),
                                                                                //   child: Row(
                                                                                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                                                                //     children: [
                                                                                //       Icon(
                                                                                //         Icons.location_searching,
                                                                                //         color: Kpink.withOpacity(
                                                                                //           0.5,
                                                                                //         ),
                                                                                //         size: 18.sp,
                                                                                //       ),
                                                                                //       Column(
                                                                                //         mainAxisAlignment: MainAxisAlignment.start,
                                                                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                                                                //         children: [
                                                                                //           SizedBox(
                                                                                //             width: 150.w,
                                                                                //             child: Text(
                                                                                //               userapiController.userOrders[index]["dropAddress"],
                                                                                //               // userapiController
                                                                                //               //             .userSavedOrders[
                                                                                //               //         index]["dropAddress"] ??
                                                                                //               //     "",
                                                                                //               maxLines: 1,
                                                                                //               overflow: TextOverflow.ellipsis,
                                                                                //               style: GoogleFonts.roboto(fontSize: kSixteenFont, color: kcarden, fontWeight: kFW500),
                                                                                //             ),
                                                                                //           ),
                                                                                //           SizedBox(
                                                                                //             height: 8.h,
                                                                                //           ),
                                                                                //           SizedBox(
                                                                                //             width: 200.w,
                                                                                //             child: Text(
                                                                                //               userapiController.userOrders[index]["pickupAddress"],
                                                                                //               // userapiController
                                                                                //               //                 .userSavedOrders[
                                                                                //               //             index]
                                                                                //               //         ["pickupAddress"] ??
                                                                                //               //     "",
                                                                                //               //     "Survey No. 1050, Balanagar Mandal, Rd Number 3, Kukatpally Housing Board Colony, Kukatpally, Hyderabad, Telangana 500072",
                                                                                //               maxLines: 1,
                                                                                //               overflow: TextOverflow.ellipsis,
                                                                                //               style: GoogleFonts.roboto(fontSize: kTwelveFont, color: Ktextcolor, fontWeight: kFW500),
                                                                                //             ),
                                                                                //           ),
                                                                                //         ],
                                                                                //       ),
                                                                                //       // userAddtoFavourite
                                                                                //       // userapiController.userSavedOrders[index]
                                                                                //       Obx(() => userapiController.userOrders[index]["favorite"] == false
                                                                                //           ? InkWell(
                                                                                //               onTap: () {
                                                                                //                 userapicontroller.userAddtoFavouriteinHistory(userapiController.userOrders[index]["_id"]);
                                                                                //               },
                                                                                //               child: Icon(
                                                                                //                 Icons.favorite_outline,
                                                                                //                 color: KlightText,
                                                                                //                 //  Kpink.withOpacity(
                                                                                //                 //   0.5,

                                                                                //                 size: 18.sp,
                                                                                //               ),
                                                                                //             )
                                                                                //           : InkWell(
                                                                                //               onTap: () {
                                                                                //                 userapicontroller.userAddtoFavouriteinHistory(userapiController.userOrders[index]["_id"]);
                                                                                //               },
                                                                                //               child: Icon(
                                                                                //                 Icons.favorite,
                                                                                //                 color: Kpink,
                                                                                //                 //  Kpink.withOpacity(
                                                                                //                 //   0.5,

                                                                                //                 size: 18.sp,
                                                                                //               ),
                                                                                //             ))
                                                                                //     ],
                                                                                //   ),
                                                                                // ),
                                                                              )
                                                                            : SizedBox();
                                                                      }))),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Get.toNamed(
                                                                  kUserRideHistory);
                                                            },
                                                            child: Text(
                                                              "Previous Rides",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          15.sp,
                                                                      color:
                                                                          Kpink,
                                                                      fontWeight:
                                                                          kFW500),
                                                            ),
                                                          ),
                                                          Text(
                                                            "|",
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        kSixteenFont,
                                                                    color:
                                                                        Kpink,
                                                                    fontWeight:
                                                                        kFW500),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Get.toNamed(
                                                                  kUserFavourites);
                                                            },
                                                            child: Text(
                                                              "Favourites List",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          15.sp,
                                                                      color:
                                                                          Kpink,
                                                                      fontWeight:
                                                                          kFW500),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      Obx(() => userapiController
                                                                  .favouriteOrdersDataLoading ==
                                                              true
                                                          ? Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 100
                                                                          .h),
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Kpink,
                                                              ),
                                                            )
                                                          : userapiController
                                                                      .favouriteOrders
                                                                      .isEmpty ||
                                                                  userapiController.favouriteOrders ==
                                                                      null
                                                              ? Text(
                                                                  "",
                                                                  style: GoogleFonts.roboto(
                                                                      fontSize:
                                                                          kSixteenFont,
                                                                      color:
                                                                          KdarkText,
                                                                      fontWeight:
                                                                          kFW500),
                                                                )
                                                              : ListView
                                                                  .builder(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: userapiController
                                                                          .favouriteOrders
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return index ==
                                                                                0
                                                                            ? InkWell(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    apicontroller.searchedDataV2.value = userapiController.favouriteOrders[index]["dropAddress"] ?? "";
                                                                                    // placePredictions[index].description!;
                                                                                  });

                                                                                  getPlaceDetails(userapiController.favouriteOrders[index]);

                                                                                  // apicontroller.updateSearchedDataGmapsV2();
                                                                                },
                                                                                child: Column(
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Row(
                                                                                          children: [
                                                                                            Icon(
                                                                                              Icons.location_searching,
                                                                                              color: Kpink.withOpacity(
                                                                                                0.5,
                                                                                              ),
                                                                                              size: 18.sp,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 10.w,
                                                                                            ),
                                                                                            Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                SizedBox(
                                                                                                  width: 220.w,
                                                                                                  child: Text(
                                                                                                    userapiController.favouriteOrders[index]["dropAddress"],
                                                                                                    // userapiController.userSavedOrders[index]["dropAddress"] ?? "",
                                                                                                    maxLines: 1,
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                    style: GoogleFonts.roboto(fontSize: kFourteenFont, color: kcarden, fontWeight: kFW500),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 2.h,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 220.w,
                                                                                                  child: Text(
                                                                                                    userapiController.favouriteOrders[index]["pickupAddress"],
                                                                                                    // userapiController.userSavedOrders[index]["pickupAddress"] ?? "",
                                                                                                    //     "Survey No. 1050, Balanagar Mandal, Rd Number 3, Kukatpally Housing Board Colony, Kukatpally, Hyderabad, Telangana 500072",
                                                                                                    maxLines: 1,
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                    style: GoogleFonts.roboto(fontSize: kTwelveFont, color: Ktextcolor, fontWeight: kFW500),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),

                                                                                        // userAddtoFavourite
                                                                                        Obx(() => userapiController.favouriteOrders[index]["favorite"] == false
                                                                                            ? InkWell(
                                                                                                onTap: () {
                                                                                                  userapicontroller.userAddtoFavouriteinFavouritesList(userapiController.favouriteOrders[index]["_id"]);
                                                                                                },
                                                                                                child: Icon(
                                                                                                  Icons.favorite_outline,
                                                                                                  color: KlightText,
                                                                                                  //  Kpink.withOpacity(
                                                                                                  //   0.5,

                                                                                                  size: 18.sp,
                                                                                                ),
                                                                                              )
                                                                                            : InkWell(
                                                                                                onTap: () {
                                                                                                  userapicontroller.userAddtoFavouriteinFavouritesList(userapiController.favouriteOrders[index]["_id"]);
                                                                                                },
                                                                                                child: Icon(
                                                                                                  Icons.favorite,
                                                                                                  color: Kpink,
                                                                                                  //  Kpink.withOpacity(
                                                                                                  //   0.5,

                                                                                                  size: 18.sp,
                                                                                                ),
                                                                                              ))
                                                                                      ],
                                                                                    ),
                                                                                    Divider()
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            : SizedBox();
                                                                      })),
                                                      ///////////////////////////////////////////////////
                                                      Obx(() => userapiController
                                                                  .userOrdersDataLoading ==
                                                              true
                                                          ? Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 100
                                                                          .h),
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Kpink,
                                                              ),
                                                            )
                                                          : userapiController
                                                                      .userOrders
                                                                      .isEmpty ||
                                                                  userapiController.userOrders ==
                                                                      null
                                                              ? SizedBox()
                                                              : Obx(() => ListView
                                                                  .builder(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemCount: userapiController
                                                                          .userOrders
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return index <=
                                                                                1
                                                                            ? InkWell(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    apicontroller.searchedDataV2.value = userapiController.userOrders[index]["dropAddress"] ?? "";
                                                                                    // placePredictions[index].description!;
                                                                                  });

                                                                                  getPlaceDetails(userapiController.userOrders[index]);

                                                                                  // apicontroller.updateSearchedDataGmapsV2();
                                                                                },
                                                                                child: Column(
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Row(
                                                                                          children: [
                                                                                            Icon(
                                                                                              Icons.location_searching,
                                                                                              color: Kpink.withOpacity(
                                                                                                0.5,
                                                                                              ),
                                                                                              size: 18.sp,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 10.w,
                                                                                            ),
                                                                                            Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                SizedBox(
                                                                                                  width: 220.w,
                                                                                                  child: Text(
                                                                                                    userapiController.userOrders[index]["dropAddress"],
                                                                                                    // userapiController.userSavedOrders[index]["dropAddress"] ?? "",
                                                                                                    maxLines: 1,
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                    style: GoogleFonts.roboto(fontSize: kFourteenFont, color: kcarden, fontWeight: kFW500),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 2.h,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 220.w,
                                                                                                  child: Text(
                                                                                                    userapiController.userOrders[index]["pickupAddress"],
                                                                                                    // userapiController.userSavedOrders[index]["pickupAddress"] ?? "",
                                                                                                    //     "Survey No. 1050, Balanagar Mandal, Rd Number 3, Kukatpally Housing Board Colony, Kukatpally, Hyderabad, Telangana 500072",
                                                                                                    maxLines: 1,
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                    style: GoogleFonts.roboto(fontSize: kTwelveFont, color: Ktextcolor, fontWeight: kFW500),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),

                                                                                        // userAddtoFavourite
                                                                                        Obx(() => userapiController.userOrders[index]["favorite"] == false
                                                                                            ? InkWell(
                                                                                                onTap: () {
                                                                                                  userapicontroller.userAddtoFavouriteinHistory(userapiController.userOrders[index]["_id"]);
                                                                                                },
                                                                                                child: Icon(
                                                                                                  Icons.favorite_outline,
                                                                                                  color: KlightText,
                                                                                                  //  Kpink.withOpacity(
                                                                                                  //   0.5,

                                                                                                  size: 18.sp,
                                                                                                ),
                                                                                              )
                                                                                            : InkWell(
                                                                                                onTap: () {
                                                                                                  userapicontroller.userAddtoFavouriteinHistory(userapiController.userOrders[index]["_id"]);
                                                                                                },
                                                                                                child: Icon(
                                                                                                  Icons.favorite,
                                                                                                  color: Kpink,
                                                                                                  //  Kpink.withOpacity(
                                                                                                  //   0.5,

                                                                                                  size: 18.sp,
                                                                                                ),
                                                                                              ))
                                                                                      ],
                                                                                    ),
                                                                                    Divider()
                                                                                  ],
                                                                                ),

                                                                                //  Container(
                                                                                //   margin: EdgeInsets.only(top: 12.h),
                                                                                //   width: double.infinity,
                                                                                //   padding: EdgeInsets.all(10.r),
                                                                                //   decoration: BoxDecoration(
                                                                                //     boxShadow: [
                                                                                //       BoxShadow(
                                                                                //         color: Ktextcolor.withOpacity(0.5),
                                                                                //         blurRadius: 5.r,
                                                                                //         offset: Offset(1, 1),
                                                                                //         spreadRadius: 1.r,
                                                                                //       )
                                                                                //     ],
                                                                                //     color: Kwhite,
                                                                                //     borderRadius: BorderRadius.circular(10.r),
                                                                                //   ),
                                                                                //   child: Row(
                                                                                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                                                                //     children: [
                                                                                //       Icon(
                                                                                //         Icons.location_searching,
                                                                                //         color: Kpink.withOpacity(
                                                                                //           0.5,
                                                                                //         ),
                                                                                //         size: 18.sp,
                                                                                //       ),
                                                                                //       Column(
                                                                                //         mainAxisAlignment: MainAxisAlignment.start,
                                                                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                                                                //         children: [
                                                                                //           SizedBox(
                                                                                //             width: 150.w,
                                                                                //             child: Text(
                                                                                //               userapiController.userOrders[index]["dropAddress"],
                                                                                //               // userapiController
                                                                                //               //             .userSavedOrders[
                                                                                //               //         index]["dropAddress"] ??
                                                                                //               //     "",
                                                                                //               maxLines: 1,
                                                                                //               overflow: TextOverflow.ellipsis,
                                                                                //               style: GoogleFonts.roboto(fontSize: kSixteenFont, color: kcarden, fontWeight: kFW500),
                                                                                //             ),
                                                                                //           ),
                                                                                //           SizedBox(
                                                                                //             height: 8.h,
                                                                                //           ),
                                                                                //           SizedBox(
                                                                                //             width: 200.w,
                                                                                //             child: Text(
                                                                                //               userapiController.userOrders[index]["pickupAddress"],
                                                                                //               // userapiController
                                                                                //               //                 .userSavedOrders[
                                                                                //               //             index]
                                                                                //               //         ["pickupAddress"] ??
                                                                                //               //     "",
                                                                                //               //     "Survey No. 1050, Balanagar Mandal, Rd Number 3, Kukatpally Housing Board Colony, Kukatpally, Hyderabad, Telangana 500072",
                                                                                //               maxLines: 1,
                                                                                //               overflow: TextOverflow.ellipsis,
                                                                                //               style: GoogleFonts.roboto(fontSize: kTwelveFont, color: Ktextcolor, fontWeight: kFW500),
                                                                                //             ),
                                                                                //           ),
                                                                                //         ],
                                                                                //       ),
                                                                                //       // userAddtoFavourite
                                                                                //       // userapiController.userSavedOrders[index]
                                                                                //       Obx(() => userapiController.userOrders[index]["favorite"] == false
                                                                                //           ? InkWell(
                                                                                //               onTap: () {
                                                                                //                 userapicontroller.userAddtoFavouriteinHistory(userapiController.userOrders[index]["_id"]);
                                                                                //               },
                                                                                //               child: Icon(
                                                                                //                 Icons.favorite_outline,
                                                                                //                 color: KlightText,
                                                                                //                 //  Kpink.withOpacity(
                                                                                //                 //   0.5,

                                                                                //                 size: 18.sp,
                                                                                //               ),
                                                                                //             )
                                                                                //           : InkWell(
                                                                                //               onTap: () {
                                                                                //                 userapicontroller.userAddtoFavouriteinHistory(userapiController.userOrders[index]["_id"]);
                                                                                //               },
                                                                                //               child: Icon(
                                                                                //                 Icons.favorite,
                                                                                //                 color: Kpink,
                                                                                //                 //  Kpink.withOpacity(
                                                                                //                 //   0.5,

                                                                                //                 size: 18.sp,
                                                                                //               ),
                                                                                //             ))
                                                                                //     ],
                                                                                //   ),
                                                                                // ),
                                                                              )
                                                                            : SizedBox();
                                                                      })))
                                                      //////////////////////////////////////////////////////////////////////

                                                      // Obx(() => userapiController
                                                      //             .userSavedOrdersDataLoading ==
                                                      //         true
                                                      //     ? Container(
                                                      //         alignment: Alignment.center,
                                                      //         margin: EdgeInsets.only(top: 100.h),
                                                      //         child: CircularProgressIndicator(
                                                      //           color: Kpink,
                                                      //         ),
                                                      //       )
                                                      //     : userapiController
                                                      //                 .userSavedOrders.isEmpty ||
                                                      //             userapiController
                                                      //                     .userSavedOrders ==
                                                      //                 null
                                                      //         ? Text(
                                                      //             "",
                                                      //             style: GoogleFonts.roboto(
                                                      //                 fontSize: kSixteenFont,
                                                      //                 color: KdarkText,
                                                      //                 fontWeight: kFW500),
                                                      //           )
                                                      //         :
                                                      //         ListView.builder(
                                                      //             padding: EdgeInsets.zero,
                                                      //             shrinkWrap: true,
                                                      //             physics:
                                                      //                 const NeverScrollableScrollPhysics(),
                                                      //             itemCount: userapiController
                                                      //                 .userSavedOrders.length,
                                                      //             itemBuilder: (context, index) {
                                                      //               return index <= 2
                                                      //                   ? InkWell(
                                                      //                       onTap: () {
                                                      //                         setState(() {
                                                      //                           apicontroller
                                                      //                               .searchedDataV2
                                                      //                               .value = userapiController
                                                      //                                           .userSavedOrders[
                                                      //                                       index]
                                                      //                                   [
                                                      //                                   "dropAddress"] ??
                                                      //                               "";
                                                      //                           // placePredictions[index].description!;
                                                      //                         });

                                                      //                         getPlaceDetails(
                                                      //                             userapiController
                                                      //                                     .userSavedOrders[
                                                      //                                 index]);

                                                      //                         // apicontroller.updateSearchedDataGmapsV2();
                                                      //                       },
                                                      //                       child: Container(
                                                      //                         margin:
                                                      //                             EdgeInsets.only(
                                                      //                                 top: 5.h),
                                                      //                         child: Column(
                                                      //                           children: [
                                                      //                             Row(
                                                      //                               mainAxisAlignment:
                                                      //                                   MainAxisAlignment
                                                      //                                       .spaceBetween,
                                                      //                               crossAxisAlignment:
                                                      //                                   CrossAxisAlignment
                                                      //                                       .center,
                                                      //                               children: [
                                                      //                                 Row(
                                                      //                                   children: [
                                                      //                                     Icon(
                                                      //                                       Icons
                                                      //                                           .location_searching,
                                                      //                                       color:
                                                      //                                           Kpink.withOpacity(
                                                      //                                         0.5,
                                                      //                                       ),
                                                      //                                       size:
                                                      //                                           18.sp,
                                                      //                                     ),
                                                      //                                     SizedBox(
                                                      //                                       width:
                                                      //                                           10.w,
                                                      //                                     ),
                                                      //                                     Column(
                                                      //                                       mainAxisAlignment:
                                                      //                                           MainAxisAlignment.start,
                                                      //                                       crossAxisAlignment:
                                                      //                                           CrossAxisAlignment.start,
                                                      //                                       children: [
                                                      //                                         SizedBox(
                                                      //                                           width: 220.w,
                                                      //                                           child: Text(
                                                      //                                             userapiController.userSavedOrders[index]["dropAddress"] ?? "",
                                                      //                                             maxLines: 1,
                                                      //                                             overflow: TextOverflow.ellipsis,
                                                      //                                             style: GoogleFonts.roboto(fontSize: kFourteenFont, color: kcarden, fontWeight: kFW500),
                                                      //                                           ),
                                                      //                                         ),
                                                      //                                         SizedBox(
                                                      //                                           height: 2.h,
                                                      //                                         ),
                                                      //                                         SizedBox(
                                                      //                                           width: 220.w,
                                                      //                                           child: Text(
                                                      //                                             userapiController.userSavedOrders[index]["pickupAddress"] ?? "",
                                                      //                                             //     "Survey No. 1050, Balanagar Mandal, Rd Number 3, Kukatpally Housing Board Colony, Kukatpally, Hyderabad, Telangana 500072",
                                                      //                                             maxLines: 1,
                                                      //                                             overflow: TextOverflow.ellipsis,
                                                      //                                             style: GoogleFonts.roboto(fontSize: kTwelveFont, color: Ktextcolor, fontWeight: kFW500),
                                                      //                                           ),
                                                      //                                         ),
                                                      //                                       ],
                                                      //                                     ),
                                                      //                                   ],
                                                      //                                 ),

                                                      //                                 // userAddtoFavourite
                                                      //                                 userapiController.userSavedOrders[index]["favorite"] ==
                                                      //                                         false
                                                      //                                     ? InkWell(
                                                      //                                         onTap:
                                                      //                                             () {
                                                      //                                           userapicontroller.userAddtoFavourite(userapiController.userSavedOrders[index]["_id"]);
                                                      //                                         },
                                                      //                                         child:
                                                      //                                             Icon(
                                                      //                                           Icons.favorite_outline,
                                                      //                                           color: KlightText,
                                                      //                                           //  Kpink.withOpacity(
                                                      //                                           //   0.5,

                                                      //                                           size: 18.sp,
                                                      //                                         ),
                                                      //                                       )
                                                      //                                     : InkWell(
                                                      //                                         onTap:
                                                      //                                             () {
                                                      //                                           userapicontroller.userAddtoFavourite(userapiController.userSavedOrders[index]["_id"]);
                                                      //                                         },
                                                      //                                         child:
                                                      //                                             Icon(
                                                      //                                           Icons.favorite,
                                                      //                                           color: Kpink,
                                                      //                                           //  Kpink.withOpacity(
                                                      //                                           //   0.5,

                                                      //                                           size: 18.sp,
                                                      //                                         ),
                                                      //                                       )
                                                      //                               ],
                                                      //                             ),
                                                      //                             Divider()
                                                      //                           ],
                                                      //                         ),
                                                      //                       ),
                                                      //                     )
                                                      //                   : SizedBox();
                                                      //             })),
                                                      ,
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Get.toNamed(
                                                                  kUserRideHistory);
                                                            },
                                                            child: Text(
                                                              "Previous Rides",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          15.sp,
                                                                      color:
                                                                          Kpink,
                                                                      fontWeight:
                                                                          kFW500),
                                                            ),
                                                          ),
                                                          Text(
                                                            "|",
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        kSixteenFont,
                                                                    color:
                                                                        Kpink,
                                                                    fontWeight:
                                                                        kFW500),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Get.toNamed(
                                                                  kUserFavourites);
                                                            },
                                                            child: Text(
                                                              "Favourites List",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          15.sp,
                                                                      color:
                                                                          Kpink,
                                                                      fontWeight:
                                                                          kFW500),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                  )),
                            ],
                          )),

                      // SizedBox(
                      //   height: 5.h,
                      // ),
                      // CustomFormField(
                      //   ontap: () {
                      //     openMapplsDirectionWidget();

                      //     //Get.toNamed(kMergeMapplsScreen);
                      //     //   Get.toNamed(kUserSelectDrop);
                      //   },
                      //   enabled: true,
                      //   prefix: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         vertical: 16, horizontal: 5),
                      //     child: Image.asset(
                      //       "assets/images/pink_corner_arrow.png",
                      //       height: 20.h,
                      //     ),

                      //     // Icon(
                      //     //   Icons.search,
                      //     //   color: kcarden,
                      //     // )
                      //   ),
                      //   contentPadding: const EdgeInsets.symmetric(
                      //     vertical: 16,
                      //   ),
                      //   fontSize: kFourteenFont,
                      //   fontWeight: FontWeight.w500,
                      //   hintText: "Enter Drop Location",
                      //   maxLines: 1,
                      //   readOnly: false,
                      //   label: "",
                      //   obscureText: false,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please Drop Location';
                      //     }
                      //     return null;
                      //   },
                      // ),

                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Our Services",
                        style: GoogleFonts.roboto(
                            fontSize: kSixteenFont,
                            color: kcarden,
                            fontWeight: kFW500),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    apicontroller.selectedVehicle.value =
                                        "scooty";
                                    apicontroller.isVehicleselected.value =
                                        true;
                                  });
                                  Get.toNamed(kSearchPlacesV2);
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.asset(
                                        "assets/images/pink_scooty.jpeg",
                                        height: 42.h,
                                        width: 42.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Text(
                                      "Scooty",
                                      style: GoogleFonts.roboto(
                                          fontSize: kSixteenFont,
                                          color: kcarden,
                                          fontWeight: kFW500),
                                    ),
                                    SizedBox(
                                      width: 42.w,
                                      child: Divider(
                                          thickness: 2,
                                          color: apicontroller
                                                      .vehicleBannerActive ==
                                                  "scooty"
                                              ? Kpink
                                              : kPinkBackGroundColur
                                                  .withOpacity(0.1)),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    apicontroller.selectedVehicle.value = "cab";
                                    apicontroller.isVehicleselected.value =
                                        true;
                                  });
                                  Get.toNamed(kSearchPlacesV2);
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.asset(
                                        "assets/images/pink_car.jpeg",
                                        height: 42.h,
                                        width: 42.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Text(
                                      "Car",
                                      style: GoogleFonts.roboto(
                                          fontSize: kSixteenFont,
                                          color: kcarden,
                                          fontWeight: kFW500),
                                    ),
                                    SizedBox(
                                      width: 42.w,
                                      child: Divider(
                                          thickness: 2,
                                          color: apicontroller
                                                      .vehicleBannerActive ==
                                                  "car"
                                              ? Kpink
                                              : kPinkBackGroundColur
                                                  .withOpacity(0.1)),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    apicontroller.selectedVehicle.value =
                                        "auto";
                                    apicontroller.isVehicleselected.value =
                                        true;
                                  });
                                  Get.toNamed(kSearchPlacesV2);
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.asset(
                                        "assets/images/pinkish_autos.jpeg",
                                        height: 42.h,
                                        width: 42.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Text(
                                      "Auto",
                                      style: GoogleFonts.roboto(
                                          fontSize: kSixteenFont,
                                          color: kcarden,
                                          fontWeight: kFW500),
                                    ),
                                    SizedBox(
                                      width: 42.w,
                                      child: Divider(
                                          thickness: 2,
                                          color: apicontroller
                                                      .vehicleBannerActive ==
                                                  "auto"
                                              ? Kpink
                                              : kPinkBackGroundColur
                                                  .withOpacity(0.1)),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    apicontroller.selectedVehicle.value =
                                        "parcel";
                                    apicontroller.isVehicleselected.value =
                                        true;
                                  });
                                  Get.toNamed(kSearchPlacesV2);
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.asset(
                                        "assets/images/delivery_two.jpeg",
                                        height: 42.h,
                                        width: 42.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Text(
                                      "Parcel",
                                      style: GoogleFonts.roboto(
                                          fontSize: kSixteenFont,
                                          color: kcarden,
                                          fontWeight: kFW500),
                                    ),
                                    SizedBox(
                                      width: 42.w,
                                      child: Divider(
                                        thickness: 2,
                                        color:
                                            apicontroller.vehicleBannerActive ==
                                                    "parcel"
                                                ? Kpink
                                                : kPinkBackGroundColur
                                                    .withOpacity(0.1),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 15.h,
                      ),
                      VehicleBanners(),
                      SizedBox(
                        height: 15.h,
                      ),

                      // Obx(
                      //   () => Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       // Custom_OutlineButton(
                      //       //     borderRadius: BorderRadius.circular(15.r),
                      //       //     margin: EdgeInsets.all(10.r),
                      //       //     width: 140.w,
                      //       //     height: 35.h,
                      //       //     Color: Kpink,
                      //       //     textColor: Kpink,
                      //       //     fontSize: 12.sp,
                      //       //     fontWeight: kFW700,

                      //       //     label: "Ride History",
                      //       //     isLoading: false,
                      //       //     onTap: () {}),
                      //       // CustomButton(
                      //       //     borderRadius: BorderRadius.circular(15.r),
                      //       //     margin: EdgeInsets.all(10.r),
                      //       //     width: 140.w,
                      //       //     height: 35.h,
                      //       //     Color: Kpink,
                      //       //     textColor: Kwhite,
                      //       //     fontSize: 12.sp,
                      //       //     fontWeight: kFW700,
                      //       //     label: "Ride History",
                      //       //     isLoading: false,
                      //       //     onTap: () {
                      //       //       setState(() {
                      //       //         userapicontroller.selectedorderlistType.value =
                      //       //             "Ride History";
                      //       //       });
                      //       //     }),
                      //       userapicontroller.selectedorderlistType ==
                      //               "Ride History"
                      //           ?
                      //           CustomButton(
                      //               borderRadius: BorderRadius.circular(15.r),
                      //               margin: EdgeInsets.all(10.r),
                      //               width: 140.w,
                      //               height: 35.h,
                      //               Color: Kpink,
                      //               textColor: Kwhite,
                      //               fontSize: 12.sp,
                      //               fontWeight: kFW700,
                      //               label: "Ride History",
                      //               isLoading: false,
                      //               onTap: () {
                      //                 setState(() {
                      //                   userapicontroller.selectedorderlistType
                      //                       .value = "Ride History";
                      //                 });
                      //               })
                      //           :
                      //           InkWell(
                      //               onTap: () {
                      //                 setState(() {
                      //                   userapicontroller.selectedorderlistType
                      //                       .value = "Ride History";
                      //                 });
                      //               },
                      //               child: Container(
                      //                 margin: EdgeInsets.all(10.r),
                      //                 height: 35,
                      //                 width: 140.w,
                      //                 alignment: Alignment.center,
                      //                 decoration: BoxDecoration(
                      //                   color: Kwhite,
                      //                   borderRadius: BorderRadius.circular(15.r),
                      //                 ),
                      //                 child: Text(
                      //                   "Ride History",
                      //                   textAlign: TextAlign.center,
                      //                   style: GoogleFonts.roboto(
                      //                     fontSize: 12.sp,
                      //                     fontWeight: kFW700,
                      //                     color: KdarkText,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //       userapicontroller.selectedorderlistType == "Favourites"
                      //           ?
                      //           CustomButton(
                      //               borderRadius: BorderRadius.circular(15.r),
                      //               margin: EdgeInsets.all(10.r),
                      //               width: 140.w,
                      //               height: 35.h,
                      //               Color: Kpink,
                      //               textColor: Kwhite,
                      //               fontSize: 12.sp,
                      //               fontWeight: kFW700,
                      //               label: "Favourites",
                      //               isLoading: false,
                      //               onTap: () {
                      //                 setState(() {
                      //                   userapicontroller.selectedorderlistType
                      //                       .value = "Favourites";
                      //                 });
                      //               })
                      //           :
                      //           InkWell(
                      //               onTap: () {
                      //                 setState(() {
                      //                   userapicontroller.selectedorderlistType
                      //                       .value = "Favourites";
                      //                 });
                      //               },
                      //               child: Container(
                      //                 margin: EdgeInsets.all(10.r),
                      //                 height: 35,
                      //                 width: 140.w,
                      //                 alignment: Alignment.center,
                      //                 decoration: BoxDecoration(
                      //                   color: Kwhite,
                      //                   borderRadius: BorderRadius.circular(15.r),
                      //                 ),
                      //                 child: Text(
                      //                   "Favourites",
                      //                   textAlign: TextAlign.center,
                      //                   style: GoogleFonts.roboto(
                      //                     fontSize: 12.sp,
                      //                     fontWeight: kFW700,
                      //                     color: KdarkText,
                      //                   ),
                      //                 ),
                      //               ),
                      //             )
                      //     ],
                      //   ),
                      // ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Column(
                      //       children: [
                      //         ClipRRect(
                      //           borderRadius: BorderRadius.circular(20),
                      //           child: Image.asset(
                      //             "assets/images/bikeTaxi.jpg",
                      //             width: 60.w,
                      //             height: 60.h,
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           height: 10.h,
                      //         ),
                      //         Text(
                      //           "Bike",
                      //           style: GoogleFonts.roboto(
                      //               fontSize: kSixteenFont,
                      //               color: kcarden,
                      //               fontWeight: kFW500),
                      //         ),
                      //       ],
                      //     ),
                      //     Column(
                      //       children: [
                      //         ClipRRect(
                      //           borderRadius: BorderRadius.circular(20),
                      //           child: Image.asset(
                      //             "assets/images/bikeTaxi.jpg",
                      //             width: 60.w,
                      //             height: 60.h,
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           height: 10.h,
                      //         ),
                      //         Text(
                      //           "Bike Lite",
                      //           style: GoogleFonts.roboto(
                      //               fontSize: kSixteenFont,
                      //               color: kcarden,
                      //               fontWeight: kFW500),
                      //         ),
                      //       ],
                      //     ),
                      //     Column(
                      //       children: [
                      //         ClipRRect(
                      //           borderRadius: BorderRadius.circular(20),
                      //           child: Image.asset(
                      //             "assets/images/autoTaxi.jpg",
                      //             width: 60.w,
                      //             height: 60.h,
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           height: 10.h,
                      //         ),
                      //         Text(
                      //           "Auto",
                      //           style: GoogleFonts.roboto(
                      //               fontSize: kSixteenFont,
                      //               color: kcarden,
                      //               fontWeight: kFW500),
                      //         ),
                      //       ],
                      //     ),
                      //     Column(
                      //       children: [
                      //         ClipRRect(
                      //           borderRadius: BorderRadius.circular(20),
                      //           child: Image.asset(
                      //             "assets/images/autoShare.jpg",
                      //             width: 60.w,
                      //             height: 60.h,
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           height: 10.h,
                      //         ),
                      //         Text(
                      //           "Auto Share",
                      //           style: GoogleFonts.roboto(
                      //               fontSize: kSixteenFont,
                      //               color: kcarden,
                      //               fontWeight: kFW500),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      ////////////////////////////////////////////////////////////////////////////////

                      //////////////////////////////////////////////////////////////////
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      "#gowomen",
                      style: GoogleFonts.roboto(
                          color: Kpink.withOpacity(0.5),
                          fontSize: 32.sp,
                          fontWeight: kFW600),
                    ),
                  ],
                )
                // Stack(
                //   children: [
                //     Image.asset(
                //       "assets/images/wor_frame.png",

                //       // width: MediaQuery.of(context).size.width,
                //     ),
                //     Positioned(
                //         top: 80.h,
                //         right: 50.w,
                //         child: Text(
                //           "#gowomen",
                //           style: GoogleFonts.roboto(
                //               color: Kpink.withOpacity(0.5),
                //               fontSize: 32.sp,
                //               fontWeight: kFW600),
                //         ))
                //   ],
                // ),
              ],
            );
          },
        ),
      ),
    );
  }

  ///////////////////////////////////////
  Future<void> openMapplsDirectionWidget() async {
    DirectionCallback directionCallback;

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
  /////////////////////////////////////////////////////
}

class CustomFabLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = scaffoldGeometry.scaffoldSize.width -
        scaffoldGeometry.floatingActionButtonSize.width / 2 -
        16;
    final double fabY = scaffoldGeometry.scaffoldSize.height / 2 -
        scaffoldGeometry.floatingActionButtonSize.height / 2;

    return Offset(fabX, fabY);
  }
}
