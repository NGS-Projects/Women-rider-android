import 'dart:convert';


import 'package:flutter/material.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:flutter_svg/svg.dart';


import 'package:fluttertoast/fluttertoast.dart';


import 'package:geocoding/geocoding.dart';


import 'package:get/get.dart';


import 'package:get/get_core/src/get_main.dart';


import 'package:google_fonts/google_fonts.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:womentaxi/Screens/User/User_Controllers/user_api_controllers.dart';


import 'package:womentaxi/Screens/User/ride_history.dart';


import 'package:womentaxi/Screens/captain/components/custom_button.dart';


import 'package:womentaxi/Screens/captain/components/custom_form_field.dart';


import 'package:womentaxi/Screens/captain/controllers/api_controllers.dart';


import 'package:womentaxi/Screens/captain/controllers/service_controller.dart';


import 'package:womentaxi/search_places_v2/components/network_utiliti.dart';


import 'package:womentaxi/search_places_v2/models/autocomplate_prediction.dart';


import 'package:womentaxi/search_places_v2/models/place_auto_complate_response.dart';


import 'package:womentaxi/search_places_v2/select_ddres_map.dart';


import 'package:womentaxi/untils/constants.dart';


// import 'package:places_auto_suggestion/components/network_utiliti.dart';


// import 'package:places_auto_suggestion/models/autocomplate_prediction.dart';


// import 'package:places_auto_suggestion/models/place_auto_complate_response.dart';


import 'components/location_list_tile.dart';


// import 'package:womentaxi/untils/export_file.dart';


// import 'constants.dart';


class SearchLocationScreen extends StatefulWidget {

  const SearchLocationScreen({Key? key}) : super(key: key);


  @override

  State<SearchLocationScreen> createState() => _SearchLocationScreenState();

}


class _SearchLocationScreenState extends State<SearchLocationScreen> {

  //////////////////////////////////////////////


  ApiController apicontroller = Get.put(ApiController());


  List<AutocompletePrediction> placePredictions = [];


  ////////////////////////////////////////////CityCheck


  String _cityName = "Unknown";


//  UserApiController userapicontroller = Get.put(UserApiController());


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


