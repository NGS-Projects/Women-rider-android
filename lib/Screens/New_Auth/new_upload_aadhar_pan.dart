import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:womentaxi/untils/constants.dart';
import 'package:womentaxi/untils/export_file.dart';

class NewAadharPanUploadDOcs extends StatefulWidget {
  const NewAadharPanUploadDOcs({super.key});

  @override
  State<NewAadharPanUploadDOcs> createState() => _NewAadharPanUploadDOcsState();
}

class _NewAadharPanUploadDOcsState extends State<NewAadharPanUploadDOcs> {
  ApiController apiController = Get.put(ApiController());
  File? selectedImagethree;
  File? selectedImagetwo;
  String base64Image = "";
  bool showimagenullMessage = false;
  Future<void> chooseImagethree(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 20,
      );
      // .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          //.pickImage(source: ImageSource.gallery);
          .pickImage(source: ImageSource.gallery, imageQuality: 20);
      //  .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImagethree = File(image.path);
        base64Image = base64Encode(selectedImagethree!.readAsBytesSync());
        print(selectedImagethree!.readAsBytesSync().lengthInBytes);
        final kb = selectedImagethree!.readAsBytesSync().lengthInBytes / 1024;
        print(kb);
        final mb = kb / 1024;
        print(mb);
        print("ram b jk dslnkv flk dlkcdslc k");
        showimagenullMessage = false;
      });
    }
  }

  ///////////////////Choose image two
  Future<void> chooseImagetwo(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 20,
      );
      // .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          //.pickImage(source: ImageSource.gallery);
          .pickImage(source: ImageSource.gallery, imageQuality: 20);
      //  .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImagetwo = File(image.path);
        base64Image = base64Encode(selectedImagetwo!.readAsBytesSync());
        print(selectedImagetwo!.readAsBytesSync().lengthInBytes);
        final kb = selectedImagetwo!.readAsBytesSync().lengthInBytes / 1024;
        print(kb);
        final mb = kb / 1024;
        print(mb);
        print("ram b jk dslnkv flk dlkcdslc k");
        showimagenullMessage = false;
      });
