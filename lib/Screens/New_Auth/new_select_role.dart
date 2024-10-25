import 'package:womentaxi/untils/export_file.dart';

class NewSelectRole extends StatefulWidget {
  const NewSelectRole({super.key});

  @override
  State<NewSelectRole> createState() => _NewSelectRoleState();
}

class _NewSelectRoleState extends State<NewSelectRole> {
  ApiController apiController = Get.put(ApiController());
  TextEditingController _phoneController = TextEditingController();
  String? selectedGenderValue;
  final _formKey = GlobalKey<FormState>();
  // final List<String> Genders = ['captain', 'user'];
  final List<String> Genders = ['rider', 'user'];
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
                    "assets/images/right_girl.png",

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
                      // apicontroller.isRegistrationIconSelected == false
                      //     ?
                      //     InkWell(
                      //         onTap: () async {
                      //           setState(() {
                      //             apiController.isRegistrationIconSelected
                      //                 .value = true;
                      //           });
                      //           print("ram");
                      //           // var payload = {"mobile": _phoneController.text};

                      //           // if (_formKey.currentState!.validate()) {
                      //           //   apiController.mobileRegistration(payload);
                      //           // }
                      //         },
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //               borderRadius:
                      //                   BorderRadius.circular(10.0),
                      //               color: Kwhite,
                      //               boxShadow: const [
                      //                 BoxShadow(
                      //                   color: Color(0x3FD3D1D8),
                      //                   blurRadius: 30,
                      //                   offset: Offset(15, 15),
                      //                   spreadRadius: 0,
                      //                 )
                      //               ]),
                      //           child: TextFormField(
                      //             controller: _phoneController,
                      //             enabled: false,
                      //             keyboardType: TextInputType.phone,
                      //             style: TextStyle(
                      //                 fontSize: 14.sp,
                      //                 fontWeight: kFW500,
                      //                 color: kblack),
                      //             decoration: InputDecoration(
                      //               focusColor: Kwhite,
                      //               filled: true,
                      //               floatingLabelBehavior:
                      //                   FloatingLabelBehavior.auto,
                      //               contentPadding:
                      //                   const EdgeInsets.symmetric(
                      //                 vertical: 16,
                      //               ),
                      //               // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

                      //               border: OutlineInputBorder(
                      //                 borderRadius:
                      //                     BorderRadius.circular(10.r),
                      //               ),
                      //               enabledBorder: OutlineInputBorder(
                      //                 borderSide: const BorderSide(
                      //                     color: Kbordergery, width: 0.5),
                      //                 borderRadius:
                      //                     BorderRadius.circular(10.r),
                      //               ),
                      //               errorBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                     color: kblack.withOpacity(0.6),
                      //                     width: 0.5),
                      //                 borderRadius:
                      //                     BorderRadius.circular(10.r),
                      //               ),
                      //               disabledBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                     color: kblack.withOpacity(0.6),
                      //                     width: 0.5),
                      //                 borderRadius:
                      //                     BorderRadius.circular(10.r),
                      //               ),
                      //               focusedErrorBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                     color: Kpink.withOpacity(0.6),
                      //                     width: 0.5),
                      //                 borderRadius:
                      //                     BorderRadius.circular(10.r),
                      //               ),
                      //               focusedBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                     color: Kpink.withOpacity(0.6),
                      //                     width: 1),
                      //                 borderRadius:
                      //                     BorderRadius.circular(10.r),
                      //               ),
                      //               fillColor: Kwhite,
                      //               // prefixIcon: Padding(
                      //               //   padding: const EdgeInsets.symmetric(
                      //               //       vertical: 20, horizontal: 8),
                      //               //   child: Text(
                      //               //     " +91",
                      //               //     style: GoogleFonts.roboto(
                      //               //         fontSize: 14.sp,
                      //               //         fontWeight: kFW500,
                      //               //         color: kblack),
                      //               //   ),
                      //               // ),
                      //               suffixIcon: Container(
                      //                 width: 70,
                      //                 // color: Kpink,
                      //                 decoration: BoxDecoration(
                      //                     color: Kpink,
                      //                     borderRadius: BorderRadius.only(
                      //                         topRight:
                      //                             Radius.circular(10.r),
                      //                         bottomRight:
                      //                             Radius.circular(10.r))),
                      //                 padding: EdgeInsets.symmetric(
                      //                     vertical: 20, horizontal: 8),
                      //                 child: Image.asset(
                      //                   "assets/images/down_arrows.png",
                      //                   // width: 28.w,
                      //                   // height: 30.h,
                      //                   //  height: 80.h,
                      //                   // width: 150.w,
                      //                 ),
                      //               ),

                      //               hintText:
                      //                   "    Select Registration Type",
                      //               alignLabelWithHint: true,
                      //               //make hint text

                      //               hintStyle: TextStyle(
                      //                 color: kcarden,
                      //                 fontSize: 15.sp,
                      //                 fontWeight: kFW500,
                      //               ),

                      //               //create lable
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //     :
                      //     InkWell(
                      //         onTap: () async {
                      //           setState(() {
                      //             apiController.isRegistrationIconSelected
                      //                 .value = false;
                      //           });
                      //           print("ram");
                      //           // var payload = {"mobile": _phoneController.text};