        if (userapiController.metropolitanCities.contains(cityName)) {

          setState(() {

            _cityName = cityName;

          });


          apicontroller.updateSearchedDataGmapsV2();


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


  ///////////////////////////


  @override

  void initState() {

    userapiController.getRideCities();


    // TODO: implement initState


    super.initState();

  }


  void placeAutocomplete(String query) async {

    Uri uri = Uri.https("maps.googleapis.com",

        'maps/api/place/autocomplete/json', {"input": query, "key": apiKey});


    String? response = await NetworkUtility.fetchUrl(uri);


    if (response != null) {

      PlaceAutocompleteResponse result =

          PlaceAutocompleteResponse.parseAutocompleteResult(response);


      // print(response);


      if (result.predictions != null) {

        setState(() {

          placePredictions = result.predictions!;

        });

      }

    }

  }


  // for latitude and longitude


  ///////////////////////////////////////////////////////////////////////////////////


  UserApiController userapiController = Get.put(UserApiController());


  void getPlaceDetailsforhistorys(Map selectedOrder) async {

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


  //////////////////////////////////////////////////////////////////////////////


  ServiceController serviceController = Get.put(ServiceController());


  void getPlaceDetails(String placeId) async {

    Uri uri = Uri.https("maps.googleapis.com", 'maps/api/place/details/json',

        {"place_id": placeId, "key": apiKey});


    String? response = await NetworkUtility.fetchUrl(uri);


    if (response != null) {

      var json = jsonDecode(response);


      double lat = json['result']['geometry']['location']['lat'];


      double lng = json['result']['geometry']['location']['lng'];


      setState(() {

        apicontroller.searchedDataV2latittude.value = lat;


        apicontroller.searchedDataV2longitude.value = lng;

      });


      // Do something with the latitude and longitude


      _getCityName(lat, lng);


      //    apicontroller.updateSearchedDataGmapsV2();


      print("Latitude: $lat, Longitude: $lng");

    }

  }


  UserApiController userapicontroller = Get.put(UserApiController());


  ////////////////////////


///////////////////////////////////////////////////////////////////////////////////////


  void _handleLocationSelected(LatLng latLng, String address) {

    setState(() {

      apicontroller.searchedDataV2.value = address;


      apicontroller.searchedDataV2latittude.value = latLng.latitude;


      apicontroller.searchedDataV2longitude.value = latLng.longitude;

    });


    // Optional: Update API or other data based on the selected location


    apicontroller.updateSearchedDataGmapsV2();

  }


/////////////////////////////////////////////


  Future<void> checkCityStatus(double pickupLat, double pickupLng,

      double dropLat, double dropLng) async {

    try {

      // Get the placemarks for pickup and drop locations


      List<Placemark> pickupPlacemarks =

          await placemarkFromCoordinates(pickupLat, pickupLng);


      List<Placemark> dropPlacemarks =

          await placemarkFromCoordinates(dropLat, dropLng);


      String pickupCity = '';


      String dropCity = '';


      if (pickupPlacemarks.isNotEmpty) {

        Placemark pickupPlace = pickupPlacemarks.first;


        if (pickupPlace.country == 'India' &&

            pickupPlace.locality != null &&

            pickupPlace.locality!.isNotEmpty) {

          pickupCity = pickupPlace.locality!;

        }

      }


      if (dropPlacemarks.isNotEmpty) {

        Placemark dropPlace = dropPlacemarks.first;


        if (dropPlace.country == 'India' &&

            dropPlace.locality != null &&

            dropPlace.locality!.isNotEmpty) {

          dropCity = dropPlace.locality!;

        }

      }


      // Check the city status of both points


      if (pickupCity.isNotEmpty && dropCity.isNotEmpty) {

        if (pickupCity == dropCity) {

          print('Both points are in the city: $pickupCity');

        } else {

          print('Pickup point is in $pickupCity, Drop point is in $dropCity');

        }

      } else if (pickupCity.isNotEmpty) {

        print(

            'Pickup point is in city: $pickupCity, Drop point is out of cities in India');

      } else if (dropCity.isNotEmpty) {

        print(

            'Drop point is in city: $dropCity, Pickup point is out of cities in India');

      } else {

        print('You are not in a city');

      }

    } catch (e) {

      print('Error occurred: $e');

    }

  }


//////////////////////////////////////////////////////////////////////


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Kwhite,

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

        actions: [

          TextButton(

            onPressed: () {

              Get.toNamed(kGmapsSelect);

            },

            child: Text(

              'Select on Map',

              style: TextStyle(

                  fontSize: kFourteenFont, color: Kpink, fontWeight: kFW500),

            ),

          ),

        ],

        title: Text(

          "Select Drop point",

          style: TextStyle(fontSize: 18.sp, color: kcarden, fontWeight: kFW600),

        ),

      ),

      body: SingleChildScrollView(

        child: Container(

          margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),

          child: Column(

            children: [

              Container(

                  width: double.infinity,

                  padding:

                      EdgeInsets.symmetric(vertical: 10, horizontal: 16.w.h),

                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(10.0),

                      color: Kwhite,

                      boxShadow: const [

                        BoxShadow(

                          color: Color(0x3FD3D1D8),

                          blurRadius: 30,

                          offset: Offset(15, 15),

                          spreadRadius: 0,

                        )

                      ]),

                  child: Column(

                    children: [

                      InkWell(

                        onTap: () {

                          Fluttertoast.showToast(

                              msg: 'You cannot change pick up Location');

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

                            Obx(() => SizedBox(

                                  width: 250.w,

                                  child: Text(

                                    serviceController.address.value == "" ||

                                            serviceController.position == null

                                        ? "Loading..."

                                        : serviceController.address.value,

                                    maxLines: 1,

                                    overflow: TextOverflow.ellipsis,

                                    style: GoogleFonts.roboto(

                                        fontSize: kFourteenFont,

                                        color: KdarkText,

                                        fontWeight: kFW500),

                                  ),

                                )),

                          ],

                        ),

                      ),

                      SizedBox(

                        height: 12.h,

                      ),

                      Divider(),

                      SizedBox(

                        height: 1.h,

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


                          Container(

                              width: 200.w,

                              child: TextFormField(

                                enabled: true,


                                style: TextStyle(

                                    fontSize: 14.sp,

                                    fontWeight: kFW500,

                                    color: kblack),


                                decoration: InputDecoration(

                                    hintText: 'Enter drop address',

                                    hintStyle: TextStyle(

                                      color: KTextgery,

                                      fontSize: 14.sp,

                                      fontWeight: kFW500,

                                    ),

                                    border: InputBorder.none,

                                    contentPadding:

                                        EdgeInsets.symmetric(vertical: 5)),


                                cursorColor: Kpink.withOpacity(

                                    0.5), // Always show cursor color


                                showCursor: true,


                                onChanged: (value) {

                                  placeAutocomplete(value);

                                },

                              ))


                          // Text(


                          //   "Enter Drop Location",


                          //   style: GoogleFonts.roboto(


                          //       fontSize: kFourteenFont,


                          //       color: KdarkText,


                          //       fontWeight: kFW500),


                          // ),

                        ],

                      ),

                    ],

                  )),


              // CustomFormField(


              //   enabled: true,


              //   prefix: Padding(


              //       padding:


              //           const EdgeInsets.symmetric(vertical: 16, horizontal: 5),


              //       child: Icon(Icons.search)),


              //   contentPadding: const EdgeInsets.symmetric(


              //     vertical: 16,


              //   ),


              //   fontSize: kFourteenFont,


              //   fontWeight: FontWeight.w500,


              //   hintText: "Search drop location",


              //   maxLines: 1,


              //   readOnly: false,


              //   label: "",


              //   obscureText: false,


              //   onChanged: (value) {


              //     placeAutocomplete(value);


              //   },


              //   validator: (value) {},


              // ),


              SizedBox(

                height: 15.h,

              ),


              Obx(

                () => Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    userapicontroller.selectedorderlistType == "Ride History"

                        ? CustomButton(

                            borderRadius: BorderRadius.circular(15.r),

                            width: 140.w,

                            height: 35.h,

                            Color: Kpink,

                            textColor: Kwhite,

                            fontSize: 12.sp,

                            fontWeight: kFW700,

                            label: "Ride History",

                            isLoading: false,

                            onTap: () {

                              setState(() {

                                userapicontroller.selectedorderlistType.value =

                                    "Ride History";

                              });

                            })

                        : InkWell(

                            onTap: () {

                              setState(() {

                                userapicontroller.selectedorderlistType.value =

                                    "Ride History";

                              });

                            },

                            child: Container(

                              height: 35,

                              width: 140.w,

                              alignment: Alignment.center,

                              decoration: BoxDecoration(

                                color: Kwhite,

                                borderRadius: BorderRadius.circular(15.r),

                              ),

                              child: Text(

                                "Ride History",

                                textAlign: TextAlign.center,

                                style: GoogleFonts.roboto(

                                  fontSize: 12.sp,

                                  fontWeight: kFW700,

                                  color: KdarkText,

                                ),

                              ),

                            ),

                          ),

                    userapicontroller.selectedorderlistType == "Favourites"

                        ? CustomButton(

                            borderRadius: BorderRadius.circular(15.r),

                            width: 140.w,

                            height: 35.h,

                            Color: Kpink,

                            textColor: Kwhite,

                            fontSize: 12.sp,

                            fontWeight: kFW700,

                            label: "Favourites",

                            isLoading: false,

                            onTap: () {

                              setState(() {

                                userapicontroller.selectedorderlistType.value =

                                    "Favourites";

                              });

                            })

                        : InkWell(

                            onTap: () {

                              setState(() {

                                userapicontroller.selectedorderlistType.value =

                                    "Favourites";

                              });

                            },

                            child: Container(

                              height: 35,

                              width: 140.w,

                              alignment: Alignment.center,

                              decoration: BoxDecoration(

                                color: Kwhite,

                                borderRadius: BorderRadius.circular(15.r),

                              ),

                              child: Text(

                                "Favourites",

                                textAlign: TextAlign.center,

                                style: GoogleFonts.roboto(

                                  fontSize: 12.sp,

                                  fontWeight: kFW700,

                                  color: KdarkText,

                                ),

                              ),

                            ),

                          )

                  ],

                ),

              ),


              SizedBox(

                height: 20.h,

              ),


              Divider(

                height: 1,

                thickness: 1,

                color: Kpink.withOpacity(0.5),

              ),


              ListView.builder(

                itemCount: placePredictions.length,

                shrinkWrap: true,

                physics: NeverScrollableScrollPhysics(),

                itemBuilder: (context, index) => LocationListTile(

                  press: () {

                    setState(() {

                      apicontroller.searchedDataV2.value =

                          placePredictions[index].description!;

                    });


                    getPlaceDetails(placePredictions[index].placeId!);

                  },

                  location: placePredictions[index].description!,

                ),

              ),


              userapicontroller.selectedorderlistType == "Ride History"

                  ? Obx(() => userapiController.userOrdersDataLoading == true

                      ? Container(

                          alignment: Alignment.center,

                          margin: EdgeInsets.only(top: 100.h),

                          child: CircularProgressIndicator(

                            color: Kpink,

                          ),

                        )

                      : userapiController.userOrders.isEmpty ||

                              userapiController.userOrders == null

                          ? Text(

                              "No Orders",

                              style: GoogleFonts.roboto(

                                  fontSize: kSixteenFont,

                                  color: KdarkText,

                                  fontWeight: kFW500),

                            )

                          : ListView.builder(

                              padding: EdgeInsets.zero,

                              shrinkWrap: true,

                              physics: NeverScrollableScrollPhysics(),

                              itemCount: userapiController.userOrders.length,

                              itemBuilder: (context, index) {

                                return Column(

                                  children: [

                                    /////////////////////////////////////


                                    Column(

                                      children: [

                                        ListTile(

                                            onTap: () {

                                              setState(() {

                                                apicontroller.searchedDataV2

                                                    .value = userapiController

                                                            .userOrders[index]

                                                        ["dropAddress"] ??

                                                    "";


                                                // placePredictions[index].description!;

                                              });


                                              getPlaceDetailsforhistorys(

                                                  userapiController

                                                      .userOrders[index]);


                                              // apicontroller.updateSearchedDataGmapsV2();

                                            },

                                            horizontalTitleGap: 3,

                                            leading: CircleAvatar(

                                                backgroundColor:

                                                    Kpink.withOpacity(0.5),

                                                radius: 16.r,

                                                child: Icon(

                                                  Icons.location_on,

                                                  color: Kpink,

                                                  size: 20.sp,

                                                )),

                                            title: Text(

                                              userapiController

                                                      .userOrders[index]

                                                  ["dropAddress"],

                                              maxLines: 2,

                                              overflow: TextOverflow.ellipsis,

                                            ),

                                            trailing: Obx(() =>

                                                userapiController.userOrders[

                                                                index]

                                                            ["favorite"] ==

                                                        false

                                                    ? InkWell(

                                                        onTap: () {

                                                          userapicontroller

                                                              .userAddtoFavouriteinHistory(

                                                                  userapiController

                                                                              .userOrders[

                                                                          index]

                                                                      ["_id"]);

                                                        },

                                                        child: Icon(

                                                          Icons

                                                              .favorite_outline,


                                                          color: KlightText,


                                                          //  Kpink.withOpacity(


                                                          //   0.5,


                                                          size: 18.sp,

                                                        ),

                                                      )

                                                    : InkWell(

                                                        onTap: () {

                                                          userapicontroller

                                                              .userAddtoFavouriteinHistory(

                                                                  userapiController

                                                                              .userOrders[

                                                                          index]

                                                                      ["_id"]);

                                                        },

                                                        child: Icon(

                                                          Icons.favorite,


                                                          color: Kpink,


                                                          //  Kpink.withOpacity(


                                                          //   0.5,


                                                          size: 18.sp,

                                                        ),

                                                      ))),

                                        Divider(

                                          height: 1,

                                          thickness: 1,

                                          color: KdarkText.withOpacity(0.2),

                                        ),

                                      ],

                                    ),


                                    ///////////////////////////


                                    // InkWell(


                                    //   onTap: () {


                                    //     setState(() {


                                    //       apicontroller.searchedDataV2.value =


                                    //           userapiController.userOrders[index]


                                    //                   ["dropAddress"] ??


                                    //               "";


                                    //       // placePredictions[index].description!;


                                    //     });


                                    //     getPlaceDetailsforhistorys(


                                    //         userapiController.userOrders[index]);


                                    //     // apicontroller.updateSearchedDataGmapsV2();


                                    //   },


                                    //   child:


                                    //   Container(


                                    //     margin: EdgeInsets.only(top: 12.h),


                                    //     width: double.infinity,


                                    //     padding: EdgeInsets.all(10.r),


                                    //     decoration: BoxDecoration(


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


                                    //       mainAxisAlignment:


                                    //           MainAxisAlignment.spaceAround,


                                    //       crossAxisAlignment:


                                    //           CrossAxisAlignment.start,


                                    //       children: [


                                    //         Icon(


                                    //           Icons.location_searching,


                                    //           color: Kpink.withOpacity(


                                    //             0.5,


                                    //           ),


                                    //           size: 18.sp,


                                    //         ),


                                    //         Column(


                                    //           mainAxisAlignment:


                                    //               MainAxisAlignment.start,


                                    //           crossAxisAlignment:


                                    //               CrossAxisAlignment.start,


                                    //           children: [


                                    //             SizedBox(


                                    //               width: 150.w,


                                    //               child: Text(


                                    //                 userapiController


                                    //                         .userOrders[index]


                                    //                     ["dropAddress"],


                                    //                 // userapiController


                                    //                 //             .userSavedOrders[


                                    //                 //         index]["dropAddress"] ??


                                    //                 //     "",


                                    //                 maxLines: 1,


                                    //                 overflow: TextOverflow.ellipsis,


                                    //                 style: GoogleFonts.roboto(


                                    //                     fontSize: kSixteenFont,


                                    //                     color: kcarden,


                                    //                     fontWeight: kFW500),


                                    //               ),


                                    //             ),


                                    //             SizedBox(


                                    //               height: 8.h,


                                    //             ),


                                    //             SizedBox(


                                    //               width: 200.w,


                                    //               child: Text(


                                    //                 userapiController


                                    //                         .userOrders[index]


                                    //                     ["pickupAddress"],


                                    //                 // userapiController


                                    //                 //                 .userSavedOrders[


                                    //                 //             index]


                                    //                 //         ["pickupAddress"] ??


                                    //                 //     "",


                                    //                 //     "Survey No. 1050, Balanagar Mandal, Rd Number 3, Kukatpally Housing Board Colony, Kukatpally, Hyderabad, Telangana 500072",


                                    //                 maxLines: 1,


                                    //                 overflow: TextOverflow.ellipsis,


                                    //                 style: GoogleFonts.roboto(


                                    //                     fontSize: kTwelveFont,


                                    //                     color: Ktextcolor,


                                    //                     fontWeight: kFW500),


                                    //               ),


                                    //             ),


                                    //           ],


                                    //         ),


                                    //         // userAddtoFavourite


                                    //         // userapiController.userSavedOrders[index]


                                    //         Obx(() =>


                                    //             userapiController.userOrders[index]


                                    //                         ["favorite"] ==


                                    //                     false


                                    //                 ? InkWell(


                                    //                     onTap: () {


                                    //                       userapicontroller


                                    //                           .userAddtoFavouriteinHistory(


                                    //                               userapiController


                                    //                                       .userOrders[


                                    //                                   index]["_id"]);


                                    //                     },


                                    //                     child: Icon(


                                    //                       Icons.favorite_outline,


                                    //                       color: KlightText,


                                    //                       //  Kpink.withOpacity(


                                    //                       //   0.5,


                                    //                       size: 18.sp,


                                    //                     ),


                                    //                   )


                                    //                 : InkWell(


                                    //                     onTap: () {


                                    //                       userapicontroller


                                    //                           .userAddtoFavouriteinHistory(


                                    //                               userapiController


                                    //                                       .userOrders[


                                    //                                   index]["_id"]);


                                    //                     },


                                    //                     child: Icon(


                                    //                       Icons.favorite,


                                    //                       color: Kpink,


                                    //                       //  Kpink.withOpacity(


                                    //                       //   0.5,


                                    //                       size: 18.sp,


                                    //                     ),


                                    //                   ))


                                    //       ],


                                    //     ),


                                    //   ),


                                    // ),

                                  ],

                                );

                              }))

                  : Obx(() => userapiController.favouriteOrdersDataLoading ==

                          true

                      ? Container(

                          alignment: Alignment.center,

                          margin: EdgeInsets.only(top: 100.h),

                          child: CircularProgressIndicator(

                            color: Kpink,

                          ),

                        )

                      : userapiController.favouriteOrders.isEmpty ||

                              userapiController.favouriteOrders == null

                          ? Text(

                              "",

                              style: GoogleFonts.roboto(

                                  fontSize: kSixteenFont,

                                  color: KdarkText,

                                  fontWeight: kFW500),

                            )

                          : ListView.builder(

                              padding: EdgeInsets.zero,

                              shrinkWrap: true,

                              physics: NeverScrollableScrollPhysics(),

                              itemCount:

                                  userapiController.favouriteOrders.length,

                              itemBuilder: (context, index) {

                                return Column(

                                  children: [

                                    Column(

                                      children: [

                                        ListTile(

                                            onTap: () {

                                              setState(() {

                                                apicontroller.searchedDataV2

                                                    .value = userapiController

                                                            .favouriteOrders[

                                                        index]["dropAddress"] ??

                                                    "";


                                                // placePredictions[index].description!;

                                              });


                                              getPlaceDetailsforhistorys(

                                                  userapiController

                                                      .favouriteOrders[index]);


                                              // apicontroller.updateSearchedDataGmapsV2();

                                            },

                                            horizontalTitleGap: 3,

                                            leading: CircleAvatar(

                                                backgroundColor:

                                                    Kpink.withOpacity(0.5),

                                                radius: 16.r,

                                                child: Icon(

                                                  Icons.location_on,

                                                  color: Kpink,

                                                  size: 20.sp,

                                                )),

                                            title: Text(

                                              userapiController

                                                      .favouriteOrders[index]

                                                  ["dropAddress"],

                                              maxLines: 2,

                                              overflow: TextOverflow.ellipsis,

                                            ),

                                            trailing: Obx(() => userapiController

                                                            .favouriteOrders[

                                                        index]["favorite"] ==

                                                    false

                                                ? InkWell(

                                                    onTap: () {

                                                      userapicontroller

                                                          .userAddtoFavouriteinFavouritesList(

                                                              userapiController

                                                                      .favouriteOrders[

                                                                  index]["_id"]);

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

                                                      userapicontroller

                                                          .userAddtoFavouriteinFavouritesList(

                                                              userapiController

                                                                      .favouriteOrders[

                                                                  index]["_id"]);

                                                    },

                                                    child: Icon(

                                                      Icons.favorite,


                                                      color: Kpink,


                                                      //  Kpink.withOpacity(


                                                      //   0.5,


                                                      size: 18.sp,

                                                    ),

                                                  ))),

                                        Divider(

                                          height: 1,

                                          thickness: 1,

                                          color: KdarkText.withOpacity(0.2),

                                        ),

                                      ],

                                    ),


                                    // InkWell(


                                    //   onTap: () {


                                    //     setState(() {


                                    //       apicontroller.searchedDataV2.value =


                                    //           userapiController


                                    //                       .favouriteOrders[index]


                                    //                   ["dropAddress"] ??


                                    //               "";


                                    //       // placePredictions[index].description!;


                                    //     });


                                    //     getPlaceDetailsforhistorys(userapiController


                                    //         .favouriteOrders[index]);


                                    //     // apicontroller.updateSearchedDataGmapsV2();


                                    //   },


                                    //   child: Container(


                                    //     margin: EdgeInsets.only(top: 12.h),


                                    //     width: double.infinity,


                                    //     padding: EdgeInsets.all(10.r),


                                    //     decoration: BoxDecoration(


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


                                    //       mainAxisAlignment:


                                    //           MainAxisAlignment.spaceAround,


                                    //       crossAxisAlignment:


                                    //           CrossAxisAlignment.start,


                                    //       children: [


                                    //         Icon(


                                    //           Icons.location_searching,


                                    //           color: Kpink.withOpacity(


                                    //             0.5,


                                    //           ),


                                    //           size: 18.sp,


                                    //         ),


                                    //         Column(


                                    //           mainAxisAlignment:


                                    //               MainAxisAlignment.start,


                                    //           crossAxisAlignment:


                                    //               CrossAxisAlignment.start,


                                    //           children: [


                                    //             SizedBox(


                                    //               width: 150.w,


                                    //               child: Text(


                                    //                 userapiController


                                    //                         .favouriteOrders[index]


                                    //                     ["dropAddress"],


                                    //                 // userapiController


                                    //                 //             .userSavedOrders[


                                    //                 //         index]["dropAddress"] ??


                                    //                 //     "",


                                    //                 maxLines: 1,


                                    //                 overflow: TextOverflow.ellipsis,


                                    //                 style: GoogleFonts.roboto(


                                    //                     fontSize: kSixteenFont,


                                    //                     color: kcarden,


                                    //                     fontWeight: kFW500),


                                    //               ),


                                    //             ),


                                    //             SizedBox(


                                    //               height: 8.h,


                                    //             ),


                                    //             SizedBox(


                                    //               width: 200.w,


                                    //               child: Text(


                                    //                 userapiController


                                    //                         .favouriteOrders[index]


                                    //                     ["pickupAddress"],


                                    //                 maxLines: 1,


                                    //                 overflow: TextOverflow.ellipsis,


                                    //                 style: GoogleFonts.roboto(


                                    //                     fontSize: kTwelveFont,


                                    //                     color: Ktextcolor,


                                    //                     fontWeight: kFW500),


                                    //               ),


                                    //             ),


                                    //           ],


                                    //         ),


                                    //         // userAddtoFavourite


                                    //         // userapiController.userSavedOrders[index]


                                    //         Obx(() => userapiController


                                    //                         .favouriteOrders[index]


                                    //                     ["favorite"] ==


                                    //                 false


                                    //             ? InkWell(


                                    //                 onTap: () {


                                    //                   userapicontroller


                                    //                       .userAddtoFavouriteinFavouritesList(


                                    //                           userapiController


                                    //                                   .favouriteOrders[


                                    //                               index]["_id"]);


                                    //                 },


                                    //                 child: Icon(


                                    //                   Icons.favorite_outline,


                                    //                   color: KlightText,


                                    //                   //  Kpink.withOpacity(


                                    //                   //   0.5,


                                    //                   size: 18.sp,


                                    //                 ),


                                    //               )


                                    //             : InkWell(


                                    //                 onTap: () {


                                    //                   userapicontroller


                                    //                       .userAddtoFavouriteinFavouritesList(


                                    //                           userapiController


                                    //                                   .favouriteOrders[


                                    //                               index]["_id"]);


                                    //                 },


                                    //                 child: Icon(


                                    //                   Icons.favorite,


                                    //                   color: Kpink,


                                    //                   //  Kpink.withOpacity(


                                    //                   //   0.5,


                                    //                   size: 18.sp,


                                    //                 ),


                                    //               ))


                                    //       ],


                                    //     ),


                                    //   ),


                                    // ),

                                  ],

                                );

                              })),

            ],

          ),

        ),

      ),

    );

  }

}



