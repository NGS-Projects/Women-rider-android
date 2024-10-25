import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:womentaxi/untils/export_file.dart';

class UserCompleteScreen extends StatefulWidget {
  const UserCompleteScreen({super.key});

  @override
  State<UserCompleteScreen> createState() => _UserCompleteScreenState();
}

class _UserCompleteScreenState extends State<UserCompleteScreen> {
  ApiController apicontroller = Get.put(ApiController());
  UserApiController userapicontroller = Get.put(UserApiController());
  ApiController authentication = Get.put(ApiController());
  int _rating = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 60.h),
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Kwhite,
                boxShadow: [
                  BoxShadow(
                    color: KdarkText.withOpacity(0.2),
                    blurRadius: 2,
                    offset: Offset(5, 5),
                    spreadRadius: 1,
                  )
                ]),
            child: Text(
              "Your Ride is Completed!",

              style: GoogleFonts.roboto(
                  fontSize: 28.sp, color: Kpink, fontWeight: kFW500),
              // GoogleFonts.roboto(
              //     fontSize: kFourteenFont,
              //     color: KdarkText,
              //     fontWeight: kFW500),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.r),
            child: Column(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      userapicontroller.userAddtoFavourite(
                                          userapicontroller.lastPlacedId.value
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
                                  userapicontroller.listenOrders["order"]
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
                                  userapicontroller.listenOrders["order"]
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userapicontroller.listenOrders["order"]
                                          ["distance"] ??
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userapicontroller.listenOrders["order"]
                                          ["rideTime"] ??
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: EdgeInsets.only(left: 2, top: 2),
                          margin: EdgeInsets.only(right: 40),
                          child: CircleAvatar(
                            backgroundColor: Kwhite,
                            radius: 30.r,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(200.r),
                              child:
                                  // userapicontroller
                                  //                     .listenOrders[
                                  //                 "acceptCaptain"]
                                  userapicontroller.listenOrders["order"]
                                              ["acceptCaptain"]["profilePic"] ==
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
                                                BorderRadius.circular(200.r),
                                            child: CachedNetworkImage(
                                              imageUrl: kBaseImageUrl +
                                                  userapicontroller
                                                                  .listenOrders[
                                                              "order"]
                                                          ["acceptCaptain"]
                                                      // userapicontroller
                                                      //             .listenOrders[
                                                      //         "acceptCaptain"]
                                                      ["profilePic"],
                                              // authentication
                                              //     .profileData["profile"],
                                              placeholder: (context, url) =>
                                                  SizedBox(
                                                height: 100.h,
                                                width: 100.w,
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.black12,
                                                  highlightColor: Colors.white
                                                      .withOpacity(0.5),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Kwhite.withOpacity(
                                                          0.5),
                                                    ),
                                                    height: 100.h,
                                                    width: 100.w,
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      CircleAvatar(
                                                backgroundColor: Kwhite,
                                                radius: 50.r,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          200.r),
                                                  child: Image.asset(
                                                    "assets/images/profileImageStatic.png",
                                                    // height: 150.h,
                                                    height: 100.h,
                                                    width: 100.w,
                                                    fit: BoxFit.cover,
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
                                userapicontroller.listenOrders["order"]
                                            ["vehicleType"] ==
                                        "scooty"
                                    ? "assets/images/scooty_anime.png"
                                    // ? "assets/images/pink_scooty.jpeg"
                                    : userapicontroller.listenOrders["order"]
                                                ["vehicleType"] ==
                                            "cab"
                                        ? "assets/images/car_anime.png"
                                        // ? "assets/images/pink_car.jpeg"
                                        : userapicontroller
                                                        .listenOrders["order"]
                                                    ["vehicleType"] ==
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              apicontroller.captainVehicleNumberCorrect.value =
                                  true;
                            });
                          },
                          child: Text(
                            "Yes",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.roboto(
                                fontSize: kSixteenFont,
                                color: apicontroller.captainVehicleNumberCorrect
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
                              apicontroller.captainVehicleNumberCorrect.value =
                                  false;
                            });
                          },
                          child: Text(
                            "No",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.roboto(
                                fontSize: kSixteenFont,
                                color: apicontroller.captainVehicleNumberCorrect
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
                      fontSize: 17.sp, color: KdarkText, fontWeight: kFW400),
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
                  controller: authentication.registerDonorfirstNameController,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
                            .registerDonorfirstNameController.text,
                        "giveVehicleNumber":
                            apicontroller.captainVehicleNumberCorrect.value
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
            ),
          ),
        ],
      ),
    );
  }
}