//       Future getImageSize() async {
// // final pickedImage = await picker.getImage(source: ImageSource.gallery);
//         final bytes = selectedImage!.readAsBytesSync().lengthInBytes;
//         final kb = bytes / 1024;
//         final mb = kb / 1024;
//         print("Below kilo bytes,...........................................");
//         print(kb);
//       }
      // var value = await Services.profileimage(File(image.path));
      // if (jsonDecode(value["msg"]) != null) {
      //   Fluttertoast.showToast(msg: value["msg"]);
      // } else {
      //   // Get.toNamed(Kapply_leaves);
      // }
    }
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
                Image.asset(
                  "assets/images/womenriders.png",
                  height: 60.h,
                  // width: 150.w,
                ),

                // Padding(
                //   padding: EdgeInsets.all(15),
                //   child: Center(
                //     child: Image.asset(
                //       "assets/images/donee.png",

                //       height: MediaQuery.of(context).size.height / 3.5,
                //       // fit: BoxFit.fitHeight,
                //       // width: 150.w,
                //     ),
                //   ),
                // ),
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
                          color: kPinkBgColortwo,
                          blurRadius: 30,
                          offset: Offset(15, 15),
                          spreadRadius: 0,
                        )
                      ]),
                  child: apiController.selectedIDType == "Aadhar"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "Upload Aadhar card Image",
                              // apiController.selectedIDType == "Aadhar"
                              // ? "Upload Aadhar card Image"
                              // : "Upload PAN card Image",
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
                              height: 15.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Ktextcolor.withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: const Offset(0, 0),
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                              child: selectedImagethree != null
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: 15.h),
                                      child: Image.file(
                                        selectedImagethree!,
                                        fit: BoxFit.cover,
                                        height: 130.h,
                                        width: double.infinity,
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(bottom: 15.h),
                                      child: Image.asset(
                                        "assets/images/adhar_front.jpeg",
                                        fit: BoxFit.cover,
                                        height: 130.h,
                                        width: double.infinity,
                                      ),
                                    ),
                            ),
                            GestureDetector(
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
                                                  chooseImagethree("Gallery");
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
                                                  chooseImagethree("camera");
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
                              child: DottedBorder(
                                  dashPattern: [8, 2],
                                  strokeWidth: 1,
                                  color: Kpink,
                                  child: Container(
                                    height: 35.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.r),
                                      color: Kwhite,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Upload Adhar Card Front Side",
                                          style: GoogleFonts.roboto(
                                              fontSize: 12.sp,
                                              color: Kpink,
                                              fontWeight: kFW600),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            // Center(
                            //   child: OTPTextField(
                            //     otpFieldStyle: OtpFieldStyle(
                            //         enabledBorderColor: Ktextcolor,
                            //         focusBorderColor: Kpink),
                            //     length: 6,
                            //     width: double.infinity,
                            //     fieldWidth: 35.w,
                            //     contentPadding: EdgeInsets.symmetric(vertical: 2),
                            //     margin: EdgeInsets.only(right: 8.w),
                            //     fieldStyle: FieldStyle.box,
                            //     outlineBorderRadius: 10,
                            //     style: GoogleFonts.roboto(
                            //         fontSize: kEighteenFont,
                            //         fontWeight: kFW500,
                            //         color: Kpink),
                            //     textFieldAlignment: MainAxisAlignment.spaceAround,
                            //   ),
                            // ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Ktextcolor.withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: const Offset(0, 0),
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                              child: selectedImagetwo != null
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: 15.h),
                                      child: Image.file(
                                        selectedImagetwo!,
                                        fit: BoxFit.cover,
                                        height: 130.h,
                                        width: double.infinity,
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(bottom: 15.h),
                                      child: Image.asset(
                                        "assets/images/adhar_back.png",
                                        fit: BoxFit.cover,
                                        height: 130.h,
                                        width: double.infinity,
                                      ),
                                    ),
                              //  const Text(
                              //     "",
                              //     textAlign: TextAlign.center,
                              //   ),
                            ),
                            GestureDetector(
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
                                                  chooseImagetwo("Gallery");
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
                                                  chooseImagetwo("camera");
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
                              child: DottedBorder(
                                  dashPattern: [8, 2],
                                  strokeWidth: 1,
                                  color: Kpink,
                                  child: Container(
                                    height: 35.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.r),
                                      color: Kwhite,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Upload  Adhar Card Back Side",
                                          style: GoogleFonts.roboto(
                                              fontSize: 12.sp,
                                              color: Kpink,
                                              fontWeight: kFW600),
                                        )
                                      ],
                                    ),
                                  )),
                            ),

                            CustomButton(
                                margin: EdgeInsets.only(top: 30.h),
                                borderRadius: BorderRadius.circular(10.r),
                                Color: Kpink,
                                textColor: Kwhite,
                                height: 42.h,
                                width: double.infinity,
                                label: "Upload ADHAAR Card",
                                fontSize: kSixteenFont,
                                fontWeight: kFW500,
                                isLoading: false,
                                onTap: () {
                                  if (selectedImagethree == null ||
                                      selectedImagetwo == null) {
                                    Fluttertoast.showToast(
                                      msg: "Please Upload Adhaar Card",
                                    );
                                  } else {
                                    apicontroller.signupuserUploadVrrifyAdhaar(
                                        selectedImagethree!, selectedImagetwo!);
                                    // apicontroller.userUploadVrrifyDocs(
                                    // selectedImagetwo!, selectedImagethree!);
                                  }
                                }

                                // Fluttertoast.showToast(
                                //   msg: "Registered Successfully",
                                // );

                                )
                            // Center(
                            //   child: Container(
                            //     margin: EdgeInsets.only(top: 10.h, bottom: 80.h),
                            //     // padding: Padding,
                            //     height: 40,
                            //     width: 200.w,
                            //     alignment: Alignment.center,
                            //     decoration: BoxDecoration(
                            //       color: KBLUESHADE,
                            //       borderRadius: BorderRadius.circular(30),
                            //     ),
                            //     child: Text(
                            //       "Upload",
                            //       textAlign: TextAlign.center,
                            //       style: GoogleFonts.roboto(
                            //           fontSize: kSixteenFont,
                            //           color: Kpink,
                            //           fontWeight: kFW500),
                            //     ),
                            //   ),
                            // ),

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
                            //     //   controller: _phoneController,
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
                            //           // var payload = {"mobile": _phoneController.text};

                            //           // if (_formKey.currentState!.validate()) {
                            //           //   apiController.mobileRegistration(payload);
                            //           // }
                            //         },
                            //         child: Container(
                            //             width: 70,
                            //             // color: Kpink,
                            //             decoration: BoxDecoration(
                            //                 color: Kpink,
                            //                 borderRadius: BorderRadius.only(
                            //                     topRight: Radius.circular(10.r),
                            //                     bottomRight: Radius.circular(10.r))),
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
                            ,
                            SizedBox(
                              height: 50.h,
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "Upload  PAN card Image",
                              // apiController.selectedIDType == "Aadhar"
                              // ? "Upload Aadhar card Image"
                              // : "Upload PAN card Image",
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
                              height: 15.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Ktextcolor.withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: const Offset(0, 0),
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                              child: selectedImagethree != null
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: 15.h),
                                      child: Image.file(
                                        selectedImagethree!,
                                        fit: BoxFit.cover,
                                        height: 130.h,
                                        width: double.infinity,
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(bottom: 15.h),
                                      child: Image.asset(
                                        "assets/images/pancard_front.jpg",
                                        fit: BoxFit.cover,
                                        height: 130.h,
                                        width: double.infinity,
                                      ),
                                    ),
                            ),
                            GestureDetector(
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
                                                  chooseImagethree("Gallery");
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
                                                  chooseImagethree("camera");
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
                              child: DottedBorder(
                                  dashPattern: [8, 2],
                                  strokeWidth: 1,
                                  color: Kpink,
                                  child: Container(
                                    height: 35.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.r),
                                      color: Kwhite,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Upload PAN Card Front Side",
                                          style: GoogleFonts.roboto(
                                              fontSize: 12.sp,
                                              color: Kpink,
                                              fontWeight: kFW600),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            // Center(
                            //   child: OTPTextField(
                            //     otpFieldStyle: OtpFieldStyle(
                            //         enabledBorderColor: Ktextcolor,
                            //         focusBorderColor: Kpink),
                            //     length: 6,
                            //     width: double.infinity,
                            //     fieldWidth: 35.w,
                            //     contentPadding: EdgeInsets.symmetric(vertical: 2),
                            //     margin: EdgeInsets.only(right: 8.w),
                            //     fieldStyle: FieldStyle.box,
                            //     outlineBorderRadius: 10,
                            //     style: GoogleFonts.roboto(
                            //         fontSize: kEighteenFont,
                            //         fontWeight: kFW500,
                            //         color: Kpink),
                            //     textFieldAlignment: MainAxisAlignment.spaceAround,
                            //   ),
                            // ),

                            CustomButton(
                                margin: EdgeInsets.only(top: 30.h),
                                borderRadius: BorderRadius.circular(10.r),
                                Color: Kpink,
                                textColor: Kwhite,
                                height: 42.h,
                                width: double.infinity,
                                label: "Upload PAN Card",
                                fontSize: kSixteenFont,
                                fontWeight: kFW500,
                                isLoading: false,
                                onTap: () {
                                  if (selectedImagethree == null) {
                                    Fluttertoast.showToast(
                                      msg: "Please Upload PAN Card",
                                    );
                                  } else {
                                    apicontroller.signupuserUploadVrrifyPan(
                                        selectedImagethree!);
                                    // apicontroller.signupuserUploadVrrifyAdhaar(
                                    //     selectedImagethree!, selectedImagetwo!);
                                  }
                                }

                                // Fluttertoast.showToast(
                                //   msg: "Registered Successfully",
                                // );

                                )
                            // Center(
                            //   child: Container(
                            //     margin: EdgeInsets.only(top: 10.h, bottom: 80.h),
                            //     // padding: Padding,
                            //     height: 40,
                            //     width: 200.w,
                            //     alignment: Alignment.center,
                            //     decoration: BoxDecoration(
                            //       color: KBLUESHADE,
                            //       borderRadius: BorderRadius.circular(30),
                            //     ),
                            //     child: Text(
                            //       "Upload",
                            //       textAlign: TextAlign.center,
                            //       style: GoogleFonts.roboto(
                            //           fontSize: kSixteenFont,
                            //           color: Kpink,
                            //           fontWeight: kFW500),
                            //     ),
                            //   ),
                            // ),

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
                            //     //   controller: _phoneController,
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
                            //           // var payload = {"mobile": _phoneController.text};

                            //           // if (_formKey.currentState!.validate()) {
                            //           //   apiController.mobileRegistration(payload);
                            //           // }
                            //         },
                            //         child: Container(
                            //             width: 70,
                            //             // color: Kpink,
                            //             decoration: BoxDecoration(
                            //                 color: Kpink,
                            //                 borderRadius: BorderRadius.only(
                            //                     topRight: Radius.circular(10.r),
                            //                     bottomRight: Radius.circular(10.r))),
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
                            ,
                            SizedBox(
                              height: 50.h,
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
  }
}
