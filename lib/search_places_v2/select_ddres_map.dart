// Vimport 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:womentaxi/Screens/captain/controllers/api_controllers.dart'; // Import geocoding package
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:womentaxi/Screens/captain/controllers/api_controllers.dart';
import 'package:womentaxi/untils/constants.dart';

class PickAddressonMap extends StatefulWidget {
  const PickAddressonMap({Key? key}) : super(key: key);

  @override
  State<PickAddressonMap> createState() => PickAddressonMapState();
}

class PickAddressonMapState extends State<PickAddressonMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng? currentPosition;
  LatLng? tappedPosition;
  String tappedAddress = 'Please Select Address';
  Set<Marker> markers = {}; // Initialize a set to hold markers

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  ApiController apicontroller = Get.put(ApiController());
  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> _onMapTapped(LatLng position) async {
    setState(() {
      tappedPosition = position;
      markers.clear(); // Clear existing markers
      markers.add(
        // Add a new marker at the tapped position
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: position,
          infoWindow: InfoWindow(title: 'Selected Location'),
        ),
      );
    });

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String fullAddress = [
          place.name,
          place.street,
          place.locality,
          place.administrativeArea,
          place.postalCode,
          place.country
        ].where((element) => element != null && element.isNotEmpty).join(', ');

        setState(() {
          tappedAddress =
              fullAddress.isNotEmpty ? fullAddress : 'No address found';
        });
        setState(() {
          apicontroller.searchedDataV2.value = tappedAddress;
        });
        ///////////////////////
        setState(() {
          apicontroller.searchedDataV2latittude.value = position.latitude;

          apicontroller.searchedDataV2longitude.value = position.longitude;
        });

        // Do something with the latitude and longitude

        apicontroller.updateSearchedDataGmapsV2();
        ///////////////
        print(tappedAddress);
      }
    } catch (e) {
      setState(() {
        tappedAddress = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Select Drop point",
          style: TextStyle(fontSize: 18.sp, color: kcarden, fontWeight: kFW600),
        ),
      ),
      //  AppBar(
      //   title: const Text("Select Location"),
      // )

      body: currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: currentPosition!,
                    zoom: 14.4746,
                  ),
                  markers: markers, // Display markers on the map
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onTap: _onMapTapped,
                ),
                Positioned(
                  bottom: 50,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: Text(
                      "$tappedAddress",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}


// class PickAddressonMap extends StatefulWidget {
//   const PickAddressonMap({Key? key}) : super(key: key);

//   @override
//   State<PickAddressonMap> createState() => PickAddressonMapState();
// }

// class PickAddressonMapState extends State<PickAddressonMap> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//   LatLng? currentPosition;
//   LatLng? tappedPosition;
//   String tappedAddress = 'No address selected';

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       currentPosition = LatLng(position.latitude, position.longitude);
//     });
//   }

//   Future<void> _onMapTapped(LatLng position) async {
//     setState(() {
//       tappedPosition = position;
//     });

//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(position.latitude, position.longitude);
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         // Construct the full address using the available fields
//         String fullAddress = [
//           place.name,
//           place.street,
//           place.locality,
//           place.administrativeArea,
//           place.postalCode,
//           place.country
//         ].where((element) => element != null && element.isNotEmpty).join(', ');

//         setState(() {
//           tappedAddress =
//               fullAddress.isNotEmpty ? fullAddress : 'No address found';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         tappedAddress = 'Error: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select Location"),
//       ),
//       body: currentPosition == null
//           ? const Center(child: CircularProgressIndicator())
//           : Stack(
//               children: [
//                 GoogleMap(
//                   mapType: MapType.normal,
//                   initialCameraPosition: CameraPosition(
//                     target: currentPosition!,
//                     zoom: 14.4746,
//                   ),
//                   onMapCreated: (GoogleMapController controller) {
//                     _controller.complete(controller);
//                   },
//                   onTap: _onMapTapped, // Add onTap event here
//                 ),
//                 Positioned(
//                   bottom: 50,
//                   left: 10,
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     color: Colors.white,
//                     child: Text(
//                       "Selected Address: $tappedAddress",
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
