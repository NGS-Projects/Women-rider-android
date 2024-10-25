import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:womentaxi/Screens/User/User_Controllers/user_api_controllers.dart';
import 'package:womentaxi/untils/export_file.dart';

class CitySearch extends StatefulWidget {
  @override
  _CitySearchState createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  String _cityName = "Unknown";
  UserApiController userapicontroller = Get.put(UserApiController());
  // Define a list of metropolitan or megacities
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

  // Function to get city name from coordinates
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
        } else {
          // Show toast message if the city is not in the list of metropolitan cities
          setState(() {
            _cityName = "Out of main city";
          });
          Fluttertoast.showToast(
            msg: "Out of main city",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
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

  @override
  void initState() {
    super.initState();
    userapicontroller.getRideCities();
    double latitude = 22.52374586147826;
    double longitude = 88.3636401219609;

    // double latitude = 17.3850;
    // double longitude = 78.4867;
    _getCityName(latitude,
        longitude); // Fetch the city name using the example coordinates
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get City from Coordinates'),
      ),
      body: Center(
        child: Text(
          'City: $_cityName',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
