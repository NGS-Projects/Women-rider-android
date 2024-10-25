import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:womentaxi/untils/export_file.dart';

// class NewSignUp extends StatefulWidget {
//   const NewSignUp({super.key});

//   @override
//   State<NewSignUp> createState() => _NewSignUpState();
// }

// class _NewSignUpState extends State<NewSignUp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'package:intl/intl.dart';

class NewSignUp extends StatefulWidget {
  const NewSignUp({super.key});

  @override
  State<NewSignUp> createState() => _NewSignUpState();
}

class _NewSignUpState extends State<NewSignUp> {
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
////////////////////////////////////image Upload
  bool showimagenullMessage = false;
  File? selectedImage;
  File? selectedImagetwo;
  String base64Image = "";
  // bool isLoading = false;
  Map typesData = {};
  List<String> options = [];
  int choosenTypeData = 0;
  String choosenOption = "";
  // String? selectedValue;
  String description = "";
  int? totalAmount;
  String? str;
  Future<void> chooseImage(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
      );
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 10);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        // apicontroller.editProfilePicture(selectedImage!); //
        print(selectedImage!.readAsBytesSync().lengthInBytes);
        final kb = selectedImage!.readAsBytesSync().lengthInBytes / 1024;
        print(kb);
        final mb = kb / 1024;
        print(mb);
        print("ram b jk dslnkv flk dlkcdslc k");
        showimagenullMessage = false;
      });
    }
  }

