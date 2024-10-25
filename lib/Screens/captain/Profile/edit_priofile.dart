// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'package:intl/intl.dart';
//import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController dOBController = TextEditingController();
  ApiController apicontroller = Get.put(ApiController());
  final List<String> bloodgroupss = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  DateTime choosenDate = DateTime.now();
  var selectDate = "Select Date".obs;
  final List<String> genderlist = ['Male', 'Female', 'Other'];
  String startTime = "";
  String closeTime = "";
  /////////////////////////////////////////////////////////
  Future<TimeOfDay?> getTime({
    required BuildContext context,
    String? title,
    String? formattedTime,
    TimeOfDay? initialTime,
    String? cancelText,
    String? confirmText,
  }) async {
    TimeOfDay? time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      cancelText: cancelText ?? "Cancel",
      confirmText: confirmText ?? "Save",
      helpText: title ?? "Select time",
      builder: (context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Kwhite, // Background color
              hourMinuteTextColor: Kpink, // Text color for hours and minutes
              dayPeriodTextColor: KdarkText, // Text color for AM/PM
              dayPeriodBorderSide:
                  BorderSide(color: KdarkText), // Border color for AM/PM
              dialHandColor: Kpink, // Color of the hour hand
              dialTextColor: Kwhite, // Text color on the clock dial
              dialBackgroundColor: Kpink.withOpacity(0.5),
              //dayPeriodColor: lightBlue,
              //hourMinuteColor: lightBlue,
              entryModeIconColor: Kpink,
              helpTextStyle: GoogleFonts.roboto(
                color: KText, // Set the text color for "Enter time"
              ),
              cancelButtonStyle: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.brown.shade300),
                  foregroundColor: MaterialStateProperty.all<Color>(Kpink)),
              confirmButtonStyle: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.brown.shade300),
                  foregroundColor: MaterialStateProperty.all<Color>(Kpink)),
              hourMinuteTextStyle: GoogleFonts.roboto(
                  fontSize: 30), // Text style for hours and minutes
            ),
            textTheme: TextTheme(
              bodySmall: GoogleFonts.roboto(color: KdarkText),
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Kpink,
              selectionColor: Kpink,
              selectionHandleColor: KText,
            ),
          ),
          child: child!,
        );
      },
    );
    formattedTime = MaterialLocalizations.of(context).formatTimeOfDay(time!);
    setState(() {
      startTime = formattedTime!;
    });
    return time;
  }

  //Closetime
  Future<TimeOfDay?> closedTime({
    required BuildContext context,
    String? title,
    String? formattedTime,
    TimeOfDay? initialTime,
    String? cancelText,
    String? confirmText,
  }) async {
    TimeOfDay? time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      cancelText: cancelText ?? "Cancel",
      confirmText: confirmText ?? "Save",
      helpText: title ?? "Select time",
      builder: (context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Kwhite, // Background color
              hourMinuteTextColor: Kpink, // Text color for hours and minutes
              dayPeriodTextColor: KdarkText, // Text color for AM/PM
              dayPeriodBorderSide:
                  BorderSide(color: KdarkText), // Border color for AM/PM
              dialHandColor: Kpink, // Color of the hour hand
              dialTextColor: Kwhite, // Text color on the clock dial
              dialBackgroundColor: Kpink.withOpacity(0.5),
              //dayPeriodColor: lightBlue,
              //hourMinuteColor: lightBlue,
              entryModeIconColor: Kpink,
              helpTextStyle: GoogleFonts.roboto(
                color: KText, // Set the text color for "Enter time"
              ),
              cancelButtonStyle: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.brown.shade300),
                  foregroundColor: MaterialStateProperty.all<Color>(Kpink)),
              confirmButtonStyle: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.brown.shade300),
                  foregroundColor: MaterialStateProperty.all<Color>(Kpink)),
              hourMinuteTextStyle: GoogleFonts.roboto(
                  fontSize: 30), // Text style for hours and minutes
            ),
            textTheme: TextTheme(
              bodySmall: GoogleFonts.roboto(color: KdarkText),
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Kpink,
              selectionColor: Kpink,
              selectionHandleColor: KText,
            ),
          ),
          child: child!,
        );
      },
    );
    formattedTime = MaterialLocalizations.of(context).formatTimeOfDay(time!);
    setState(() {
      closeTime = formattedTime!;
    });
    return time;
  }

  ///////////////////////////////////////////////////////
  final List<String> Genders = [
    'Male',
    'Female',
    'Others',
  ];
  String? selectedgender;
  //////////////////////////////
  bool showimagenullMessage = false;
  File? selectedImage;
  File? selectedImagetwo;
  String base64Image = "";
  // bool isLoading = false;
  Map typesData = {};
  List<String> options = [];
  int choosenTypeData = 0;
  String choosenOption = "";
  String? selectedValue;
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
        apicontroller.editProfilePicture(selectedImage!); //
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

  String? selectedGenderValue;

  @override
  void initState() {
    setState(() {
      apicontroller.editfirstNameController.text =
          apicontroller.profileData["name"] ?? "";
      apicontroller.editRideEmailController.text =
          apicontroller.profileData["email"] ?? "";
      apicontroller.editRideAddressController.text =
          apicontroller.profileData["address"] ?? "";
    });
    // if (apicontroller.profileData["dateOfBirth"] != null) {
    //   setState(() {
    //     // apicontroller.editRideDobController.text =
    //     //     apicontroller.profileData["dateOfBirth"];
    //     selectedDate = DateFormat.yMMMd()
    //         .format(apicontroller.profileData["dateOfBirth"]) as DateTime;
    //   });
    // }
    // if (apicontroller.profileData["dateOfBirth"] != null) {
    //   // Parsing the date string from profileData
    //   final String dateOfBirthStr = apicontroller.profileData["dateOfBirth"];
    //   DateTime parsedDate =
    //       DateTime.parse(dateOfBirthStr); // Convert to DateTime

    //   setState(() {
    //     apicontroller.editRideDobController.text =
    //         DateFormat.yMMMd().format(parsedDate);
    //     selectedDate = parsedDate; // Update selectedDate with the parsed date
    //   });
    // }
    if (apicontroller.profileData["dateOfBirth"] != null) {
      final String dateOfBirthStr = apicontroller.profileData["dateOfBirth"];

      try {
        // Define the format that matches your input (MM/dd/yyyy)
        DateTime parsedDate = DateFormat('MM/dd/yyyy').parse(dateOfBirthStr);

        setState(() {
          apicontroller.editRideDobController.text =
              DateFormat.yMMMd().format(parsedDate);
          selectedDate = parsedDate; // Update selectedDate with the parsed date
        });
      } catch (e) {
        print("Error parsing date: $e");
      }
    }

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          "Edit Profile",
          style: GoogleFonts.roboto(
              fontSize: 22.sp, color: kcarden, fontWeight: kFW600),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: 30.h,
              // ),
              // Stack(
              //   children: [
              //     CircleAvatar(
              //       backgroundColor: Kwhite,
              //       radius: 50.r,
              //       child: ClipRRect(
              //         borderRadius: BorderRadius.circular(200.r),
              //         child: selectedImage != null
              //             ? Image.file(
              //                 selectedImage!,
              //                 height: 100.h,
              //                 width: 100.w,
              //                 fit: BoxFit.cover,
              //               )
              //             : apicontroller.profileData["profilePic"] == null
              //                 ? Image.asset(
              //                     "assets/images/profileImageStatic.png",
              //                     height: 100.h,
              //                     width: 100.w,
              //                     fit: BoxFit.cover,
              //                   )
              //                 : CircleAvatar(
              //                     backgroundColor: Kwhite,
              //                     radius: 50.r,
              //                     child: ClipRRect(
              //                       borderRadius: BorderRadius.circular(200.r),
              //                       child: CachedNetworkImage(
              //                         imageUrl: kBaseImageUrl +
              //                             apicontroller
              //                                 .profileData["profilePic"],
              //                         // authentication
              //                         //     .profileData["profile"],
              //                         placeholder: (context, url) => SizedBox(
              //                           height: 100.h,
              //                           width: 100.w,
              //                           child: Shimmer.fromColors(
              //                             baseColor: Colors.black12,
              //                             highlightColor:
              //                                 Colors.white.withOpacity(0.5),
              //                             child: Container(
              //                               decoration: BoxDecoration(
              //                                 shape: BoxShape.circle,
              //                                 color: Kwhite.withOpacity(0.5),
              //                               ),
              //                               height: 100.h,
              //                               width: 100.w,
              //                             ),
              //                           ),
              //                         ),
              //                         errorWidget: (context, url, error) =>
              //                             CircleAvatar(
              //                           backgroundColor: Kwhite,
              //                           radius: 50.r,
              //                           child: ClipRRect(
              //                             borderRadius:
              //                                 BorderRadius.circular(200.r),
              //                             child: Image.asset(
              //                               "assets/images/profileImageStatic.png",
              //                               // height: 150.h,
              //                               height: 100.h,
              //                               width: 100.w,
              //                               fit: BoxFit.cover,
              //                             ),
              //                           ),
              //                         ),
              //                         height: 100.h,
              //                         width: 100.w,
              //                         //   fit: BoxFit.cover,
              //                         fit: BoxFit.cover,
              //                       ),
              //                       // Image.asset(
              //                       //   "assets/images/profileImageStatic.png",
              //                       //   // height: 150.h,
              //                       //   height: 100.h,
              //                       //   width: 100.w,
              //                       //   fit: BoxFit.cover,
              //                       // ),
              //                     ),
              //                   ),
              //       ),
              //     ),
              //     Positioned(
              //       bottom: 4.h,
              //       right: 4.w,
              //       child: InkWell(
              //         onTap: () {
              //           showModalBottomSheet(
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.only(
              //                     topRight: Radius.circular(20),
              //                     topLeft: Radius.circular(20)),
              //               ),
              //               backgroundColor: Kbackground,
              //               context: context,
              //               builder: (context) {
              //                 return Container(
              //                   child: Container(
              //                     decoration: BoxDecoration(
              //                         color: Kbackground,
              //                         borderRadius: BorderRadius.only(
              //                             topLeft: Radius.circular(20),
              //                             topRight: Radius.circular(20))),
              //                     height: 100.h,
              //                     padding: EdgeInsets.only(top: 20.h),
              //                     child: Row(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.center,
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceAround,
              //                       children: [
              //                         GestureDetector(
              //                           onTap: () {
              //                             chooseImage("Gallery");
              //                             Navigator.pop(context);
              //                           },
              //                           child: Column(
              //                             children: [
              //                               Icon(
              //                                 Icons.image_outlined,
              //                                 color: Kpink,
              //                               ),
              //                               SizedBox(
              //                                 height: 5.h,
              //                               ),
              //                               Text('Gallery',
              //                                   maxLines: 2,
              //                                   overflow: TextOverflow.ellipsis,
              //                                   style: GoogleFonts.roboto(
              //                                       fontSize: 12.sp,
              //                                       fontWeight: kFW700,
              //                                       color: KdarkText)),
              //                             ],
              //                           ),
              //                         ),
              //                         GestureDetector(
              //                           onTap: () {
              //                             chooseImage("camera");
              //                             Navigator.pop(context);
              //                           },
              //                           child: Column(
              //                             children: [
              //                               Icon(
              //                                 Icons.camera_alt_outlined,
              //                                 color: Kpink,
              //                               ),
              //                               SizedBox(
              //                                 height: 5.h,
              //                               ),
              //                               Text('camera',
              //                                   maxLines: 2,
              //                                   overflow: TextOverflow.ellipsis,
              //                                   style: GoogleFonts.roboto(
              //                                       fontSize: 12.sp,
              //                                       fontWeight: kFW700,
              //                                       color: KdarkText)),
              //                             ],
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 );
              //               });
              //         },
              //         child: Image.asset(
              //           "assets/images/edit.png",
              //           color: Kpink,
              //           height: 20.h,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              SizedBox(
                height: 50.h,
              ),
              CustomFormField(
                enabled: true,
                controller: apicontroller.editfirstNameController,
                obscureText: false,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                fontSize: kFourteenFont,
                fontWeight: FontWeight.w500,
                hintText: "Enter First Name",
                maxLines: 1,
                readOnly: false,
                label: 'First Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter First Name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomFormField(
                enabled: true,
                controller: apicontroller.editRideEmailController,
                obscureText: false,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                fontSize: kFourteenFont,
                fontWeight: FontWeight.w500,
                hintText: "Enter Email",
                maxLines: 1,
                readOnly: false,
                label: 'Email',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Email';
                  }
                  return null;
                },
              ),

              ///////////
              SizedBox(
                height: 20.h,
              ),
              CustomFormField(
                suffix: InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1924, 8),
                      lastDate: DateTime.now(),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Kpink,
                              onSurface: Colors.black,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked; // Update selectedDate
                        apicontroller.editRideDobController.text =
                            DateFormat('dd/MM/yyyy').format(
                                selectedDate); // Update the controller text
                      });
                    }
                  },
                  child: Icon(
                    Icons.calendar_today,
                    color: kblack.withOpacity(0.6),
                  ),
                ),
                enabled: true,
                obscureText: false,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
                controller: apicontroller.editRideDobController,
                hintText: apicontroller.editRideDobController.text.isEmpty
                    ? "Select Date"
                    : DateFormat('dd/MM/yyyy')
                        .format(selectedDate), // Display selected date
                hintStyle: TextStyle(color: KdarkText),
                readOnly: false,
                onChanged: (value) {},
                label: 'Date of Birth',
                validator: (value) {
                  if (apicontroller.editRideDobController.text.isEmpty) {
                    return 'Please select Date of Birth';
                  }
                  return null;
                },
              ),

              // CustomFormField(
              //   // hintColor: DateFormat.yMMMd()
              //   //             .format(selectedDate) ==
              //   //         DateFormat.yMMMd()
              //   //             .format(DateTime.now())
              //   //     ? KTextgery.withOpacity(0.5)
              //   //     : KdarkText,
              //   // labelColor: KText,
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
              //                 colorScheme: ColorScheme.light(
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
              //       child: Icon(
              //         Icons.calendar_today,
              //         color: kblack.withOpacity(0.6),
              //       )),
              //   enabled: true,

              //   obscureText: false,
              //   contentPadding:
              //       const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              //   // fontSize: kFourteenFont,
              //   // fontWeight: FontWeight.w500,
              //   fontSize: kFourteenFont,
              //   fontWeight: FontWeight.w500,
              //   textColor: KdarkText,
              //   keyboardType: TextInputType.none,
              //   textStyle: GoogleFonts.roboto(
              //     color: kblack,
              //     fontSize: kFourteenFont,
              //     fontWeight: FontWeight.w500,
              //   ),
              //   maxLines: 1,
              //   controller: apicontroller.editRideDobController,
              //   hintText:
              //       // selectedDate == DateTime.now()
              //       DateFormat.yMMMd().format(selectedDate) ==
              //               DateFormat.yMMMd().format(DateTime.now())
              //           ? "Select Date"
              //           : DateFormat('dd/MM/yyyy')
              //               // DateFormat.yMMMEd()
              //               .format(selectedDate)
              //   // DateFormat.yMMMEd().format(selectedDate)
              //   ,
              //   hintStyle: TextStyle(color: KdarkText),
              //   readOnly: false,
              //   onChanged: (value) {},
              //   label: 'Date of Birth',
              //   // hintText: "Full Name",
              //   // maxLines: 1,
              //   // readOnly: false,
              //   // label: 'Full Name',
              //   validator: (value) {
              //     if (DateFormat.yMMMd().format(selectedDate) ==
              //         DateFormat.yMMMd().format(DateTime.now())) {
              //       return 'Please select Date of Birth';
              //     }
              //     return null;
              //   },
              // ),
              SizedBox(
                height: 20.h,
              ),
              CustomFormField(
                enabled: true,
                controller: apicontroller.editRideAddressController,
                obscureText: false,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                fontSize: kFourteenFont,
                fontWeight: FontWeight.w500,
                hintText: "Enter Address",
                maxLines: 1,
                readOnly: false,
                label: 'Address',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Address';
                  }
                  return null;
                },
              ),
              // CustomFormField(
              //   enabled: true,
              //   controller: apicontroller.editRideDobController,
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
              SizedBox(
                height: 60.h,
              ),
              Obx(() => apicontroller.ridereditFormLoading == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Kpink,
                      ),
                    )
                  : CustomButton(
                      borderRadius: BorderRadius.circular(10.r),
                      Color: Kpink,
                      textColor: Kwhite,
                      height: 42.h,
                      width: double.infinity,
                      label: "Update",
                      fontSize: kSixteenFont,
                      fontWeight: kFW500,
                      isLoading: false,
                      onTap: () {
                        var payload = {
                          "Name": apicontroller.editfirstNameController.text,
                          "email": apicontroller.editRideEmailController.text,
                          "address":
                              apicontroller.editRideAddressController.text,

                          "dateOfBirth":
                              apicontroller.editRideDobController.text,

                          // "lastName": authentication
                          //     .editDonorLastNameController.text,
                          // "email": authentication
                          //     .editBloodBankEmailController.text,
                          // "address": authentication
                          //     .editBloodBanklocationsController.text,
                          // "bloodGroup": authentication
                          //     .donorRegisterBloodGroup.value,
                          // "gender":
                          //     authentication.donorRegisterGender.value,
                          // "dateOfBirth": selectDate.value,
                        };

                        apicontroller.ridereditProfileForm(payload);
                        // var payload = {
                        //   "firstName": authentication
                        //       .editDonorfirstNameController.text,
                        //   "lastName": authentication
                        //       .editDonorLastNameController.text

                        // };
                        // if (_formKey.currentState!.validate()) {
                        //   authentication.donorEditProfile(
                        //       payload, selectedImage!);
                        // }
                      }

                      // Fluttertoast.showToast(
                      //   msg: "Registered Successfully",
                      // );

                      )),

              // Obx(() => authentication.editFormLoading == true
              //     ? Center(
              //         child: CircularProgressIndicator(
              //           color: Kpink,
              //         ),
              //       )
              //     : authentication.profileData["employeeType"] == "Donor"
              //         ? CustomButton(
              //             borderRadius: BorderRadius.circular(10.r),
              //             Color: Kpink,
              //             textColor: Kwhite,
              //             height: 42.h,
              //             width: double.infinity,
              //             label: "Update",
              //             fontSize: kSixteenFont,
              //             fontWeight: kFW500,
              //             isLoading: false,
              //             onTap: () {
              //               var payload = {
              //                 "firstName": authentication
              //                     .editDonorfirstNameController.text,
              //                 "lastName": authentication
              //                     .editDonorLastNameController.text,
              //                 "email": authentication
              //                     .editBloodBankEmailController.text,
              //                 "address": authentication
              //                     .editBloodBanklocationsController.text,
              //                 "bloodGroup": authentication
              //                     .donorRegisterBloodGroup.value,
              //                 "gender":
              //                     authentication.donorRegisterGender.value,
              //                 "dateOfBirth": selectDate.value,
              //                 //////////////////////
              //                 // "bloodBankName": authentication
              //                 //     .editBloodBankNameController.text,
              //                 // "email": authentication
              //                 //     .editBloodBankEmailController.text,
              //                 // "address": authentication
              //                 //     .editBloodBanklocationsController.text,
              //                 // "startTime": startTime,
              //                 // "endTime": closeTime,
              //               };

              //               authentication.editProfileForm(payload);
              //               // var payload = {
              //               //   "firstName": authentication
              //               //       .editDonorfirstNameController.text,
              //               //   "lastName": authentication
              //               //       .editDonorLastNameController.text

              //               // };
              //               // if (_formKey.currentState!.validate()) {
              //               //   authentication.donorEditProfile(
              //               //       payload, selectedImage!);
              //               // }
              //             }

              //             // Fluttertoast.showToast(
              //             //   msg: "Registered Successfully",
              //             // );

              //             )
              //         : CustomButton(
              //             borderRadius: BorderRadius.circular(10.r),
              //             Color: Kpink,
              //             textColor: Kwhite,
              //             height: 42.h,
              //             width: double.infinity,
              //             label: "Update",
              //             fontSize: kSixteenFont,
              //             fontWeight: kFW500,
              //             isLoading: false,
              //             onTap: () {
              //               var payload = {
              //                 "bloodBankName": authentication
              //                     .editBloodBankNameController.text,
              //                 "email": authentication
              //                     .editBloodBankEmailController.text,
              //                 "address": authentication
              //                     .editBloodBanklocationsController.text,
              //                 // Latest Comments
              //                 // "startTime": startTime,
              //                 // "endTime": closeTime,
              //                 // "firstName": authentication
              //                 //     .registerDonorfirstNameController.text,
              //                 //"Ram Nayak",

              //                 //16.5196953
              //               };

              //               authentication.editProfileForm(payload);
              //               // authentication.donorEditProfileBank(
              //               //     payload, selectedImage!);

              //               // "phone": authentication.loginMobileController.text,
              //               //  "8297297247"
              //             }

              //             // Fluttertoast.showToast(
              //             //   msg: "Registered Successfully",
              //             // );

              //             )),

              // CustomButton(
              //   //margin: EdgeInsets.all(10.r),
              //   borderRadius: BorderRadius.circular(10.r),
              //   Color: Kpink,
              //   textColor: Kwhite,
              //   height: 42.h,
              //   width: double.infinity,
              //   label: "Update Profile",
              //   fontSize: kSixteenFont,
              //   fontWeight: kFW500,
              //   isLoading: false,
              //   onTap: () async {
              //     Fluttertoast.showToast(
              //       msg: "Registered Successfully",
              //     );
              //     Get.back();
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
