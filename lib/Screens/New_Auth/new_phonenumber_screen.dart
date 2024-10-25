import 'package:pinput/pinput.dart';
import 'package:womentaxi/untils/export_file.dart';

// class NewPhoneNumber extends StatefulWidget {
//   const NewPhoneNumber({super.key});

//   @override
//   State<NewPhoneNumber> createState() => _NewPhoneNumberState();
// }

// class _NewPhoneNumberState extends State<NewPhoneNumber> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

class NewPhoneNumber extends StatefulWidget {
  const NewPhoneNumber({super.key});

  @override
  State<NewPhoneNumber> createState() => _NewPhoneNumberState();
}

class _NewPhoneNumberState extends State<NewPhoneNumber> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Are you sure?',
              style: GoogleFonts.roboto(
                  fontSize: kEighteenFont,
                  fontWeight: kFW600,
                  color: Ktextcolor),
            ),
            content: Text(
              'Do you want to exit this App',
              style: GoogleFonts.roboto(
                  fontSize: 13.sp, fontWeight: kFW600, color: KText),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: GoogleFonts.roboto(
                      fontSize: kTwelveFont,
                      fontWeight: kFW600,
                      color: KdarkText),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text(
                  'Yes',
                  style: GoogleFonts.roboto(
                      fontSize: kTwelveFont, fontWeight: kFW600, color: Kpink),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  ApiController apiController = Get.put(ApiController());
  TextEditingController _phoneController = TextEditingController();
  bool value = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color of each input field
        borderRadius: BorderRadius.circular(28), // Circular shape
        border: Border.all(color: Colors.blue, width: 2), // Border color
      ),
    );
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
              key: _formKey,
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
                      "assets/images/phoneauth_pic.png",

                      // height: MediaQuery.of(context).size.height / 4,
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
                        // color: Color(0x3FD3D1D8),
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
                        InkWell(
                          onTap: () {
                            // Get.toNamed(kRazorPay);
                          },
                          child: Text(
                            "Verify Your Mobile Number",
                            style: GoogleFonts.roboto(
                                fontSize: kEighteenFont,
                                fontWeight: kFW600,
                                //  height: 1,
                                color: kcarden),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),

                        Divider(
                          color: Kpink,
                          thickness: 2,
                        ),
                        InkWell(
                          onTap: () {
                            // Get.toNamed(kPhonePeScreen);
                          },
                          child: Text(
                            "By Entering your mobile number you are agreeing to our terms & Condition",
                            style: GoogleFonts.roboto(
                                fontSize: 13.sp,
                                fontWeight: kFW400,
                                color: kcarden),
                          ),
                        ),
                        // SizedBox(
                        //   height: 15.h,
                        // ),
                        CustomFormField(
                          enabled: true,
                          keyboardType: TextInputType.phone,
                          controller: _phoneController,
                          obscureText: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          fontSize: kFourteenFont,
                          fontWeight: FontWeight.w500,
                          hintText: "Enter Mobile Number",
                          maxLines: 1,
                          prefix: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "+91",
                                  style: GoogleFonts.roboto(
                                      fontSize: kFourteenFont,
                                      fontWeight: kFW600,
                                      color: kcarden),
                                ),
                              ],
                            ),
                          ),
                          readOnly: false,
                          label: '',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter mobile number';
                            }
                            return null;
                          },
                          onChanged: (Value) {
                            setState(() {});
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              activeColor: Kpink,
                              checkColor: Kwhite,
                              value: value,
                              onChanged: (value) {
                                setState(() {
                                  this.value = value!;
                                  apicontroller.accountAcceptTerms.value =
                                      value;
                                });
                                print(value);
                              },
                            ),
                            Text(
                              "Agree Terms & Conditions",
                              style: GoogleFonts.roboto(
                                  fontSize: kTwelveFont.sp,
                                  color: KText,
                                  fontWeight: kFW500),
                            ),
                          ],
                        ),
                        apicontroller.accountAcceptTerms == true &&
                                _phoneController.text != ""
                            // apicontroller.accountAcceptTerms == true && _phoneController
                            ? GestureDetector(
                                onTap: () async {
                                  var payload = {
                                    "mobile": _phoneController.text
                                  };

                                  if (_formKey.currentState!.validate()) {
                                    apiController.mobileRegistration(payload);
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
                                      borderRadius: BorderRadius.circular(30),
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
                                ))
                            : GestureDetector(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Please Agree Terms and Conditions and fill fields');
                                },
                                child: Center(
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
                        //     controller: _phoneController,
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
                        //           var payload = {
                        //             "mobile": _phoneController.text
                        //           };

                        //           if (_formKey.currentState!.validate()) {
                        //             apiController.mobileRegistration(payload);
                        //           }
                        //         },
                        //         child: Container(
                        //             width: 70,
                        //             // color: Kpink,
                        //             decoration: BoxDecoration(
                        //                 color: Kpink,
                        //                 borderRadius: BorderRadius.only(
                        //                     topRight: Radius.circular(10.r),
                        //                     bottomRight:
                        //                         Radius.circular(10.r))),
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
      ),
    );
  }
}
