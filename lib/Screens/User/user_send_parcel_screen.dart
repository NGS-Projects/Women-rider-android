import 'package:womentaxi/untils/export_file.dart';
import 'package:intl/intl.dart';

class UserSendparcel extends StatefulWidget {
  const UserSendparcel({super.key});

  @override
  State<UserSendparcel> createState() => _UserSendparcelState();
}

class _UserSendparcelState extends State<UserSendparcel> {
  ApiController apicontroller = Get.put(ApiController());
  UserApiController userapicontroller = Get.put(UserApiController());
  final LocalAuthentication auth = LocalAuthentication();
  ////////////////////
  Future<void> authenticateWithBiometrics() async {
    try {
      final authenticated = await auth.authenticate(
          localizedReason: 'Authenticate with fingerprint or Face ID',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));

      if (!mounted) {
        return;
      }

      if (authenticated) {
        Get.toNamed(kUserBookRideAuth);

        // apicontroller.captainAvailability();
        // setState(() {
        //   _switchValue = value;
        //   apicontroller.duty == "ON DUTY"
        //       ? apicontroller.duty.value = "OFF DUTY"
        //       : apicontroller.duty.value = "ON DUTY";
        // });
        // Get.toNamed(KSplash);

        // Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
      }
    } on PlatformException catch (e) {
      print(e);

      return;
    }
  }

  //////////
  final List<String> bloodgroupss = [
    'Food',
    'Medicines',
    'Electronics',
    'Clothes',
    'Others'
  ];

  String? selectedValue;
  @override
  void initState() {
    setState(() {
      apicontroller.selectedParcelType.value = "Food";
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("dd-MM-yyyy").format(now);
    String formattedTime = DateFormat("hh:mm a").format(now);
    return Scaffold(
      backgroundColor: Kwhite,
      appBar: AppBar(
        backgroundColor: Kwhite,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: KTextdark,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          "Parcel",
          style: GoogleFonts.roboto(
              fontSize: 22.sp, color: kcarden, fontWeight: kFW600),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() => Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 16.w.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Kwhite,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3FD3D1D8),
                            blurRadius: 5,
                            offset: Offset(1, 1),
                            spreadRadius: 2,
                          )
                        ]),
                    child: Column(
                      children: [
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
                            SizedBox(
                              width: 250.w,
                              child: Text(
                                apicontroller.searchedDataPickupAddress.value,
                                maxLines: 1,
                                style: GoogleFonts.roboto(
                                    fontSize: kFourteenFont,
                                    color: KdarkText,
                                    fontWeight: kFW500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Divider(),
                        SizedBox(
                          height: 12.h,
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
                            SizedBox(
                              width: 250.w,
                              child: Text(
                                apicontroller.searchedDataDropAddress.value,
                                maxLines: 1,
                                style: GoogleFonts.roboto(
                                    fontSize: kFourteenFont,
                                    color: KdarkText,
                                    fontWeight: kFW500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Select Parcel Type",
                  style: GoogleFonts.roboto(
                      fontSize: kFourteenFont,
                      color: kcarden,
                      fontWeight: kFW500),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          apicontroller.selectedParcelType.value = "Food";
                        });
                      },
                      child: Text(
                        "Food",
                        style: GoogleFonts.roboto(
                            fontSize: kFourteenFont,
                            color: apicontroller.selectedParcelType == "Food"
                                //apicontroller.selectedVehicle == "auto"
                                ? Kpink
                                : kcarden,
                            fontWeight: kFW500),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          apicontroller.selectedParcelType.value = "Groceries";
                        });
                      },
                      child: Text(
                        "Groceries",
                        style: GoogleFonts.roboto(
                            fontSize: kFourteenFont,
                            color:
                                apicontroller.selectedParcelType == "Groceries"
                                    //apicontroller.selectedVehicle == "auto"
                                    ? Kpink
                                    : kcarden,
                            fontWeight: kFW500),
                      ),
                    ),
                    // Text(
                    //   "Groceries",
                    //   style: GoogleFonts.roboto(
                    //       fontSize: kFourteenFont,
                    //       color: kcarden,
                    //       fontWeight: kFW500),
                    // ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          apicontroller.selectedParcelType.value = "Medicine";
                        });
                      },
                      child: Text(
                        "Medicine",
                        style: GoogleFonts.roboto(
                            fontSize: kFourteenFont,
                            color:
                                apicontroller.selectedParcelType == "Medicine"
                                    //apicontroller.selectedVehicle == "auto"
                                    ? Kpink
                                    : kcarden,
                            fontWeight: kFW500),
                      ),
                    ),
                    // Text(
                    //   "Medicine",
                    //   style: GoogleFonts.roboto(
                    //       fontSize: kFourteenFont,
                    //       color: kcarden,
                    //       fontWeight: kFW500),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          apicontroller.selectedParcelType.value = "Clothes";
                        });
                      },
                      child: Text(
                        "Clothes",
                        style: GoogleFonts.roboto(
                            fontSize: kFourteenFont,
                            color: apicontroller.selectedParcelType == "Clothes"
                                //apicontroller.selectedVehicle == "auto"
                                ? Kpink
                                : kcarden,
                            fontWeight: kFW500),
                      ),
                    ),
                    // Text(
                    //   "Clothes",
                    //   style: GoogleFonts.roboto(
                    //       fontSize: kFourteenFont,
                    //       color: kcarden,
                    //       fontWeight: kFW500),
                    // ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          apicontroller.selectedParcelType.value = "Documents";
                        });
                      },
                      child: Text(
                        "Documents",
                        style: GoogleFonts.roboto(
                            fontSize: kFourteenFont,
                            color:
                                apicontroller.selectedParcelType == "Documents"
                                    //apicontroller.selectedVehicle == "auto"
                                    ? Kpink
                                    : kcarden,
                            fontWeight: kFW500),
                      ),
                    ),
                    // Text(
                    //   "Documents",
                    //   style: GoogleFonts.roboto(
                    //       fontSize: kFourteenFont,
                    //       color: kcarden,
                    //       fontWeight: kFW500),
                    // ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          apicontroller.selectedParcelType.value =
                              "Electronics";
                        });
                      },
                      child: Text(
                        "Electronics",
                        style: GoogleFonts.roboto(
                            fontSize: kFourteenFont,
                            color: apicontroller.selectedParcelType ==
                                    "Electronics"
                                //apicontroller.selectedVehicle == "auto"
                                ? Kpink
                                : kcarden,
                            fontWeight: kFW500),
                      ),
                    ),
                    // Text(
                    //   "Electronics",
                    //   style: GoogleFonts.roboto(
                    //       fontSize: kFourteenFont,
                    //       color: kcarden,
                    //       fontWeight: kFW500),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 25.w,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          apicontroller.selectedParcelType.value = "Others";
                        });
                      },
                      child: Text(
                        "Others",
                        style: GoogleFonts.roboto(
                            fontSize: kFourteenFont,
                            color: apicontroller.selectedParcelType == "Others"
                                //apicontroller.selectedVehicle == "auto"
                                ? Kpink
                                : kcarden,
                            fontWeight: kFW500),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 25.h),
                  child: CustomFormField(
                    enabled: true,
                    controller: apicontroller.instructionsController,
                    obscureText: false,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    fontSize: kFourteenFont,
                    fontWeight: FontWeight.w500,
                    textColor: kcarden,
                    hintText: "Enter Instructions",
                    maxLines: 1,
                    readOnly: false,
                    label: 'Instructions',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Instructions';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Fit these specifications",
                  style: GoogleFonts.roboto(
                      fontSize: kFourteenFont,
                      color: kcarden,
                      fontWeight: kFW500),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/weights.png",
                      height: 20.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      "Parcel weights 10Kg or less",
                      style: GoogleFonts.roboto(
                          fontSize: kFourteenFont,
                          color: apicontroller.selectedParcelType == "Others"
                              //apicontroller.selectedVehicle == "auto"
                              ? Kpink
                              : kcarden,
                          fontWeight: kFW500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning,
                      size: 18.sp,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      "No illgeal,alcohol or restricted items",
                      style: GoogleFonts.roboto(
                          fontSize: kFourteenFont,
                          color: apicontroller.selectedParcelType == "Others"
                              //apicontroller.selectedVehicle == "auto"
                              ? Kpink
                              : kcarden,
                          fontWeight: kFW500),
                    ),
                  ],
                ),

                ///////////////////////////////
                CustomButton(
                    margin: EdgeInsets.only(top: 80.h),
                    width: double.infinity,
                    height: 42.h,
                    fontSize: kFourteenFont,
                    fontWeight: kFW700,
                    textColor: Kwhite,
                    borderRadius: BorderRadius.circular(30.r),
                    label: "Book Ride",
                    isLoading: false,
                    onTap: () {
                      setState(() {
                        apicontroller.userRideAutenticationBody.value = {
                          "dropLangitude":
                              "${apicontroller.searchedData["waypoints"][1]["location"][0]}",
                          "dropLongitude":
                              "${apicontroller.searchedData["waypoints"][1]["location"][1]}",
                          "pickupLangitude":
                              "${apicontroller.searchedData["waypoints"][0]["location"][0]}",
                          "pickupLongitude":
                              "${apicontroller.searchedData["waypoints"][0]["location"][1]}",
                          "pickupAddress":
                              apicontroller.searchedDataPickupAddress.value,
                          "dropAddress":
                              apicontroller.searchedDataDropAddress.value,
                          "price": "250",
                          "orderPlaceTime": formattedTime,
                          "orderPlaceDate": formattedDate,
                          "vehicleType": apicontroller.selectedVehicle.value,
                          "parcelType": apicontroller.selectedParcelType.value,
                          "deliveryInstruction":
                              apicontroller.instructionsController.text
                        };
                      });
                      if (apicontroller.profileData["userVerified"] == true) {
                        if (apicontroller.profileData["authenticationImage"] ==
                            null) {
                          Get.toNamed(kUserUploadDocs);
                        } else {
                          authenticateWithBiometrics();
                          setState(() {
                            userapicontroller.isopenedUserCompleteScreen.value =
                                false;
                          });
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Yuor Account is not verified.");
                      }

                      // userapicontroller.placeOrdersUser(payload);
                    }),
                ////////////////////
              ],
            ))),
      ),
    );
  }
}
