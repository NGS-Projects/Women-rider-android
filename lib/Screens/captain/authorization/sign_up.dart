import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String selectedgender = "";
  // location

  /////////////////////////////////////////////
  final LocalAuthentication auth = LocalAuthentication();

  SupportState supportState = SupportState.unknown;

  List<BiometricType>? availableBiometrics;
  /////////////////////////////////////////

  int activeIndex = 0;

  bool value = false;
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();
  // GoogleMapController? _controller;

  double lat = 37.42796133580664;
  double lon = -122.085749655962;

  String? _currentAddress;
  String? _currentAddresspincode;
  String? _destination;

  var isLoading = "none";

  /////////////////////////////
  final List<String> bloodgroupss = [
    'captain',
    'user',
  ];

  //
  final List<String> Genders = [
    'female',
  ];

  String? selectedValue;
  String? selectedGenderValue;
  DateTime selectedDate = DateTime.now();
  DateTime choosenDate = DateTime.now();
  var selectDate = "Select Date".obs;

  bool passwordVisible = true;
  bool confirmpasswordVisible = true;
  ApiController authentication = Get.put(ApiController());
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

  void setId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // print('Running on ${androidInfo.device}');
    UserSimplePreferences.setuniquecode(androidInfo.id);
    print("object");
  }

  @override
  void initState() {
    checkBiometric();

    getAvailableBiometrics();
    setId();
    //     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // // print('Running on ${androidInfo.device}');
    // UserSimplePreferences.setuniquecode(androidInfo.device);
    // TODO: implement initState
    super.initState();
  }

  /////////
  Future<void> checkBiometric() async {
    late bool canCheckBiometric;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;

      print("Biometric supported: $canCheckBiometric");
    } on PlatformException catch (e) {
      print(e);

      canCheckBiometric = false;
    }
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> biometricTypes;

    try {
      biometricTypes = await auth.getAvailableBiometrics();

      print("supported biometrics $biometricTypes");
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) {
      return;
    }

    setState(() {
      availableBiometrics = biometricTypes;
    });
  }

  //

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
        Get.toNamed(kBiometricRegistration);

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

  ///////////////

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Kwhite,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                left: 20.w, right: 20.w, bottom: 20.h, top: 100.h),
            child: Form(
                key: _formKey,
                // autovalidateMode: AutovalidateMode.always,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height: 45.h,
                      //   child: FadeAnimatedTextKit(
                      //     totalRepeatCount: 50,
                      //     duration: Duration(milliseconds: 3500),
                      //     text: ["Sign Up as Donor", "Register Blood Bank"],
                      //     textStyle: GoogleFonts.roboto(
                      //         fontSize: 30.sp,
                      //         color: Kpink,
                      //         fontWeight: kFW600),
                      //   ),
                      // ),

                      Text(
                        "Sign Up",
                        style: GoogleFonts.roboto(
                            fontSize: 30.sp, color: Kpink, fontWeight: kFW600),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      // SizedBox(

                      //   height: 90.h,
                      // ),

                      // Obx(
                      //   () => serviceController.address.value != null
                      //       ? Text(
                      //           "${serviceController.address.value}",
                      //           //serviceController.address.value,
                      //           style:GoogleFonts.roboto(
                      //               fontSize: kSixteenFont,
                      //               color: KText,
                      //               fontWeight: kFW400),
                      //         )
                      //       : Text(
                      //           "Please wait",
                      //           //serviceController.address.value,
                      //           style:GoogleFonts.roboto(
                      //               fontSize: kSixteenFont,
                      //               color: KText,
                      //               fontWeight: kFW400),
                      //         ),
                      // ),

                      Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Create an account now to get started on your health and happiness journey.",
                            style: GoogleFonts.roboto(
                                fontSize: kSixteenFont,
                                color: KText,
                                fontWeight: kFW400),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          // momsfood
                          // CustomFormField(
                          //   enabled: true,
                          //   controller: apicontroller.signupfullnameController,
                          //   obscureText: false,
                          //   contentPadding: const EdgeInsets.symmetric(
                          //       vertical: 16, horizontal: 8),
                          //   fontSize: kFourteenFont,
                          //   fontWeight: FontWeight.w500,
                          //   hintText: "Full Name",
                          //   maxLines: 1,
                          //   readOnly: false,
                          //   label: 'Full Name',
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please enter Full Name';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // CustomFormFieldOutilined(
                          //   controller: authentication.registerDonorfirstNameController,
                          //   obscureText: false,
                          //   contentPadding:
                          //       const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          //   fontSize: kFourteenFont,
                          //   fontWeight: FontWeight.w500,
                          //   hintText: "Enter First Name",
                          //   maxLines: 1,
                          //   readOnly: false,
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please enter First Name';
                          //     }
                          //     return null;
                          //   },
                          //   onChanged: (value) {},
                          //   label: 'First Name',
                          // ),

                          CustomFormField(
                            enabled: true,
                            controller:
                                authentication.registerDonorfirstNameController,
                            obscureText: false,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            fontSize: kFourteenFont,
                            fontWeight: FontWeight.w500,
                            hintText: "Enter  Name",
                            maxLines: 1,
                            readOnly: false,
                            label: ' Name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomFormField(
                            enabled: true,
                            controller:
                                authentication.registerDonoremailController,
                            obscureText: false,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            fontSize: kFourteenFont,
                            fontWeight: FontWeight.w500,
                            hintText: "Enter  Email",
                            maxLines: 1,
                            readOnly: false,
                            label: ' Email',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                          ),
                          ///////////
                          SizedBox(
                            height: 20.h,
                          ),

                          CustomFormField(
                            // hintColor: DateFormat.yMMMd()
                            //             .format(selectedDate) ==
                            //         DateFormat.yMMMd()
                            //             .format(DateTime.now())
                            //     ? KTextgery.withOpacity(0.5)
                            //     : KdarkText,
                            // labelColor: KText,
                            suffix: InkWell(
                                onTap: () async {
                                  // setState(() {
                                  //   isFormOpen.value = true;
                                  // });
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    firstDate: DateTime(1924, 8),
                                    //  firstDate: DateTime(2015, 8),
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            // background: white,
                                            primary: Kpink,
                                            //onPrimary: white,
                                            onSurface: Colors.black,
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                                // primary: Kbluedark,
                                                ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );

                                  if (picked != null &&
                                      picked != selectedDate) {
                                    // if (picked.isAfter(DateTime.now())) {
                                    //   // date.isAfter(DateTime.now()
                                    //   //  if(date.month>DateTime.now().month){
                                    //   Fluttertoast.showToast(
                                    //       msg: "Upcomming Months can't be selected");
                                    // } else {
                                    setState(() {
                                      selectedDate = picked;
                                      choosenDate = selectedDate;
                                      selectDate.value =
                                          DateFormat('MM/dd/yyyy')
                                              // DateFormat.yMMMEd()
                                              .format(selectedDate);
                                    });
                                    //  }
                                    // setState(() {
                                    //   selectedDate = picked;
                                    //   choosenDate = selectedDate;
                                    // }
                                    // );
                                  }
                                },
                                child: Icon(
                                  Icons.calendar_today,
                                  color: kblack.withOpacity(0.6),
                                )),
                            enabled: true,

                            obscureText: false,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            // fontSize: kFourteenFont,
                            // fontWeight: FontWeight.w500,
                            fontSize: kFourteenFont,
                            fontWeight: FontWeight.w500,
                            textColor: KdarkText,
                            keyboardType: TextInputType.none,
                            textStyle: GoogleFonts.roboto(
                              color: kblack,
                              fontSize: kFourteenFont,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            controller: authentication
                                .registerDonorDateofBirthController,
                            hintText:
                                // selectedDate == DateTime.now()
                                DateFormat.yMMMd().format(selectedDate) ==
                                        DateFormat.yMMMd()
                                            .format(DateTime.now())
                                    ? "Select Date"
                                    : DateFormat('dd/MM/yyyy')
                                        // DateFormat.yMMMEd()
                                        .format(selectedDate)
                            // DateFormat.yMMMEd().format(selectedDate)
                            ,
                            hintStyle: TextStyle(color: KdarkText),
                            readOnly: false,
                            onChanged: (value) {},
                            label: 'Date of Birth',
                            // hintText: "Full Name",
                            // maxLines: 1,
                            // readOnly: false,
                            // label: 'Full Name',
                            validator: (value) {
                              if (DateFormat.yMMMd().format(selectedDate) ==
                                  DateFormat.yMMMd().format(DateTime.now())) {
                                return 'Please select Date of Birth';
                              }
                              return null;
                            },
                          ),
                          // CustomFormFieldOutilined(
                          //   controller: authentication.registerDonorlastNameController,
                          //   obscureText: false,
                          //   contentPadding:
                          //       const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          //   fontSize: kFourteenFont,
                          //   fontWeight: FontWeight.w500,
                          //   hintText: "Enter Last Name",
                          //   maxLines: 1,
                          //   readOnly: false,
                          //   onChanged: (value) {},
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please enter Last Name';
                          //     }
                          //     return null;
                          //   },
                          //   label: 'Last Name',
                          // ),

                          // SizedBox(
                          //   height: 20.h,
                          // ),
                          /////
                          // CustomFormField(
                          //   enabled: true,
                          //   controller: apicontroller.signupfullnameController,
                          //   obscureText: false,
                          //   contentPadding: const EdgeInsets.symmetric(
                          //       vertical: 16, horizontal: 8),
                          //   fontSize: kFourteenFont,
                          //   fontWeight: FontWeight.w500,
                          //   hintText: "Full Name",
                          //   maxLines: 1,
                          //   readOnly: false,
                          //   label: 'Full Name',
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please enter Full Name';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          //////
                          // CustomFormFieldOutilined(
                          //   controller: authentication.registerDonorEmailController,
                          //   obscureText: false,
                          //   contentPadding:
                          //       const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          //   fontSize: kFourteenFont,
                          //   fontWeight: FontWeight.w500,
                          //   hintText: "Enter Email",
                          //   maxLines: 1,
                          //   readOnly: false,
                          //   onChanged: (value) {},
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please enter Email';
                          //     }
                          //     return null;
                          //   },
                          //   label: 'Email',
                          // ),

                          //
                          ////old data
                          // CustomFormFields(
                          //   labelColor: KText,
                          //   enabled: true,
                          //   controller: authentication.registerDonorEmailController,
                          //   obscureText: false,
                          //   contentPadding:
                          //       const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          //   fontSize: kFourteenFont,
                          //   fontWeight: FontWeight.w500,
                          //   hintText: "Enter Email",
                          //   maxLines: 1,
                          //   readOnly: false,
                          //   label: 'Email',
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please enter Email';
                          //     }
                          //     return null;
                          //   },
                          // ),

                          // CustomFormField(
                          //   suffix: InkWell(
                          //       onTap: () async {
                          //         // setState(() {
                          //         //   isFormOpen.value = true;
                          //         // });
                          //         final DateTime? picked = await showDatePicker(
                          //           context: context,
                          //           initialDate: selectedDate,
                          //           firstDate: DateTime(1924, 8),
                          //           //  firstDate: DateTime(2015, 8),
                          //           lastDate: DateTime.now(),
                          //           builder: (context, child) {
                          //             return Theme(
                          //               data: Theme.of(context).copyWith(
                          //                 colorScheme: const ColorScheme.light(
                          //                   // background: white,
                          //                   primary: Kpink,
                          //                   //onPrimary: white,
                          //                   onSurface: Colors.black,
                          //                 ),
                          //                 textButtonTheme: TextButtonThemeData(
                          //                   style: TextButton.styleFrom(
                          //                       // primary: Kbluedark,
                          //                       ),
                          //                 ),
                          //               ),
                          //               child: child!,
                          //             );
                          //           },
                          //         );

                          //         if (picked != null && picked != selectedDate) {
                          //           // if (picked.isAfter(DateTime.now())) {
                          //           //   // date.isAfter(DateTime.now()
                          //           //   //  if(date.month>DateTime.now().month){
                          //           //   Fluttertoast.showToast(
                          //           //       msg: "Upcomming Months can't be selected");
                          //           // } else {
                          //           setState(() {
                          //             selectedDate = picked;
                          //             choosenDate = selectedDate;
                          //             selectDate.value = DateFormat('MM/dd/yyyy')
                          //                 // DateFormat.yMMMEd()
                          //                 .format(selectedDate);
                          //           });
                          //           //  }
                          //           // setState(() {
                          //           //   selectedDate = picked;
                          //           //   choosenDate = selectedDate;
                          //           // }
                          //           // );
                          //         }
                          //       },
                          //       child: Icon(Icons.calendar_today)),
                          //   obscureText: false,
                          //   contentPadding:
                          //       const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          //   fontSize: kFourteenFont,
                          //   fontWeight: FontWeight.w500,
                          //   textColor: KdarkText,
                          //   hintStyle: GoogleFonts.roboto(
                          //       color: KdarkText.withOpacity(
                          //         0.8,
                          //       ),
                          //       fontSize: kTwelveFont),
                          //   keyboardType: TextInputType.none,
                          //   maxLines: 1,
                          //   controller:
                          //       authentication.registerDonorDateofBirthController,
                          //   hintText: selectedDate != null
                          //       ? DateFormat('dd/MM/yyyy')
                          //           // DateFormat.yMMMEd()
                          //           .format(selectedDate)
                          //       // DateFormat.yMMMEd().format(selectedDate)
                          //       : "Select Date",
                          //   readOnly: false,
                          //   onChanged: (value) {},
                          // ),
                          //

                          // SizedBox(
                          //   height: 20.h,
                          // ),
                          // CustomFormFieldOutilined(
                          //   controller: authentication.registerDonorMobileController,
                          //   keyboardType: TextInputType.number,
                          //   obscureText: false,
                          //   contentPadding:
                          //       const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          //   fontSize: kFourteenFont,
                          //   fontWeight: FontWeight.w500,
                          //   hintText: "Enter Mobile Number",
                          //   maxLines: 1,
                          //   readOnly: false,
                          //   onChanged: (value) {},
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please enter Mobile Number';
                          //     }
                          //     return null;
                          //   },
                          //   label: 'Mobile',
                          // ),
                          // CustomFormFields(
                          //   labelColor: KText,
                          //   enabled: true,
                          //   controller: authentication.registerDonorMobileController,
                          //   keyboardType: TextInputType.number,
                          //   obscureText: false,
                          //   contentPadding:
                          //       const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          //   fontSize: kFourteenFont,
                          //   fontWeight: FontWeight.w500,
                          //   hintText: "Enter Mobile Number",
                          //   maxLines: 1,
                          //   readOnly: false,
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please enter Mobile Number';
                          //     }
                          //     return null;
                          //   },
                          //   label: 'Mobile Number',
                          // ),

                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     "Registration Type",
                          //     textAlign: TextAlign.start,
                          //     style: GoogleFonts.roboto(
                          //         fontSize: kFourteenFont,
                          //         //  letterSpacing: 1,
                          //         color: KTextgery,
                          //         fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 2.h,
                          // ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(10.0),
                          //       color: Kwhite,
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: Color(0x3FD3D1D8),
                          //           blurRadius: 30,
                          //           offset: Offset(15, 15),
                          //           spreadRadius: 0,
                          //         )
                          //         // BoxShadow(
                          //         //   color: Color(0x3FD3D1D8),
                          //         //   blurRadius: 30,
                          //         //   offset: Offset(15, 15),
                          //         //   spreadRadius: 2,
                          //         // )
                          //       ]),
                          //   child: DropdownButtonFormField2<String>(
                          //     isExpanded: true,
                          //     decoration: InputDecoration(
                          //       enabledBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //           color: kblack.withOpacity(0.2),
                          //         ),
                          //         borderRadius: BorderRadius.circular(10.r),
                          //       ),
                          //       errorBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //           color: kblack.withOpacity(0.2),
                          //         ),
                          //         borderRadius: BorderRadius.circular(10.r),
                          //       ),
                          //       disabledBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //           color: kblack.withOpacity(0.2),
                          //         ),
                          //         borderRadius: BorderRadius.circular(10.r),
                          //       ),
                          //       focusedErrorBorder: OutlineInputBorder(
                          //         borderSide:
                          //             BorderSide(color: Kpink, width: 1),
                          //         borderRadius: BorderRadius.circular(10.r),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderSide:
                          //             BorderSide(color: Kpink, width: 1),
                          //         borderRadius: BorderRadius.circular(10.r),
                          //       ),
                          //       contentPadding: const EdgeInsets.symmetric(
                          //           vertical: 10, horizontal: 8),
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //     ),
                          //     hint: Text(
                          //       'Select Registration Type',
                          //       style: GoogleFonts.roboto(
                          //         fontSize: 14,
                          //         color: KTextgery.withOpacity(0.5),
                          //       ),
                          //     ),
                          //     items: bloodgroupss
                          //         .map((item) => DropdownMenuItem<String>(
                          //               value: item,
                          //               child: Text(
                          //                 item,
                          //                 style: GoogleFonts.roboto(
                          //                   fontSize: 14,
                          //                 ),
                          //               ),
                          //             ))
                          //         .toList(),
                          //     validator: (value) {
                          //       if (value == null) {
                          //         return 'Please select BloodGroup.';
                          //       }
                          //       return null;
                          //     },
                          //     onChanged: (value) {
                          //       setState(() {
                          //         authentication.donorRegisterBloodGroup.value =
                          //             value.toString();
                          //         selectedValue = value.toString();
                          //         print(selectedValue);
                          //       });

                          //       // authentication.registerDonorBloodController.value =
                          //       //     selectedValue as TextEditingValue;
                          //       //Do something when selected item is changed.
                          //     },
                          //     onSaved: (value) {
                          //       selectedValue = value.toString();
                          //       print(selectedValue);
                          //       // authentication.registerDonorBloodController.value =
                          //       //     selectedValue as TextEditingValue;
                          //     },
                          //     buttonStyleData: const ButtonStyleData(
                          //       padding: EdgeInsets.only(right: 8),
                          //     ),
                          //     iconStyleData: IconStyleData(
                          //       icon: Icon(
                          //         Icons.arrow_drop_down,
                          //         color: kblack.withOpacity(0.6),
                          //       ),
                          //       iconSize: 24,
                          //     ),
                          //     dropdownStyleData: DropdownStyleData(
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(15),
                          //       ),
                          //     ),
                          //     menuItemStyleData: const MenuItemStyleData(
                          //       padding: EdgeInsets.symmetric(horizontal: 16),
                          //     ),
                          //   ),
                          // ),

                          SizedBox(
                            height: 20.h,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Gender",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                  fontSize: kFourteenFont,
                                  //  letterSpacing: 1,
                                  color: KTextgery,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
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
                                'Select Gender',
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: KTextgery.withOpacity(0.5),
                                ),
                              ),
                              items: Genders.map(
                                  (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                          ),
                                        ),
                                      )).toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select Gender.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  authentication.donorRegisterGender.value =
                                      value.toString();
                                  selectedGenderValue = value.toString();
                                  print(selectedGenderValue);
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
                            height: 20.h,
                          ),
                          CustomFormField(
                            enabled: true,
                            controller:
                                authentication.registerworaddressController,
                            obscureText: false,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            fontSize: kFourteenFont,
                            fontWeight: FontWeight.w500,
                            hintText: "Enter  Address",
                            maxLines: 1,
                            readOnly: false,
                            label: ' Address',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomFormField(
                            enabled: true,
                            keyboardType: TextInputType.phone,
                            controller:
                                authentication.registerworemergencyController,
                            obscureText: false,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            fontSize: kFourteenFont,
                            fontWeight: FontWeight.w500,
                            hintText: "Enter Emergency Contact",
                            maxLines: 1,
                            readOnly: false,
                            label: 'Emergency Contact',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Emergency';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
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
                                  });
                                  print(value);
                                },
                              ),
                              Text(
                                "Accept Terms and conditions",
                                style: GoogleFonts.roboto(
                                    fontSize: kTwelveFont.sp,
                                    color: KdarkText,
                                    fontWeight: kFW500),
                              ),
                            ],
                          ),

                          // Container(
                          //   height: 60.h,
                          //   width: double.infinity,
                          //   padding: EdgeInsets.all(10.r),
                          //   decoration: BoxDecoration(
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Ktextcolor.withOpacity(0.5),
                          //         blurRadius: 5.r,
                          //         offset: Offset(1, 1),
                          //         spreadRadius: 1.r,
                          //       )
                          //     ],
                          //     color: Kwhite,
                          //     borderRadius: BorderRadius.circular(10.r),
                          //   ),
                          //   child: TextFormField(
                          //     obscureText: passwordVisible,
                          //     style: GoogleFonts.roboto(
                          //         fontSize: 13.sp,
                          //         fontWeight: kFW500,
                          //         color: kblack.withOpacity(0.8)),
                          //     decoration: InputDecoration(
                          //       focusColor: Kwhite.withOpacity(0.5),
                          //       filled: true,
                          //       labelText: "Password",
                          //       labelStyle:GoogleFonts.roboto(
                          //           fontSize: 12.sp,
                          //           fontWeight: kFW600,
                          //           color: kblack.withOpacity(0.6),
                          //           letterSpacing: 1),
                          //       contentPadding:
                          //           const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(50.r),
                          //       ),
                          //       enabledBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(color: kblack, width: 1),
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
                          //         borderSide: BorderSide(color: Kpink, width: 1),
                          //         borderRadius: BorderRadius.circular(10.r),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(color: Kpink, width: 1),
                          //         borderRadius: BorderRadius.circular(10.r),
                          //       ),
                          //       fillColor: Kwhite,
                          //       suffixIcon: IconButton(
                          //         icon: Icon(
                          //           passwordVisible
                          //               ? Icons.visibility
                          //               : Icons.visibility_off,
                          //           size: 20.sp,
                          //         ),
                          //         onPressed: () {
                          //           setState(
                          //             () {
                          //               passwordVisible = !passwordVisible;
                          //             },
                          //           );
                          //         },
                          //       ),
                          //       hintText: "**************",
                          //       alignLabelWithHint: true,
                          //       hintStyle: GoogleFonts.roboto(
                          //         color: KTextgery.withOpacity(0.5),
                          //         fontSize: 12.sp,
                          //         fontWeight: kFW500,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 20.h,
                          // ),
                          // Container(
                          //   height: 60.h,
                          //   width: double.infinity,
                          //   padding: EdgeInsets.all(10.r),
                          //   decoration: BoxDecoration(
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Ktextcolor.withOpacity(0.5),
                          //         blurRadius: 5.r,
                          //         offset: Offset(1, 1),
                          //         spreadRadius: 1.r,
                          //       )
                          //     ],
                          //     color: Kwhite,
                          //     borderRadius: BorderRadius.circular(10.r),
                          //   ),
                          //   child: TextFormField(
                          //     obscureText: confirmpasswordVisible,
                          //     style: GoogleFonts.roboto(
                          //         fontSize: 13.sp,
                          //         fontWeight: kFW500,
                          //         color: kblack.withOpacity(0.8)),
                          //     decoration: InputDecoration(
                          //       focusColor: Kwhite.withOpacity(0.5),
                          //       filled: true,
                          //       labelText: "Confirm Password",
                          //       labelStyle:GoogleFonts.roboto(
                          //           fontSize: 12.sp,
                          //           fontWeight: kFW600,
                          //           color: kblack.withOpacity(0.6),
                          //           letterSpacing: 1),
                          //       contentPadding:
                          //           const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(50.r),
                          //       ),
                          //       enabledBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(color: kblack, width: 1),
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
                          //         borderSide: BorderSide(color: Kpink, width: 1),
                          //         borderRadius: BorderRadius.circular(10.r),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(color: Kpink, width: 1),
                          //         borderRadius: BorderRadius.circular(10.r),
                          //       ),
                          //       fillColor: Kwhite,
                          //       suffixIcon: IconButton(
                          //         icon: Icon(
                          //           confirmpasswordVisible
                          //               ? Icons.visibility
                          //               : Icons.visibility_off,
                          //           size: 20.sp,
                          //         ),
                          //         onPressed: () {
                          //           setState(
                          //             () {
                          //               confirmpasswordVisible = !confirmpasswordVisible;
                          //             },
                          //           );
                          //         },
                          //       ),
                          //       hintText: "**************",
                          //       alignLabelWithHint: true,
                          //       hintStyle: GoogleFonts.roboto(
                          //         color: KTextgery.withOpacity(0.5),
                          //         fontSize: 12.sp,
                          //         fontWeight: kFW500,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Obx(() => CustomButton(
                              margin: EdgeInsets.only(top: 50.h),
                              borderRadius: BorderRadius.circular(30.r),
                              Color: Kpink,
                              textColor: Kwhite,
                              height: 42.h,
                              width: double.infinity,
                              label: authentication.donorRegistrationLoading ==
                                      true
                                  ? "Loading"
                                  : "Sign Up",
                              fontSize: kSixteenFont,
                              fontWeight: kFW500,
                              isLoading: false,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Biometrics Upload',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                                fontSize: 12.sp,
                                                fontWeight: kFW700,
                                                color: KText)),
                                        content: Text(
                                            'Take Biometrics for Verification',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                                fontSize: 12.sp,
                                                fontWeight: kFW700,
                                                color: KdarkText)),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              var payload = {
                                                "name": authentication
                                                    .registerDonorfirstNameController
                                                    .text,

                                                "mobile": authentication
                                                    .enteredNumber
                                                    .value, // test
                                                "gender": authentication
                                                    .donorRegisterGender.value,
                                                "role": authentication
                                                    .selectedRegisterType.value,
                                                "uniqueKey":
                                                    UserSimplePreferences
                                                        .getuniquecode(),
                                                //  authentication
                                                //     .donorRegisterBloodGroup
                                                //     .value,
                                                "termsAndCondition": "${value}",
                                                "dateOfBirth": selectDate.value,
                                                "email": authentication
                                                    .registerDonoremailController
                                                    .text,
                                                "address": authentication
                                                    .registerworaddressController
                                                    .text,
                                                "personalContact": authentication
                                                    .registerworemergencyController
                                                    .text,

                                                "longitude": "78.3728449",
                                                "latitude": "17.4563093"
                                              };

                                              if (_formKey.currentState!
                                                  .validate()) {
                                                authentication
                                                    .donorRegistration(payload);
                                              }
                                              // Get.back();
                                            },
                                            child: Text('Skip',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12.sp,
                                                    fontWeight: kFW700,
                                                    color: KdarkText)),
                                          ),
                                          TextButton(
                                            // textColor: Color(0xFF6200EE),
                                            onPressed: () async {
                                              setState(
                                                () {
                                                  authentication
                                                      .registerAutenticationBody
                                                      .value = {
                                                    "name": authentication
                                                        .registerDonorfirstNameController
                                                        .text,
                                                    "mobile": authentication
                                                        .enteredNumber.value,
                                                    "gender": authentication
                                                        .donorRegisterGender
                                                        .value,
                                                    "role": authentication
                                                        .selectedRegisterType
                                                        .value,
                                                    "uniqueKey":
                                                        UserSimplePreferences
                                                            .getuniquecode(),
                                                    //  authentication
                                                    //     .donorRegisterBloodGroup
                                                    //     .value,
                                                    "termsAndCondition":
                                                        "${value}",
                                                    "dateOfBirth":
                                                        selectDate.value,
                                                    "email": authentication
                                                        .registerDonoremailController
                                                        .text,
                                                    "address": authentication
                                                        .registerworaddressController
                                                        .text,
                                                    "personalContact":
                                                        authentication
                                                            .registerworemergencyController
                                                            .text,

                                                    "longitude": "78.3728449",
                                                    "latitude": "17.4563093"
                                                  };
                                                },
                                              );
                                              authenticateWithBiometrics();
                                              // Get.toNamed(
                                              //     kBiometricRegistration);
                                            },

                                            child: Text('Continue',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12.sp,
                                                    fontWeight: kFW700,
                                                    color: KdarkText)),
                                          )
                                        ],
                                      );
                                    });
                                // var payload = {
                                //   "name": authentication
                                //       .registerDonorfirstNameController.text,

                                //   "mobile": authentication
                                //       .enteredNumber.value, // test
                                //   "gender":
                                //       authentication.donorRegisterGender.value,
                                //   "role": authentication
                                //       .donorRegisterBloodGroup.value,
                                // };

                                // if (_formKey.currentState!.validate()) {
                                //   authentication.donorRegistration(payload);
                                // }

                                // "phone": authentication.loginMobileController.text,
                                //  "8297297247"
                              }

                              // Fluttertoast.showToast(
                              //   msg: "Registered Successfully",
                              // );

                              )),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      )

                      //FindDonor()
                    ])),
          ),
        ),
      ),
    );
  }
}
