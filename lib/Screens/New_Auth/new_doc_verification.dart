import 'package:womentaxi/untils/export_file.dart';

class NewDocVerification extends StatefulWidget {
  const NewDocVerification({super.key});

  @override
  State<NewDocVerification> createState() => _NewDocVerificationState();
}

class _NewDocVerificationState extends State<NewDocVerification> {
  ApiController apiController = Get.put(ApiController());
  double progress = 0.6;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apicontroller.getRapidoEmpProfile();
  }

  @override
  Widget build(BuildContext context) {
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
            height: MediaQuery.of(context).size.height / 1,
            margin: EdgeInsets.only(top: 30.h),
            child: Form(
              //  key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Column(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/images/womenriders.png",
                            height: 80.h,
                            // width: 150.w,
                          ),
                          Obx(
                            () => apiController.profileData[
                                        "signUpCompletePercentage"] ==
                                    null
                                ? SizedBox()
                                : LinearProgressIndicator(
                                    value: apiController.profileData[
                                            "signUpCompletePercentage"] /
                                        100,
                                    backgroundColor: Colors.grey,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.pink),
                                  ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              apicontroller.getRapidoEmpProfileNvaigation();
                            },
                            child: Text(
                              "Skip    ",
                              style: GoogleFonts.roboto(
                                  fontSize: kSixteenFont,
                                  fontWeight: kFW600,
                                  //  height: 1,
                                  color: kcarden),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Image.asset(
                      "assets/images/doc_card.png",

                      height: MediaQuery.of(context).size.height / 4,
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
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        Text(
                          "Document verification",
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
                        SizedBox(
                          height: 5.h,
                        ),
                        // SignupAdhaarVerified = false.obs;
                        Obx(() => apicontroller.isSignupAdhaarVerified == true
                            ? InkWell(
                                onTap: () async {
                                  Get.toNamed(kNewAdhaarPanScreen);
                                  // var payload = {"mobile": _phoneController.text};

                                  // if (_formKey.currentState!.validate()) {
                                  //   apiController.mobileRegistration(payload);
                                  // }
                                },
                                child: Container(
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
                                  child: TextFormField(
                                    enabled: false,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: kFW500,
                                        color: kblack),
                                    decoration: InputDecoration(
                                      focusColor: Kwhite,
                                      filled: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Kbordergery, width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kblack.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kblack.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Kpink.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Kpink.withOpacity(0.6),
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      fillColor: Kwhite,
                                      // prefixIcon: Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical: 20, horizontal: 8),
                                      //   child: Text(
                                      //     " +91",
                                      //     style: GoogleFonts.roboto(
                                      //         fontSize: 14.sp,
                                      //         fontWeight: kFW500,
                                      //         color: kblack),
                                      //   ),
                                      // ),
                                      suffixIcon: Container(
                                        width: 70,
                                        height: 50,
                                        // color: Kpink,
                                        decoration: BoxDecoration(
                                            color: Kpink,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10.r),
                                                bottomRight:
                                                    Radius.circular(10.r))),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: Image.asset(
                                          "assets/images/right_one.png",
                                          // width: 28.w,
                                          // height: 30.h,
                                          //  height: 80.h,
                                          // width: 150.w,
                                        ),
                                      ),

                                      hintText: "    Enter Aadhar",
                                      alignLabelWithHint: true,
                                      //make hint text

                                      hintStyle: TextStyle(
                                        color: kcarden,
                                        fontSize: 15.sp,
                                        fontWeight: kFW500,
                                      ),

                                      //create lable
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () async {
                                  Get.toNamed(kNewAdhaarPanScreen);
                                  // var payload = {"mobile": _phoneController.text};

                                  // if (_formKey.currentState!.validate()) {
                                  //   apiController.mobileRegistration(payload);
                                  // }
                                },
                                child: Container(
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
                                  child: TextFormField(
                                    enabled: false,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: kFW500,
                                        color: kblack),
                                    decoration: InputDecoration(
                                      focusColor: Kwhite,
                                      filled: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Kbordergery, width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kblack.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kblack.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Kpink.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Kpink.withOpacity(0.6),
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      fillColor: Kwhite,
                                      // prefixIcon: Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical: 20, horizontal: 8),
                                      //   child: Text(
                                      //     " +91",
                                      //     style: GoogleFonts.roboto(
                                      //         fontSize: 14.sp,
                                      //         fontWeight: kFW500,
                                      //         color: kblack),
                                      //   ),
                                      // ),
                                      suffixIcon: Container(
                                        width: 70,
                                        height: 50,
                                        // color: Kpink,
                                        decoration: BoxDecoration(
                                            color: Kpink,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10.r),
                                                bottomRight:
                                                    Radius.circular(10.r))),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Image.asset(
                                            "assets/images/down_arrows.png",
                                            // width: 28.w,
                                            // height: 30.h,
                                            //  height: 80.h,
                                            // width: 150.w,
                                          ),
                                        ),
                                      ),

                                      hintText: "    Enter Aadhar",
                                      alignLabelWithHint: true,
                                      //make hint text

                                      hintStyle: TextStyle(
                                        color: kcarden,
                                        fontSize: 15.sp,
                                        fontWeight: kFW500,
                                      ),

                                      //create lable
                                    ),
                                  ),
                                ),
                              )),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => apicontroller.isSignupBiometricVerified ==
                                true
                            ? InkWell(
                                onTap: () async {
                                  Get.toNamed(kNewBiometricScreen);
                                },
                                child: Container(
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
                                  child: TextFormField(
                                    enabled: false,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: kFW500,
                                        color: kblack),
                                    decoration: InputDecoration(
                                      focusColor: Kwhite,
                                      filled: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Kbordergery, width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kblack.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kblack.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Kpink.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Kpink.withOpacity(0.6),
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      fillColor: Kwhite,
                                      // prefixIcon: Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical: 20, horizontal: 8),
                                      //   child: Text(
                                      //     " +91",
                                      //     style: GoogleFonts.roboto(
                                      //         fontSize: 14.sp,
                                      //         fontWeight: kFW500,
                                      //         color: kblack),
                                      //   ),
                                      // ),
                                      suffixIcon: Container(
                                        width: 70,
                                        height: 50,
                                        // color: Kpink,
                                        decoration: BoxDecoration(
                                            color: Kpink,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10.r),
                                                bottomRight:
                                                    Radius.circular(10.r))),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: Image.asset(
                                          "assets/images/right_one.png",
                                          // width: 28.w,
                                          // height: 30.h,
                                          //  height: 80.h,
                                          // width: 150.w,
                                        ),
                                      ),

                                      hintText: "    Face Authentication",
                                      alignLabelWithHint: true,
                                      //make hint text

                                      hintStyle: TextStyle(
                                        color: kcarden,
                                        fontSize: 15.sp,
                                        fontWeight: kFW500,
                                      ),

                                      //create lable
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () async {
                                  Get.toNamed(kNewBiometricScreen);
                                },
                                child: Container(
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
                                  child: TextFormField(
                                    enabled: false,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: kFW500,
                                        color: kblack),
                                    decoration: InputDecoration(
                                      focusColor: Kwhite,
                                      filled: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Kbordergery, width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kblack.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kblack.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Kpink.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Kpink.withOpacity(0.6),
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      fillColor: Kwhite,
                                      // prefixIcon: Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical: 20, horizontal: 8),
                                      //   child: Text(
                                      //     " +91",
                                      //     style: GoogleFonts.roboto(
                                      //         fontSize: 14.sp,
                                      //         fontWeight: kFW500,
                                      //         color: kblack),
                                      //   ),
                                      // ),
                                      suffixIcon: Container(
                                        width: 70,
                                        height: 50,
                                        // color: Kpink,
                                        decoration: BoxDecoration(
                                            color: Kpink,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10.r),
                                                bottomRight:
                                                    Radius.circular(10.r))),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Image.asset(
                                            "assets/images/down_arrows.png",
                                            // width: 28.w,
                                            // height: 30.h,
                                            //  height: 80.h,
                                            // width: 150.w,
                                          ),
                                        ),
                                      ),
                                      // suffixIcon: Container(
                                      //   width: 70,
                                      //   height: 50,
                                      //   // color: Kpink,
                                      //   decoration: BoxDecoration(
                                      //       color: Kpink,
                                      //       borderRadius: BorderRadius.only(
                                      //           topRight: Radius.circular(10.r),
                                      //           bottomRight:
                                      //               Radius.circular(10.r))),
                                      //   padding: EdgeInsets.symmetric(
                                      //       vertical: 8, horizontal: 8),
                                      //   child: RotatedBox(
                                      //     quarterTurns: 3,
                                      //     child: Image.asset(
                                      //       "assets/images/down_arrows.png",
                                      //       // width: 28.w,
                                      //       // height: 30.h,
                                      //       //  height: 80.h,
                                      //       // width: 150.w,
                                      //     ),
                                      //   ),
                                      // ),
                                      // suffixIcon: Container(
                                      //   width: 70,
                                      //   height: 60,
                                      //   // color: Kpink,
                                      //   decoration: BoxDecoration(
                                      //       color: Kpink,
                                      //       borderRadius: BorderRadius.only(
                                      //           topRight: Radius.circular(10.r),
                                      //           bottomRight:
                                      //               Radius.circular(10.r))),
                                      //   padding: EdgeInsets.symmetric(
                                      //       vertical: 20, horizontal: 8),
                                      //   child: RotatedBox(
                                      //     quarterTurns: 3,
                                      //     child: Image.asset(
                                      //       "assets/images/down_arrows.png",
                                      //       // width: 28.w,
                                      //       // height: 30.h,
                                      //       //  height: 80.h,
                                      //       // width: 150.w,
                                      //     ),
                                      //   ),
                                      // ),

                                      hintText: "    Face Authentication",
                                      alignLabelWithHint: true,
                                      //make hint text

                                      hintStyle: TextStyle(
                                        color: kcarden,
                                        fontSize: 15.sp,
                                        fontWeight: kFW500,
                                      ),

                                      //create lable
                                    ),
                                  ),
                                ),
                              )),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => apicontroller.isEmergencyVerified == true
                            ? InkWell(
                                onTap: () async {
                                  Get.toNamed(kAddContactScreen);
                                },
                                child: Container(
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
                                  child: TextFormField(
                                    enabled: false,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: kFW500,
                                        color: kblack),
                                    decoration: InputDecoration(
                                      focusColor: Kwhite,
                                      filled: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Kbordergery, width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kblack.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kblack.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Kpink.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Kpink.withOpacity(0.6),
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      fillColor: Kwhite,
                                      // prefixIcon: Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical: 20, horizontal: 8),
                                      //   child: Text(
                                      //     " +91",
                                      //     style: GoogleFonts.roboto(
                                      //         fontSize: 14.sp,
                                      //         fontWeight: kFW500,
                                      //         color: kblack),
                                      //   ),
                                      // ),
                                      suffixIcon: Container(
                                        width: 70,
                                        height: 50,
                                        // color: Kpink,
                                        decoration: BoxDecoration(
                                            color: Kpink,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10.r),
                                                bottomRight:
                                                    Radius.circular(10.r))),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: Image.asset(
                                          "assets/images/right_one.png",
                                          // width: 28.w,
                                          // height: 30.h,
                                          //  height: 80.h,
                                          // width: 150.w,
                                        ),
                                      ),

                                      hintText: "    Emergency Contact NUmber",
                                      alignLabelWithHint: true,
                                      //make hint text

                                      hintStyle: TextStyle(
                                        color: kcarden,
                                        fontSize: 15.sp,
                                        fontWeight: kFW500,
                                      ),

                                      //create lable
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () async {
                                  Get.toNamed(kAddContactScreen);
                                },
                                child: Container(
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
                                  child: TextFormField(
                                    enabled: false,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: kFW500,
                                        color: kblack),
                                    decoration: InputDecoration(
                                      focusColor: Kwhite,
                                      filled: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Kbordergery, width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kblack.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kblack.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Kpink.withOpacity(0.6),
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Kpink.withOpacity(0.6),
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      fillColor: Kwhite,
                                      // prefixIcon: Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical: 20, horizontal: 8),
                                      //   child: Text(
                                      //     " +91",
                                      //     style: GoogleFonts.roboto(
                                      //         fontSize: 14.sp,
                                      //         fontWeight: kFW500,
                                      //         color: kblack),
                                      //   ),
                                      // ),
                                      suffixIcon: Container(
                                        width: 70,
                                        height: 50,
                                        // color: Kpink,
                                        decoration: BoxDecoration(
                                            color: Kpink,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10.r),
                                                bottomRight:
                                                    Radius.circular(10.r))),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Image.asset(
                                            "assets/images/down_arrows.png",
                                            // width: 28.w,
                                            // height: 30.h,
                                            //  height: 80.h,
                                            // width: 150.w,
                                          ),
                                        ),
                                      ),
                                      // suffixIcon: Container(
                                      //   width: 70,
                                      //   height: 60,
                                      //   // color: Kpink,
                                      //   decoration: BoxDecoration(
                                      //       color: Kpink,
                                      //       borderRadius: BorderRadius.only(
                                      //           topRight: Radius.circular(10.r),
                                      //           bottomRight:
                                      //               Radius.circular(10.r))),
                                      //   padding: EdgeInsets.symmetric(
                                      //       vertical: 20, horizontal: 8),
                                      //   child: RotatedBox(
                                      //     quarterTurns: 3,
                                      //     child: Image.asset(
                                      //       "assets/images/down_arrows.png",
                                      //       // width: 28.w,
                                      //       // height: 30.h,
                                      //       //  height: 80.h,
                                      //       // width: 150.w,
                                      //     ),
                                      //   ),
                                      // ),

                                      hintText: "    Emergency Contact NUmber",
                                      alignLabelWithHint: true,
                                      //make hint text

                                      hintStyle: TextStyle(
                                        color: kcarden,
                                        fontSize: 15.sp,
                                        fontWeight: kFW500,
                                      ),

                                      //create lable
                                    ),
                                  ),
                                ),
                              )),
                        Obx(() => apicontroller.isSignupAdhaarVerified ==
                                    true &&
                                apicontroller.isSignupBiometricVerified ==
                                    true &&
                                apicontroller.isEmergencyVerified == true
                            ? Center(
                                child: InkWell(
                                  onTap: () {
                                    apicontroller
                                        .getRapidoEmpProfileNvaigation();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 30.h),
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
                                ),
                              )
                            : Center(
                                child: InkWell(
                                  onTap: () {
                                    apicontroller
                                        .getRapidoEmpProfileNvaigation();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 30.h),
                                    // padding: Padding,
                                    height: 40,
                                    width: 200.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: KBLUESHADE,
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
                              )),
                        SizedBox(
                          height: 60.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      ////////////////////old
      // Scaffold(
      //   body: Center(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         SizedBox(
      //           height: 20.h,
      //         ),
      //         InkWell(
      //             onTap: () {
      //               Get.toNamed(kAddContactScreen);
      //             },
      //             child: Text("Emergency Contact Number")),
      //         SizedBox(
      //           height: 20.h,
      //         ),
      //         GestureDetector(
      //             onTap: () {
      //               Get.toNamed(kNewBiometricScreen);
      //             },
      //             child: Text("Biometrics")),
      //         SizedBox(
      //           height: 20.h,
      //         ),
      //         InkWell(
      //             onTap: () {
      //               Get.toNamed(kNewAdhaarPanScreen);
      //               // Get.toNamed(kUserAnyIDScreen);
      //             },
      //             child: Text("Adhaar")),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
