import 'package:flutter/material.dart';

import 'package:womentaxi/untils/export_file.dart';

class SelectFlow extends StatefulWidget {
  const SelectFlow({super.key});

  @override
  State<SelectFlow> createState() => _SelectFlowState();
}

class _SelectFlowState extends State<SelectFlow> {
  ApiController apiController = Get.put(ApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPinkBackGroundColur,
      // backgroundColor: Kpink.withOpacity(0.5),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/women_halt.jpg",
              // "assets/images/pinkCar.png",
              height: MediaQuery.of(context).size.height / 2.3,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 16.h,
            ),
            // GestureDetector(
            //   onTap: () {
            //     Get.toNamed(kRazorPay);
            //   },
            //   child: Container(
            //     margin: EdgeInsets.only(left: 16.w),
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       "Please select app type below...",
            //       style: GoogleFonts.roboto(
            //           fontSize: kFourteenFont,
            //           color: Kwhite,
            //           fontWeight: kFW400),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 16.h,
            // ),
            GestureDetector(
              onTap: () {
                Get.toNamed(kNewSignUpScreen);
                // Get.toNamed(kpaymentsScreen);
              },
              child: Container(
                margin: EdgeInsets.only(left: 16.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Please select app below...",
                  style: GoogleFonts.roboto(
                      fontSize: kFourteenFont,
                      color: Kpink,
                      fontWeight: kFW400),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(kNewPhoneScreen);
                // Get.toNamed(kpaymentsScreen);
              },
              child: Container(
                margin: EdgeInsets.only(left: 16.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Phone Number",
                  style: GoogleFonts.roboto(
                      fontSize: kFourteenFont,
                      color: Kpink,
                      fontWeight: kFW400),
                ),
              ),
            ),

            SizedBox(
              height: 30.h,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  apiController.selectedRegisterType.value = "captain";
                  print(apiController.selectedRegisterType.value);
                });
                Get.toNamed(KMobileRegistration);
              },
              child: Container(
                height: 50.h,
                padding: EdgeInsets.all(15.r),
                margin: EdgeInsets.all(16.r),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Kwhite,
                    boxShadow: [
                      BoxShadow(
                        color: Kpink.withOpacity(0.2),
                        blurRadius: 2.r,
                        offset: Offset(1, 1),
                        spreadRadius: 1.r,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "",
                      style: GoogleFonts.roboto(
                          fontSize: kSixteenFont,
                          color: Kpink,
                          fontWeight: kFW500),
                    ),
                    Text(
                      "Rider",
                      style: GoogleFonts.roboto(
                          fontSize: kSixteenFont,
                          color: Kpink,
                          fontWeight: kFW500),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Kpink,
                    )
                  ],
                ),
              ),
            ),
            // CustomButton(
            //     width: 250.w,
            //     height: 42.h,
            //     fontSize: kFourteenFont,
            //     fontWeight: kFW700,
            //     textColor: Kwhite,
            //     borderRadius: BorderRadius.circular(30.r),
            //     label: "Captain",
            //     isLoading: false,
            //     onTap: () async {
            //       Get.toNamed(KMobileRegistration);
            //       //  Get.toNamed(kArrivedScreen);
            //       //  KOtpVerification
            //       //  await Get.toNamed(kOtpVerify);
            //     }),

            SizedBox(
              height: 30.h,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  apiController.selectedRegisterType.value = "user";
                  print(apiController.selectedRegisterType.value);
                });
                Get.toNamed(KMobileRegistration);
                // Get.toNamed(kUserPhoneRegister);
              },
              child: Container(
                height: 50.h,
                padding: EdgeInsets.all(15.r),
                margin: EdgeInsets.all(16.r),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Kwhite,
                    boxShadow: [
                      BoxShadow(
                        color: Kpink.withOpacity(0.2),
                        blurRadius: 2.r,
                        offset: Offset(1, 1),
                        spreadRadius: 1.r,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "",
                      style: GoogleFonts.roboto(
                          fontSize: kSixteenFont,
                          color: Kwhite,
                          fontWeight: kFW500),
                    ),
                    Text(
                      "User",
                      style: GoogleFonts.roboto(
                          fontSize: kSixteenFont,
                          color: Kpink,
                          fontWeight: kFW500),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Kpink,
                    )
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 15.h,
            // ),
            // InkWell(
            //   onTap: () {
            //     Get.toNamed(kCitySearchScreen);
            //   },
            //   child: Text(
            //     "City Search",
            //     style: GoogleFonts.roboto(
            //         fontSize: kFourteenFont, color: Kpink, fontWeight: kFW400),
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Get.toNamed(kSearchPlacesV2);
            //     // Get.toNamed(kpaymentsScreen);
            //   },
            //   child: Container(
            //     margin: EdgeInsets.only(left: 16.w),
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       "Gmaps place",
            //       style: GoogleFonts.roboto(
            //           fontSize: kFourteenFont,
            //           color: Kwhite,
            //           fontWeight: kFW400),
            //     ),
            //   ),
            // ),

// kRouteGMapsTestScreen
            // SizedBox(
            //   height: 50.h,
            // ),
            // CustomButton(
            //     width: 250.w,
            //     height: 42.h,
            //     fontSize: kFourteenFont,
            //     fontWeight: kFW700,
            //     textColor: Kwhite,
            //     borderRadius: BorderRadius.circular(30.r),
            //     label: "Biometric",
            //     isLoading: false,
            //     onTap: () async {
            //       Get.toNamed(kFacialBiometric);
            //       //  KOtpVerification
            //       // Get.toNamed(kUserPhoneRegister);
            //     }),

            // SizedBox(
            //   height: 50.h,
            // ),
            // CustomButton(
            //     width: 250.w,
            //     height: 42.h,
            //     fontSize: kFourteenFont,
            //     fontWeight: kFW700,
            //     textColor: Kwhite,
            //     borderRadius: BorderRadius.circular(30.r),
            //     label: "Map Tracking",
            //     isLoading: false,
            //     onTap: () async {
            //       //  KOtpVerification
            //       Get.toNamed(kTrackingScreen);
            //     }),
            // SizedBox(
            //   height: 10.h,
            // ),
            // CustomButton(
            //     width: 250.w,
            //     height: 42.h,
            //     fontSize: kFourteenFont,
            //     fontWeight: kFW700,
            //     textColor: Kwhite,
            //     borderRadius: BorderRadius.circular(30.r),
            //     label: "Map Tracking",
            //     isLoading: false,
            //     onTap: () async {
            //       //  KOtpVerification
            //       Get.toNamed(kLauncherScreen);
            //     }),
            // SizedBox(
            //   height: 10.h,
            // ),
            // CustomButton(
            //     width: 250.w,
            //     height: 42.h,
            //     fontSize: kFourteenFont,
            //     fontWeight: kFW700,
            //     textColor: Kwhite,
            //     borderRadius: BorderRadius.circular(30.r),
            //     label: "Map  Merg",
            //     isLoading: false,
            //     onTap: () async {
            //       //  KOtpVerification
            //       Get.toNamed(kMergeMapplsScreen);
            //     }),
            // SizedBox(
            //   height: 10.h,
            // ),
            // CustomButton(
            //     width: 250.w,
            //     height: 42.h,
            //     fontSize: kFourteenFont,
            //     fontWeight: kFW700,
            //     textColor: Kwhite,
            //     borderRadius: BorderRadius.circular(30.r),
            //     label: "Add Poliline",
            //     isLoading: false,
            //     onTap: () async {
            //       //  KOtpVerification
            //       Get.toNamed(kMappleLocationScreen);
            //     }),
            //
          ],
        ),
      ),
    );
  }
}
// kMappleLocationScreen


