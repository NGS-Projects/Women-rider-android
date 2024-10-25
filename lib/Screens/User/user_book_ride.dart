// import 'package:womentaxi/untils/export_file.dart';
// import 'package:womentaxi/untils/export_file.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sliding_sheet_new/sliding_sheet_new.dart';
import 'package:womentaxi/Screens/User/User_Controllers/user_api_controllers.dart';
import 'package:womentaxi/Screens/captain/controllers/api_controllers.dart';
import 'dart:async';
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
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';

class UserBookRide extends StatefulWidget {
  const UserBookRide({super.key});

  @override
  State<UserBookRide> createState() => _UserBookRideState();
}

class _UserBookRideState extends State<UserBookRide> {
  /////////////////////////////////////////////////////////////////////////////////////
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

  String arrivalTime = '';

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(17.470766577190037, 78.36709472827017),
    zoom: 14.4746,
  );

  /////////////////////////////////////////////////////////////
  List<Marker> _markers = [];
  UserApiController userapicontroller = Get.put(UserApiController());
  ////////////

  final LocalAuthentication auth = LocalAuthentication();

  SupportState supportState = SupportState.unknown;

  List<BiometricType>? availableBiometrics;
  // ////////////////////////////////////////////////////////clock
  // Future<TimeOfDay?> getSaturdayCloseTime({
  //   required BuildContext context,
  //   String? title,
  //   String? formattedTime,
  //   TimeOfDay? initialTime,
  //   String? cancelText,
  //   String? confirmText,
  // }) async {
  //   TimeOfDay? time = await showTimePicker(
  //     initialEntryMode: TimePickerEntryMode.dial,
  //     context: context,
  //     initialTime: initialTime ?? TimeOfDay.now(),
  //     cancelText: cancelText ?? "Cancel",
  //     confirmText: confirmText ?? "Save",
  //     helpText: title ?? "Select time",
  //     builder: (context, Widget? child) {
  //       return Theme(
  //         data: ThemeData.light().copyWith(
  //           timePickerTheme: TimePickerThemeData(
  //             backgroundColor: Kwhite, // Background color
  //             hourMinuteTextColor:
  //                 kbloodred, // Text color for hours and minutes
  //             dayPeriodTextColor: KdarkText, // Text color for AM/PM
  //             dayPeriodBorderSide:
  //                 BorderSide(color: KdarkText), // Border color for AM/PM
  //             dialHandColor: Kpink, // Color of the hour hand
  //             dialTextColor: Kwhite, // Text color on the clock dial
  //             dialBackgroundColor: Kpink.withOpacity(0.5),
  //             //dayPeriodColor: lightBlue,
  //             //hourMinuteColor: lightBlue,
  //             entryModeIconColor: Kpink,
  //             helpTextStyle: GoogleFonts.roboto(
  //               color: KText, // Set the text color for "Enter time"
  //             ),
  //             cancelButtonStyle: ButtonStyle(
  //                 backgroundColor:
  //                     MaterialStateProperty.all<Color>(Colors.brown.shade300),
  //                 foregroundColor: MaterialStateProperty.all<Color>(Kpink)),
  //             confirmButtonStyle: ButtonStyle(
  //                 backgroundColor:
  //                     MaterialStateProperty.all<Color>(Colors.brown.shade300),
  //                 foregroundColor: MaterialStateProperty.all<Color>(Kpink)),
  //             hourMinuteTextStyle: GoogleFonts.roboto(
  //                 fontSize: 30), // Text style for hours and minutes
  //           ),
  //           textTheme: TextTheme(
  //             bodySmall: GoogleFonts.roboto(color: KdarkText),
  //           ),
  //           textSelectionTheme: TextSelectionThemeData(
  //             cursorColor: Kpink,
  //             selectionColor: Kpink,
  //             selectionHandleColor: KText,
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //   formattedTime = MaterialLocalizations.of(context).formatTimeOfDay(time!);

  //   setState(() {
  //     saturdayayCloseTime = formattedTime!;
  //     userapicontroller.ridebookTime.value = saturdayayCloseTime;
  //   });
  //   return time;
  // }

  // ////////////////////////////////////////////////////
  // String saturdayayCloseTime = "";
  Future<TimeOfDay?> getSaturdayCloseTime({
    required BuildContext context,
    String? title,
    String? formattedTime,
    TimeOfDay? initialTime,
    String? cancelText,
    String? confirmText,
  }) async {
    TimeOfDay? time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      cancelText: cancelText ?? "Cancel",
      confirmText: confirmText ?? "Save",
      helpText: title ?? "Select time",
      builder: (context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Kwhite,
              hourMinuteTextColor: kbloodred,
              dayPeriodTextColor: KdarkText,
              dayPeriodBorderSide: BorderSide(color: KdarkText),
              dialHandColor: Kpink,
              dialTextColor: Kwhite,
              dialBackgroundColor: Kpink.withOpacity(0.5),
              entryModeIconColor: Kpink,
              helpTextStyle: GoogleFonts.roboto(color: KText),
              cancelButtonStyle: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.brown.shade300),
                foregroundColor: MaterialStateProperty.all<Color>(Kpink),
              ),
              confirmButtonStyle: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.brown.shade300),
                foregroundColor: MaterialStateProperty.all<Color>(Kpink),
              ),
              hourMinuteTextStyle: GoogleFonts.roboto(fontSize: 30),
            ),
            textTheme:
                TextTheme(bodySmall: GoogleFonts.roboto(color: KdarkText)),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Kpink,
              selectionColor: Kpink,
              selectionHandleColor: KText,
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      // Format time in 24-hour format
      formattedTime = time.hour.toString().padLeft(2, '0') +
          ':' +
          time.minute.toString().padLeft(2, '0');

      setState(() {
        saturdayayCloseTime = formattedTime!;
        userapicontroller.ridebookTime.value = saturdayayCloseTime;
      });
      ////////////////////////////////////////////////api
      if (apicontroller.profileData["userVerified"] == true) {
        if (apicontroller.profileData["authenticationImage"] == null) {
          Get.toNamed(kUserUploadDocs);
        } else {
          //   popup
          authenticateWithBiometrics();
          setState(() {
            userapicontroller.isopenedUserCompleteScreen.value = false;
          });
        }
      } else {
        Fluttertoast.showToast(msg: "Your Account is not verified.");
      }
      // var payload = {
      //   "time": userapicontroller.ridebookTime.value,
      // };
      // apicontroller.timeBooking(payload);
      ////////////////////////////
    }

    return time;
  }

  ///cla

  ///////////

  String saturdayayCloseTime = "";

  final List<String> bloodgroupss = [
    'Food',
    'Medicines',
    'Electronics',
    'Clothes',
    'Others'
  ];
  // List of PNG frame file paths for GIF animation
  // gif
  final List<String> _gifFrames = [
    'assets/images/frame_18_delay-0.03s.png',
    'assets/images/frame_19_delay-0.04s.png',
    'assets/images/frame_20_delay-0.03s.png',
    'assets/images/frame_21_delay-0.03s.png',
    'assets/images/frame_22_delay-0.04s.png',
    'assets/images/frame_23_delay-0.03s.png',
  ];

  Timer? _timer;
  int _frameIndex = 0;

  // Start the GIF animation by cycling through the frames
  void _startGifAnimation() {
    _timer =
        Timer.periodic(const Duration(milliseconds: 500), (Timer timer) async {
      _frameIndex = (_frameIndex + 1) % _gifFrames.length;

      final BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(35, 35)),
        _gifFrames[_frameIndex],
      );

      setState(() {
        _markers[0] =
            _markers[0].copyWith(iconParam: icon); // Update marker icon
      });
    });
  }

// Initialize the marker with the first frame
// void _initializeMarker() async {
//   final BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
//     const ImageConfiguration(size: Size(48, 48)),
//     _gifFrames[_frameIndex],
//   );

//   setState(() {
//     _markers.add(
//       Marker(
//         markerId: const MarkerId('animated_marker'),
//         position: const LatLng(17.470766577190037, 78.36709472827017),
//         icon: icon,
//       ),
//     );
//   });
// }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /////////////

  String? selectedValue;

  ////////////
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(25.321684, 82.987289),
    zoom: 10.0,
  );

  // late MapplsMapController controller;
  List<String> profile = [
    // DirectionCriteria.PROFILE_DRIVING,
    // DirectionCriteria.PROFILE_BIKING,
    // DirectionCriteria.PROFILE_WALKING,
  ];

  int selectedIndex = 0;

  // DirectionsRoute? route;
  //////////////////////////////////////////Shift Code
  // ServiceController serviceController = Get.put(ServiceController());
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();
  IO.Socket? socket;
  double lat = 37.42796133580664;
  double lon = -122.085749655962;
  String isLoading = "stopped";
  // String? _currentAddress;
  void _startLiveTracking() {
    // Call the _getliveTrackLocation function every 10 seconds
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      _getliveTrackLocation();
    });
  }

  void _getliveTrackLocation() async {
    Position? position = await _determinePosition();
    setState(() {
      serviceController.liveTrackposition = position;
      serviceController.liveTracklatittude =
          serviceController.position!.latitude;
      serviceController.liveTracklongitude =
          serviceController.position!.longitude;
      print("liveTracking");
      socket?.emit('send-coordinates', {
        "userId": apicontroller.profileData["mobile"] ?? "6281682528",
        "coordinates": {
          "lat": serviceController.liveTracklatittude,
          "lng": serviceController.liveTracklongitude
        }
      });
      print("liveTracking");
      // _getAddressFromLatLngs(position!);
    });
  }
  // void _getliveTrackLocation() async {
  //   setState(() {
  //     isLoading = "started";
  //   });
  //   Position? position =
  //       await _determinePosition(); // Your method to get the position
  //   setState(() {
  //     serviceController.liveTrackposition = position;
  //     serviceController.liveTracklatittude =
  //         serviceController.position!.latitude;
  //     serviceController.liveTracklongitude =
  //         serviceController.position!.longitude;
  //     print("liveTracking");
  //     socket?.emit('send-coordinates', {
  //       "userId": "9014548747",
  //       "coordinates": {
  //         "lat": serviceController.liveTracklatittude,
  //         "lng": serviceController.liveTracklongitude
  //       }
  //     });
  //     print("liveTracking");
  //     // _getAddressFromLatLngs(position!);
  //   });
  // }
  // var isLoading = "none";
  // void _getliveTrackLocation() async {
  //   setState(() {
  //     isLoading = "started";
  //   });
  //   Position? position = await _determinePosition();
  //   setState(() {
  //     serviceController.liveTrackposition = position;
  //     serviceController.liveTracklatittude =
  //         serviceController.position!.latitude;
  //     serviceController.liveTracklongitude =
  //         serviceController.position!.longitude;
  //     print("liveTracking");
  //     socket?.emit('send-coordinates', {
  //       "userId": "9014548747",
  //       "coordinates": {
  //         "lat": serviceController.liveTracklatittude,
  //         "lng": serviceController.liveTracklongitude
  //       }
  //     });
  //     print("liveTracking");
  //     // _getAddressFromLatLngs(position!);
  //   });
  // }
  /////////