// import 'dart:convert';


// import 'package:flutter/material.dart';


// import 'package:flutter_screenutil/flutter_screenutil.dart';


// import 'package:flutter_svg/svg.dart';


// import 'package:fluttertoast/fluttertoast.dart';


// import 'package:geocoding/geocoding.dart';


// import 'package:get/get.dart';


// import 'package:get/get_core/src/get_main.dart';


// import 'package:google_fonts/google_fonts.dart';


// import 'package:google_maps_flutter/google_maps_flutter.dart';


// import 'package:womentaxi/Screens/User/User_Controllers/user_api_controllers.dart';


// import 'package:womentaxi/Screens/User/ride_history.dart';


// import 'package:womentaxi/Screens/captain/components/custom_button.dart';


// import 'package:womentaxi/Screens/captain/components/custom_form_field.dart';


// import 'package:womentaxi/Screens/captain/controllers/api_controllers.dart';


// import 'package:womentaxi/Screens/captain/controllers/service_controller.dart';


// import 'package:womentaxi/search_places_v2/components/network_utiliti.dart';


// import 'package:womentaxi/search_places_v2/models/autocomplate_prediction.dart';


// import 'package:womentaxi/search_places_v2/models/place_auto_complate_response.dart';


// import 'package:womentaxi/search_places_v2/select_ddres_map.dart';


