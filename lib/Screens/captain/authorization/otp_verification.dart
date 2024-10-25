import 'dart:async';

import 'package:womentaxi/untils/export_file.dart';

class OtpVerify extends StatefulWidget {
  const OtpVerify({super.key});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  ApiController authentication = Get.put(ApiController());
  ApiController apiController = Get.put(ApiController());
  TextEditingController _otpController = TextEditingController();

  var phoneNumber = Get.arguments;
  String? selectedValue;
  bool passwordVisible = true;
  bool confirmpasswordVisible = true;
  int _seconds = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    setState(() {
      authentication.timerOn.value = true;
    });
    debugPrint("hi");
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          setState(() {
            authentication.timerOn.value = false;
          });
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            bottom: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 38.w,
                  height: 38.h,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    left: 2.w,
                  ),
                  // height: 47.88,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Kwhite,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(23.94),
                    // ),
                    boxShadow: const [
                      BoxShadow(
                        color: KBoxShadow,
                        blurRadius: 31.23,
                        offset: Offset(15.61, 15.61),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: KTextdark,
                    size: 18.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Verification Code",
                style: GoogleFonts.roboto(
                    fontSize: 30.sp, color: Kpink, fontWeight: kFW600),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Please Enter Verification Code sent to +91 ${phoneNumber}",
                style: GoogleFonts.roboto(
                    fontSize: kSixteenFont, color: KText, fontWeight: kFW400),
              ),
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: OTPTextField(
                  otpFieldStyle: OtpFieldStyle(
                      enabledBorderColor: Ktextcolor, focusBorderColor: Kpink),
                  length: 6,
                  width: double.infinity,
                  fieldWidth: 35.w,
                  contentPadding: EdgeInsets.symmetric(vertical: 2),
                  margin: EdgeInsets.only(right: 8.w),
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 10,
                  style: GoogleFonts.roboto(
                      fontSize: kEighteenFont,
                      fontWeight: kFW500,
                      color: Kpink),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  onCompleted: (pin) {
                    setState(() {
                      _otpController.text = pin;
                    });
                    print("Completed: " + pin);
                  },
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Center(
                child: RichText(
                  textScaleFactor: 1,
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: "Resending OTP in  ",

                    style: GoogleFonts.roboto(
                        fontSize: kTwelveFont,
                        color: KText,
                        fontWeight: kFW500),
                    // GoogleFonts.roboto(
                    //   fontSize: kTwentyFont,
                    //   fontWeight: FontWeight.bold,
                    //   color: selectedTheme == "Lighttheme"
                    //       ? KdarkText
                    //       : Kwhite,
                    // ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "$_seconds" + " s",
                        style: GoogleFonts.roboto(
                            fontSize: kTwelveFont,
                            color: KdarkText,
                            fontWeight: kFW500),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      authentication.timerOn.value = true;
                    });
                    Get.back();
                    //  Get.toNamed(kMobileSignUp);
                  },
                  child: Text(
                    "Wrong Number ?",
                    style: GoogleFonts.roboto(
                        fontSize: kFourteenFont,
                        color: Kpink,
                        fontWeight: kFW500),
                  ),
                ),
              ),
              SizedBox(
                height: 95.h,
              ),
              Center(
                  child: Text(
                "Didn’t receive the OTP?",
                style: GoogleFonts.roboto(
                    fontSize: kTwelveFont, color: KText, fontWeight: kFW500),
              )),
              SizedBox(
                height: 15.h,
              ),
              authentication.timerOn == false
                  ? Center(
                      child: InkWell(
                        onTap: () async {
                          var payload = {"mobile": phoneNumber};
                          apiController.mobileRegistration(payload);

                          Fluttertoast.showToast(
                            msg: "Sent Successfully",
                          );
                          setState(() {
                            apiController.isLoadings.value = false;
                          });

                          ;

                          //     Get.toNamed(kOtpScreen);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset(
                            //   "assets/images/recycle.png",
                            //   height: 16.h,
                            //   color: Kpink,
                            // ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "Resend ?",
                              style: GoogleFonts.roboto(
                                  fontSize: kFourteenFont,
                                  color: Kpink,
                                  fontWeight: kFW500),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image.asset(
                          //   "assets/images/recycle.png",
                          //   height: 16.h,
                          //   color: KText,
                          // ),
                          // SizedBox(
                          //   width: 8.w,
                          // ),
                          Text(
                            "Resend ?",
                            style: GoogleFonts.roboto(
                                fontSize: kFourteenFont,
                                color: KText,
                                fontWeight: kFW500),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: 45.h,
              ),
              Obx(() => authentication.loginsLoading == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Kpink,
                      ),
                    )
                  : CustomButton(
                      borderRadius: BorderRadius.circular(30.r),
                      Color: Kpink,
                      textColor: Kwhite,
                      height: 42.h,
                      width: double.infinity,
                      label: "Verify",
                      fontSize: kSixteenFont,
                      fontWeight: kFW500,
                      isLoading: false,
                      onTap: () async {
                        // if (_otpController.text != "") {
                        //   AuthService.loginWithOtp(otp: _otpController.text)
                        //       .then((value) {
                        //     if (value == "Success") {
                        //       Fluttertoast.showToast(
                        //         msg: "SignIn Successfully",
                        //       );
                        //       var payload = {
                        //         "mobile": phoneNumber,

                        //       };

                        //   authentication.logins(payload);

                        //     } else {

                        //       Fluttertoast.showToast(
                        //         msg: value,
                        //       );
                        //     }
                        //   });
                        // } else {
                        //   Fluttertoast.showToast(
                        //     msg: "Please Enter OTP",
                        //   );
                        // }
                        if (_otpController.text != "") {
                          var payload = {
                            "mobile": phoneNumber,
                            "otp": _otpController.text
                          };

                          /// {"mobile":phoneNumber};

                          apiController.otpRegistration(payload);
                        } else {
                          Fluttertoast.showToast(
                            msg: "Please Enter OTP",
                          );
                        }
                      },
                    )),
            ],
          ),
        ),
      ),
    ));
    //   Container(
    //     margin: EdgeInsets.only(left: 20.w, right: 20.w),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         SizedBox(
    //           height: 50.h,
    //         ),
    //         GestureDetector(
    //           onTap: () {
    //             Get.back();
    //           },
    //           child: Container(
    //             width: 38.w,
    //             height: 38.h,
    //             alignment: Alignment.center,
    //             padding: EdgeInsets.only(
    //               left: 2.w,
    //             ),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10.r),
    //               color: Kwhite,
    //               boxShadow: const [
    //                 BoxShadow(
    //                   color: KBoxShadow,
    //                   blurRadius: 31.23,
    //                   offset: Offset(15.61, 15.61),
    //                   spreadRadius: 0,
    //                 )
    //               ],
    //             ),
    //             child: Icon(
    //               Icons.arrow_back_ios,
    //               color: KTextdark,
    //               size: 18.sp,
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 50.h,
    //         ),
    //         Text(
    //           "Verification Code",
    //           style: GoogleFonts.roboto(
    //               fontSize: 28.sp,
    //               fontWeight: kFW700,
    //               height: 1.2,
    //               color: KTextdark),
    //         ),
    //         SizedBox(
    //           height: 30.h,
    //         ),
    //         Text(
    //           "Please type the verification code Form Mobile No (or) Email Id",
    //           style: GoogleFonts.roboto(
    //               fontSize: kFourteenFont,
    //               fontWeight: kFW500,
    //               color: KTextgery),
    //         ),
    //         SizedBox(
    //           height: 32.h,
    //         ),
    //         Center(
    //           child: OTPTextField(
    //             otpFieldStyle: OtpFieldStyle(
    //                 enabledBorderColor: KTextgery.withOpacity(0.4),
    //                 focusBorderColor: Kpink),
    //             length: 4,
    //             width: double.infinity,
    //             fieldWidth: 55.w,
    //             contentPadding: const EdgeInsets.symmetric(vertical: 2),
    //             margin: EdgeInsets.only(right: 8.w),
    //             fieldStyle: FieldStyle.box,

    //             //  fieldStyle: FieldStyle.box,
    //             outlineBorderRadius: 10,
    //             style: GoogleFonts.roboto(
    //                 fontSize: kEighteenFont, fontWeight: kFW500, color: Kpink),
    //             textFieldAlignment: MainAxisAlignment.spaceAround,
    //             //  otpFieldStyle: BoxDecoration(borderRadius: 10),
    //             // fieldStyle: FieldStyle.underline,
    //             onCompleted: (pin) {
    //               // Get.toNamed(kDashboardScreen);
    //               // print("Completed: " + pin);
    //             },
    //           ),
    //         ),
    //         SizedBox(
    //           height: 35.h,
    //         ),
    //         RichText(
    //           maxLines: 1,
    //           textAlign: TextAlign.left,
    //           text: TextSpan(
    //             text: "I didn’t receive a code! ",
    //             style: GoogleFonts.roboto(
    //                 fontSize: kTwelveFont,
    //                 fontWeight: kFW500,
    //                 color: KTextdarkgery),
    //             children: <TextSpan>[
    //               TextSpan(
    //                 text: "Please resend",
    //                 style: GoogleFonts.roboto(
    //                     fontSize: kSixteenFont,
    //                     fontWeight: kFW500,
    //                     color: Kpink),
    //               ),
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 80.h,
    //         ),
    //         CustomButton(
    //             width: double.infinity,
    //             height: 42.h,
    //             fontSize: kFourteenFont,
    //             fontWeight: kFW700,
    //             textColor: Kwhite,
    //             borderRadius: BorderRadius.circular(30.r),
    //             label: "Verify",
    //             isLoading: false,
    //             onTap: () async {
    //               Get.toNamed(KDashboard);
    //               //  KOtpVerification
    //               //  await Get.toNamed(kOtpVerify);
    //             }),
    //       ],
    //     ),
    //   ),
    // );
  }
}
