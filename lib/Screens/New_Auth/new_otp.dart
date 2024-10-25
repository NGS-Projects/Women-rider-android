import 'dart:async';

import 'package:pinput/pinput.dart';
import 'package:womentaxi/untils/export_file.dart';

class NewOtpScreen extends StatefulWidget {
  const NewOtpScreen({super.key});

  @override
  State<NewOtpScreen> createState() => _NewOtpScreenState();
}

class _NewOtpScreenState extends State<NewOtpScreen> {
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
      apicontroller.otpEnterCompleted.value = false;
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
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 52,
      textStyle: const TextStyle(
        fontSize: 20,
        color: kcarden,
        fontWeight: kFW600,
      ),
      decoration: BoxDecoration(
        color: Kwhite, // Background color of each input field
        borderRadius: BorderRadius.circular(28), // Circular shape
        border: Border.all(
            color: Kpink.withOpacity(0.5), width: 0.5), // Border color
      ),
    );
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Kwhite,
      // ),
      backgroundColor: Kwhite,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.06,
          margin: EdgeInsets.only(top: 50.h),
          child: Form(
            //  key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 50,
                // ),
                Image.asset(
                  "assets/images/womenriders.png",
                  height: 80.h,
                  // width: 150.w,
                ),

                Padding(
                  padding: EdgeInsets.all(15),
                  child: Image.asset(
                    "assets/images/phone_lock.png",

                    height: MediaQuery.of(context).size.height / 3.5,
                    // fit: BoxFit.fitHeight,
                    // width: 150.w,
                  ),
                ),
                // SizedBox(
                //   height: 70.h,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Get.back();
                //   },
                //   child: Container(
                //     width: 38.w,
                //     height: 38.h,
                //     alignment: Alignment.center,
                //     padding: EdgeInsets.only(
                //       left: 2.w,
                //     ),
                //     // height: 47.88,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10.r),
                //       color: Kwhite,
                //       // shape: RoundedRectangleBorder(
                //       //   borderRadius: BorderRadius.circular(23.94),
                //       // ),
                //       boxShadow: const [
                //         BoxShadow(
                //           color: KBoxShadow,
                //           blurRadius: 31.23,
                //           offset: Offset(15.61, 15.61),
                //           spreadRadius: 0,
                //         )
                //       ],
                //     ),
                //     child: Icon(
                //       Icons.arrow_back_ios,
                //       color: KTextdark,
                //       size: 18.sp,
                //     ),
                //   ),
                // ),

                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: kPinkBgColortwo,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3FD3D1D8),
                          blurRadius: 30,
                          offset: Offset(15, 15),
                          spreadRadius: 0,
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Enter OTP",
                        style: GoogleFonts.roboto(
                            fontSize: kTwentyFont,
                            fontWeight: kFW600,
                            //  height: 1,
                            color: kcarden),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Divider(
                        color: Kpink,
                        thickness: 2,
                      ),
                      Text(
                        "Please enter 6 digit otp sent to your registered mobile number ending with ${phoneNumber.substring(phoneNumber.length - 4)}",
                        style: GoogleFonts.roboto(
                            fontSize: 13.sp,
                            fontWeight: kFW400,
                            color: kcarden),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Center(
                        child: Pinput(
                          length: 6,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: Kwhite,
                              border: Border.all(
                                  color: Kwhite.withOpacity(0.5), width: 1),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: Kwhite,
                            ),
                          ),
                          onCompleted: (pin) {
                            setState(() {
                              _otpController.text = pin;
                              apicontroller.otpEnterCompleted.value = true;
                            });
                            print("Completed: " + pin);
                          },
                          // onCompleted: (pin) {
                          //   print('Entered Pin: $pin');
                          // },
                        ),
                      ),

                      // Center(
                      //   child: OTPTextField(
                      //     otpFieldStyle: OtpFieldStyle(
                      //         enabledBorderColor: Ktextcolor,
                      //         focusBorderColor: Kpink),
                      //     length: 6,
                      //     width: double.infinity,
                      //     // fieldWidth: 35.w,
                      //     fieldWidth: 50.w,
                      //     //   contentPadding: EdgeInsets.symmetric(vertical: 2),

                      //     // margin: EdgeInsets.only(right: 8.w),
                      //     fieldStyle: FieldStyle.box,
                      //     outlineBorderRadius: 300,
                      //     style: GoogleFonts.roboto(
                      //         fontSize: kEighteenFont,
                      //         fontWeight: kFW500,
                      //         color: Kpink),
                      //     textFieldAlignment: MainAxisAlignment.spaceAround,
                      //     onCompleted: (pin) {
                      //       setState(() {
                      //         _otpController.text = pin;
                      //         apicontroller.otpEnterCompleted.value = true;
                      //       });
                      //       print("Completed: " + pin);
                      //     },
                      //   ),
                      // ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              var payload = {"mobile": phoneNumber};

                              apiController.mobileRegistration(payload);
                            },
                            child: Text(
                              "Resend ?",
                              style: GoogleFonts.roboto(
                                  fontSize: kFourteenFont,
                                  color: kcarden,
                                  fontWeight: kFW500),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      apicontroller.otpEnterCompleted == true
                          ? Obx(() => authentication.loginsLoading == true
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Kpink,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        if (_otpController.text != "") {
                                          var payload = {
                                            "mobile": phoneNumber,
                                            "otp": _otpController.text,
                                            "termsAndCondition":
                                                "${apicontroller.accountAcceptTerms.value}",
                                          };

                                          apiController
                                              .otpRegistration(payload);
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: "Please Enter OTP",
                                          );
                                        }
                                      },
                                      child: Center(
                                        child: Container(
                                          margin: EdgeInsets.only(top: 15.h),
                                          // padding: Padding,
                                          height: 40,
                                          width: 200.w,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Kpink,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Text(
                                            "Continue",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                                fontSize: kSixteenFont,
                                                color: Kwhite,
                                                fontWeight: kFW500),
                                          ),
                                        ),
                                      ),
                                    )
                              // CustomButton(
                              //     borderRadius: BorderRadius.circular(30.r),
                              //     Color: Kpink,
                              //     textColor: Kwhite,
                              //     height: 42.h,
                              //     width: double.infinity,
                              //     label: "Verify",
                              //     fontSize: kSixteenFont,
                              //     fontWeight: kFW500,
                              //     isLoading: false,

                              //   )
                              )
                          : Center(
                              child: GestureDetector(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg: 'Please Enter Otp');
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 15.h),
                                  // padding: Padding,
                                  height: 40,
                                  width: 200.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Kwhite,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    "Continue",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        fontSize: kSixteenFont,
                                        color: Kpink,
                                        fontWeight: kFW500),
                                  ),
                                ),
                              ),
                            ),

                      // Container(
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       color: Kwhite,
                      //       boxShadow: const [
                      //         BoxShadow(
                      //           color: Color(0x3FD3D1D8),
                      //           blurRadius: 30,
                      //           offset: Offset(15, 15),
                      //           spreadRadius: 0,
                      //         )
                      //       ]),
                      //   child: TextFormField(
                      //     //   controller: _phoneController,
                      //     enabled: true,
                      //     keyboardType: TextInputType.phone,
                      //     style: TextStyle(
                      //         fontSize: 14.sp,
                      //         fontWeight: kFW500,
                      //         color: kblack),
                      //     decoration: InputDecoration(
                      //       focusColor: Kwhite,
                      //       filled: true,
                      //       floatingLabelBehavior: FloatingLabelBehavior.auto,
                      //       contentPadding: const EdgeInsets.symmetric(
                      //         vertical: 16,
                      //       ),
                      //       // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10.r),
                      //       ),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: const BorderSide(
                      //             color: Kbordergery, width: 0.5),
                      //         borderRadius: BorderRadius.circular(10.r),
                      //       ),
                      //       errorBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //             color: kblack.withOpacity(0.6), width: 0.5),
                      //         borderRadius: BorderRadius.circular(10.r),
                      //       ),
                      //       disabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //             color: kblack.withOpacity(0.6), width: 0.5),
                      //         borderRadius: BorderRadius.circular(10.r),
                      //       ),
                      //       focusedErrorBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //             color: Kpink.withOpacity(0.6), width: 0.5),
                      //         borderRadius: BorderRadius.circular(10.r),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //             color: Kpink.withOpacity(0.6), width: 1),
                      //         borderRadius: BorderRadius.circular(10.r),
                      //       ),
                      //       fillColor: Kwhite,
                      //       prefixIcon: Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             vertical: 20, horizontal: 8),
                      //         child: Text(
                      //           " +91",
                      //           style: GoogleFonts.roboto(
                      //               fontSize: 14.sp,
                      //               fontWeight: kFW500,
                      //               color: kblack),
                      //         ),
                      //       ),
                      //       suffixIcon: InkWell(
                      //         onTap: () async {
                      //           // var payload = {"mobile": _phoneController.text};

                      //           // if (_formKey.currentState!.validate()) {
                      //           //   apiController.mobileRegistration(payload);
                      //           // }
                      //         },
                      //         child: Container(
                      //             width: 70,
                      //             // color: Kpink,
                      //             decoration: BoxDecoration(
                      //                 color: Kpink,
                      //                 borderRadius: BorderRadius.only(
                      //                     topRight: Radius.circular(10.r),
                      //                     bottomRight: Radius.circular(10.r))),
                      //             padding: EdgeInsets.symmetric(
                      //                 vertical: 20, horizontal: 8),
                      //             child: Icon(
                      //               Icons.arrow_forward_ios,
                      //               size: 24.sp,
                      //               color: Kwhite,
                      //             )),
                      //       ),

                      //       hintText: "Your mobile no",
                      //       alignLabelWithHint: true,
                      //       //make hint text

                      //       hintStyle: TextStyle(
                      //         color: KTextgery.withOpacity(0.5),
                      //         fontSize: 14.sp,
                      //         fontWeight: kFW500,
                      //       ),

                      //       //create lable
                      //     ),
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return 'Please enter Mobile No';
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),

                      SizedBox(
                        height: 90.h,
                      ),
                    ],
                  ),
                ),

                // CustomFormField(
                //   controller: _phoneController,
                //   enabled: true,
                //   prefix: Padding(
                //     padding:
                //         const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
                //     child: Text(
                //       " +91",
                //       style: GoogleFonts.roboto(
                //           fontSize: 14.sp, fontWeight: kFW500, color: kblack),
                //     ),
                //   ),
                //   contentPadding: const EdgeInsets.symmetric(
                //     vertical: 16,
                //   ),
                //   fontSize: kFourteenFont,
                //   fontWeight: FontWeight.w500,
                //   hintText:
                //   maxLines: 1,
                //   readOnly: false,
                //   label: "",
                //   keyboardType: TextInputType.phone,
                //   obscureText: false,

                // ),

                // Obx(() => apiController.mobileRegistrationLoading == true
                //     ? Center(
                //         child: CircularProgressIndicator(
                //           color: Kpink,
                //         ),
                //       )
                //     : CustomButton(
                //         width: double.infinity,
                //         height: 42.h,
                //         fontSize: kFourteenFont,
                //         fontWeight: kFW700,
                //         textColor: Kwhite,
                //         borderRadius: BorderRadius.circular(30.r),
                //         label: "Send",
                //         isLoading: false,
                //         onTap: () async {
                //           var payload = {"mobile": _phoneController.text};

                //           // {"mobile": _phoneController.text}
                //           apiController.mobileRegistration(payload);
                //         })),
              ],
            ),
          ),
        ),
      ),
    );
    // Scaffold(
    //     body: Obx(
    //   () => SingleChildScrollView(
    //     child: Container(
    //       margin: EdgeInsets.only(
    //         left: 20.w,
    //         right: 20.w,
    //         bottom: 20.h,
    //       ),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           SizedBox(
    //             height: 70.h,
    //           ),
    //           GestureDetector(
    //             onTap: () {
    //               Get.back();
    //             },
    //             child: Container(
    //               width: 38.w,
    //               height: 38.h,
    //               alignment: Alignment.center,
    //               padding: EdgeInsets.only(
    //                 left: 2.w,
    //               ),
    //               // height: 47.88,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10.r),
    //                 color: Kwhite,
    //                 // shape: RoundedRectangleBorder(
    //                 //   borderRadius: BorderRadius.circular(23.94),
    //                 // ),
    //                 boxShadow: const [
    //                   BoxShadow(
    //                     color: KBoxShadow,
    //                     blurRadius: 31.23,
    //                     offset: Offset(15.61, 15.61),
    //                     spreadRadius: 0,
    //                   )
    //                 ],
    //               ),
    //               child: Icon(
    //                 Icons.arrow_back_ios,
    //                 color: KTextdark,
    //                 size: 18.sp,
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 15.h,
    //           ),
    //           Text(
    //             "Verification Code",
    //             style: GoogleFonts.roboto(
    //                 fontSize: 30.sp, color: Kpink, fontWeight: kFW600),
    //           ),
    //           SizedBox(
    //             height: 15.h,
    //           ),
    //           Text(
    //             "Please Enter Verification Code sent to +91 ${phoneNumber}",
    //             style: GoogleFonts.roboto(
    //                 fontSize: kSixteenFont, color: KText, fontWeight: kFW400),
    //           ),
    //           SizedBox(
    //             height: 40.h,
    //           ),
    //           Center(
    //             child: OTPTextField(
    //               otpFieldStyle: OtpFieldStyle(
    //                   enabledBorderColor: Ktextcolor, focusBorderColor: Kpink),
    //               length: 6,
    //               width: double.infinity,
    //               fieldWidth: 35.w,
    //               contentPadding: EdgeInsets.symmetric(vertical: 2),
    //               margin: EdgeInsets.only(right: 8.w),
    //               fieldStyle: FieldStyle.box,
    //               outlineBorderRadius: 10,
    //               style: GoogleFonts.roboto(
    //                   fontSize: kEighteenFont,
    //                   fontWeight: kFW500,
    //                   color: Kpink),
    //               textFieldAlignment: MainAxisAlignment.spaceAround,
    //               onCompleted: (pin) {
    //                 setState(() {
    //                   _otpController.text = pin;
    //                 });
    //                 print("Completed: " + pin);
    //               },
    //             ),
    //           ),
    //           SizedBox(
    //             height: 50.h,
    //           ),
    //           Center(
    //             child: RichText(
    //               textScaleFactor: 1,
    //               textAlign: TextAlign.left,
    //               text: TextSpan(
    //                 text: "Resending OTP in  ",

    //                 style: GoogleFonts.roboto(
    //                     fontSize: kTwelveFont,
    //                     color: KText,
    //                     fontWeight: kFW500),
    //                 // GoogleFonts.roboto(
    //                 //   fontSize: kTwentyFont,
    //                 //   fontWeight: FontWeight.bold,
    //                 //   color: selectedTheme == "Lighttheme"
    //                 //       ? KdarkText
    //                 //       : Kwhite,
    //                 // ),
    //                 children: <TextSpan>[
    //                   TextSpan(
    //                     text: "$_seconds" + " s",
    //                     style: GoogleFonts.roboto(
    //                         fontSize: kTwelveFont,
    //                         color: KdarkText,
    //                         fontWeight: kFW500),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 15.h,
    //           ),
    //           Center(
    //             child: InkWell(
    //               onTap: () {
    //                 setState(() {
    //                   authentication.timerOn.value = true;
    //                 });
    //                 Get.back();
    //                 //  Get.toNamed(kMobileSignUp);
    //               },
    //               child: Text(
    //                 "Wrong Number ?",
    //                 style: GoogleFonts.roboto(
    //                     fontSize: kFourteenFont,
    //                     color: Kpink,
    //                     fontWeight: kFW500),
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 95.h,
    //           ),
    //           Center(
    //               child: Text(
    //             "Didn’t receive the OTP?",
    //             style: GoogleFonts.roboto(
    //                 fontSize: kTwelveFont, color: KText, fontWeight: kFW500),
    //           )),
    //           SizedBox(
    //             height: 15.h,
    //           ),
    //           authentication.timerOn == false
    //               ? Center(
    //                   child: InkWell(
    //                     onTap: () async {
    //                       var payload = {"mobile": phoneNumber};
    //                       apiController.mobileRegistration(payload);

    //                       Fluttertoast.showToast(
    //                         msg: "Sent Successfully",
    //                       );
    //                       setState(() {
    //                         apiController.isLoadings.value = false;
    //                       });

    //                       ;

    //                       //     Get.toNamed(kOtpScreen);
    //                     },
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         // Image.asset(
    //                         //   "assets/images/recycle.png",
    //                         //   height: 16.h,
    //                         //   color: Kpink,
    //                         // ),
    //                         SizedBox(
    //                           width: 8.w,
    //                         ),
    //                         Text(
    //                           "Resend ?",
    //                           style: GoogleFonts.roboto(
    //                               fontSize: kFourteenFont,
    //                               color: Kpink,
    //                               fontWeight: kFW500),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 )
    //               : Center(
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       // Image.asset(
    //                       //   "assets/images/recycle.png",
    //                       //   height: 16.h,
    //                       //   color: KText,
    //                       // ),
    //                       // SizedBox(
    //                       //   width: 8.w,
    //                       // ),
    //                       Text(
    //                         "Resend ?",
    //                         style: GoogleFonts.roboto(
    //                             fontSize: kFourteenFont,
    //                             color: KText,
    //                             fontWeight: kFW500),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //           SizedBox(
    //             height: 45.h,
    //           ),
    //           Obx(() => authentication.loginsLoading == true
    //               ? Center(
    //                   child: CircularProgressIndicator(
    //                     color: Kpink,
    //                   ),
    //                 )
    //               : CustomButton(
    //                   borderRadius: BorderRadius.circular(30.r),
    //                   Color: Kpink,
    //                   textColor: Kwhite,
    //                   height: 42.h,
    //                   width: double.infinity,
    //                   label: "Verify",
    //                   fontSize: kSixteenFont,
    //                   fontWeight: kFW500,
    //                   isLoading: false,
    //                   onTap: () async {
    //                     // if (_otpController.text != "") {
    //                     //   AuthService.loginWithOtp(otp: _otpController.text)
    //                     //       .then((value) {
    //                     //     if (value == "Success") {
    //                     //       Fluttertoast.showToast(
    //                     //         msg: "SignIn Successfully",
    //                     //       );
    //                     //       var payload = {
    //                     //         "mobile": phoneNumber,

    //                     //       };

    //                     //   authentication.logins(payload);

    //                     //     } else {

    //                     //       Fluttertoast.showToast(
    //                     //         msg: value,
    //                     //       );
    //                     //     }
    //                     //   });
    //                     // } else {
    //                     //   Fluttertoast.showToast(
    //                     //     msg: "Please Enter OTP",
    //                     //   );
    //                     // }
    //                     if (_otpController.text != "") {
    //                       var payload = {
    //                         "mobile": phoneNumber,
    //                         "otp": _otpController.text
    //                       };

    //                       /// {"mobile":phoneNumber};

    //                       apiController.otpRegistration(payload);
    //                     } else {
    //                       Fluttertoast.showToast(
    //                         msg: "Please Enter OTP",
    //                       );
    //                     }
    //                   },
    //                 )),
    //         ],
    //       ),
    //     ),
    //   ),
    // ));
  }
}