//   {
//   userId: '9014548747',
//   coordinates: { lat: 17.5184123, lng: 78.3393763 }
// }
  /////////

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

  Future<void> _getAddressFromLatLngs(Position position) async {
    await placemarkFromCoordinates(serviceController.position!.latitude,
            serviceController.position!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        // _currentAddress =
        //     '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},${place.postalCode}';
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

//////////////////////////Socket code

  void _setupSocketConnection() {
    socket = IO.io('https://womenrapido.nuhvin.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket?.connect();

    socket?.onConnect((_) {
      _startLiveTracking();
      // _getliveTrackLocation();
      // print('connected: ${socket?.id}');
      // socket?.emit('new-user-add', apicontroller.profileData["_id"]);
    });

    // socket?.on('get-users', (data) {
    //   setState(() {
    //     // activeUsers = List<Map<String, dynamic>>.from(data);
    //   });
    //   print('Active users:');
    // });

    socket?.onDisconnect((_) {
      print('disconnected');
    });

    // socket?.on('recieve-message', (data) {
    //   // setState(() {
    //   //   apicontroller.previousChatData.add({
    //   //     'message': data['message'],
    //   //     'senderId': data['senderId'],
    //   //     // 'isMe': true,
    //   //     'chatId': data['chatId']
    //   //   });
    //   // });
    //   //   print(apicontroller.previousChatData.value);
    //   apicontroller
    //       .socketioGetpreviousChat(apicontroller.socketioData[0]["_id"]);
    //   //  apicontroller.updateMessage(data);
    //   // setState(() {
    //   //   apicontroller.previousChatData.add({
    //   //     'message': data['message'],
    //   //     'senderId': data['senderId'],
    //   //     // 'isMe': data['senderId'] == apicontroller.profileData["_id"],
    //   //   });
    //   // });
    // });

    // setState(() {
    //   apicontroller.previousChatData.add({
    //     'message': data['message'],
    //     'senderId': data['senderId'],
    //     // 'isMe': true,
    //     'chatId': data['chatId']
    //   });
    // });
    //   print(apicontroller.previousChatData.value);

    //  apicontroller.updateMessage(data);
    // setState(() {
    //   apicontroller.previousChatData.add({
    //     'message': data['message'],
    //     'senderId': data['senderId'],
    //     // 'isMe': data['senderId'] == apicontroller.profileData["_id"],
    //   });
    // });
  }

//////

////////////
  // @override
  // void dispose() {
  //   socket?.disconnect();
  //   super.dispose();
  // }

  ///Shif code////////////////////////////////shift code

  @override
  void initState() {
    super.initState();
    setState(() {
      apicontroller.selectedMensCount.value = "0";
    });
    setState(() {
      userapicontroller.ridebookTime.value = "";
    });
    userapicontroller.getActiveRidersList();
    _setupSocketConnection();
    _initializeMarkers();
    // _initializeMarker();
    _startGifAnimation();
    if (apicontroller.isVehicleselected == true) {
      setState(() {
        apicontroller.isVehicleselected.value = false;
      });
      print("ram");
    } else {
      setState(() {
        apicontroller.selectedVehicle.value = "scooty";
      });
    }

    _getAddressFromLatLng();
    _getDropAddressFromLatLng();
    //////
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initializeCoordinates();

      await initializeMap();
    });
    ///////
    // Auth
    auth.isDeviceSupported().then((bool isSupported) => setState(() =>
        supportState =
            isSupported ? SupportState.supported : SupportState.unSupported));
    checkBiometric();

    getAvailableBiometrics();
    Future.delayed(const Duration(seconds: 10), () async {
      _initializeMarkers();
    });
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////
    //  Get.toNamed(kUserBookRide);
    ////////////////////////////////////
  }

  //active ridrs
  Future<void> _initializeMarkers() async {
    final BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(35, 35)),
      _gifFrames[_frameIndex],
    );
    //  setState(() {
    //   _markers.add(
    //     Marker(
    //       markerId: const MarkerId('animated_marker'),
    //       position: const LatLng(17.470766577190037, 78.36709472827017),
    //       icon: icon,
    //     ),
    //   );
    // });
    setState(() {
      if (userapicontroller.coordinatesList.isEmpty ||
          userapicontroller.coordinatesList == null) {
      } else {
        for (int i = 0; i < userapicontroller.coordinatesList.length; i++) {
          _markers.add(
            Marker(
              markerId: const MarkerId('animated_marker'), // Unique marker ID
              position: LatLng(userapicontroller.coordinatesList[i]["latitude"],
                  userapicontroller.coordinatesList[i]["longitude"]),

              // Set marker position using LatLng
              icon: icon,
            ),
          );
        }
      }
    });
  }

  /////////////////////////////////////
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
  ///////////////////////////
  //Auths

  Future<void> checkBiometric() async {
    late bool canCheckBiometric;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;

      print("Biometric supported: $canCheckBiometric");
    } on PlatformException catch (e) {
      print(e);

      canCheckBiometric = false;
    }
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> biometricTypes;

    try {
      biometricTypes = await auth.getAvailableBiometrics();

      print("supported biometrics $biometricTypes");
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) {
      return;
    }

    setState(() {
      availableBiometrics = biometricTypes;
    });
  }

  //

  Future<void> authenticateWithBiometrics() async {
    try {
      final authenticated = await auth.authenticate(
          localizedReason: 'Authenticate with fingerprint or Face ID',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));

      if (!mounted) {
        return;
      }

      if (authenticated) {
        Get.toNamed(kUserBookRideAuth);

        // apicontroller.captainAvailability();
        // setState(() {
        //   _switchValue = value;
        //   apicontroller.duty == "ON DUTY"
        //       ? apicontroller.duty.value = "OFF DUTY"
        //       : apicontroller.duty.value = "ON DUTY";
        // });
        // Get.toNamed(KSplash);

        // Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
      }
    } on PlatformException catch (e) {
      print(e);

      return;
    }
  }

  ///////////////////////////////////////////Get Address from Lat and Longitude
  String? _currentAddress;
  Future<void> _getAddressFromLatLng() async {
    await placemarkFromCoordinates(
            apicontroller.searchedData["waypoints"][0]["location"][0],
            apicontroller.searchedData["waypoints"][0]["location"][1]
            // serviceController.position!.latitude,
            //       serviceController.position!.longitude
            )
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},${place.postalCode}';
        apicontroller.searchedDataPickupAddress.value =
            _currentAddress.toString();
        print(apicontroller.searchedDataPickupAddress.value);
        // serviceController.addressLatitude.value =
        //     serviceController.position!.latitude.toString();
        // serviceController.addressLongitude.value =
        //     serviceController.position!.longitude.toString();
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // Drop Address
  String? _dropAddress;
  Future<void> _getDropAddressFromLatLng() async {
    await placemarkFromCoordinates(
            apicontroller.searchedData["waypoints"][1]["location"][0],
            apicontroller.searchedData["waypoints"][1]["location"][1]
            // serviceController.position!.latitude,
            //       serviceController.position!.longitude
            )
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _dropAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},${place.postalCode}';
        apicontroller.searchedDataDropAddress.value = _dropAddress.toString();
        print(apicontroller.searchedDataDropAddress.value);
        // serviceController.addressLatitude.value =
        //     serviceController.position!.latitude.toString();
        // serviceController.addressLongitude.value =
        //     serviceController.position!.longitude.toString();
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////////////////////
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("dd-MM-yyyy").format(now);
    String formattedTime = DateFormat("hh:mm a").format(now);
    //////////////////////////////////////////
    return Scaffold(
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height / 6.5,
        padding: EdgeInsets.all(16.r),
        color: Kwhite,
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.money,
                  size: 18.sp,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  "Paying Via cash",
                  style: GoogleFonts.roboto(
                      fontSize: kFourteenFont,
                      color: kcarden,
                      fontWeight: kFW500),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomButton(
                // margin: EdgeInsets.only(top: 40.h),//ram
                width: double.infinity,
                height: 42.h,
                fontSize: kFourteenFont,
                fontWeight: kFW700,
                textColor: Kwhite,
                borderRadius: BorderRadius.circular(30.r),
                label: "Book Ride",
                isLoading: false,
                onTap: () {
                  setState(() {
                    userapicontroller.ridebookTime.value = "";
                    apicontroller.userRideAutenticationBody.value = {
                      "dropLangitude":
                          "${apicontroller.searchedData["waypoints"][1]["location"][0]}",
                      "dropLongitude":
                          "${apicontroller.searchedData["waypoints"][1]["location"][1]}",
                      "pickupLangitude":
                          "${apicontroller.searchedData["waypoints"][0]["location"][0]}",
                      "pickupLongitude":
                          "${apicontroller.searchedData["waypoints"][0]["location"][1]}",
                      "pickupAddress":
                          apicontroller.searchedDataPickupAddress.value,
                      "dropAddress":
                          apicontroller.searchedDataDropAddress.value,
                      "price": "250",
                      "orderPlaceTime": formattedTime,
                      "orderPlaceDate": formattedDate,
                      "vehicleType": apicontroller.selectedVehicle.value,
                      "howManyMans": apicontroller.selectedMensCount.value
                    };
                  });
                  /////////////////////
                  if (apicontroller.profileData["pan"] == null &&
                      apicontroller.profileData["adhar"] == null) {
                    Get.toNamed(kUserAnyIDScreen);
                    Fluttertoast.showToast(msg: "Please Upload any ID Proof");
                    // Get.toNamed(kUserUploadDocs);
                  } else {
                    if (apicontroller.profileData["authenticationImage"] ==
                        null) {
                      Get.toNamed(kUserUploadDocs);
                      Fluttertoast.showToast(
                          msg: "Please Upload Face Biometrics");
                    } else {
                      if (apicontroller.profileData["userVerified"] == true) {
                        authenticateWithBiometrics();
                        setState(() {
                          userapicontroller.isopenedUserCompleteScreen.value =
                              false;
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Your Account is under review and make sure that you uploaded all documents.");
                      }
                    }
                  }
                  ;
                  //////////////////////////////
                  // if (apicontroller.profileData["userVerified"] == true) {
                  //   if (apicontroller.profileData["authenticationImage"] ==
                  //       null) {
                  //     Get.toNamed(kUserUploadDocs);
                  //   } else {
                  //     //   popup
                  //     authenticateWithBiometrics();
                  //     setState(() {
                  //       userapicontroller.isopenedUserCompleteScreen.value =
                  //           false;
                  //     });
                  //   }
                  // } else {
                  //   Fluttertoast.showToast(
                  //       msg: "Your Account is not verified.");
                  // }
                  // userapicontroller.placeOrdersUser(payload);
                }),
          ],
        ),
      ),
      backgroundColor: Kwhite,
      body: SlidingSheet(
        elevation: 8,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          snap: false,
          initialSnap: 0.7,
          // snappings: [0.7, 1.0],
          snappings: [
            0.4,
            0.7,
          ],
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
                          ? Center(child: CircularProgressIndicator())
                          : Obx(() =>
                              userapicontroller.activeRidersDataLoading == true
                                  ? Center(child: CircularProgressIndicator())
                                  : Expanded(
                                      child: GoogleMap(
                                        mapType: MapType.normal,
                                        initialCameraPosition: _kGooglePlex,
                                        onMapCreated:
                                            (GoogleMapController controller) {
                                          _controller.complete(controller);
                                        },
                                        markers: Set<Marker>.of(
                                            _markers), // Display markers on the map
                                      ),
                                      //  GoogleMap(
                                      //   mapType: MapType.normal,
                                      //   initialCameraPosition: _kGooglePlex,
                                      //   onMapCreated: (GoogleMapController controller) {
                                      //     _controller.complete(controller);
                                      //   },

                                      //   //   markers: {
                                      //   //   Marker(
                                      //   //     markerId: const MarkerId('currentLocation'),
                                      //   //     icon: BitmapDescriptor.defaultMarker,
                                      //   //     position: currentPosition!,
                                      //   //   ),
                                      //   //   Marker(
                                      //   //     markerId: MarkerId('sourceLocation'),
                                      //   //     icon: BitmapDescriptor.defaultMarker,
                                      //   //     position: googlePlex!,
                                      //   //   ),
                                      //   //   Marker(
                                      //   //     markerId: MarkerId('destinationLocation'),
                                      //   //     icon: BitmapDescriptor.defaultMarker,
                                      //   //     position: mountainView!,
                                      //   //   ),
                                      //   // },
                                      //   polylines: Set<Polyline>.of(polylines.values),
                                      // ),
                                    )),
                ),
              )
            ],
          ),
        ),
        builder: (context, state) {
          return Container(
              // margin: EdgeInsets.all(15.r),
              // color: kblack,
              color: kPinkBackGroundColur.withOpacity(0.1),
              height: MediaQuery.of(context).size.height / 1.5,
              child: Obx(
                () => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5.h),
                          height: 4.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kLinegrey),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(15.r),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: double.infinity,
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
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.4,
                                  child: Column(
                                    children: [
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
                                          SizedBox(
                                            width: 180.w,
                                            // width: MediaQuery.of(context)
                                            //         .size
                                            //         .width /
                                            //     1.6,
                                            child: Text(
                                              apicontroller
                                                  .searchedDataPickupAddress
                                                  .value,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                  fontSize: kFourteenFont,
                                                  color: kcarden,
                                                  fontWeight: kFW500),
                                              // GoogleFonts.roboto(
                                              //     fontSize: kFourteenFont,
                                              //     color: KdarkText,
                                              //     fontWeight: kFW500),
                                            ),
                                          )
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
                                        children: [
                                          Image.asset(
                                            "assets/images/pink_corner_arrow.png",
                                            height: 16.h,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            width: 16.w,
                                          ),
                                          SizedBox(
                                            width: 180.w,
                                            child: Text(
                                              //                "pickupAddress":
                                              //     apicontroller.searchedDataPickupAddress.value,
                                              // "dropAddress":
                                              apicontroller
                                                  .searchedDataDropAddress
                                                  .value,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                  fontSize: kFourteenFont,
                                                  color: kcarden,
                                                  fontWeight: kFW500),
                                              //  GoogleFonts.roboto(
                                              //     fontSize: kFourteenFont,
                                              //     color: KdarkText,
                                              //     fontWeight: kFW500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                InkWell(
                                    onTap: () async {
                                      setState(() {
                                        userapicontroller.ridebookTime.value =
                                            "";
                                        apicontroller
                                            .userRideAutenticationBody.value = {
                                          "dropLangitude":
                                              "${apicontroller.searchedData["waypoints"][1]["location"][0]}",
                                          "dropLongitude":
                                              "${apicontroller.searchedData["waypoints"][1]["location"][1]}",
                                          "pickupLangitude":
                                              "${apicontroller.searchedData["waypoints"][0]["location"][0]}",
                                          "pickupLongitude":
                                              "${apicontroller.searchedData["waypoints"][0]["location"][1]}",
                                          "pickupAddress": apicontroller
                                              .searchedDataPickupAddress.value,
                                          "dropAddress": apicontroller
                                              .searchedDataDropAddress.value,
                                          "price": "250",
                                          "orderPlaceTime": formattedTime,
                                          "orderPlaceDate": formattedDate,
                                          "time": userapicontroller
                                              .ridebookTime.value,
                                          "vehicleType": apicontroller
                                              .selectedVehicle.value,
                                          "howManyMans": apicontroller
                                              .selectedMensCount.value
                                        };
                                      });
                                      TimeOfDay? time =
                                          await getSaturdayCloseTime(
                                        context: context,
                                        title: "Select Your Time",
                                      );
                                    },
                                    child: Icon(Icons.alarm))
                              ],
                            ),
                          ),
                          SizedBox(
                            // height: 200,
                            height: MediaQuery.of(context).size.height / 2.8,
                            child: ListView(
                              shrinkWrap: true,
                              physics: AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.all(8.0),
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      apicontroller.selectedVehicle.value =
                                          "scooty";
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 12.h),
                                    width: double.infinity,
                                    // padding: EdgeInsets.all(10.r),
                                    padding: EdgeInsets.only(
                                        left: 10.w,
                                        top: 5.h,
                                        bottom: 5.h,
                                        right: 10.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              apicontroller.selectedVehicle ==
                                                      "scooty"
                                                  ? Kpink
                                                  : Kwhite),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                "assets/images/scooty.png",
                                                width: 45.w,
                                                height: 45.h,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 100.w,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Scooty",
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        kTwelveFont,
                                                                    color:
                                                                        Kpink,
                                                                    fontWeight:
                                                                        kFW500),
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Image.asset(
                                                            "assets/images/pink_profile.png",
                                                            height: 12.h,
                                                          ),
                                                          SizedBox(
                                                            width: 2.w,
                                                          ),
                                                          Text(
                                                            "1",
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        kTwelveFont,
                                                                    color:
                                                                        Kpink,
                                                                    fontWeight:
                                                                        kFW500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15.w,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Kpink,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r)),
                                                      padding: EdgeInsets.only(
                                                          left: 6.w,
                                                          right: 6.w,
                                                          top: 2.h,
                                                          bottom: 2.h),
                                                      child: Text(
                                                        "Fastest",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize:
                                                                    kTwelveFont,
                                                                color: Kwhite,
                                                                fontWeight:
                                                                    kFW400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                  "Beat the traffic & pay less",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: kTenFont,
                                                      color: kcarden,
                                                      fontWeight: kFW500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "₹ 49",
                                          style: GoogleFonts.roboto(
                                              fontSize: kSixteenFont,
                                              color: kcarden,
                                              fontWeight: kFW500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // InkWell(
                                //   // 2
                                //   onTap: () {
                                //     setState(() {
                                //       apicontroller.selectedVehicle.value = "cab";
                                //     });
                                //   },
                                //   child: Container(
                                //     margin: EdgeInsets.only(top: 12.h),
                                //     width: double.infinity,
                                //     padding: EdgeInsets.all(10.r),
                                //     decoration: BoxDecoration(
                                //       border: Border.all(
                                //           color: apicontroller.selectedVehicle == "cab"
                                //               ? Kpink
                                //               : Kwhite),
                                //       boxShadow: [
                                //         BoxShadow(
                                //           color: Ktextcolor.withOpacity(0.5),
                                //           blurRadius: 5.r,
                                //           offset: Offset(1, 1),
                                //           spreadRadius: 1.r,
                                //         )
                                //       ],
                                //       color: Kwhite,
                                //       borderRadius: BorderRadius.circular(10.r),
                                //     ),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Row(
                                //           children: [
                                //             ClipRRect(
                                //               borderRadius: BorderRadius.circular(20),
                                //               child: Image.asset(
                                //                 "assets/images/cabed.png",
                                //                 width: 60.w,
                                //                 height: 45.h,
                                //               ),
                                //             ),
                                //             SizedBox(
                                //               width: 5.w,
                                //             ),
                                //             Text(
                                //               "Cab",
                                //               style: GoogleFonts.roboto(
                                //                   fontSize: kSixteenFont,
                                //                   color: kcarden,
                                //                   fontWeight: kFW500),
                                //             ),
                                //           ],
                                //         ),
                                //         Text(
                                //           "₹ 49",
                                //           style: GoogleFonts.roboto(
                                //               fontSize: kSixteenFont,
                                //               color: kcarden,
                                //               fontWeight: kFW500),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                ///////////////////
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      apicontroller.selectedVehicle.value =
                                          "cab";
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 12.h),
                                    width: double.infinity,
                                    // padding: EdgeInsets.all(10.r),
                                    padding: EdgeInsets.only(
                                        left: 10.w,
                                        top: 5.h,
                                        bottom: 5.h,
                                        right: 10.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              apicontroller.selectedVehicle ==
                                                      "cab"
                                                  ? Kpink
                                                  : Kwhite),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                "assets/images/cabed.png",
                                                width: 45.w,
                                                height: 45.h,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 100.w,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Cab",
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        kTwelveFont,
                                                                    color:
                                                                        Kpink,
                                                                    fontWeight:
                                                                        kFW500),
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Image.asset(
                                                            "assets/images/pink_profile.png",
                                                            height: 12.h,
                                                          ),
                                                          SizedBox(
                                                            width: 2.w,
                                                          ),
                                                          Text(
                                                            "1",
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        kTwelveFont,
                                                                    color:
                                                                        Kpink,
                                                                    fontWeight:
                                                                        kFW500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15.w,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Kpink,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r)),
                                                      padding: EdgeInsets.only(
                                                          left: 6.w,
                                                          right: 6.w,
                                                          top: 2.h,
                                                          bottom: 2.h),
                                                      child: Text(
                                                        "Fastest",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize:
                                                                    kTwelveFont,
                                                                color: Kwhite,
                                                                fontWeight:
                                                                    kFW400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                  "Beat the traffic & pay less",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: kTenFont,
                                                      color: kcarden,
                                                      fontWeight: kFW500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "₹ 49",
                                          style: GoogleFonts.roboto(
                                              fontSize: kSixteenFont,
                                              color: kcarden,
                                              fontWeight: kFW500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                apicontroller.selectedVehicle == "cab"
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            top: 8.h,
                                            left: 16.w,
                                            right: 16.w,
                                            bottom: 8.h),
                                        width: double.infinity,
                                        padding: EdgeInsets.all(8.r),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: apicontroller
                                                          .selectedVehicle ==
                                                      "cab"
                                                  ? Kpink
                                                  : Kwhite),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Ktextcolor.withOpacity(0.5),
                                              blurRadius: 5.r,
                                              offset: Offset(1, 1),
                                              spreadRadius: 1.r,
                                            )
                                          ],
                                          color: Kwhite,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Select Male Passengers Count",
                                              style: GoogleFonts.roboto(
                                                  fontSize: kTwelveFont,
                                                  color: Kpink,
                                                  fontWeight: kFW500),
                                            ),
                                            SizedBox(height: 10.h),
                                            Obx(() => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          apicontroller
                                                              .selectedMensCount
                                                              .value = "0";
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: apicontroller
                                                                    .selectedMensCount
                                                                    .value ==
                                                                "0"
                                                            ? Kpink.withOpacity(
                                                                0.5)
                                                            : KText,
                                                        child: Text(
                                                          "0",
                                                          style: GoogleFonts.roboto(
                                                              fontSize:
                                                                  kFourteenFont,
                                                              color: apicontroller
                                                                          .selectedMensCount
                                                                          .value ==
                                                                      "0"
                                                                  ? Kwhite
                                                                  : Klightgreen,
                                                              fontWeight:
                                                                  kFW500),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          apicontroller
                                                              .selectedMensCount
                                                              .value = "1";
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: apicontroller
                                                                    .selectedMensCount
                                                                    .value ==
                                                                "1"
                                                            ? Kpink.withOpacity(
                                                                0.5)
                                                            : KText,
                                                        child: Text(
                                                          "1",
                                                          style: GoogleFonts.roboto(
                                                              fontSize:
                                                                  kFourteenFont,
                                                              color: apicontroller
                                                                          .selectedMensCount
                                                                          .value ==
                                                                      "1"
                                                                  ? Kwhite
                                                                  : Klightgreen,
                                                              fontWeight:
                                                                  kFW500),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          apicontroller
                                                              .selectedMensCount
                                                              .value = "2";
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: apicontroller
                                                                    .selectedMensCount
                                                                    .value ==
                                                                "2"
                                                            ? Kpink.withOpacity(
                                                                0.5)
                                                            : KText,
                                                        child: Text(
                                                          "2",
                                                          style: GoogleFonts.roboto(
                                                              fontSize:
                                                                  kFourteenFont,
                                                              color: apicontroller
                                                                          .selectedMensCount
                                                                          .value ==
                                                                      "2"
                                                                  ? Kwhite
                                                                  : Klightgreen,
                                                              fontWeight:
                                                                  kFW500),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          apicontroller
                                                              .selectedMensCount
                                                              .value = "3";
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: apicontroller
                                                                    .selectedMensCount
                                                                    .value ==
                                                                "3"
                                                            ? Kpink.withOpacity(
                                                                0.5)
                                                            : KText,
                                                        child: Text(
                                                          "3",
                                                          style: GoogleFonts.roboto(
                                                              fontSize:
                                                                  kFourteenFont,
                                                              color: apicontroller
                                                                          .selectedMensCount
                                                                          .value ==
                                                                      "3"
                                                                  ? Kwhite
                                                                  : Klightgreen,
                                                              fontWeight:
                                                                  kFW500),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      )
                                    : SizedBox(),
                                ///////////////////
                                // InkWell(
                                //   // 3
                                //   onTap: () {
                                //     setState(() {
                                //       apicontroller.selectedVehicle.value = "auto";
                                //     });
                                //   },
                                //   child: Container(
                                //     margin: EdgeInsets.only(top: 12.h),
                                //     width: double.infinity,
                                //     padding: EdgeInsets.all(10.r),
                                //     decoration: BoxDecoration(
                                //       border: Border.all(
                                //           color: apicontroller.selectedVehicle == "auto"
                                //               ? Kpink
                                //               : Kwhite),
                                //       boxShadow: [
                                //         BoxShadow(
                                //           color: Ktextcolor.withOpacity(0.5),
                                //           blurRadius: 5.r,
                                //           offset: Offset(1, 1),
                                //           spreadRadius: 1.r,
                                //         )
                                //       ],
                                //       color: Kwhite,
                                //       borderRadius: BorderRadius.circular(10.r),
                                //     ),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Row(
                                //           children: [
                                //             ClipRRect(
                                //               borderRadius: BorderRadius.circular(20),
                                //               child: Image.asset(
                                //                 "assets/images/autoed.png",
                                //                 width: 60.w,
                                //                 height: 45.h,
                                //               ),
                                //             ),
                                //             SizedBox(
                                //               width: 5.w,
                                //             ),
                                //             Text(
                                //               "Auto",
                                //               style: GoogleFonts.roboto(
                                //                   fontSize: kSixteenFont,
                                //                   color: kcarden,
                                //                   fontWeight: kFW500),
                                //             ),
                                //           ],
                                //         ),
                                //         Text(
                                //           "₹ 49",
                                //           style: GoogleFonts.roboto(
                                //               fontSize: kSixteenFont,
                                //               color: kcarden,
                                //               fontWeight: kFW500),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                //////////////////////////////////////////////////////////
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      apicontroller.selectedVehicle.value =
                                          "auto";
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 12.h),
                                    width: double.infinity,
                                    // padding: EdgeInsets.all(10.r),
                                    padding: EdgeInsets.only(
                                        left: 10.w,
                                        top: 5.h,
                                        bottom: 5.h,
                                        right: 10.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              apicontroller.selectedVehicle ==
                                                      "auto"
                                                  ? Kpink
                                                  : Kwhite),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                "assets/images/autoed.png",
                                                width: 45.w,
                                                height: 45.h,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 100.w,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Auto",
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        kTwelveFont,
                                                                    color:
                                                                        Kpink,
                                                                    fontWeight:
                                                                        kFW500),
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Image.asset(
                                                            "assets/images/pink_profile.png",
                                                            height: 12.h,
                                                          ),
                                                          SizedBox(
                                                            width: 2.w,
                                                          ),
                                                          Text(
                                                            "1",
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        kTwelveFont,
                                                                    color:
                                                                        Kpink,
                                                                    fontWeight:
                                                                        kFW500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15.w,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Kpink,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r)),
                                                      padding: EdgeInsets.only(
                                                          left: 6.w,
                                                          right: 6.w,
                                                          top: 2.h,
                                                          bottom: 2.h),
                                                      child: Text(
                                                        "Fastest",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize:
                                                                    kTwelveFont,
                                                                color: Kwhite,
                                                                fontWeight:
                                                                    kFW400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                  "Beat the traffic & pay less",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: kTenFont,
                                                      color: kcarden,
                                                      fontWeight: kFW500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "₹ 49",
                                          style: GoogleFonts.roboto(
                                              fontSize: kSixteenFont,
                                              color: kcarden,
                                              fontWeight: kFW500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                apicontroller.selectedVehicle == "auto"
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            top: 8.h,
                                            left: 16.w,
                                            right: 16.w,
                                            bottom: 8.h),
                                        width: double.infinity,
                                        padding: EdgeInsets.all(8.r),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: apicontroller
                                                          .selectedVehicle ==
                                                      "auto"
                                                  ? Kpink
                                                  : Kwhite),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Ktextcolor.withOpacity(0.5),
                                              blurRadius: 5.r,
                                              offset: Offset(1, 1),
                                              spreadRadius: 1.r,
                                            )
                                          ],
                                          color: Kwhite,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Select Male Passengers Count",
                                              style: GoogleFonts.roboto(
                                                  fontSize: kTwelveFont,
                                                  color: Kpink,
                                                  fontWeight: kFW500),
                                            ),
                                            SizedBox(height: 10.h),
                                            Obx(() => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          apicontroller
                                                              .selectedMensCount
                                                              .value = "0";
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: apicontroller
                                                                    .selectedMensCount
                                                                    .value ==
                                                                "0"
                                                            ? Kpink.withOpacity(
                                                                0.5)
                                                            : KText,
                                                        child: Text(
                                                          "0",
                                                          style: GoogleFonts.roboto(
                                                              fontSize:
                                                                  kFourteenFont,
                                                              color: apicontroller
                                                                          .selectedMensCount
                                                                          .value ==
                                                                      "0"
                                                                  ? Kwhite
                                                                  : Klightgreen,
                                                              fontWeight:
                                                                  kFW500),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          apicontroller
                                                              .selectedMensCount
                                                              .value = "1";
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: apicontroller
                                                                    .selectedMensCount
                                                                    .value ==
                                                                "1"
                                                            ? Kpink.withOpacity(
                                                                0.5)
                                                            : KText,
                                                        child: Text(
                                                          "1",
                                                          style: GoogleFonts.roboto(
                                                              fontSize:
                                                                  kFourteenFont,
                                                              color: apicontroller
                                                                          .selectedMensCount
                                                                          .value ==
                                                                      "1"
                                                                  ? Kwhite
                                                                  : Klightgreen,
                                                              fontWeight:
                                                                  kFW500),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          apicontroller
                                                              .selectedMensCount
                                                              .value = "2";
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: apicontroller
                                                                    .selectedMensCount
                                                                    .value ==
                                                                "2"
                                                            ? Kpink.withOpacity(
                                                                0.5)
                                                            : KText,
                                                        child: Text(
                                                          "2",
                                                          style: GoogleFonts.roboto(
                                                              fontSize:
                                                                  kFourteenFont,
                                                              color: apicontroller
                                                                          .selectedMensCount
                                                                          .value ==
                                                                      "2"
                                                                  ? Kwhite
                                                                  : Klightgreen,
                                                              fontWeight:
                                                                  kFW500),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          apicontroller
                                                              .selectedMensCount
                                                              .value = "3";
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: apicontroller
                                                                    .selectedMensCount
                                                                    .value ==
                                                                "3"
                                                            ? Kpink.withOpacity(
                                                                0.5)
                                                            : KText,
                                                        child: Text(
                                                          "3",
                                                          style: GoogleFonts.roboto(
                                                              fontSize:
                                                                  kFourteenFont,
                                                              color: apicontroller
                                                                          .selectedMensCount
                                                                          .value ==
                                                                      "3"
                                                                  ? Kwhite
                                                                  : Klightgreen,
                                                              fontWeight:
                                                                  kFW500),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      )
                                    : SizedBox(),
                                ////////////////////////////////////////
                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                //       apicontroller.selectedVehicle.value = "parcel";
                                //       Get.toNamed(kUserSendParcel);
                                //     });
                                //   },
                                //   child: Container(
                                //     margin: EdgeInsets.only(top: 12.h),
                                //     width: double.infinity,
                                //     padding: EdgeInsets.all(10.r),
                                //     decoration: BoxDecoration(
                                //       border: Border.all(
                                //           color: apicontroller.selectedVehicle == "parcel"
                                //               ? Kpink
                                //               : Kwhite),
                                //       boxShadow: [
                                //         BoxShadow(
                                //           color: Ktextcolor.withOpacity(0.5),
                                //           blurRadius: 5.r,
                                //           offset: Offset(1, 1),
                                //           spreadRadius: 1.r,
                                //         )
                                //       ],
                                //       color: Kwhite,
                                //       borderRadius: BorderRadius.circular(10.r),
                                //     ),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Row(
                                //           children: [
                                //             ClipRRect(
                                //               borderRadius: BorderRadius.circular(20),
                                //               child: Image.asset(
                                //                 "assets/images/parcelbike.png",
                                //                 width: 70.w,
                                //                 height: 45.h,
                                //               ),
                                //             ),
                                //             SizedBox(
                                //               width: 2.w,
                                //             ),
                                //             Text(
                                //               "Parcel",
                                //               style: GoogleFonts.roboto(
                                //                   fontSize: kSixteenFont,
                                //                   color: kcarden,
                                //                   fontWeight: kFW500),
                                //             ),
                                //           ],
                                //         ),
                                //         Text(
                                //           "₹ 49",
                                //           style: GoogleFonts.roboto(
                                //               fontSize: kSixteenFont,
                                //               color: kcarden,
                                //               fontWeight: kFW500),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),

                                ///////////////////////////////////////////////////////////////////////////////////////////////
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      apicontroller.selectedVehicle.value =
                                          "parcel";
                                      Get.toNamed(kUserSendParcel);
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 12.h),
                                    width: double.infinity,
                                    // padding: EdgeInsets.all(10.r),
                                    padding: EdgeInsets.only(
                                        left: 10.w,
                                        top: 5.h,
                                        bottom: 5.h,
                                        right: 10.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              apicontroller.selectedVehicle ==
                                                      "parcel"
                                                  ? Kpink
                                                  : Kwhite),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                "assets/images/parcelbike.png",
                                                width: 45.w,
                                                height: 45.h,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 100.w,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Parcel",
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        kTwelveFont,
                                                                    color:
                                                                        Kpink,
                                                                    fontWeight:
                                                                        kFW500),
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Image.asset(
                                                            "assets/images/pink_profile.png",
                                                            height: 12.h,
                                                          ),
                                                          SizedBox(
                                                            width: 2.w,
                                                          ),
                                                          Text(
                                                            "1",
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        kTwelveFont,
                                                                    color:
                                                                        Kpink,
                                                                    fontWeight:
                                                                        kFW500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15.w,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Kpink,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r)),
                                                      padding: EdgeInsets.only(
                                                          left: 6.w,
                                                          right: 6.w,
                                                          top: 2.h,
                                                          bottom: 2.h),
                                                      child: Text(
                                                        "Fastest",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize:
                                                                    kTwelveFont,
                                                                color: Kwhite,
                                                                fontWeight:
                                                                    kFW400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                  "Beat the traffic & pay less",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: kTenFont,
                                                      color: kcarden,
                                                      fontWeight: kFW500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "₹ 49",
                                          style: GoogleFonts.roboto(
                                              fontSize: kSixteenFont,
                                              color: kcarden,
                                              fontWeight: kFW500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       vertical: 8, horizontal: 5.w),
                          //   child:
                          //   Column(
                          //     children: [
                          //       InkWell(
                          //         onTap: () {
                          //           setState(() {
                          //             apicontroller.selectedVehicle.value =
                          //                 "scooty";
                          //           });
                          //         },
                          //         child: Container(
                          //           margin: EdgeInsets.only(top: 12.h),
                          //           width: double.infinity,
                          //           // padding: EdgeInsets.all(10.r),
                          //           padding: EdgeInsets.only(
                          //               left: 10.w,
                          //               top: 5.h,
                          //               bottom: 5.h,
                          //               right: 10.w),
                          //           decoration: BoxDecoration(
                          //             border: Border.all(
                          //                 color:
                          //                     apicontroller.selectedVehicle ==
                          //                             "scooty"
                          //                         ? Kpink
                          //                         : Kwhite),
                          //             boxShadow: [
                          //               BoxShadow(
                          //                 color: Ktextcolor.withOpacity(0.5),
                          //                 blurRadius: 5.r,
                          //                 offset: Offset(1, 1),
                          //                 spreadRadius: 1.r,
                          //               )
                          //             ],
                          //             color: Kwhite,
                          //             borderRadius: BorderRadius.circular(10.r),
                          //           ),
                          //           child: Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               Row(
                          //                 children: [
                          //                   ClipRRect(
                          //                     borderRadius:
                          //                         BorderRadius.circular(20),
                          //                     child: Image.asset(
                          //                       "assets/images/scooty.png",
                          //                       width: 45.w,
                          //                       height: 45.h,
                          //                     ),
                          //                   ),
                          //                   SizedBox(
                          //                     width: 10.w,
                          //                   ),
                          //                   Column(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Row(
                          //                         children: [
                          //                           SizedBox(
                          //                             width: 100.w,
                          //                             child: Row(
                          //                               children: [
                          //                                 Text(
                          //                                   "Scooty",
                          //                                   style: GoogleFonts
                          //                                       .roboto(
                          //                                           fontSize:
                          //                                               kTwelveFont,
                          //                                           color:
                          //                                               Kpink,
                          //                                           fontWeight:
                          //                                               kFW500),
                          //                                 ),
                          //                                 SizedBox(
                          //                                   width: 15,
                          //                                 ),
                          //                                 Image.asset(
                          //                                   "assets/images/pink_profile.png",
                          //                                   height: 12.h,
                          //                                 ),
                          //                                 SizedBox(
                          //                                   width: 2.w,
                          //                                 ),
                          //                                 Text(
                          //                                   "1",
                          //                                   style: GoogleFonts
                          //                                       .roboto(
                          //                                           fontSize:
                          //                                               kTwelveFont,
                          //                                           color:
                          //                                               Kpink,
                          //                                           fontWeight:
                          //                                               kFW500),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           ),
                          //                           SizedBox(
                          //                             width: 15.w,
                          //                           ),
                          //                           Container(
                          //                             decoration: BoxDecoration(
                          //                                 color: Kpink,
                          //                                 borderRadius:
                          //                                     BorderRadius
                          //                                         .circular(
                          //                                             15.r)),
                          //                             padding: EdgeInsets.only(
                          //                                 left: 6.w,
                          //                                 right: 6.w,
                          //                                 top: 2.h,
                          //                                 bottom: 2.h),
                          //                             child: Text(
                          //                               "Fastest",
                          //                               style:
                          //                                   GoogleFonts.roboto(
                          //                                       fontSize:
                          //                                           kTwelveFont,
                          //                                       color: Kwhite,
                          //                                       fontWeight:
                          //                                           kFW400),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                       SizedBox(
                          //                         height: 5.h,
                          //                       ),
                          //                       Text(
                          //                         "Beat the traffic & pay less",
                          //                         style: GoogleFonts.roboto(
                          //                             fontSize: kTenFont,
                          //                             color: kcarden,
                          //                             fontWeight: kFW500),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ],
                          //               ),
                          //               Text(
                          //                 "₹ 49",
                          //                 style: GoogleFonts.roboto(
                          //                     fontSize: kSixteenFont,
                          //                     color: kcarden,
                          //                     fontWeight: kFW500),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //       // InkWell(
                          //       //   // 2
                          //       //   onTap: () {
                          //       //     setState(() {
                          //       //       apicontroller.selectedVehicle.value = "cab";
                          //       //     });
                          //       //   },
                          //       //   child: Container(
                          //       //     margin: EdgeInsets.only(top: 12.h),
                          //       //     width: double.infinity,
                          //       //     padding: EdgeInsets.all(10.r),
                          //       //     decoration: BoxDecoration(
                          //       //       border: Border.all(
                          //       //           color: apicontroller.selectedVehicle == "cab"
                          //       //               ? Kpink
                          //       //               : Kwhite),
                          //       //       boxShadow: [
                          //       //         BoxShadow(
                          //       //           color: Ktextcolor.withOpacity(0.5),
                          //       //           blurRadius: 5.r,
                          //       //           offset: Offset(1, 1),
                          //       //           spreadRadius: 1.r,
                          //       //         )
                          //       //       ],
                          //       //       color: Kwhite,
                          //       //       borderRadius: BorderRadius.circular(10.r),
                          //       //     ),
                          //       //     child: Row(
                          //       //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       //       children: [
                          //       //         Row(
                          //       //           children: [
                          //       //             ClipRRect(
                          //       //               borderRadius: BorderRadius.circular(20),
                          //       //               child: Image.asset(
                          //       //                 "assets/images/cabed.png",
                          //       //                 width: 60.w,
                          //       //                 height: 45.h,
                          //       //               ),
                          //       //             ),
                          //       //             SizedBox(
                          //       //               width: 5.w,
                          //       //             ),
                          //       //             Text(
                          //       //               "Cab",
                          //       //               style: GoogleFonts.roboto(
                          //       //                   fontSize: kSixteenFont,
                          //       //                   color: kcarden,
                          //       //                   fontWeight: kFW500),
                          //       //             ),
                          //       //           ],
                          //       //         ),
                          //       //         Text(
                          //       //           "₹ 49",
                          //       //           style: GoogleFonts.roboto(
                          //       //               fontSize: kSixteenFont,
                          //       //               color: kcarden,
                          //       //               fontWeight: kFW500),
                          //       //         ),
                          //       //       ],
                          //       //     ),
                          //       //   ),
                          //       // ),
                          //       ///////////////////
                          //       InkWell(
                          //         onTap: () {
                          //           setState(() {
                          //             apicontroller.selectedVehicle.value =
                          //                 "cab";
                          //           });
                          //         },
                          //         child: Container(
                          //           margin: EdgeInsets.only(top: 12.h),
                          //           width: double.infinity,
                          //           // padding: EdgeInsets.all(10.r),
                          //           padding: EdgeInsets.only(
                          //               left: 10.w,
                          //               top: 5.h,
                          //               bottom: 5.h,
                          //               right: 10.w),
                          //           decoration: BoxDecoration(
                          //             border: Border.all(
                          //                 color:
                          //                     apicontroller.selectedVehicle ==
                          //                             "cab"
                          //                         ? Kpink
                          //                         : Kwhite),
                          //             boxShadow: [
                          //               BoxShadow(
                          //                 color: Ktextcolor.withOpacity(0.5),
                          //                 blurRadius: 5.r,
                          //                 offset: Offset(1, 1),
                          //                 spreadRadius: 1.r,
                          //               )
                          //             ],
                          //             color: Kwhite,
                          //             borderRadius: BorderRadius.circular(10.r),
                          //           ),
                          //           child: Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               Row(
                          //                 children: [
                          //                   ClipRRect(
                          //                     borderRadius:
                          //                         BorderRadius.circular(20),
                          //                     child: Image.asset(
                          //                       "assets/images/cabed.png",
                          //                       width: 45.w,
                          //                       height: 45.h,
                          //                     ),
                          //                   ),
                          //                   SizedBox(
                          //                     width: 10.w,
                          //                   ),
                          //                   Column(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Row(
                          //                         children: [
                          //                           SizedBox(
                          //                             width: 100.w,
                          //                             child: Row(
                          //                               children: [
                          //                                 Text(
                          //                                   "Cab",
                          //                                   style: GoogleFonts
                          //                                       .roboto(
                          //                                           fontSize:
                          //                                               kTwelveFont,
                          //                                           color:
                          //                                               Kpink,
                          //                                           fontWeight:
                          //                                               kFW500),
                          //                                 ),
                          //                                 SizedBox(
                          //                                   width: 15,
                          //                                 ),
                          //                                 Image.asset(
                          //                                   "assets/images/pink_profile.png",
                          //                                   height: 12.h,
                          //                                 ),
                          //                                 SizedBox(
                          //                                   width: 2.w,
                          //                                 ),
                          //                                 Text(
                          //                                   "1",
                          //                                   style: GoogleFonts
                          //                                       .roboto(
                          //                                           fontSize:
                          //                                               kTwelveFont,
                          //                                           color:
                          //                                               Kpink,
                          //                                           fontWeight:
                          //                                               kFW500),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           ),
                          //                           SizedBox(
                          //                             width: 15.w,
                          //                           ),
                          //                           Container(
                          //                             decoration: BoxDecoration(
                          //                                 color: Kpink,
                          //                                 borderRadius:
                          //                                     BorderRadius
                          //                                         .circular(
                          //                                             15.r)),
                          //                             padding: EdgeInsets.only(
                          //                                 left: 6.w,
                          //                                 right: 6.w,
                          //                                 top: 2.h,
                          //                                 bottom: 2.h),
                          //                             child: Text(
                          //                               "Fastest",
                          //                               style:
                          //                                   GoogleFonts.roboto(
                          //                                       fontSize:
                          //                                           kTwelveFont,
                          //                                       color: Kwhite,
                          //                                       fontWeight:
                          //                                           kFW400),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                       SizedBox(
                          //                         height: 5.h,
                          //                       ),
                          //                       Text(
                          //                         "Beat the traffic & pay less",
                          //                         style: GoogleFonts.roboto(
                          //                             fontSize: kTenFont,
                          //                             color: kcarden,
                          //                             fontWeight: kFW500),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ],
                          //               ),
                          //               Text(
                          //                 "₹ 49",
                          //                 style: GoogleFonts.roboto(
                          //                     fontSize: kSixteenFont,
                          //                     color: kcarden,
                          //                     fontWeight: kFW500),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //       apicontroller.selectedVehicle == "cab"
                          //           ? Container(
                          //               margin: EdgeInsets.only(
                          //                   top: 8.h,
                          //                   left: 16.w,
                          //                   right: 16.w,
                          //                   bottom: 8.h),
                          //               width: double.infinity,
                          //               padding: EdgeInsets.all(8.r),
                          //               decoration: BoxDecoration(
                          //                 border: Border.all(
                          //                     color: apicontroller
                          //                                 .selectedVehicle ==
                          //                             "cab"
                          //                         ? Kpink
                          //                         : Kwhite),
                          //                 boxShadow: [
                          //                   BoxShadow(
                          //                     color:
                          //                         Ktextcolor.withOpacity(0.5),
                          //                     blurRadius: 5.r,
                          //                     offset: Offset(1, 1),
                          //                     spreadRadius: 1.r,
                          //                   )
                          //                 ],
                          //                 color: Kwhite,
                          //                 borderRadius:
                          //                     BorderRadius.circular(10.r),
                          //               ),
                          //               child: Column(
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.start,
                          //                 children: [
                          //                   Text(
                          //                     "Select Male Passengers Count",
                          //                     style: GoogleFonts.roboto(
                          //                         fontSize: kTwelveFont,
                          //                         color: Kpink,
                          //                         fontWeight: kFW500),
                          //                   ),
                          //                   SizedBox(height: 10.h),
                          //                   Obx(() => Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment
                          //                                 .spaceAround,
                          //                         children: [
                          //                           InkWell(
                          //                             onTap: () {
                          //                               setState(() {
                          //                                 apicontroller
                          //                                     .selectedMensCount
                          //                                     .value = "0";
                          //                               });
                          //                             },
                          //                             child: CircleAvatar(
                          //                               backgroundColor: apicontroller
                          //                                           .selectedMensCount
                          //                                           .value ==
                          //                                       "0"
                          //                                   ? Kpink.withOpacity(
                          //                                       0.5)
                          //                                   : KText,
                          //                               child: Text(
                          //                                 "0",
                          //                                 style: GoogleFonts.roboto(
                          //                                     fontSize:
                          //                                         kFourteenFont,
                          //                                     color: apicontroller
                          //                                                 .selectedMensCount
                          //                                                 .value ==
                          //                                             "0"
                          //                                         ? Kwhite
                          //                                         : Klightgreen,
                          //                                     fontWeight:
                          //                                         kFW500),
                          //                               ),
                          //                             ),
                          //                           ),
                          //                           InkWell(
                          //                             onTap: () {
                          //                               setState(() {
                          //                                 apicontroller
                          //                                     .selectedMensCount
                          //                                     .value = "1";
                          //                               });
                          //                             },
                          //                             child: CircleAvatar(
                          //                               backgroundColor: apicontroller
                          //                                           .selectedMensCount
                          //                                           .value ==
                          //                                       "1"
                          //                                   ? Kpink.withOpacity(
                          //                                       0.5)
                          //                                   : KText,
                          //                               child: Text(
                          //                                 "1",
                          //                                 style: GoogleFonts.roboto(
                          //                                     fontSize:
                          //                                         kFourteenFont,
                          //                                     color: apicontroller
                          //                                                 .selectedMensCount
                          //                                                 .value ==
                          //                                             "1"
                          //                                         ? Kwhite
                          //                                         : Klightgreen,
                          //                                     fontWeight:
                          //                                         kFW500),
                          //                               ),
                          //                             ),
                          //                           ),
                          //                           InkWell(
                          //                             onTap: () {
                          //                               setState(() {
                          //                                 apicontroller
                          //                                     .selectedMensCount
                          //                                     .value = "2";
                          //                               });
                          //                             },
                          //                             child: CircleAvatar(
                          //                               backgroundColor: apicontroller
                          //                                           .selectedMensCount
                          //                                           .value ==
                          //                                       "2"
                          //                                   ? Kpink.withOpacity(
                          //                                       0.5)
                          //                                   : KText,
                          //                               child: Text(
                          //                                 "2",
                          //                                 style: GoogleFonts.roboto(
                          //                                     fontSize:
                          //                                         kFourteenFont,
                          //                                     color: apicontroller
                          //                                                 .selectedMensCount
                          //                                                 .value ==
                          //                                             "2"
                          //                                         ? Kwhite
                          //                                         : Klightgreen,
                          //                                     fontWeight:
                          //                                         kFW500),
                          //                               ),
                          //                             ),
                          //                           ),
                          //                           InkWell(
                          //                             onTap: () {
                          //                               setState(() {
                          //                                 apicontroller
                          //                                     .selectedMensCount
                          //                                     .value = "3";
                          //                               });
                          //                             },
                          //                             child: CircleAvatar(
                          //                               backgroundColor: apicontroller
                          //                                           .selectedMensCount
                          //                                           .value ==
                          //                                       "3"
                          //                                   ? Kpink.withOpacity(
                          //                                       0.5)
                          //                                   : KText,
                          //                               child: Text(
                          //                                 "3",
                          //                                 style: GoogleFonts.roboto(
                          //                                     fontSize:
                          //                                         kFourteenFont,
                          //                                     color: apicontroller
                          //                                                 .selectedMensCount
                          //                                                 .value ==
                          //                                             "3"
                          //                                         ? Kwhite
                          //                                         : Klightgreen,
                          //                                     fontWeight:
                          //                                         kFW500),
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ))
                          //                 ],
                          //               ),
                          //             )
                          //           : SizedBox(),
                          //       ///////////////////
                          //       // InkWell(
                          //       //   // 3
                          //       //   onTap: () {
                          //       //     setState(() {
                          //       //       apicontroller.selectedVehicle.value = "auto";
                          //       //     });
                          //       //   },
                          //       //   child: Container(
                          //       //     margin: EdgeInsets.only(top: 12.h),
                          //       //     width: double.infinity,
                          //       //     padding: EdgeInsets.all(10.r),
                          //       //     decoration: BoxDecoration(
                          //       //       border: Border.all(
                          //       //           color: apicontroller.selectedVehicle == "auto"
                          //       //               ? Kpink
                          //       //               : Kwhite),
                          //       //       boxShadow: [
                          //       //         BoxShadow(
                          //       //           color: Ktextcolor.withOpacity(0.5),
                          //       //           blurRadius: 5.r,
                          //       //           offset: Offset(1, 1),
                          //       //           spreadRadius: 1.r,
                          //       //         )
                          //       //       ],
                          //       //       color: Kwhite,
                          //       //       borderRadius: BorderRadius.circular(10.r),
                          //       //     ),
                          //       //     child: Row(
                          //       //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       //       children: [
                          //       //         Row(
                          //       //           children: [
                          //       //             ClipRRect(
                          //       //               borderRadius: BorderRadius.circular(20),
                          //       //               child: Image.asset(
                          //       //                 "assets/images/autoed.png",
                          //       //                 width: 60.w,
                          //       //                 height: 45.h,
                          //       //               ),
                          //       //             ),
                          //       //             SizedBox(
                          //       //               width: 5.w,
                          //       //             ),
                          //       //             Text(
                          //       //               "Auto",
                          //       //               style: GoogleFonts.roboto(
                          //       //                   fontSize: kSixteenFont,
                          //       //                   color: kcarden,
                          //       //                   fontWeight: kFW500),
                          //       //             ),
                          //       //           ],
                          //       //         ),
                          //       //         Text(
                          //       //           "₹ 49",
                          //       //           style: GoogleFonts.roboto(
                          //       //               fontSize: kSixteenFont,
                          //       //               color: kcarden,
                          //       //               fontWeight: kFW500),
                          //       //         ),
                          //       //       ],
                          //       //     ),
                          //       //   ),
                          //       // ),
                          //       //////////////////////////////////////////////////////////
                          //       InkWell(
                          //         onTap: () {
                          //           setState(() {
                          //             apicontroller.selectedVehicle.value =
                          //                 "auto";
                          //           });
                          //         },
                          //         child: Container(
                          //           margin: EdgeInsets.only(top: 12.h),
                          //           width: double.infinity,
                          //           // padding: EdgeInsets.all(10.r),
                          //           padding: EdgeInsets.only(
                          //               left: 10.w,
                          //               top: 5.h,
                          //               bottom: 5.h,
                          //               right: 10.w),
                          //           decoration: BoxDecoration(
                          //             border: Border.all(
                          //                 color:
                          //                     apicontroller.selectedVehicle ==
                          //                             "auto"
                          //                         ? Kpink
                          //                         : Kwhite),
                          //             boxShadow: [
                          //               BoxShadow(
                          //                 color: Ktextcolor.withOpacity(0.5),
                          //                 blurRadius: 5.r,
                          //                 offset: Offset(1, 1),
                          //                 spreadRadius: 1.r,
                          //               )
                          //             ],
                          //             color: Kwhite,
                          //             borderRadius: BorderRadius.circular(10.r),
                          //           ),
                          //           child: Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               Row(
                          //                 children: [
                          //                   ClipRRect(
                          //                     borderRadius:
                          //                         BorderRadius.circular(20),
                          //                     child: Image.asset(
                          //                       "assets/images/autoed.png",
                          //                       width: 45.w,
                          //                       height: 45.h,
                          //                     ),
                          //                   ),
                          //                   SizedBox(
                          //                     width: 10.w,
                          //                   ),
                          //                   Column(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Row(
                          //                         children: [
                          //                           SizedBox(
                          //                             width: 100.w,
                          //                             child: Row(
                          //                               children: [
                          //                                 Text(
                          //                                   "Auto",
                          //                                   style: GoogleFonts
                          //                                       .roboto(
                          //                                           fontSize:
                          //                                               kTwelveFont,
                          //                                           color:
                          //                                               Kpink,
                          //                                           fontWeight:
                          //                                               kFW500),
                          //                                 ),
                          //                                 SizedBox(
                          //                                   width: 15,
                          //                                 ),
                          //                                 Image.asset(
                          //                                   "assets/images/pink_profile.png",
                          //                                   height: 12.h,
                          //                                 ),
                          //                                 SizedBox(
                          //                                   width: 2.w,
                          //                                 ),
                          //                                 Text(
                          //                                   "1",
                          //                                   style: GoogleFonts
                          //                                       .roboto(
                          //                                           fontSize:
                          //                                               kTwelveFont,
                          //                                           color:
                          //                                               Kpink,
                          //                                           fontWeight:
                          //                                               kFW500),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           ),
                          //                           SizedBox(
                          //                             width: 15.w,
                          //                           ),
                          //                           Container(
                          //                             decoration: BoxDecoration(
                          //                                 color: Kpink,
                          //                                 borderRadius:
                          //                                     BorderRadius
                          //                                         .circular(
                          //                                             15.r)),
                          //                             padding: EdgeInsets.only(
                          //                                 left: 6.w,
                          //                                 right: 6.w,
                          //                                 top: 2.h,
                          //                                 bottom: 2.h),
                          //                             child: Text(
                          //                               "Fastest",
                          //                               style:
                          //                                   GoogleFonts.roboto(
                          //                                       fontSize:
                          //                                           kTwelveFont,
                          //                                       color: Kwhite,
                          //                                       fontWeight:
                          //                                           kFW400),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                       SizedBox(
                          //                         height: 5.h,
                          //                       ),
                          //                       Text(
                          //                         "Beat the traffic & pay less",
                          //                         style: GoogleFonts.roboto(
                          //                             fontSize: kTenFont,
                          //                             color: kcarden,
                          //                             fontWeight: kFW500),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ],
                          //               ),
                          //               Text(
                          //                 "₹ 49",
                          //                 style: GoogleFonts.roboto(
                          //                     fontSize: kSixteenFont,
                          //                     color: kcarden,
                          //                     fontWeight: kFW500),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //       apicontroller.selectedVehicle == "auto"
                          //           ? Container(
                          //               margin: EdgeInsets.only(
                          //                   top: 8.h,
                          //                   left: 16.w,
                          //                   right: 16.w,
                          //                   bottom: 8.h),
                          //               width: double.infinity,
                          //               padding: EdgeInsets.all(8.r),
                          //               decoration: BoxDecoration(
                          //                 border: Border.all(
                          //                     color: apicontroller
                          //                                 .selectedVehicle ==
                          //                             "auto"
                          //                         ? Kpink
                          //                         : Kwhite),
                          //                 boxShadow: [
                          //                   BoxShadow(
                          //                     color:
                          //                         Ktextcolor.withOpacity(0.5),
                          //                     blurRadius: 5.r,
                          //                     offset: Offset(1, 1),
                          //                     spreadRadius: 1.r,
                          //                   )
                          //                 ],
                          //                 color: Kwhite,
                          //                 borderRadius:
                          //                     BorderRadius.circular(10.r),
                          //               ),
                          //               child: Column(
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.start,
                          //                 children: [
                          //                   Text(
                          //                     "Select Male Passengers Count",
                          //                     style: GoogleFonts.roboto(
                          //                         fontSize: kTwelveFont,
                          //                         color: Kpink,
                          //                         fontWeight: kFW500),
                          //                   ),
                          //                   SizedBox(height: 10.h),
                          //                   Obx(() => Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment
                          //                                 .spaceAround,
                          //                         children: [
                          //                           InkWell(
                          //                             onTap: () {
                          //                               setState(() {
                          //                                 apicontroller
                          //                                     .selectedMensCount
                          //                                     .value = "0";
                          //                               });
                          //                             },
                          //                             child: CircleAvatar(
                          //                               backgroundColor: apicontroller
                          //                                           .selectedMensCount
                          //                                           .value ==
                          //                                       "0"
                          //                                   ? Kpink.withOpacity(
                          //                                       0.5)
                          //                                   : KText,
                          //                               child: Text(
                          //                                 "0",
                          //                                 style: GoogleFonts.roboto(
                          //                                     fontSize:
                          //                                         kFourteenFont,
                          //                                     color: apicontroller
                          //                                                 .selectedMensCount
                          //                                                 .value ==
                          //                                             "0"
                          //                                         ? Kwhite
                          //                                         : Klightgreen,
                          //                                     fontWeight:
                          //                                         kFW500),
                          //                               ),
                          //                             ),
                          //                           ),
                          //                           InkWell(
                          //                             onTap: () {
                          //                               setState(() {
                          //                                 apicontroller
                          //                                     .selectedMensCount
                          //                                     .value = "1";
                          //                               });
                          //                             },
                          //                             child: CircleAvatar(
                          //                               backgroundColor: apicontroller
                          //                                           .selectedMensCount
                          //                                           .value ==
                          //                                       "1"
                          //                                   ? Kpink.withOpacity(
                          //                                       0.5)
                          //                                   : KText,
                          //                               child: Text(
                          //                                 "1",
                          //                                 style: GoogleFonts.roboto(
                          //                                     fontSize:
                          //                                         kFourteenFont,
                          //                                     color: apicontroller
                          //                                                 .selectedMensCount
                          //                                                 .value ==
                          //                                             "1"
                          //                                         ? Kwhite
                          //                                         : Klightgreen,
                          //                                     fontWeight:
                          //                                         kFW500),
                          //                               ),
                          //                             ),
                          //                           ),
                          //                           InkWell(
                          //                             onTap: () {
                          //                               setState(() {
                          //                                 apicontroller
                          //                                     .selectedMensCount
                          //                                     .value = "2";
                          //                               });
                          //                             },
                          //                             child: CircleAvatar(
                          //                               backgroundColor: apicontroller
                          //                                           .selectedMensCount
                          //                                           .value ==
                          //                                       "2"
                          //                                   ? Kpink.withOpacity(
                          //                                       0.5)
                          //                                   : KText,
                          //                               child: Text(
                          //                                 "2",
                          //                                 style: GoogleFonts.roboto(
                          //                                     fontSize:
                          //                                         kFourteenFont,
                          //                                     color: apicontroller
                          //                                                 .selectedMensCount
                          //                                                 .value ==
                          //                                             "2"
                          //                                         ? Kwhite
                          //                                         : Klightgreen,
                          //                                     fontWeight:
                          //                                         kFW500),
                          //                               ),
                          //                             ),
                          //                           ),
                          //                           InkWell(
                          //                             onTap: () {
                          //                               setState(() {
                          //                                 apicontroller
                          //                                     .selectedMensCount
                          //                                     .value = "3";
                          //                               });
                          //                             },
                          //                             child: CircleAvatar(
                          //                               backgroundColor: apicontroller
                          //                                           .selectedMensCount
                          //                                           .value ==
                          //                                       "3"
                          //                                   ? Kpink.withOpacity(
                          //                                       0.5)
                          //                                   : KText,
                          //                               child: Text(
                          //                                 "3",
                          //                                 style: GoogleFonts.roboto(
                          //                                     fontSize:
                          //                                         kFourteenFont,
                          //                                     color: apicontroller
                          //                                                 .selectedMensCount
                          //                                                 .value ==
                          //                                             "3"
                          //                                         ? Kwhite
                          //                                         : Klightgreen,
                          //                                     fontWeight:
                          //                                         kFW500),
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ))
                          //                 ],
                          //               ),
                          //             )
                          //           : SizedBox(),
                          //       ////////////////////////////////////////
                          //       // InkWell(
                          //       //   onTap: () {
                          //       //     setState(() {
                          //       //       apicontroller.selectedVehicle.value = "parcel";
                          //       //       Get.toNamed(kUserSendParcel);
                          //       //     });
                          //       //   },
                          //       //   child: Container(
                          //       //     margin: EdgeInsets.only(top: 12.h),
                          //       //     width: double.infinity,
                          //       //     padding: EdgeInsets.all(10.r),
                          //       //     decoration: BoxDecoration(
                          //       //       border: Border.all(
                          //       //           color: apicontroller.selectedVehicle == "parcel"
                          //       //               ? Kpink
                          //       //               : Kwhite),
                          //       //       boxShadow: [
                          //       //         BoxShadow(
                          //       //           color: Ktextcolor.withOpacity(0.5),
                          //       //           blurRadius: 5.r,
                          //       //           offset: Offset(1, 1),
                          //       //           spreadRadius: 1.r,
                          //       //         )
                          //       //       ],
                          //       //       color: Kwhite,
                          //       //       borderRadius: BorderRadius.circular(10.r),
                          //       //     ),
                          //       //     child: Row(
                          //       //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       //       children: [
                          //       //         Row(
                          //       //           children: [
                          //       //             ClipRRect(
                          //       //               borderRadius: BorderRadius.circular(20),
                          //       //               child: Image.asset(
                          //       //                 "assets/images/parcelbike.png",
                          //       //                 width: 70.w,
                          //       //                 height: 45.h,
                          //       //               ),
                          //       //             ),
                          //       //             SizedBox(
                          //       //               width: 2.w,
                          //       //             ),
                          //       //             Text(
                          //       //               "Parcel",
                          //       //               style: GoogleFonts.roboto(
                          //       //                   fontSize: kSixteenFont,
                          //       //                   color: kcarden,
                          //       //                   fontWeight: kFW500),
                          //       //             ),
                          //       //           ],
                          //       //         ),
                          //       //         Text(
                          //       //           "₹ 49",
                          //       //           style: GoogleFonts.roboto(
                          //       //               fontSize: kSixteenFont,
                          //       //               color: kcarden,
                          //       //               fontWeight: kFW500),
                          //       //         ),
                          //       //       ],
                          //       //     ),
                          //       //   ),
                          //       // ),

                          //       ///////////////////////////////////////////////////////////////////////////////////////////////
                          //       InkWell(
                          //         onTap: () {
                          //           setState(() {
                          //             apicontroller.selectedVehicle.value =
                          //                 "parcel";
                          //             Get.toNamed(kUserSendParcel);
                          //           });
                          //         },
                          //         child: Container(
                          //           margin: EdgeInsets.only(top: 12.h),
                          //           width: double.infinity,
                          //           // padding: EdgeInsets.all(10.r),
                          //           padding: EdgeInsets.only(
                          //               left: 10.w,
                          //               top: 5.h,
                          //               bottom: 5.h,
                          //               right: 10.w),
                          //           decoration: BoxDecoration(
                          //             border: Border.all(
                          //                 color:
                          //                     apicontroller.selectedVehicle ==
                          //                             "parcel"
                          //                         ? Kpink
                          //                         : Kwhite),
                          //             boxShadow: [
                          //               BoxShadow(
                          //                 color: Ktextcolor.withOpacity(0.5),
                          //                 blurRadius: 5.r,
                          //                 offset: Offset(1, 1),
                          //                 spreadRadius: 1.r,
                          //               )
                          //             ],
                          //             color: Kwhite,
                          //             borderRadius: BorderRadius.circular(10.r),
                          //           ),
                          //           child: Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               Row(
                          //                 children: [
                          //                   ClipRRect(
                          //                     borderRadius:
                          //                         BorderRadius.circular(20),
                          //                     child: Image.asset(
                          //                       "assets/images/parcelbike.png",
                          //                       width: 45.w,
                          //                       height: 45.h,
                          //                     ),
                          //                   ),
                          //                   SizedBox(
                          //                     width: 10.w,
                          //                   ),
                          //                   Column(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Row(
                          //                         children: [
                          //                           SizedBox(
                          //                             width: 100.w,
                          //                             child: Row(
                          //                               children: [
                          //                                 Text(
                          //                                   "Parcel",
                          //                                   style: GoogleFonts
                          //                                       .roboto(
                          //                                           fontSize:
                          //                                               kTwelveFont,
                          //                                           color:
                          //                                               Kpink,
                          //                                           fontWeight:
                          //                                               kFW500),
                          //                                 ),
                          //                                 SizedBox(
                          //                                   width: 15,
                          //                                 ),
                          //                                 Image.asset(
                          //                                   "assets/images/pink_profile.png",
                          //                                   height: 12.h,
                          //                                 ),
                          //                                 SizedBox(
                          //                                   width: 2.w,
                          //                                 ),
                          //                                 Text(
                          //                                   "1",
                          //                                   style: GoogleFonts
                          //                                       .roboto(
                          //                                           fontSize:
                          //                                               kTwelveFont,
                          //                                           color:
                          //                                               Kpink,
                          //                                           fontWeight:
                          //                                               kFW500),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           ),
                          //                           SizedBox(
                          //                             width: 15.w,
                          //                           ),
                          //                           Container(
                          //                             decoration: BoxDecoration(
                          //                                 color: Kpink,
                          //                                 borderRadius:
                          //                                     BorderRadius
                          //                                         .circular(
                          //                                             15.r)),
                          //                             padding: EdgeInsets.only(
                          //                                 left: 6.w,
                          //                                 right: 6.w,
                          //                                 top: 2.h,
                          //                                 bottom: 2.h),
                          //                             child: Text(
                          //                               "Fastest",
                          //                               style:
                          //                                   GoogleFonts.roboto(
                          //                                       fontSize:
                          //                                           kTwelveFont,
                          //                                       color: Kwhite,
                          //                                       fontWeight:
                          //                                           kFW400),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                       SizedBox(
                          //                         height: 5.h,
                          //                       ),
                          //                       Text(
                          //                         "Beat the traffic & pay less",
                          //                         style: GoogleFonts.roboto(
                          //                             fontSize: kTenFont,
                          //                             color: kcarden,
                          //                             fontWeight: kFW500),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ],
                          //               ),
                          //               Text(
                          //                 "₹ 49",
                          //                 style: GoogleFonts.roboto(
                          //                     fontSize: kSixteenFont,
                          //                     color: kcarden,
                          //                     fontWeight: kFW500),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          /////////////////////////////////////////////////////////////////////////////
                          // apicontroller.selectedVehicle.value == "parcel"
                          //     ? Container(
                          //         height: 60.h,
                          //         margin: EdgeInsets.only(top: 20.h),
                          //         width: double.infinity,
                          //         padding: EdgeInsets.all(10.r),
                          //         decoration: BoxDecoration(
                          //           boxShadow: [
                          //             BoxShadow(
                          //               color: Ktextcolor.withOpacity(0.5),
                          //               blurRadius: 5.r,
                          //               offset: Offset(1, 1),
                          //               spreadRadius: 1.r,
                          //             )
                          //           ],
                          //           color: Kwhite,
                          //           borderRadius: BorderRadius.circular(10.r),
                          //         ),
                          //         child: DropdownButtonFormField2<String>(
                          //           isExpanded: true,
                          //           decoration: InputDecoration(
                          //             enabledBorder: OutlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   color: Colors.transparent, width: 0),
                          //               borderRadius: BorderRadius.circular(10.r),
                          //             ),
                          //             errorBorder: OutlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   color: Colors.transparent, width: 0),
                          //               borderRadius: BorderRadius.circular(10.r),
                          //             ),
                          //             disabledBorder: OutlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   color: Colors.transparent, width: 0),
                          //               borderRadius: BorderRadius.circular(10.r),
                          //             ),
                          //             focusedErrorBorder: OutlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   color: Colors.transparent, width: 0),
                          //               borderRadius: BorderRadius.circular(10.r),
                          //             ),
                          //             focusedBorder: OutlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   color: Colors.transparent, width: 0),
                          //               borderRadius: BorderRadius.circular(10.r),
                          //             ),
                          //             contentPadding: const EdgeInsets.symmetric(
                          //                 vertical: 10, horizontal: 8),
                          //             border: OutlineInputBorder(
                          //               borderRadius: BorderRadius.circular(10),
                          //             ),
                          //           ),
                          //           hint: Text(
                          //             'Select Parcel Type',
                          //             style: GoogleFonts.roboto(fontSize: 14),
                          //           ),
                          //           items: bloodgroupss
                          //               .map((item) => DropdownMenuItem<String>(
                          //                     value: item,
                          //                     child: Text(
                          //                       item,
                          //                       style: const TextStyle(
                          //                         fontSize: 14,
                          //                       ),
                          //                     ),
                          //                   ))
                          //               .toList(),
                          //           validator: (value) {
                          //             if (value == null) {
                          //               return 'Please select Type.';
                          //             }
                          //             return null;
                          //           },
                          //           onChanged: (value) {
                          //             setState(() {
                          //               // authentication.findDonorBloodGroup.value =
                          //               //     value.toString();
                          //               selectedValue = value.toString();
                          //               print(selectedValue);
                          //             });

                          //             // authentication.registerDonorBloodController.value =
                          //             //     selectedValue as TextEditingValue;
                          //             //Do something when selected item is changed.
                          //           },
                          //           onSaved: (value) {
                          //             selectedValue = value.toString();
                          //             print(selectedValue);
                          //             // authentication.registerDonorBloodController.value =
                          //             //     selectedValue as TextEditingValue;
                          //           },
                          //           buttonStyleData: const ButtonStyleData(
                          //             padding: EdgeInsets.only(right: 8),
                          //           ),
                          //           iconStyleData: const IconStyleData(
                          //             icon: Icon(
                          //               Icons.arrow_drop_down,
                          //               color: KText,
                          //             ),
                          //             iconSize: 24,
                          //           ),
                          //           dropdownStyleData: DropdownStyleData(
                          //             decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(15),
                          //             ),
                          //           ),
                          //           menuItemStyleData: const MenuItemStyleData(
                          //             padding: EdgeInsets.symmetric(horizontal: 16),
                          //           ),
                          //         ),
                          //       )
                          //     : SizedBox(),
                          // apicontroller.selectedVehicle.value == "parcel"
                          //     ? Container(
                          //         margin: EdgeInsets.only(top: 20.h),
                          //         child: CustomFormField(
                          //           enabled: true,
                          //           controller: apicontroller.instructionsController,
                          //           obscureText: false,
                          //           contentPadding: const EdgeInsets.symmetric(
                          //               vertical: 16, horizontal: 8),
                          //           fontSize: kFourteenFont,
                          //           fontWeight: FontWeight.w500,
                          //           hintText: "Enter Instructions",
                          //           maxLines: 1,
                          //           readOnly: false,
                          //           label: 'Instructions',
                          //           validator: (value) {
                          //             if (value!.isEmpty) {
                          //               return 'Please enter Instructions';
                          //             }
                          //             return null;
                          //           },
                          //         ),
                          //       )
                          //     : SizedBox(),
                          // apicontroller.selectedVehicle.value == "parcel"
                          //     ? CustomButton(
                          //         margin: EdgeInsets.only(top: 40.h),
                          //         width: double.infinity,
                          //         height: 42.h,
                          //         fontSize: kFourteenFont,
                          //         fontWeight: kFW700,
                          //         textColor: Kwhite,
                          //         borderRadius: BorderRadius.circular(30.r),
                          //         label: "Book Ride",
                          //         isLoading: false,
                          //         onTap: () {
                          //           setState(() {
                          //             apicontroller.userRideAutenticationBody.value =
                          //                 {
                          //               "dropLangitude":
                          //                   "${apicontroller.searchedData["waypoints"][1]["location"][0]}",
                          //               "dropLongitude":
                          //                   "${apicontroller.searchedData["waypoints"][1]["location"][1]}",
                          //               "pickupLangitude":
                          //                   "${apicontroller.searchedData["waypoints"][0]["location"][0]}",
                          //               "pickupLongitude":
                          //                   "${apicontroller.searchedData["waypoints"][0]["location"][1]}",
                          //               "pickupAddress": apicontroller
                          //                   .searchedDataPickupAddress.value,
                          //               "dropAddress": apicontroller
                          //                   .searchedDataDropAddress.value,
                          //               "price": "250",
                          //               "orderPlaceTime": formattedTime,
                          //               "orderPlaceDate": formattedDate,
                          //               "vehicleType":
                          //                   apicontroller.selectedVehicle.value,
                          //               "parcelType": selectedValue,
                          //               "deliveryInstruction":
                          //                   apicontroller.instructionsController.text
                          //             };
                          //           });
                          //           if (apicontroller
                          //                   .profileData["authenticationImage"] ==
                          //               null) {
                          //             Get.toNamed(kUserUploadDocs);
                          //           } else {
                          //             authenticateWithBiometrics();
                          //           }

                          //           // userapicontroller.placeOrdersUser(payload);
                          //         })
                          //     :
                          ///////////////////////////////////////below is replaced
                          // CustomButton(
                          //     margin: EdgeInsets.only(top: 40.h),
                          //     width: double.infinity,
                          //     height: 42.h,
                          //     fontSize: kFourteenFont,
                          //     fontWeight: kFW700,
                          //     textColor: Kwhite,
                          //     borderRadius: BorderRadius.circular(30.r),
                          //     label: "Book Ride",
                          //     isLoading: false,
                          //     onTap: () {
                          //       setState(() {
                          //         apicontroller.userRideAutenticationBody.value = {
                          //           "dropLangitude":
                          //               "${apicontroller.searchedData["waypoints"][1]["location"][0]}",
                          //           "dropLongitude":
                          //               "${apicontroller.searchedData["waypoints"][1]["location"][1]}",
                          //           "pickupLangitude":
                          //               "${apicontroller.searchedData["waypoints"][0]["location"][0]}",
                          //           "pickupLongitude":
                          //               "${apicontroller.searchedData["waypoints"][0]["location"][1]}",
                          //           "pickupAddress":
                          //               apicontroller.searchedDataPickupAddress.value,
                          //           "dropAddress":
                          //               apicontroller.searchedDataDropAddress.value,
                          //           "price": "250",
                          //           "orderPlaceTime": formattedTime,
                          //           "orderPlaceDate": formattedDate,
                          //           "vehicleType": apicontroller.selectedVehicle.value
                          //         };
                          //       });
                          //       if (apicontroller
                          //               .profileData["authenticationImage"] ==
                          //           null) {
                          //         Get.toNamed(kUserUploadDocs);
                          //       } else {
                          //         authenticateWithBiometrics();
                          //       }
                          //       // userapicontroller.placeOrdersUser(payload);
                          //     }),
                          ////////////////////////////////////////////////////////////////////////////////////////
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  ////////////////////

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

  ////////////
}