// import 'package:womentaxi/untils/constants.dart';


// // import 'package:places_auto_suggestion/components/network_utiliti.dart';


// // import 'package:places_auto_suggestion/models/autocomplate_prediction.dart';


// // import 'package:places_auto_suggestion/models/place_auto_complate_response.dart';


// import 'components/location_list_tile.dart';


// // import 'package:womentaxi/untils/export_file.dart';


// // import 'constants.dart';


// class SearchLocationScreen extends StatefulWidget {

//   const SearchLocationScreen({Key? key}) : super(key: key);


//   @override

//   State<SearchLocationScreen> createState() => _SearchLocationScreenState();

// }


// class _SearchLocationScreenState extends State<SearchLocationScreen> {

//   //////////////////////////////////////////////


//   ApiController apicontroller = Get.put(ApiController());


//   List<AutocompletePrediction> placePredictions = [];


//   ////////////////////////////////////////////


//   ///////////////////////////


//   void placeAutocomplete(String query) async {

//     Uri uri = Uri.https("maps.googleapis.com",

//         'maps/api/place/autocomplete/json', {"input": query, "key": apiKey});


//     String? response = await NetworkUtility.fetchUrl(uri);


//     if (response != null) {

//       PlaceAutocompleteResponse result =

//           PlaceAutocompleteResponse.parseAutocompleteResult(response);


//       // print(response);


//       if (result.predictions != null) {

//         setState(() {

//           placePredictions = result.predictions!;

//         });

//       }

//     }

//   }


//   // for latitude and longitude


//   ///////////////////////////////////////////////////////////////////////////////////


//   UserApiController userapiController = Get.put(UserApiController());


//   void getPlaceDetailsforhistorys(Map selectedOrder) async {