                      //           // if (_formKey.currentState!.validate()) {
                      //           //   apiController.mobileRegistration(payload);
                      //           // }
                      //         },
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //               borderRadius:
                      //                   BorderRadius.circular(10.0),
                      //               color: Kwhite,
                      //               boxShadow: const [
                      //                 BoxShadow(
                      //                   color: Color(0x3FD3D1D8),
                      //                   blurRadius: 30,
                      //                   offset: Offset(15, 15),
                      //                   spreadRadius: 0,
                      //                 )
                      //               ]),
                      //           child: TextFormField(
                      //             controller: _phoneController,
                      //             enabled: false,
                      //             keyboardType: TextInputType.phone,
                      //             style: TextStyle(
                      //                 fontSize: 14.sp,
                      //                 fontWeight: kFW500,
                      //                 color: kblack),
                      //             decoration: InputDecoration(
                      //               focusColor: Kwhite,
                      //               filled: true,
                      //               floatingLabelBehavior:
                      //                   FloatingLabelBehavior.auto,
                      //               contentPadding:
                      //                   const EdgeInsets.symmetric(
                      //                 vertical: 16,
                      //               ),
                      //               // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

                      //               border: OutlineInputBorder(
                      //                 borderRadius:
                      //                     BorderRadius.circular(10.r),
                      //               ),
                      //               enabledBorder: OutlineInputBorder(
                      //                 borderSide: const BorderSide(
                      //                     color: Kbordergery, width: 0.5),
                      //                 borderRadius:
                      //                     BorderRadius.circular(10.r),
                      //               ),
                      //               errorBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                     color: kblack.withOpacity(0.6),
                      //                     width: 0.5),
                      //                 borderRadius:
                      //                     BorderRadius.circular(10.r),
                      //               ),
                      //               disabledBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                     color: kblack.withOpacity(0.6),
                      //                     width: 0.5),
                      //                 borderRadius:
                      //                     BorderRadius.circular(10.r),
                      //               ),
                      //               focusedErrorBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                     color: Kpink.withOpacity(0.6),
                      //                     width: 0.5),
                      //                 borderRadius:
                      //                     BorderRadius.circular(10.r),
                      //               ),
                      //               focusedBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                     color: Kpink.withOpacity(0.6),
                      //                     width: 1),
                      //                 borderRadius:
                      //                     BorderRadius.circular(10.r),
                      //               ),
                      //               fillColor: Kwhite,
                      //               // prefixIcon: Padding(
                      //               //   padding: const EdgeInsets.symmetric(
                      //               //       vertical: 20, horizontal: 8),
                      //               //   child: Text(
                      //               //     " +91",
                      //               //     style: GoogleFonts.roboto(
                      //               //         fontSize: 14.sp,
                      //               //         fontWeight: kFW500,
                      //               //         color: kblack),
                      //               //   ),
                      //               // ),
                      //               suffixIcon: Container(
                      //                 width: 70,
                      //                 // color: Kpink,
                      //                 decoration: BoxDecoration(
                      //                     color: Kpink,
                      //                     borderRadius: BorderRadius.only(
                      //                         topRight:
                      //                             Radius.circular(10.r),
                      //                         bottomRight:
                      //                             Radius.circular(10.r))),
                      //                 padding: EdgeInsets.symmetric(
                      //                     vertical: 20, horizontal: 8),
                      //                 child: RotatedBox(
                      //                   quarterTurns: 2,
                      //                   child: Image.asset(
                      //                     "assets/images/down_arrows.png",
                      //                     // width: 28.w,
                      //                     // height: 30.h,
                      //                     //  height: 80.h,
                      //                     // width: 150.w,
                      //                   ),
                      //                 ),
                      //               ),

                      //               hintText:
                      //                   "    Select Registration Type",
                      //               alignLabelWithHint: true,
                      //               //make hint text

                      //               hintStyle: TextStyle(
                      //                 color: kcarden,
                      //                 fontSize: 15.sp,
                      //                 fontWeight: kFW500,
                      //               ),

