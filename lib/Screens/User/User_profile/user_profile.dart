import 'package:flutter/material.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'package:intl/intl.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
            "User Profile",
            style:
                TextStyle(fontSize: 22.sp, color: kcarden, fontWeight: kFW600),
          ),
          // actions: [
          //   InkWell(
          //     onTap: () {
          //       Get.toNamed(kEditProfileScreen);
          //     },
          //     child: Text(
          //       "Edit Profile",
          //       style: GoogleFonts.roboto(
          //           fontSize: kSixteenFont, color: kcarden, fontWeight: kFW600),
          //     ),
          //   ),
          // ],
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                                borderRadius: BorderRadius.circular(200.r),
                                child: selectedImage != null
                                    ? CircleAvatar(
                                        backgroundColor: Kwhite,
                                        radius: 56.r,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(200.r),
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
                                    : apicontroller.profileData["profilePic"] ==
                                            null
                                        ? Image.asset(
                                            "assets/images/profileImageStatic.png",
                                            height: 100.h,
                                            width: 100.w,
                                            fit: BoxFit.cover,
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Kwhite,
                                            radius: 56.r,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(200.r),
                                              child: CachedNetworkImage(
                                                imageUrl: kBaseImageUrl +
                                                    apicontroller.profileData[
                                                        "profilePic"],
                                                // authentication
                                                //     .profileData["profile"],
                                                placeholder: (context, url) =>
                                                    SizedBox(
                                                  height: 100.h,
                                                  width: 100.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 100.h,
                                                      width: 100.w,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        CircleAvatar(
                                                  backgroundColor: Kwhite,
                                                  radius: 56.r,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            200.r),
                                                    child: Image.asset(
                                                      "assets/images/profileImageStatic.png",
                                                      // height: 150.h,
                                                      width: 120.w,
                                                      //   fit: BoxFit.cover,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                // height: 100.h,
                                                width: 120.w,
                                                //   fit: BoxFit.cover,
                                                fit: BoxFit.cover,
                                              ),
                                              // Image.asset(
                                              //   "assets/images/profileImageStatic.png",
                                              //   // height: 150.h,
                                              //   height: 100.h,
                                              //   width: 100.w,
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                          ),
                              ),
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
                                              topRight: Radius.circular(20))),
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 12.sp,
                                                        fontWeight: kFW700,
                                                        color: KdarkText)),
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 12.sp,
                                                        fontWeight: kFW700,
                                                        color: KdarkText)),
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
                    height: 10.h,
                  ),
                  Text(
                    apicontroller.profileData["name"] ?? "NA",
                    style: GoogleFonts.roboto(
                        fontSize: 20.sp, color: KdarkText, fontWeight: kFW500),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "4.9",
                            style: GoogleFonts.roboto(
                                fontSize: kFourteenFont,
                                fontWeight: kFW500,
                                color: kcarden),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            Icons.star,
                            size: 18.sp,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                        child: VerticalDivider(
                          color: kcarden,
                          thickness: 1,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "165 Rides",
                            style: GoogleFonts.roboto(
                                fontSize: kFourteenFont,
                                fontWeight: kFW500,
                                color: kcarden),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Image.asset(
                            "assets/images/scooter.png",
                            height: 20.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                        child: VerticalDivider(
                          color: kcarden,
                          thickness: 1,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 85.w,
                            child: 
                            
                            Text(
                              (() {
                                final signUpDateString = apicontroller
                                    .profileData["signUpDateAndTime"];
                                if (signUpDateString == null) {
                                  return "NA";
                                }

                                final signUpDate =
                                    DateTime.parse(signUpDateString);

                                final now = DateTime.now();
                                final difference = now.difference(signUpDate);

                                if (difference.inDays < 30) {
                                  return "${difference.inDays} days";
                                } else if (difference.inDays < 365) {
                                  final months =
                                      (difference.inDays / 30).floor();
                                  return "$months ${months == 1 ? 'month' : 'months'}";
                                } else {
                                  final years =
                                      (difference.inDays / 365).floor();
                                  final months =
                                      ((difference.inDays % 365) / 30).floor();
                                  return months > 0
                                      ? "$years.${months} years"
                                      : "$years ${years == 1 ? 'year' : 'years'}";
                                }
                              })(),
                              style: GoogleFonts.roboto(
                                fontSize: kFourteenFont,
                                color: kcarden,
                                fontWeight: kFW500,
                              ),
                            ),
                          ),
                          //   Text(
                          //     "Joined 4 ",
                          //     style: GoogleFonts.roboto(
                          //         fontSize: kFourteenFont,
                          //         fontWeight: kFW500,
                          //         color: kcarden),
                          //   ),
                          // ),
                          Image.asset(
                            "assets/images/calender.png",
                            height: 20.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    color: Kpink.withOpacity(0.5),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 15.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Ktextcolor.withOpacity(0.5),
                          blurRadius: 5.r,
                          offset: Offset(1, 1),
                          spreadRadius: 1.r,
                        )
                      ],
                      border:
                          Border.all(width: 1, color: Kpink.withOpacity(0.5)),
                      color: Kwhite,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          apicontroller.profileData["role"] ?? "NA",
                          style: GoogleFonts.roboto(
                              fontSize: kFourteenFont,
                              color: kcarden,
                              fontWeight: kFW500),
                        ),
                        GestureDetector(
                            onTap: () {
                              // role: “user” or “captain”
                              if (apicontroller.profileData["role"] == "user") {
                                var payload = {"role": "captain"};

                                // {"mobile": _phoneController.text};
                                userapicontroller.roleChangeOtp(payload,
                                    apicontroller.profileData["mobile"]);
                              } else {
                                var payload = {"role": "user"};

                                // {"mobile": _phoneController.text};
                                userapicontroller.roleChangeOtp(payload,
                                    apicontroller.profileData["mobile"]);
                              }
                              ////////////////////////////////////
                              ///  if (apicontroller.profileData["role"] == "user") {
                              //   var payload = {"role": "captain"};

                              //   // {"mobile": _phoneController.text};
                              //   userapicontroller.roleChangeOtp(payload,
                              //       apicontroller.profileData["mobile"]);
                              // } else {
                              //   var payload = {"role": "user"};

                              //   // {"mobile": _phoneController.text};
                              //   userapicontroller.roleChangeOtp(payload,
                              //       apicontroller.profileData["mobile"]);
                              // }
                              //////////////////////////////
                            },
                            child: Row(
                              children: [
                                Icon(Icons.change_circle),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "Change Role",
                                  style: GoogleFonts.roboto(
                                      fontSize: kTwelveFont,
                                      color: Ktextcolor,
                                      fontWeight: kFW500),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Get.toNamed(kUserPersonalInformationScreen);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Ktextcolor.withOpacity(0.5),
                            blurRadius: 5.r,
                            offset: Offset(1, 1),
                            spreadRadius: 1.r,
                          )
                        ],
                        border:
                            Border.all(width: 1, color: Kpink.withOpacity(0.5)),
                        color: Kwhite,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Personal Information",
                            style: GoogleFonts.roboto(
                                fontSize: kFourteenFont,
                                color: kcarden,
                                fontWeight: kFW500),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: kcarden,
                            size: kEighteenFont,
                          )
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Get.toNamed(kPrivacyPolicies);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Ktextcolor.withOpacity(0.5),
                            blurRadius: 5.r,
                            offset: Offset(1, 1),
                            spreadRadius: 1.r,
                          )
                        ],
                        border:
                            Border.all(width: 1, color: Kpink.withOpacity(0.5)),
                        color: Kwhite,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Security and Privacy",
                            style: GoogleFonts.roboto(
                                fontSize: kFourteenFont,
                                color: kcarden,
                                fontWeight: kFW500),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: kcarden,
                            size: kEighteenFont,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(kUserDocsVerifyScreen);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Ktextcolor.withOpacity(0.5),
                            blurRadius: 5.r,
                            offset: Offset(1, 1),
                            spreadRadius: 1.r,
                          )
                        ],
                        border:
                            Border.all(width: 1, color: Kpink.withOpacity(0.5)),
                        color: Kwhite,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Documents & Bio Metrics",
                            style: GoogleFonts.roboto(
                                fontSize: kFourteenFont,
                                color: kcarden,
                                fontWeight: kFW500),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: kcarden,
                            size: kEighteenFont,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Ktextcolor.withOpacity(0.5),
                          blurRadius: 5.r,
                          offset: Offset(1, 1),
                          spreadRadius: 1.r,
                        )
                      ],
                      border:
                          Border.all(width: 1, color: Kpink.withOpacity(0.5)),
                      color: Kwhite,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "banking Details",
                          style: GoogleFonts.roboto(
                              fontSize: kFourteenFont,
                              color: kcarden,
                              fontWeight: kFW500),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: kcarden,
                          size: kEighteenFont,
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(kUserAnyIDScreen);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Ktextcolor.withOpacity(0.5),
                            blurRadius: 5.r,
                            offset: Offset(1, 1),
                            spreadRadius: 1.r,
                          )
                        ],
                        border:
                            Border.all(width: 1, color: Kpink.withOpacity(0.5)),
                        color: Kwhite,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Upload ID proof",
                            style: GoogleFonts.roboto(
                                fontSize: kFourteenFont,
                                color: kcarden,
                                fontWeight: kFW500),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: kcarden,
                            size: kEighteenFont,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Are You Sure',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      fontWeight: kFW700,
                                      color: KdarkText)),
                              content: Text('You Want To LogOut ?',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      fontWeight: kFW700,
                                      color: KdarkText.withOpacity(0.7))),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('No',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                          fontSize: 12.sp,
                                          fontWeight: kFW700,
                                          color: KdarkText)),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    ///
                                    /// Delete the database at the given path.
                                    ///
                                    // Future<void> deleteDatabase(String path) =>
                                    //     _databaseHelper.database;
                                    UserSimplePreferences.clearAllData();
                                    // Get.toNamed(kSelectType);
                                    Get.toNamed(kNewPhoneScreen);
                                    // Get.toNamed(kSelectType);
                                  },
                                  child: Text('Yes',
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
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Ktextcolor.withOpacity(0.5),
                            blurRadius: 5.r,
                            offset: Offset(1, 1),
                            spreadRadius: 1.r,
                          )
                        ],
                        border:
                            Border.all(width: 1, color: Kpink.withOpacity(0.5)),
                        color: Kwhite,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Log Out",
                            style: GoogleFonts.roboto(
                                fontSize: kFourteenFont,
                                color: kcarden,
                                fontWeight: kFW500),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: kcarden,
                            size: kEighteenFont,
                          )
                        ],
                      ),
                    ),
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
                ],
              ),
            ),
          ),
        ));
  }
}
