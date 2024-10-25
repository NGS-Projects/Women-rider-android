import 'package:flutter/material.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'package:intl/intl.dart';

class UserPersonalInformation extends StatefulWidget {
  const UserPersonalInformation({super.key});

  @override
  State<UserPersonalInformation> createState() =>
      _UserPersonalInformationState();
}

class _UserPersonalInformationState extends State<UserPersonalInformation> {
  ApiController apicontroller = Get.put(ApiController());
  UserApiController userapicontroller = Get.put(UserApiController());
  /////////////
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

  @override
  void initState() {
    apicontroller.getRapidoEmpProfile();
    // TODO: implement initState
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
            "Personal Information",
            style:
                TextStyle(fontSize: 19.sp, color: kcarden, fontWeight: kFW600),
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed(kEditProfileScreen);
              },
              child: Text(
                "Edit profile",
                style: GoogleFonts.roboto(
                    fontSize: 15.sp, color: kcarden, fontWeight: kFW500),
              ),
            ),
            SizedBox(
              width: 16.w,
            )
          ],
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: GoogleFonts.roboto(
                        fontSize: kTwelveFont,
                        color: Ktextcolor,
                        fontWeight: kFW400),
                  ),
                  Text(
                    apicontroller.profileData["name"] ?? "NA",
                    style: GoogleFonts.roboto(
                        fontSize: kFourteenFont,
                        color: Kpink,
                        fontWeight: kFW500),
                  ),
                  Divider(),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "Gender",
                    style: GoogleFonts.roboto(
                        fontSize: kTwelveFont,
                        color: Ktextcolor,
                        fontWeight: kFW400),
                  ),
                  Text(
                    "Female",
                    style: GoogleFonts.roboto(
                        fontSize: kFourteenFont,
                        color: Kpink,
                        fontWeight: kFW500),
                  ),
                  Divider(),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "Date of Birth",
                    style: GoogleFonts.roboto(
                        fontSize: kTwelveFont,
                        color: Ktextcolor,
                        fontWeight: kFW400),
                  ),
                  Text(
                    apicontroller.profileData["dateOfBirth"] ?? "NA",
                    style: GoogleFonts.roboto(
                        fontSize: kFourteenFont,
                        color: Kpink,
                        fontWeight: kFW500),
                  ),
                  Divider(),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "Mobile Number",
                    style: GoogleFonts.roboto(
                        fontSize: kTwelveFont,
                        color: Ktextcolor,
                        fontWeight: kFW400),
                  ),
                  Text(
                    apicontroller.profileData["mobile"] ?? "NA",
                    style: GoogleFonts.roboto(
                        fontSize: kFourteenFont,
                        color: Kpink,
                        fontWeight: kFW500),
                  ),
                  Divider(),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "Email ID",
                    style: GoogleFonts.roboto(
                        fontSize: kTwelveFont,
                        color: Ktextcolor,
                        fontWeight: kFW400),
                  ),
                  Text(
                    apicontroller.profileData["email"] ?? "NA",
                    style: GoogleFonts.roboto(
                        fontSize: kFourteenFont,
                        color: Kpink,
                        fontWeight: kFW500),
                  ),
                  Divider(),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "Member since",
                    style: GoogleFonts.roboto(
                        fontSize: kTwelveFont,
                        color: Ktextcolor,
                        fontWeight: kFW400),
                  ),
                  Text(
                    (() {
                      final signUpDateString =
                          apicontroller.profileData["signUpDateAndTime"];
                      if (signUpDateString == null) {
                        return "NA";
                      }

                      final signUpDate = DateTime.parse(signUpDateString);

                      final now = DateTime.now();
                      final difference = now.difference(signUpDate);

                      if (difference.inDays < 30) {
                        return "${difference.inDays} days";
                      } else if (difference.inDays < 365) {
                        final months = (difference.inDays / 30).floor();
                        return "$months ${months == 1 ? 'month' : 'months'}";
                      } else {
                        final years = (difference.inDays / 365).floor();
                        final months = ((difference.inDays % 365) / 30).floor();
                        return months > 0
                            ? "$years.${months} years"
                            : "$years ${years == 1 ? 'year' : 'years'}";
                      }
                    })(),
                    style: GoogleFonts.roboto(
                      fontSize: kFourteenFont,
                      color: Kpink,
                      fontWeight: kFW500,
                    ),
                  ),
                  // Text(
                  //   apicontroller.profileData["signUpDateAndTime"] ?? "NA",
                  //   style: GoogleFonts.roboto(
                  //       fontSize: kFourteenFont,
                  //       color: Kpink,
                  //       fontWeight: kFW500),
                  // ),
                  Divider(),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "Address",
                    style: GoogleFonts.roboto(
                        fontSize: kTwelveFont,
                        color: Ktextcolor,
                        fontWeight: kFW400),
                  ),
                  Text(
                    apicontroller.profileData["address"] ?? "",
                    style: GoogleFonts.roboto(
                        fontSize: kFourteenFont,
                        color: Kpink,
                        fontWeight: kFW500),
                  ),
                  Divider(),
                  SizedBox(
                    height: 15.h,
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   margin: EdgeInsets.only(top: 15.h),
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
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         "Gender",
                  //         style: GoogleFonts.roboto(
                  //             fontSize: kSixteenFont,
                  //             color: KdarkText,
                  //             fontWeight: kFW500),
                  //       ),
                  //       SizedBox(
                  //         height: 8.h,
                  //       ),
                  //       Text(
                  //         apicontroller.profileData["gender"] ?? "NA",
                  //         style: GoogleFonts.roboto(
                  //             fontSize: kTwelveFont,
                  //             color: Ktextcolor,
                  //             fontWeight: kFW500),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   width: double.infinity,
                  //   margin: EdgeInsets.only(top: 15.h),
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
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         "Phone Number",
                  //         style: GoogleFonts.roboto(
                  //             fontSize: kSixteenFont,
                  //             color: KdarkText,
                  //             fontWeight: kFW500),
                  //       ),
                  //       SizedBox(
                  //         height: 8.h,
                  //       ),
                  //       Text(
                  //         apicontroller.profileData["mobile"] ?? "NA",
                  //         style: GoogleFonts.roboto(
                  //             fontSize: kTwelveFont,
                  //             color: Ktextcolor,
                  //             fontWeight: kFW500),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  //  Get.toNamed(kEditProfileScreen);
                  // SizedBox(
                  //   height: 70.h,
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.toNamed(kEditProfileScreen);
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     alignment: Alignment.center,
                  //     // margin: EdgeInsets.only(top: 70.h),
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: 10.w, vertical: 10.h),
                  //     decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Ktextcolor.withOpacity(0.5),
                  //           blurRadius: 5.r,
                  //           offset: Offset(1, 1),
                  //           spreadRadius: 1.r,
                  //         )
                  //       ],
                  //       border:
                  //           Border.all(width: 1, color: Kpink.withOpacity(0.5)),
                  //       color: Kwhite,
                  //       borderRadius: BorderRadius.circular(30.r),
                  //     ),
                  //     child: Text(
                  //       "Update Profile",
                  //       style: GoogleFonts.roboto(
                  //           fontSize: 15.sp, color: Kpink, fontWeight: kFW500),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