//     setState(() {

//       apicontroller.searchedDataV2latittude.value =

//           selectedOrder["drop"]["coordinates"][1];


//       apicontroller.searchedDataV2longitude.value =

//           selectedOrder["drop"]["coordinates"][0];

//     });


//     apicontroller.updateSearchedDataGmapsV2();


//     // Uri uri = Uri.https("maps.googleapis.com", 'maps/api/place/details/json',


//     //     {"place_id": placeId, "key": apiKey});


//     // String? response = await NetworkUtility.fetchUrl(uri);


//     // if (response != null) {


//     //   var json = jsonDecode(response);


//     //   double lat = json['result']['geometry']['location']['lat'];


//     //   double lng = json['result']['geometry']['location']['lng'];


//     //   // Do something with the latitude and longitude


//     //   apicontroller.updateSearchedDataGmapsV2();


//     //   print("Latitude: $lat, Longitude: $lng");


//     // }

//   }


//   //////////////////////////////////////////////////////////////////////////////


//   double pickupLat = 17.3850; // Example pickup latitude

//   double pickupLng = 78.4867; // Example pickup longitude

//   double dropLat = 13.0827; // Example drop latitude

//   double dropLng = 80.2707; // Exa


//   ServiceController serviceController = Get.put(ServiceController());


//   void getPlaceDetails(String placeId) async {

//     Uri uri = Uri.https("maps.googleapis.com", 'maps/api/place/details/json',

//         {"place_id": placeId, "key": apiKey});


//     String? response = await NetworkUtility.fetchUrl(uri);


//     if (response != null) {

//       var json = jsonDecode(response);


//       double lat = json['result']['geometry']['location']['lat'];


//       double lng = json['result']['geometry']['location']['lng'];


//       setState(() {

//         apicontroller.searchedDataV2latittude.value = lat;


//         apicontroller.searchedDataV2longitude.value = lng;

//       });


// //////////////////////////////////////in city status


//       // Example coordinates (you can replace these with actual user inputs)


//       setState(() {

//         pickupLat = double.parse(serviceController.addressLatitude.value);


//         //serviceController.addressLatitude.value;

//         pickupLng = double.parse(serviceController.addressLongitude.value);

//         dropLat = apicontroller.searchedDataV2latittude.value;

//         dropLng = apicontroller.searchedDataV2longitude.value;

//       });


//       checkCityStatus(pickupLat, pickupLng, dropLat, dropLng);


//       // Do something with the latitude and longitude


//       // apicontroller.updateSearchedDataGmapsV2(); vvip code


//       print("Latitude: $lat, Longitude: $lng");

//     }

//   }


//   UserApiController userapicontroller = Get.put(UserApiController());


//   ////////////////////////


// ///////////////////////////////////////////////////////////////////////////////////////


//   void _handleLocationSelected(LatLng latLng, String address) {

//     setState(() {

//       apicontroller.searchedDataV2.value = address;


//       apicontroller.searchedDataV2latittude.value = latLng.latitude;


//       apicontroller.searchedDataV2longitude.value = latLng.longitude;

//     });


//     // Optional: Update API or other data based on the selected location


//     apicontroller.updateSearchedDataGmapsV2();

//   }


// /////////////////////////////////////////////


// //////////////////////////////////////////////////////////////////////


// //  in city or not


//   String _result = '';


//   Future<void> checkCityStatus(double pickupLat, double pickupLng,

//       double dropLat, double dropLng) async {

//     try {

//       // Get the placemarks for pickup and drop locations


//       List<Placemark> pickupPlacemarks =

//           await placemarkFromCoordinates(pickupLat, pickupLng);


//       List<Placemark> dropPlacemarks =

//           await placemarkFromCoordinates(dropLat, dropLng);


//       String pickupCity = '';


//       String dropCity = '';


//       if (pickupPlacemarks.isNotEmpty) {

//         Placemark pickupPlace = pickupPlacemarks.first;


//         if (pickupPlace.country == 'India' &&

//             pickupPlace.locality != null &&

//             pickupPlace.locality!.isNotEmpty) {

//           pickupCity = pickupPlace.locality!;

//         }

//       }


//       if (dropPlacemarks.isNotEmpty) {

//         Placemark dropPlace = dropPlacemarks.first;


//         if (dropPlace.country == 'India' &&

//             dropPlace.locality != null &&

//             dropPlace.locality!.isNotEmpty) {

//           dropCity = dropPlace.locality!;

//         }

//       }


//       // Determine the result based on the city status of both points


//       if (pickupCity.isNotEmpty && dropCity.isNotEmpty) {

//         if (pickupCity == dropCity) {

//           setState(() {

//             _result = 'Both points are in the city: $pickupCity';

//           });

//         } else {

//           setState(() {

//             _result =

//                 'Pickup point is in $pickupCity, Drop point is in $dropCity';

//           });

//         }

//       } else if (pickupCity.isNotEmpty) {

//         setState(() {

//           _result =

//               'Pickup point is in city: $pickupCity, Drop point is out of cities in India';

//         });

//       } else if (dropCity.isNotEmpty) {

//         setState(() {

//           _result =

//               'Drop point is in city: $dropCity, Pickup point is out of cities in India';

//         });

//       } else {

//         setState(() {

//           _result = 'You are not in a city';

//         });

//       }

//     } catch (e) {

//       setState(() {

//         _result = 'Error occurred: $e';

//       });

//     }

//   }


// //


//   @override

//   Widget build(BuildContext context) {

//     return Scaffold(

//       backgroundColor: Kwhite,

//       appBar: AppBar(

//         backgroundColor: Kwhite,

//         leading: GestureDetector(

//           onTap: () {

//             Get.back();

//           },

//           child: Icon(

//             Icons.arrow_back_ios,

//             color: KTextdark,

//           ),

//         ),

//         titleSpacing: 0,

//         actions: [

//           TextButton(

//             onPressed: () {

//               Get.toNamed(kGmapsSelect);

//             },

//             child: Text(

//               'Select on Map',

//               style: TextStyle(

//                   fontSize: kFourteenFont, color: Kpink, fontWeight: kFW500),

//             ),

//           ),

//         ],

//         title: Text(

//           "Select Drop point",

//           style: TextStyle(fontSize: 18.sp, color: kcarden, fontWeight: kFW600),

//         ),

//       ),

//       body: SingleChildScrollView(

//         child: Container(

//           margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),

//           child: Column(

//             children: [

//               Container(

//                   width: double.infinity,

//                   padding:

//                       EdgeInsets.symmetric(vertical: 10, horizontal: 16.w.h),

//                   decoration: BoxDecoration(

//                       borderRadius: BorderRadius.circular(10.0),

//                       color: Kwhite,

//                       boxShadow: const [

//                         BoxShadow(

//                           color: Color(0x3FD3D1D8),

//                           blurRadius: 30,

//                           offset: Offset(15, 15),

//                           spreadRadius: 0,

//                         )

//                       ]),

//                   child: Column(

//                     children: [

//                       InkWell(

//                         onTap: () {

//                           Fluttertoast.showToast(

//                               msg: 'You cannot change pick up Location');

//                         },

//                         child: Row(

//                           children: [

//                             Image.asset(

//                               "assets/images/location_green.png",

//                               height: 20.h,

//                               fit: BoxFit.cover,

//                             ),

//                             SizedBox(

//                               width: 16.w,

//                             ),

//                             Obx(() => Text(

//                                   serviceController.address.value == "" ||

//                                           serviceController.position == null

//                                       ? "Loading..."

//                                       : serviceController.address.value,

//                                   style: GoogleFonts.roboto(

//                                       fontSize: kFourteenFont,

//                                       color: KdarkText,

//                                       fontWeight: kFW500),

//                                 )),

//                           ],

//                         ),