/////////////////////////////////////
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

  @override
  void initState() {
    super.initState();
  }

  /////////

  //

  ///////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      // appBar: AppBar(
      //   leading: InkWell(
      //       onTap: () {
      //         Get.back();
      //       },
      //       child: Icon(Icons.arrow_back_ios)),
      // ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 1,
          margin: EdgeInsets.only(bottom: 20.h, top: 20.h),
          child: Form(
              key: _formKey,
              // autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Image.asset(
                        "assets/images/womenriders.png",
                        height: 60.h,
                        // width: 150.w,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Kpink,
                            radius: 60.r,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Kwhite,
                                  radius: 58.r,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Kwhite,
                                  radius: 56.r,
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(200.r),
                                      child: selectedImage != null
                                          ? CircleAvatar(
                                              backgroundColor: Kwhite,
                                              radius: 56.r,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        200.r),
                                                child: Image.file(
                                                  selectedImage!,
                                                  width: 120.w,
                                                  //   fit: BoxFit.cover,
                                                  fit: BoxFit.cover,
                                                  // height: 100.h,
                                                  // width: 100.w,
                                                  // fit: BoxFit.cover,
                                                ),
                                              ))
                                          : Image.asset(
                                              "assets/images/null_profile.png",
                                              height: 100.h,
                                              width: 100.w,
                                              fit: BoxFit.cover,
                                            )),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 4.h,
                            right: 4.w,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                    ),
                                    backgroundColor: Kbackground,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Kbackground,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          height: 100.h,
                                          padding: EdgeInsets.only(top: 20.h),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  chooseImage("Gallery");
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.image_outlined,
                                                      color: Kpink,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text('Gallery',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    kFW700,
                                                                color:
                                                                    KdarkText)),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  chooseImage("camera");
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: Kpink,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text('camera',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    kFW700,
                                                                color:
                                                                    KdarkText)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Image.asset(
                                "assets/images/edit.png",
                                color: Kpink,
                                height: 20.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Details",
                              style: GoogleFonts.roboto(
                                  fontSize: kEighteenFont,
                                  color: kcarden,
                                  fontWeight: kFW500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Divider(
                          color: Kpink,
                          thickness: 2,
                        ),
                        CustomFormField(
                          enabled: true,
                          prefix: Image.asset(
                            "assets/images/profile.png",

                            // width: 150.w,
                          ),
                          controller:
                              authentication.registerDonorfirstNameController,
                          obscureText: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          fontSize: kFourteenFont,
                          fontWeight: FontWeight.w500,
                          hintText: "Enter  Name",
                          labelColor: kcarden,
                          // textColor: kcarden,
                          // hintStyle: TextStyle(color: kcarden),
                          maxLines: 1,
                          readOnly: false,

                          label: ' Name',
                          onChanged: (Value) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomFormField(
                          prefix: Image.asset(
                            "assets/images/email.png",

                            // width: 150.w,
                          ),
                          enabled: true,
                          controller:
                              authentication.registerDonoremailController,
                          obscureText: false,
                          labelColor: kcarden,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          fontSize: kFourteenFont,
                          fontWeight: FontWeight.w500,
                          hintText: "Enter  Email",
                          maxLines: 1,
                          readOnly: false,
                          label: ' Email',
                          onChanged: (Value) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                        ),
                        ///////////
                        SizedBox(
                          height: 15.h,
                        ),

                        CustomFormField(
                          // hintColor: DateFormat.yMMMd()
                          //             .format(selectedDate) ==
                          //         DateFormat.yMMMd()
                          //             .format(DateTime.now())
                          //     ? KTextgery.withOpacity(0.5)
                          //     : KdarkText,
                          // labelColor: KText,

                          enabled: true,
                          labelColor: kcarden,
                          obscureText: false,
                          prefix: InkWell(
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

                              if (picked != null && picked != selectedDate) {
                                // if (picked.isAfter(DateTime.now())) {
                                //   // date.isAfter(DateTime.now()
                                //   //  if(date.month>DateTime.now().month){
                                //   Fluttertoast.showToast(
                                //       msg: "Upcomming Months can't be selected");
                                // } else {
                                setState(() {
                                  selectedDate = picked;
                                  choosenDate = selectedDate;
                                  selectDate.value = DateFormat('MM/dd/yyyy')
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
                            child: Image.asset(
                              "assets/images/dob.png",

                              // width: 150.w,
                            ),
                          ),
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
                          controller:
                              authentication.registerDonorDateofBirthController,
                          hintText:
                              // selectedDate == DateTime.now()
                              DateFormat.yMMMd().format(selectedDate) ==
                                      DateFormat.yMMMd().format(DateTime.now())
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

                        SizedBox(
                          height: 15.h,
                        ),
                        CustomFormField(
                          prefix: Image.asset(
                            "assets/images/address.png",

                            // width: 150.w,
                          ),
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
                          labelColor: kcarden,
                          onChanged: (Value) {
                            setState(() {});
                          },
                          label: ' Address',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter address';
                            }
                            return null;
                          },
                        ),
                        authentication.registerDonorfirstNameController.text ==
                                    "" ||
                                authentication
                                        .registerDonoremailController.text ==
                                    "" ||
                                authentication
                                        .registerworaddressController.text ==
                                    "" ||
                                selectedImage == null ||
                                selectDate.value == "Select Date"
                            ? GestureDetector(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg: 'Please fill All fields');
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
                                ))
                            : Obx(() => GestureDetector(
                                onTap: () {
                                  var payload = {
                                    "name": authentication
                                        .registerDonorfirstNameController.text,
                                    "mobile":
                                        authentication.enteredNumber.value,
                                    // "mobile": "9381022558",
                                    "role": authentication
                                        .selectedRegisterType.value,

                                    "dateOfBirth": selectDate.value,
                                    "email": authentication
                                        .registerDonoremailController.text,
                                    "address": authentication
                                        .registerworaddressController.text,

                                    "longitude": "78.3728449",
                                    "latitude": "17.4563093"
                                  };

                                  if (_formKey.currentState!.validate()) {
                                    authentication.newRegister(
                                        payload, selectedImage!);
                                  }
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
                                      authentication.donorRegistrationLoading ==
                                              true
                                          ? "Loading"
                                          : "Continue",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          fontSize: kSixteenFont,
                                          color: Kwhite,
                                          fontWeight: kFW500),
                                    ),
                                  ),
                                ))),
                        SizedBox(
                          height: 40.h,
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
