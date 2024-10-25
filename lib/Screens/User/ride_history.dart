import 'package:womentaxi/untils/export_file.dart';

class RideHistory extends StatefulWidget {
  const RideHistory({super.key});

  @override
  State<RideHistory> createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
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
    userapiController.getUserOrders();
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
          "Rides History",
          style: GoogleFonts.roboto(
              fontSize: kEighteenFont, fontWeight: kFW500, color: kcarden),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(15.w),
            child: 
            Obx(() => userapiController.userOrdersDataLoading == true
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
                    : Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: userapiController.userOrders.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                apicontroller.searchedDataV2.value =
                                    userapiController.userOrders[index]
                                            ["dropAddress"] ??
                                        "";
                                // placePredictions[index].description!;
                              });

                              getPlaceDetails(
                                  userapiController.userOrders[index]);

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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        child: Text(
                                          userapiController.userOrders[index]
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
                                          userapiController.userOrders[index]
                                              ["pickupAddress"],
                                          // userapiController
                                          //                 .userSavedOrders[
                                          //             index]
                                          //         ["pickupAddress"] ??
                                          //     "",
                                          //     "Survey No. 1050, Balanagar Mandal, Rd Number 3, Kukatpally Housing Board Colony, Kukatpally, Hyderabad, Telangana 500072",
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
                                  Obx(() => userapiController.userOrders[index]
                                              ["favorite"] ==
                                          false
                                      ? InkWell(
                                          onTap: () {
                                            userapicontroller
                                                .userAddtoFavouriteinHistory(
                                                    userapiController
                                                            .userOrders[index]
                                                        ["_id"]);
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
                                                .userAddtoFavouriteinHistory(
                                                    userapiController
                                                            .userOrders[index]
                                                        ["_id"]);
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
                        })))
                        ),
     
      ),
    );
  }
}