//                       ),

//                       SizedBox(

//                         height: 12.h,

//                       ),

//                       Divider(),

//                       SizedBox(

//                         height: 1.h,

//                       ),

//                       Row(

//                         children: [

//                           Image.asset(

//                             "assets/images/pink_corner_arrow.png",

//                             height: 16.h,

//                             fit: BoxFit.cover,

//                           ),


//                           SizedBox(

//                             width: 16.w,

//                           ),


//                           Container(

//                               width: 200.w,

//                               child: TextFormField(

//                                 enabled: true,


//                                 style: TextStyle(

//                                     fontSize: 14.sp,

//                                     fontWeight: kFW500,

//                                     color: kblack),


//                                 decoration: InputDecoration(

//                                     hintText: 'Enter drop address',

//                                     hintStyle: TextStyle(

//                                       color: KTextgery,

//                                       fontSize: 14.sp,

//                                       fontWeight: kFW500,

//                                     ),

//                                     border: InputBorder.none,

//                                     contentPadding:

//                                         EdgeInsets.symmetric(vertical: 5)),


//                                 cursorColor: Kpink.withOpacity(

//                                     0.5), // Always show cursor color


//                                 showCursor: true,


//                                 onChanged: (value) {

//                                   placeAutocomplete(value);

//                                 },

//                               ))


//                           // Text(


//                           //   "Enter Drop Location",


//                           //   style: GoogleFonts.roboto(


//                           //       fontSize: kFourteenFont,


//                           //       color: KdarkText,


//                           //       fontWeight: kFW500),


//                           // ),

//                         ],

//                       ),

//                     ],

//                   )),


//               // CustomFormField(


//               //   enabled: true,


//               //   prefix: Padding(


//               //       padding:


//               //           const EdgeInsets.symmetric(vertical: 16, horizontal: 5),


//               //       child: Icon(Icons.search)),


//               //   contentPadding: const EdgeInsets.symmetric(


//               //     vertical: 16,


//               //   ),


//               //   fontSize: kFourteenFont,


//               //   fontWeight: FontWeight.w500,


//               //   hintText: "Search drop location",


//               //   maxLines: 1,


//               //   readOnly: false,


//               //   label: "",


//               //   obscureText: false,


//               //   onChanged: (value) {


//               //     placeAutocomplete(value);


//               //   },


//               //   validator: (value) {},


//               // ),


//               SizedBox(

//                 height: 15.h,

//               ),


//               Obx(

//                 () => Row(

//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,

//                   children: [

//                     userapicontroller.selectedorderlistType == "Ride History"

//                         ? CustomButton(

//                             borderRadius: BorderRadius.circular(15.r),

//                             width: 140.w,

//                             height: 35.h,

//                             Color: Kpink,

//                             textColor: Kwhite,

//                             fontSize: 12.sp,

//                             fontWeight: kFW700,

//                             label: "Ride History",

//                             isLoading: false,

//                             onTap: () {

//                               setState(() {

//                                 userapicontroller.selectedorderlistType.value =

//                                     "Ride History";

//                               });

//                             })

//                         : InkWell(

//                             onTap: () {

//                               setState(() {

//                                 userapicontroller.selectedorderlistType.value =

//                                     "Ride History";

//                               });

//                             },

//                             child: Container(

//                               height: 35,

//                               width: 140.w,

//                               alignment: Alignment.center,

//                               decoration: BoxDecoration(

//                                 color: Kwhite,

//                                 borderRadius: BorderRadius.circular(15.r),

//                               ),

//                               child: Text(

//                                 "Ride History",

//                                 textAlign: TextAlign.center,

//                                 style: GoogleFonts.roboto(

//                                   fontSize: 12.sp,

//                                   fontWeight: kFW700,

//                                   color: KdarkText,

//                                 ),

//                               ),

//                             ),

//                           ),

//                     userapicontroller.selectedorderlistType == "Favourites"

//                         ? CustomButton(

//                             borderRadius: BorderRadius.circular(15.r),

//                             width: 140.w,

//                             height: 35.h,

//                             Color: Kpink,

//                             textColor: Kwhite,

//                             fontSize: 12.sp,

//                             fontWeight: kFW700,

//                             label: "Favourites",

//                             isLoading: false,

//                             onTap: () {

//                               setState(() {

//                                 userapicontroller.selectedorderlistType.value =

//                                     "Favourites";

//                               });

//                             })

//                         : InkWell(

//                             onTap: () {

//                               setState(() {

//                                 userapicontroller.selectedorderlistType.value =

//                                     "Favourites";

//                               });

//                             },

//                             child: Container(

//                               height: 35,

//                               width: 140.w,

//                               alignment: Alignment.center,

//                               decoration: BoxDecoration(

//                                 color: Kwhite,

//                                 borderRadius: BorderRadius.circular(15.r),

//                               ),

//                               child: Text(

//                                 "Favourites",

//                                 textAlign: TextAlign.center,

//                                 style: GoogleFonts.roboto(

//                                   fontSize: 12.sp,

//                                   fontWeight: kFW700,

//                                   color: KdarkText,

//                                 ),

//                               ),

//                             ),

//                           )

//                   ],

//                 ),

//               ),


//               SizedBox(

//                 height: 20.h,

//               ),


//               Divider(

//                 height: 1,

//                 thickness: 1,

//                 color: Kpink.withOpacity(0.5),

//               ),


//               ListView.builder(

//                 itemCount: placePredictions.length,

//                 shrinkWrap: true,

//                 physics: NeverScrollableScrollPhysics(),

//                 itemBuilder: (context, index) => LocationListTile(

//                   press: () {

//                     setState(() {

//                       apicontroller.searchedDataV2.value =

//                           placePredictions[index].description!;

//                     });


//                     getPlaceDetails(placePredictions[index].placeId!);


//                     // apicontroller.updateSearchedDataGmapsV2();

//                   },

//                   location: placePredictions[index].description!,

//                 ),

//               ),


//               userapicontroller.selectedorderlistType == "Ride History"

//                   ? Obx(() => userapiController.userOrdersDataLoading == true

//                       ? Container(

//                           alignment: Alignment.center,

//                           margin: EdgeInsets.only(top: 100.h),

//                           child: CircularProgressIndicator(

//                             color: Kpink,

//                           ),

//                         )

//                       : userapiController.userOrders.isEmpty ||

//                               userapiController.userOrders == null

//                           ? Text(

//                               "No Orders",

//                               style: GoogleFonts.roboto(

//                                   fontSize: kSixteenFont,

//                                   color: KdarkText,

//                                   fontWeight: kFW500),

//                             )

//                           : ListView.builder(

//                               padding: EdgeInsets.zero,

//                               shrinkWrap: true,

//                               physics: NeverScrollableScrollPhysics(),

//                               itemCount: userapiController.userOrders.length,

//                               itemBuilder: (context, index) {

//                                 return Column(

//                                   children: [

//                                     /////////////////////////////////////


//                                     Column(

//                                       children: [

//                                         ListTile(

//                                             onTap: () {

//                                               setState(() {

//                                                 apicontroller.searchedDataV2

//                                                     .value = userapiController

//                                                             .userOrders[index]

//                                                         ["dropAddress"] ??

//                                                     "";


//                                                 // placePredictions[index].description!;

//                                               });


//                                               getPlaceDetailsforhistorys(

//                                                   userapiController

//                                                       .userOrders[index]);


//                                               // apicontroller.updateSearchedDataGmapsV2();

//                                             },

//                                             horizontalTitleGap: 3,

//                                             leading: CircleAvatar(

//                                                 backgroundColor:

//                                                     Kpink.withOpacity(0.5),

//                                                 radius: 16.r,

//                                                 child: Icon(

//                                                   Icons.location_on,

//                                                   color: Kpink,

