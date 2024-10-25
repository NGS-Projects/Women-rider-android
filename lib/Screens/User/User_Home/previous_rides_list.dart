import 'package:womentaxi/untils/export_file.dart';

class FavouritesList extends StatefulWidget {
  const FavouritesList({super.key});

  @override
  State<FavouritesList> createState() => _FavouritesListState();
}

class _FavouritesListState extends State<FavouritesList> {
  UserApiController userapicontroller = Get.put(UserApiController());
  UserApiController userapiController = Get.put(UserApiController());
  ////////////////////
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

  ////////////////
  @override
  void initState() {
    userapicontroller.getUserfavourites();
    // TODO: implement initState
    super.initState();
  }

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
            "Favourite List",
            style: GoogleFonts.roboto(
                fontSize: kEighteenFont, fontWeight: kFW500, color: kcarden),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.all(15.w),
          child: 
          Obx(() => userapiController.favouriteOrdersDataLoading == true
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
                      itemCount: userapiController.favouriteOrders.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              apicontroller.searchedDataV2.value =
                                  userapiController.favouriteOrders[index]
                                          ["dropAddress"] ??
                                      "";
                              // placePredictions[index].description!;
                            });

                            getPlaceDetails(
                                userapiController.favouriteOrders[index]);

                            // apicontroller.updateSearchedDataGmapsV2();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 12.h),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_searching,
                                  color: Kpink.withOpacity(
                                    0.5,
                                  ),
                                  size: 18.sp,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150.w,
                                      child: Text(
                                        userapiController.favouriteOrders[index]
                                            ["dropAddress"],
                                        // userapiController
                                        //             .userSavedOrders[
                                        //         index]["dropAddress"] ??
                                        //     "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                            fontSize: kSixteenFont,
                                            color: kcarden,
                                            fontWeight: kFW500),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    SizedBox(
                                      width: 200.w,
                                      child: Text(
                                        userapiController.favouriteOrders[index]
                                            ["pickupAddress"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                            fontSize: kTwelveFont,
                                            color: Ktextcolor,
                                            fontWeight: kFW500),
                                      ),
                                    ),
                                  ],
                                ),
                                // userAddtoFavourite
                                // userapiController.userSavedOrders[index]
                                Obx(() =>
                                    userapiController.favouriteOrders[index]
                                                ["favorite"] ==
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
                                          ))
                              ],
                            ),
                          ),
                        );
                      })),
      
        )));
  }
}

// class FavouritesList extends StatefulWidget {
//   const FavouritesList({super.key});

//   @override
//   State<FavouritesList> createState() => _FavouritesListState();
// }

// UserApiController userapiController = Get.put(UserApiController());

// class _FavouritesListState extends State<FavouritesList> {
//   @override
//   void initState() {
//     userapiController.getUserfavourites();
//     // TODO: implement initState
//     super.initState();
//   }

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
//           "Rides History",
//           style: GoogleFonts.roboto(
//               fontSize: kEighteenFont, fontWeight: kFW500, color: kcarden),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//             margin: EdgeInsets.all(15.w),
//             child: Obx(
//               () => userapiController.userOrdersDataLoading == true
//                   ? Container(
//                       alignment: Alignment.center,
//                       margin: EdgeInsets.only(top: 100.h),
//                       child: CircularProgressIndicator(
//                         color: Kpink,
//                       ),
//                     )
//                   : userapiController.userOrders.isEmpty ||
//                           userapiController.userOrders == null
//                       ? Text(
//                           "No Orders",
//                           style: GoogleFonts.roboto(
//                               fontSize: kSixteenFont,
//                               color: KdarkText,
//                               fontWeight: kFW500),
//                         )
//                       : ListView.builder(
//                           padding: EdgeInsets.zero,
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: userapiController.userOrders.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               margin: EdgeInsets.only(bottom: 12.h),
//                               width: double.infinity,
//                               padding: EdgeInsets.all(10.r),
//                               decoration: BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Ktextcolor.withOpacity(0.5),
//                                     blurRadius: 5.r,
//                                     offset: Offset(1, 1),
//                                     spreadRadius: 1.r,
//                                   )
//                                 ],
//                                 color: Kwhite,
//                                 borderRadius: BorderRadius.circular(10.r),
//                               ),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.motorcycle,
//                                         color: Kpink.withOpacity(
//                                           0.5,
//                                         ),
//                                         size: 24.sp,
//                                       ),
//                                       SizedBox(
//                                         width: 10.w,
//                                       ),
//                                       SizedBox(
//                                         width: 200.w,
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "325,HMT HILLS,Kukatpally",
//                                               style: GoogleFonts.roboto(
//                                                   fontSize: kSixteenFont,
//                                                   color: kcarden,
//                                                   fontWeight: kFW500),
//                                             ),
//                                             SizedBox(
//                                               height: 15.h,
//                                             ),
//                                             SizedBox(
//                                               width: 270.w,
//                                               child: Text(
//                                                 userapiController
//                                                             .userOrders[index]
//                                                         ["orderPlaceDate"] ??
//                                                     "" +
//                                                         " -   " +
//                                                         userapiController
//                                                                     .userOrders[
//                                                                 index][
//                                                             "orderPlaceTime"] ??
//                                                     "",
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: GoogleFonts.roboto(
//                                                     fontSize: kTwelveFont,
//                                                     color: Ktextcolor,
//                                                     fontWeight: kFW500),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 10.h,
//                                             ),
//                                             Text(
//                                               userapiController
//                                                           .userOrders[index]
//                                                       ["status"] ??
//                                                   "",
//                                               style: GoogleFonts.roboto(
//                                                   fontSize: kTwelveFont,
//                                                   color: KlightText,
//                                                   fontWeight:
//                                                       kFW500), // KlightText
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Icon(
//                                     Icons.keyboard_arrow_right,
//                                     color: Kpink.withOpacity(
//                                       0.5,
//                                     ),
//                                     size: 24.sp,
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }),
//             )),
//       ),
//     );
//   }
// }
