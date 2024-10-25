import 'dart:async';

import 'package:pinput/pinput.dart';
import 'package:womentaxi/untils/export_file.dart';

class CahngeRoleOTP extends StatefulWidget {
  const CahngeRoleOTP({super.key});

  @override
  State<CahngeRoleOTP> createState() => _CahngeRoleOTPState();
}

class _CahngeRoleOTPState extends State<CahngeRoleOTP> {
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
    // _startTimer();
    // setState(() {
    //   authentication.timerOn.value = true;
    // });
    debugPrint("hi");
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/womenriders.png",
                    height: 60.h,
                    // width: 150.w,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: Image.asset(
                      "assets/images/donee.png",

                      height: MediaQuery.of(context).size.height / 3.5,
                      // fit: BoxFit.fitHeight,
                      // width: 150.w,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: kPinkBgColortwo,
                      boxShadow: const [
                        BoxShadow(
                          color: kPinkBgColortwo,
                          blurRadius: 30,
                          offset: Offset(15, 15),
                          spreadRadius: 0,
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.h,
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
                        "Enter OTP from your Mobile Number",
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
                          onChanged: (pin) {
                            setState(() {});
                          },
                          onCompleted: (pin) {
                            setState(() {
                              _otpController.text = pin;
                            });
                            print("Completed: " + pin);
                          },
                          // onCompleted: (pin) {
                          //   setState(() {
                          //     _otpController.text = pin;
                          //     apicontroller.otpEnterCompleted.value = true;
                          //   });
                          //   print("Completed: " + pin);
                          // },
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

                      //     fieldWidth: 50.w,

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
                      //         _otpsController.text = pin;
                      //       });
                      //       print("Completed: " + pin);
                      //     },
                      //   ),
                      // ),

                      SizedBox(
                        height: 20.h,
                      ),
                      _otpController.text == ""
                          ? Center(
                              child: InkWell(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg: 'Please Enter OTP');
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.only(top: 30.h, bottom: 80.h
                                          // bottom: 50.h
                                          ),
                                  // padding: Padding,
                                  height: 40,
                                  width: 200.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: KBLUESHADE,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    "Verify",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        fontSize: kSixteenFont,
                                        color: Kpink,
                                        fontWeight: kFW500),
                                  ),
                                ),
                              ),
                            )
                          : Obx(() => authentication.otpAdharDocLoading == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Kpink,
                                  ),
                                )
                              : CustomButton(
                                  borderRadius: BorderRadius.circular(30.r),
                                  Color: Kpink,
                                  margin: EdgeInsets.only(top: 30.h),
                                  textColor: Kwhite,
                                  height: 42.h,
                                  width: double.infinity,
                                  label: "Verify",
                                  fontSize: kSixteenFont,
                                  fontWeight: kFW500,
                                  isLoading: false,
                                  onTap: () async {
                                    if (_otpController.text != "") {
                                      var payload = {
                                        "mobile": phoneNumber,
                                        "otp": _otpController.text
                                      };

                                      apiController.otpRegistrationotp(payload);
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Please Enter OTP",
                                      );
                                    }

                                    // if (_otpController.text != "") {
                                    //   var payload = {
                                    //     "otp": _otpController.text,
                                    //     "aadhaarNo": apicontroller
                                    //         .enteredVerifyAdharNumber.value,
                                    //     // "aadhaarUpdateHistory": "Y",
                                    //     //  "shareCode": "5555",
                                    //     "requestId": apicontroller
                                    //         .verifyAdharDocData["requestId"],
                                    //     "consent": "Y"
                                    //     // "clientData": {"caseId": "123456"}
                                    //   };

                                    //   apicontroller.newotpAdharDoc(payload);

                                    // } else {
                                    //   Fluttertoast.showToast(
                                    //     msg: "Please Enter OTP",
                                    //   );
                                    // }
                                  },
                                )),
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
                        height: 50.h,
                      ),
                    ],
                  ),
                ),
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

                // SizedBox(
                //   height: 40.h,
                // ),
                // Center(
                //   child: OTPTextField(
                //     otpFieldStyle: OtpFieldStyle(
                //         enabledBorderColor: Ktextcolor,
                //         focusBorderColor: Kpink),
                //     length: 6,
                //     width: double.infinity,
                //     fieldWidth: 35.w,
                //     contentPadding: EdgeInsets.symmetric(vertical: 2),
                //     margin: EdgeInsets.only(right: 8.w),
                //     fieldStyle: FieldStyle.box,
                //     outlineBorderRadius: 10,
                //     style: GoogleFonts.roboto(
                //         fontSize: kEighteenFont,
                //         fontWeight: kFW500,
                //         color: Kpink),
                //     textFieldAlignment: MainAxisAlignment.spaceAround,
                //     onCompleted: (pin) {
                //       setState(() {
                //         _otpController.text = pin;
                //       });
                //       print("Completed: " + pin);
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: 150.h,
                // ),
                // Obx(() => authentication.loginsLoading == true
                //     ? Center(
                //         child: CircularProgressIndicator(
                //           color: Kpink,
                //         ),
                //       )
                //     : CustomButton(
                //         borderRadius: BorderRadius.circular(30.r),
                //         Color: Kpink,
                //         textColor: Kwhite,
                //         height: 42.h,
                //         width: double.infinity,
                //         label: "Verify",
                //         fontSize: kSixteenFont,
                //         fontWeight: kFW500,
                //         isLoading: false,
                //         onTap: () async {
                //           if (_otpController.text != "") {
                //             var payload = {
                //               "mobile": phoneNumber,
                //               "otp": _otpController.text
                //             };

                //             apiController.otpRegistrationotp(payload);
                //           } else {
                //             Fluttertoast.showToast(
                //               msg: "Please Enter OTP",
                //             );
                //           }
                //         },
                //       )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