//                                                   size: 20.sp,

//                                                 )),

//                                             title: Text(

//                                               userapiController

//                                                       .userOrders[index]

//                                                   ["dropAddress"],

//                                               maxLines: 2,

//                                               overflow: TextOverflow.ellipsis,

//                                             ),

//                                             trailing: Obx(() =>

//                                                 userapiController.userOrders[

//                                                                 index]

//                                                             ["favorite"] ==

//                                                         false

//                                                     ? InkWell(

//                                                         onTap: () {

//                                                           userapicontroller

//                                                               .userAddtoFavouriteinHistory(

//                                                                   userapiController

//                                                                               .userOrders[

//                                                                           index]

//                                                                       ["_id"]);

//                                                         },

//                                                         child: Icon(

//                                                           Icons

//                                                               .favorite_outline,


//                                                           color: KlightText,


//                                                           //  Kpink.withOpacity(


//                                                           //   0.5,


//                                                           size: 18.sp,

//                                                         ),

//                                                       )

//                                                     : InkWell(

//                                                         onTap: () {

//                                                           userapicontroller

//                                                               .userAddtoFavouriteinHistory(

//                                                                   userapiController

//                                                                               .userOrders[

//                                                                           index]

//                                                                       ["_id"]);

//                                                         },

//                                                         child: Icon(

//                                                           Icons.favorite,


//                                                           color: Kpink,


//                                                           //  Kpink.withOpacity(


//                                                           //   0.5,


//                                                           size: 18.sp,

//                                                         ),

//                                                       ))),

//                                         Divider(

//                                           height: 1,

//                                           thickness: 1,

//                                           color: KdarkText.withOpacity(0.2),

//                                         ),

//                                       ],

//                                     ),


//                                     ///////////////////////////


//                                     // InkWell(


//                                     //   onTap: () {


//                                     //     setState(() {


//                                     //       apicontroller.searchedDataV2.value =


//                                     //           userapiController.userOrders[index]


//                                     //                   ["dropAddress"] ??


//                                     //               "";


//                                     //       // placePredictions[index].description!;


//                                     //     });


//                                     //     getPlaceDetailsforhistorys(


//                                     //         userapiController.userOrders[index]);


//                                     //     // apicontroller.updateSearchedDataGmapsV2();


//                                     //   },


//                                     //   child:


//                                     //   Container(


//                                     //     margin: EdgeInsets.only(top: 12.h),


//                                     //     width: double.infinity,


//                                     //     padding: EdgeInsets.all(10.r),


//                                     //     decoration: BoxDecoration(


//                                     //       boxShadow: [


//                                     //         BoxShadow(


//                                     //           color: Ktextcolor.withOpacity(0.5),


//                                     //           blurRadius: 5.r,


//                                     //           offset: Offset(1, 1),


//                                     //           spreadRadius: 1.r,


//                                     //         )


//                                     //       ],


//                                     //       color: Kwhite,


//                                     //       borderRadius: BorderRadius.circular(10.r),


//                                     //     ),


//                                     //     child: Row(


//                                     //       mainAxisAlignment:


//                                     //           MainAxisAlignment.spaceAround,


//                                     //       crossAxisAlignment:


//                                     //           CrossAxisAlignment.start,


//                                     //       children: [


//                                     //         Icon(


//                                     //           Icons.location_searching,


//                                     //           color: Kpink.withOpacity(


//                                     //             0.5,


//                                     //           ),


//                                     //           size: 18.sp,


//                                     //         ),


//                                     //         Column(


//                                     //           mainAxisAlignment:


//                                     //               MainAxisAlignment.start,


//                                     //           crossAxisAlignment:


//                                     //               CrossAxisAlignment.start,


//                                     //           children: [


//                                     //             SizedBox(


//                                     //               width: 150.w,


//                                     //               child: Text(


//                                     //                 userapiController


//                                     //                         .userOrders[index]


//                                     //                     ["dropAddress"],


//                                     //                 // userapiController


//                                     //                 //             .userSavedOrders[


//                                     //                 //         index]["dropAddress"] ??


//                                     //                 //     "",


//                                     //                 maxLines: 1,


//                                     //                 overflow: TextOverflow.ellipsis,


//                                     //                 style: GoogleFonts.roboto(


//                                     //                     fontSize: kSixteenFont,


//                                     //                     color: kcarden,


//                                     //                     fontWeight: kFW500),


//                                     //               ),


//                                     //             ),


//                                     //             SizedBox(


//                                     //               height: 8.h,


//                                     //             ),


//                                     //             SizedBox(


//                                     //               width: 200.w,


//                                     //               child: Text(


//                                     //                 userapiController


//                                     //                         .userOrders[index]


//                                     //                     ["pickupAddress"],


//                                     //                 // userapiController


//                                     //                 //                 .userSavedOrders[


//                                     //                 //             index]


//                                     //                 //         ["pickupAddress"] ??


//                                     //                 //     "",


//                                     //                 //     "Survey No. 1050, Balanagar Mandal, Rd Number 3, Kukatpally Housing Board Colony, Kukatpally, Hyderabad, Telangana 500072",


//                                     //                 maxLines: 1,


//                                     //                 overflow: TextOverflow.ellipsis,


//                                     //                 style: GoogleFonts.roboto(


//                                     //                     fontSize: kTwelveFont,


//                                     //                     color: Ktextcolor,


//                                     //                     fontWeight: kFW500),


//                                     //               ),


//                                     //             ),


//                                     //           ],


//                                     //         ),


//                                     //         // userAddtoFavourite


//                                     //         // userapiController.userSavedOrders[index]


//                                     //         Obx(() =>


//                                     //             userapiController.userOrders[index]


//                                     //                         ["favorite"] ==


//                                     //                     false


//                                     //                 ? InkWell(


//                                     //                     onTap: () {


//                                     //                       userapicontroller


//                                     //                           .userAddtoFavouriteinHistory(


//                                     //                               userapiController


//                                     //                                       .userOrders[


//                                     //                                   index]["_id"]);


//                                     //                     },


//                                     //                     child: Icon(


//                                     //                       Icons.favorite_outline,


//                                     //                       color: KlightText,


//                                     //                       //  Kpink.withOpacity(


//                                     //                       //   0.5,


//                                     //                       size: 18.sp,


//                                     //                     ),


//                                     //                   )


//                                     //                 : InkWell(


//                                     //                     onTap: () {


//                                     //                       userapicontroller


//                                     //                           .userAddtoFavouriteinHistory(


//                                     //                               userapiController


//                                     //                                       .userOrders[


//                                     //                                   index]["_id"]);


//                                     //                     },


//                                     //                     child: Icon(


//                                     //                       Icons.favorite,


//                                     //                       color: Kpink,


//                                     //                       //  Kpink.withOpacity(


//                                     //                       //   0.5,


//                                     //                       size: 18.sp,


//                                     //                     ),


//                                     //                   ))


//                                     //       ],


//                                     //     ),


//                                     //   ),


//                                     // ),

//                                   ],

//                                 );

//                               }))

//                   : Obx(() => userapiController.favouriteOrdersDataLoading ==

//                           true

//                       ? Container(

//                           alignment: Alignment.center,

//                           margin: EdgeInsets.only(top: 100.h),

//                           child: CircularProgressIndicator(

//                             color: Kpink,

//                           ),

//                         )

//                       : userapiController.favouriteOrders.isEmpty ||

//                               userapiController.favouriteOrders == null

//                           ? Text(

//                               "",

//                               style: GoogleFonts.roboto(

//                                   fontSize: kSixteenFont,

//                                   color: KdarkText,

//                                   fontWeight: kFW500),

//                             )

//                           : ListView.builder(

//                               padding: EdgeInsets.zero,

//                               shrinkWrap: true,