                      //               //create lable
                      //             ),
                      //           ),
                      //         ),
                      //       ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Select Registration Type",
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
                            "Please select your role in this app.",
                            style: GoogleFonts.roboto(
                                fontSize: 13.sp,
                                fontWeight: kFW400,
                                color: kcarden),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Kwhite,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3FD3D1D8),
                                    blurRadius: 30,
                                    offset: Offset(15, 15),
                                    spreadRadius: 0,
                                  )
                                  // BoxShadow(
                                  //   color: Color(0x3FD3D1D8),
                                  //   blurRadius: 30,
                                  //   offset: Offset(15, 15),
                                  //   spreadRadius: 2,
                                  // )
                                ]),
                            child: DropdownButtonFormField2<String>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kblack.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kblack.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kblack.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Kpink, width: 1),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Kpink, width: 1),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              hint: Text(
                                'Select Registration Type',
                                style: GoogleFonts.roboto(
                                  fontSize: kSixteenFont,
                                  color: kcarden,
                                ),
                              ),
                              items: Genders.map(
                                  (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          //   "Select Registration Type",
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                          ),
                                        ),
                                      )).toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select Registration Type.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (value.toString() == "rider") {
                                    apiController.selectedRegisterType.value =
                                        "captain";
                                  } else {
                                    apiController.selectedRegisterType.value =
                                        value.toString();
                                  }

                                  print(
                                      apiController.selectedRegisterType.value);
                                  // authentication.donorRegisterGender.value =
                                  //     value.toString();
                                  selectedGenderValue = value.toString();
                                  print(selectedGenderValue);
                                  apiController.doesUserSelectedRole.value =
                                      true;
                                });

                                // authentication.registerDonorBloodController.value =
                                //     selectedValue as TextEditingValue;
                                //Do something when selected item is changed.
                              },
                              onSaved: (value) {
                                selectedGenderValue = value.toString();
                                print(selectedGenderValue);
                                // authentication.registerDonorBloodController.value =
                                //     selectedValue as TextEditingValue;
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.only(right: 8),
                              ),
                              iconStyleData: IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: kblack.withOpacity(0.6),
                                ),
                                iconSize: 24,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     // setState(() {
                          //     //   apiController.selectedRegisterType
                          //     //       .value = "user";
                          //     //   print(apiController
                          //     //       .selectedRegisterType.value);
                          //     // });

                          //     // Get.toNamed(kUserPhoneRegister);
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.only(left: 5.w),
                          //     height: 60.h,
                          //     // color: Colors.yellow,
                          //     child: Row(
                          //       children: [
                          //         apiController.selectedRegisterType ==
                          //                 "user"
                          //             ? Image.asset(
                          //                 "assets/images/active_ellipse.png",
                          //                 // width: 28.w,
                          //                 // height: 30.h,
                          //                 //  height: 80.h,
                          //                 // width: 150.w,
                          //               )
                          //             : Padding(
                          //                 padding:
                          //                     EdgeInsets.only(left: 6.w),
                          //                 child: Image.asset(
                          //                   "assets/images/inactive_ellipse.png",
                          //                   // width: 28.w,
                          //                   // height: 30.h,
                          //                   //  height: 80.h,
                          //                   // width: 150.w,
                          //                 ),
                          //               ),
                          //         SizedBox(
                          //           width: 10.w,
                          //         ),
                          //         Text(
                          //           "USER",
                          //           style: GoogleFonts.roboto(
                          //               fontSize: kSixteenFont,
                          //               color: apiController
                          //                           .selectedRegisterType ==
                          //                       "user"
                          //                   ? Kpink
                          //                   : kcarden,
                          //               fontWeight: kFW500),
                          //         ),
                          //         // Text(
                          //         //   "Continue",
                          //         //   style: GoogleFonts.roboto(
                          //         //       fontSize: kSixteenFont,
                          //         //       color: apiController
                          //         //                   .selectedRegisterType ==
                          //         //               "user"
                          //         //           ? Kpink
                          //         //           : kcarden,
                          //         //       fontWeight: kFW500),
                          //         // ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // GestureDetector(
                          //   onTap: () {
                          //     // setState(() {
                          //     //   apiController.selectedRegisterType
                          //     //       .value = "captain";
                          //     //   print(apiController
                          //     //       .selectedRegisterType.value);
                          //     // });
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.only(left: 5.w),
                          //     height: 60.h,
                          //     // color: Colors.yellow,
                          //     child: Row(
                          //       children: [
                          //         apiController.selectedRegisterType ==
                          //                 "captain"
                          //             ? Image.asset(
                          //                 "assets/images/active_ellipse.png",
                          //                 // width: 28.w,
                          //                 // height: 30.h,
                          //                 //  height: 80.h,
                          //                 // width: 150.w,
                          //               )
                          //             : Padding(
                          //                 padding:
                          //                     EdgeInsets.only(left: 6.w),
                          //                 child: Image.asset(
                          //                   "assets/images/inactive_ellipse.png",
                          //                   // width: 28.w,
                          //                   // height: 30.h,
                          //                   //  height: 80.h,
                          //                   // width: 150.w,
                          //                 ),
                          //               ),
                          //         SizedBox(
                          //           width: 10.w,
                          //         ),
                          //         Text(
                          //           "RIDER",
                          //           style: GoogleFonts.roboto(
                          //               fontSize: kSixteenFont,
                          //               color: apiController
                          //                           .selectedRegisterType ==
                          //                       "captain"
                          //                   ? Kpink
                          //                   : kcarden,
                          //               fontWeight: kFW500),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          apiController.doesUserSelectedRole == true
                              ? GestureDetector(
                                  onTap: () {
                                    Get.toNamed(kNewSignUpScreen);
                                  },
                                  child: Center(
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
                                  ))
                              : GestureDetector(
                                  onTap: () {
                                    Fluttertoast.showToast(
                                        msg: 'Please Enter Role');
                                  },
                                  child: Center(
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
                                  )),
                          SizedBox(
                            height: 90.h,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
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

                //   Obx(() => apiController.mobileRegistrationLoading == true
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
  }
}
