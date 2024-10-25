import 'package:flutter/material.dart';

import 'package:womentaxi/untils/export_file.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  ApiController authentication = Get.put(ApiController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apicontroller.getRapidoEmpProfile();
  }

  @override
  Widget build(BuildContext context) {
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
                Column(
                  children: [
                    Image.asset(
                      "assets/images/womenriders.png",
                      height: 80.h,
                      // width: 150.w,
                    ),
                    Obx(
                      () => authentication
                                  .profileData["signUpCompletePercentage"] ==
                              null
                          ? SizedBox()
                          : LinearProgressIndicator(
                              value: authentication
                                      .profileData["signUpCompletePercentage"] /
                                  100,
                              backgroundColor: Colors.grey,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.pink),
                            ),
                    )
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(15),
                  child: Image.asset(
                    "assets/images/contact_save.png",

                    height: MediaQuery.of(context).size.height / 3,
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
                        height: 20.h,
                      ),
                      Text(
                        "Emergency Contact Number",
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
                        "Please enter phone number",
                        style: GoogleFonts.roboto(
                            fontSize: 13.sp,
                            fontWeight: kFW400,
                            color: kcarden),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomFormField(
                        enabled: true,
                        controller:
                            authentication.registerworemergencyController,
                        obscureText: false,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        fontSize: kFourteenFont,
                        fontWeight: FontWeight.w500,
                        hintText: "Enter  phone Number",
                        maxLines: 1,
                        readOnly: false,
                        label: ' Phone Number',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Obx(() => CustomButton(
                          margin: EdgeInsets.only(top: 20.h),
                          borderRadius: BorderRadius.circular(30.r),
                          Color: Kpink,
                          textColor: Kwhite,
                          height: 42.h,
                          width: double.infinity,
                          label: authentication.addContactLoading == true
                              ? "Loading"
                              : "Add",
                          fontSize: kSixteenFont,
                          fontWeight: kFW500,
                          isLoading: false,
                          onTap: () {
                            var payload = {
                              "personalContact": authentication
                                  .registerworemergencyController.text
                            };

                            authentication.addEmergencyForm(payload);
                          })),
                      SizedBox(
                        height: 60.h,
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
    //   body: Center(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         CustomFormField(
    //           enabled: true,
    //           controller: authentication.registerworemergencyController,
    //           obscureText: false,
    //           contentPadding:
    //               const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    //           fontSize: kFourteenFont,
    //           fontWeight: FontWeight.w500,
    //           hintText: "Enter  Address",
    //           maxLines: 1,
    //           readOnly: false,
    //           label: ' Address',
    //           validator: (value) {
    //             if (value!.isEmpty) {
    //               return 'Please enter address';
    //             }
    //             return null;
    //           },
    //         ),
    //         SizedBox(
    //           height: 20.h,
    //         ),
    //         Obx(() => CustomButton(
    //             margin: EdgeInsets.only(top: 50.h),
    //             borderRadius: BorderRadius.circular(30.r),
    //             Color: Kpink,
    //             textColor: Kwhite,
    //             height: 42.h,
    //             width: double.infinity,
    //             label: authentication.donorRegistrationLoading == true
    //                 ? "Loading"
    //                 : "Sign Up",
    //             fontSize: kSixteenFont,
    //             fontWeight: kFW500,
    //             isLoading: false,
    //             onTap: () {
    //               var payload = {
    //                 "personalContact":
    //                     authentication.registerworemergencyController.text
    //               };

    //               authentication.addEmergencyForm(payload);

    //             })),
    //       ],
    //     ),
    //   ),
    // );
  }
}