//                               physics: NeverScrollableScrollPhysics(),

//                               itemCount:

//                                   userapiController.favouriteOrders.length,

//                               itemBuilder: (context, index) {

//                                 return Column(

//                                   children: [

//                                     Column(

//                                       children: [

//                                         ListTile(

//                                             onTap: () {

//                                               setState(() {

//                                                 apicontroller.searchedDataV2

//                                                     .value = userapiController

//                                                             .favouriteOrders[

//                                                         index]["dropAddress"] ??

//                                                     "";


//                                                 // placePredictions[index].description!;

//                                               });


//                                               getPlaceDetailsforhistorys(

//                                                   userapiController

//                                                       .favouriteOrders[index]);


//                                               // apicontroller.updateSearchedDataGmapsV2();

//                                             },

//                                             horizontalTitleGap: 3,

//                                             leading: CircleAvatar(

//                                                 backgroundColor:

//                                                     Kpink.withOpacity(0.5),

//                                                 radius: 16.r,

//                                                 child: Icon(

//                                                   Icons.location_on,

//                                                   color: Kpink,

//                                                   size: 20.sp,

//                                                 )),

//                                             title: Text(

//                                               userapiController

//                                                       .favouriteOrders[index]

//                                                   ["dropAddress"],

//                                               maxLines: 2,

//                                               overflow: TextOverflow.ellipsis,

//                                             ),

//                                             trailing: Obx(() => userapiController

//                                                             .favouriteOrders[

//                                                         index]["favorite"] ==

//                                                     false

//                                                 ? InkWell(

//                                                     onTap: () {

//                                                       userapicontroller

//                                                           .userAddtoFavouriteinFavouritesList(

//                                                               userapiController

//                                                                       .favouriteOrders[

//                                                                   index]["_id"]);

//                                                     },

//                                                     child: Icon(

//                                                       Icons.favorite_outline,


//                                                       color: KlightText,


//                                                       //  Kpink.withOpacity(


//                                                       //   0.5,


//                                                       size: 18.sp,

//                                                     ),

//                                                   )

//                                                 : InkWell(

//                                                     onTap: () {

//                                                       userapicontroller

//                                                           .userAddtoFavouriteinFavouritesList(

//                                                               userapiController

//                                                                       .favouriteOrders[

//                                                                   index]["_id"]);

//                                                     },

//                                                     child: Icon(

//                                                       Icons.favorite,


//                                                       color: Kpink,


//                                                       //  Kpink.withOpacity(


//                                                       //   0.5,


//                                                       size: 18.sp,

//                                                     ),

//                                                   ))),

//                                         Divider(

//                                           height: 1,

//                                           thickness: 1,

//                                           color: KdarkText.withOpacity(0.2),

//                                         ),

//                                       ],

//                                     ),


//                                     // InkWell(


//                                     //   onTap: () {


//                                     //     setState(() {


//                                     //       apicontroller.searchedDataV2.value =


//                                     //           userapiController


//                                     //                       .favouriteOrders[index]


//                                     //                   ["dropAddress"] ??


//                                     //               "";


//                                     //       // placePredictions[index].description!;


//                                     //     });


//                                     //     getPlaceDetailsforhistorys(userapiController


//                                     //         .favouriteOrders[index]);


//                                     //     // apicontroller.updateSearchedDataGmapsV2();


//                                     //   },


//                                     //   child: Container(


//                                     //     margin: EdgeInsets.only(top: 12.h),


//                                     //     width: double.infinity,


//                                     //     padding: EdgeInsets.all(10.r),


//                                     //     decoration: BoxDecoration(


//                                     //       boxShadow: [


//                                     //         BoxShadow(


//                                     //           color: Ktextcolor.withOpacity(0.5),


//                                     //           blurRadius: 5.r,


//                                     //           offset: Offset(1, 1),


//                                     //           spreadRadius: 1.r,


//                                     //         )


//                                     //       ],


//                                     //       color: Kwhite,


//                                     //       borderRadius: BorderRadius.circular(10.r),


//                                     //     ),


//                                     //     child: Row(


//                                     //       mainAxisAlignment:


//                                     //           MainAxisAlignment.spaceAround,


//                                     //       crossAxisAlignment:


//                                     //           CrossAxisAlignment.start,


//                                     //       children: [


//                                     //         Icon(


//                                     //           Icons.location_searching,


//                                     //           color: Kpink.withOpacity(


//                                     //             0.5,


//                                     //           ),


//                                     //           size: 18.sp,


//                                     //         ),


//                                     //         Column(


//                                     //           mainAxisAlignment:


//                                     //               MainAxisAlignment.start,


//                                     //           crossAxisAlignment:


//                                     //               CrossAxisAlignment.start,


//                                     //           children: [


//                                     //             SizedBox(


//                                     //               width: 150.w,


//                                     //               child: Text(


//                                     //                 userapiController


//                                     //                         .favouriteOrders[index]


//                                     //                     ["dropAddress"],


//                                     //                 // userapiController


//                                     //                 //             .userSavedOrders[


//                                     //                 //         index]["dropAddress"] ??


//                                     //                 //     "",


//                                     //                 maxLines: 1,


//                                     //                 overflow: TextOverflow.ellipsis,


//                                     //                 style: GoogleFonts.roboto(


//                                     //                     fontSize: kSixteenFont,


//                                     //                     color: kcarden,


//                                     //                     fontWeight: kFW500),


//                                     //               ),


//                                     //             ),


//                                     //             SizedBox(


//                                     //               height: 8.h,


//                                     //             ),


//                                     //             SizedBox(


//                                     //               width: 200.w,


//                                     //               child: Text(


//                                     //                 userapiController


//                                     //                         .favouriteOrders[index]


//                                     //                     ["pickupAddress"],


//                                     //                 maxLines: 1,


//                                     //                 overflow: TextOverflow.ellipsis,


//                                     //                 style: GoogleFonts.roboto(


//                                     //                     fontSize: kTwelveFont,


//                                     //                     color: Ktextcolor,


//                                     //                     fontWeight: kFW500),


//                                     //               ),


//                                     //             ),


//                                     //           ],


//                                     //         ),


//                                     //         // userAddtoFavourite


//                                     //         // userapiController.userSavedOrders[index]


//                                     //         Obx(() => userapiController


//                                     //                         .favouriteOrders[index]


//                                     //                     ["favorite"] ==


//                                     //                 false


//                                     //             ? InkWell(


//                                     //                 onTap: () {


//                                     //                   userapicontroller


//                                     //                       .userAddtoFavouriteinFavouritesList(


//                                     //                           userapiController


//                                     //                                   .favouriteOrders[


//                                     //                               index]["_id"]);


//                                     //                 },


//                                     //                 child: Icon(


//                                     //                   Icons.favorite_outline,


//                                     //                   color: KlightText,


//                                     //                   //  Kpink.withOpacity(


//                                     //                   //   0.5,


//                                     //                   size: 18.sp,


//                                     //                 ),


//                                     //               )


//                                     //             : InkWell(


//                                     //                 onTap: () {


//                                     //                   userapicontroller


//                                     //                       .userAddtoFavouriteinFavouritesList(


//                                     //                           userapiController


//                                     //                                   .favouriteOrders[


//                                     //                               index]["_id"]);


//                                     //                 },


//                                     //                 child: Icon(


//                                     //                   Icons.favorite,


//                                     //                   color: Kpink,


//                                     //                   //  Kpink.withOpacity(


//                                     //                   //   0.5,


//                                     //                   size: 18.sp,


//                                     //                 ),


//                                     //               ))


//                                     //       ],


//                                     //     ),


//                                     //   ),


//                                     // ),

//                                   ],

//                                 );

//                               })),

//             ],

//           ),

//         ),

//       ),

//     );

//   }

// }

