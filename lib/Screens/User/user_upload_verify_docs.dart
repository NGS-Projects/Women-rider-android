import 'package:womentaxi/untils/export_file.dart';

// class UserUploadVerifyDocs extends StatefulWidget {
//   const UserUploadVerifyDocs({super.key});

//   @override
//   State<UserUploadVerifyDocs> createState() => _UserUploadVerifyDocsState();
// }

// class _UserUploadVerifyDocsState extends State<UserUploadVerifyDocs> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For base64 encoding
import 'dart:io';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_compare_2/image_compare_2.dart';
import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

class UserUploadVerifyDocs extends StatefulWidget {
  const UserUploadVerifyDocs({super.key});

  @override
  State<UserUploadVerifyDocs> createState() => _UserUploadVerifyDocsState();
}

class _UserUploadVerifyDocsState extends State<UserUploadVerifyDocs> {
  ApiController apicontroller = Get.put(ApiController());
  UserApiController userapicontroller = Get.put(UserApiController());
  ////////////////////////////////////////////////////////////////////////////////////////////
  String comparisonResult = '';

  Future<void> compareTwoImages() async {
    try {
      // Local image file
      var localImage = File(userapicontroller
          .bioMetricImage.value); // Update with your local image path

      // Remote image URL
      var remoteImageUrl = Uri.parse(
          kBaseImageUrl + apicontroller.profileData["authenticationImage"]
          // apicontroller.profileData["authenticationImage"]
          // 'https://fujifilm-x.com/wp-content/uploads/2019/08/x-t30_sample-images03.jpg'
          );

      // Download the remote image as bytes
      final response = await http.get(remoteImageUrl);
      if (response.statusCode == 200) {
        // Compare local image file with the downloaded remote image
        var comparisonResultValue = await compareImages(
          src1: localImage.readAsBytesSync(),
          src2: response.bodyBytes,
          algorithm:
              PixelMatching(), // You can change the algorithm here if needed
        );

        // Set a similarity threshold (e.g., 0.1 for images considered "similar")
        double threshold = 0.1;

        // Check if the images are similar or identical
        if (comparisonResultValue <= threshold) {
          setState(() {
            comparisonResult = "The images are similar or identical.";
          });
        } else {
          setState(() {
            comparisonResult = "The images are different.";
          });
        }
      } else {
        setState(() {
          comparisonResult = 'Failed to load remote image';
        });
      }
    } catch (e) {
      setState(() {
        comparisonResult = 'Error comparing images: $e';
      });
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<String?> imageToBase64(String imageUrl) async {
    try {
      // Fetch the image from the URL
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Convert image bytes to base64
        final bytes = response.bodyBytes;
        final base64String = base64Encode(bytes);
        setState(() {
          userapicontroller.urlbaseImage.value = base64String;
        });
        print(userapicontroller.urlbaseImage);
        return base64String;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  //////////////////////////////////
  Future<String?> fileToBase64(String filePath) async {
    try {
      // Read the file as bytes
      final bytes = File(filePath).readAsBytesSync();

      // Convert the bytes to base64 string
      final base64String = base64Encode(bytes);
      setState(() {
        userapicontroller.filebaseImage.value = base64String;
      });
      print(userapicontroller.filebaseImage);
      return base64String;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  //////////////////////////////////////////////////
  final List<String> Genders = [
    'Male',
    'Female',
    'Others',
  ];

  String? selectedGenderValue;
  ////Current Location
  // location

  int activeIndex = 0;

  final _formKey = GlobalKey<FormState>();
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();
  // GoogleMapController? _controller;

  double lat = 37.42796133580664;
  double lon = -122.085749655962;

  String? _currentAddress;
  String? _currentAddresspincode;
  String? _destination;

  var isLoading = "none";

  final TextEditingController mlController1 = TextEditingController();
  final TextEditingController mlController2 = TextEditingController();
  final TextEditingController mlController3 = TextEditingController();
  final TextEditingController mlController4 = TextEditingController();
  final TextEditingController mlController5 = TextEditingController();
  final TextEditingController mlController6 = TextEditingController();
  final TextEditingController mlController7 = TextEditingController();
  final TextEditingController mlController8 = TextEditingController();

  final TextEditingController unitsController1 = TextEditingController();
  final TextEditingController unitsController2 = TextEditingController();
  final TextEditingController unitsController3 = TextEditingController();
  final TextEditingController unitsController4 = TextEditingController();
  final TextEditingController unitsController5 = TextEditingController();
  final TextEditingController unitsController6 = TextEditingController();
  final TextEditingController unitsController7 = TextEditingController();
  final TextEditingController unitsController8 = TextEditingController();

  double mlToUnits(double ml) {
    // Conversion logic: 1 unit = 450 ml
    return ml / 450;
  }

  double unitsToMl(double units) {
    // Conversion logic: 1 unit = 450 ml
    return units * 450;
  }

  /////////////////////////////
  void updateUnitsFromMl(TextEditingController mlController,
      TextEditingController unitsController) {
    final double mlValue = double.tryParse(mlController.text) ?? 0;
    final double unitsValue = mlToUnits(mlValue);
    unitsController.text = unitsValue.toStringAsFixed(2);
  }

  void updateMlFromUnits(TextEditingController unitsController,
      TextEditingController mlController) {
    final double unitsValue = double.tryParse(unitsController.text) ?? 0;
    final double mlValue = unitsToMl(unitsValue);
    mlController.text = mlValue.toStringAsFixed(2);
  }

  ////////////////////////

  final List<String> bloodgroupss = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
    'RH+',
    'RH-'
  ];

  String? selectedValue;

  final List<String> requesttype = ['Blood', 'Platelets', 'Plasma'];

  String? selectedrequest;

  //////////////

  //////////////////////
  bool value = false;
  bool valuetwo = false;
  TextEditingController dOBController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime choosenDate = DateTime.now();

  bool showimagenullMessage = false;

  //////////////////////////////
  File? selectedImage;
  File? selectedImagetwo;
  File? selectedImagethree;
  File? selectedImagefour;
  File? selectedImagefive;

  String base64Image = "";
  // bool isLoading = false;
  Map typesData = {};
  List<String> options = [];
  int choosenTypeData = 0;
  String choosenOption = "";

  String description = "";
  int? totalAmount;
  String? str;
  Future<void> chooseImage(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
      );
      // .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          //.pickImage(source: ImageSource.gallery);
          .pickImage(source: ImageSource.gallery, imageQuality: 10);
      //  .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        print(selectedImage!.readAsBytesSync().lengthInBytes);
        final kb = selectedImage!.readAsBytesSync().lengthInBytes / 1024;
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

  /////////////////
  Future<void> chooseImagetwo(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
      );
      // .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          //.pickImage(source: ImageSource.gallery);
          .pickImage(source: ImageSource.gallery, imageQuality: 10);
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

  ////
  Future<void> chooseImagethree(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
      );
      // .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          //.pickImage(source: ImageSource.gallery);
          .pickImage(source: ImageSource.gallery, imageQuality: 10);
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

  /////
  Future<void> chooseImagefour(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
      );
      // .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          //.pickImage(source: ImageSource.gallery);
          .pickImage(source: ImageSource.gallery, imageQuality: 10);
      //  .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImagefour = File(image.path);
        base64Image = base64Encode(selectedImagefour!.readAsBytesSync());
        print(selectedImagefour!.readAsBytesSync().lengthInBytes);
        final kb = selectedImagefour!.readAsBytesSync().lengthInBytes / 1024;
        print(kb);
        final mb = kb / 1024;
        print(mb);
        print("ram b jk dslnkv flk dlkcdslc k");
        showimagenullMessage = false;
      });
    }
  }

  ////////
  Future<void> chooseImagefive(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
      );
      // .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          //.pickImage(source: ImageSource.gallery);
          .pickImage(source: ImageSource.gallery, imageQuality: 10);
      //  .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImagefive = File(image.path);
        base64Image = base64Encode(selectedImagefive!.readAsBytesSync());
        print(selectedImagefive!.readAsBytesSync().lengthInBytes);
        final kb = selectedImagefive!.readAsBytesSync().lengthInBytes / 1024;
        print(kb);
        final mb = kb / 1024;
        print(mb);
        print("ram b jk dslnkv flk dlkcdslc k");
        showimagenullMessage = false;
      });
    }
  }

  ////////////////////////////////
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: kcarden,
            size: 20.sp,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          "User Upload Documents",
          style: GoogleFonts.roboto(
              fontSize: kEighteenFont, fontWeight: kFW500, color: kcarden),
        ),
      ),
      backgroundColor: Kwhite,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.r),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
//////////////////////////////////////////////////////////////////////////////////////////

                /////////////////////////////////////////////////////////////////////
                SizedBox(
                  height: 30.h,
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
                  child:

                      ////////////////////////////
                      Obx(() => apicontroller
                                  .profileData["authenticationImage"] ==
                              null
                          ? Text("")
                          : Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: kBaseImageUrl +
                                      apicontroller
                                          .profileData["authenticationImage"],
                                  // authentication
                                  //     .profileData["profile"],
                                  placeholder: (context, url) => SizedBox(
                                    height: 130.h,
                                    width: double.infinity,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.black12,
                                      highlightColor:
                                          Colors.white.withOpacity(0.5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Kwhite.withOpacity(0.5),
                                        ),
                                        height: 130.h,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Center(child: Text("No Image")),
                                  height: 130.h,
                                  width: double.infinity,
                                  //   fit: BoxFit.cover,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            )),
                  //////////////////////
                ),
                SizedBox(
                  height: 5.h,
                ),

                GestureDetector(
                  onTap: () {
                    Get.toNamed(kUserUploadDocs);
                    //  Get.toNamed(kCaptainAuthenticationUpload);
                    // showModalBottomSheet(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.only(
                    //           topRight: Radius.circular(20),
                    //           topLeft: Radius.circular(20)),
                    //     ),
                    //     backgroundColor: Kbackground,
                    //     context: context,
                    //     builder: (context) {
                    //       return Container(
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               color: Kbackground,
                    //               borderRadius: BorderRadius.only(
                    //                   topLeft: Radius.circular(20),
                    //                   topRight: Radius.circular(20))),
                    //           height: 100.h,
                    //           padding: EdgeInsets.only(top: 20.h),
                    //           child: Row(
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceAround,
                    //             children: [
                    //               GestureDetector(
                    //                 onTap: () {
                    //                   chooseImagefour("Gallery");
                    //                   Navigator.pop(context);
                    //                 },
                    //                 child: Column(
                    //                   children: [
                    //                     Icon(
                    //                       Icons.image_outlined,
                    //                       color: Kpink,
                    //                     ),
                    //                     SizedBox(
                    //                       height: 5.h,
                    //                     ),
                    //                     Text('Gallery',
                    //                         maxLines: 2,
                    //                         overflow: TextOverflow.ellipsis,
                    //                         style: GoogleFonts.roboto(
                    //                             fontSize: 12.sp,
                    //                             fontWeight: kFW700,
                    //                             color: KdarkText)),
                    //                   ],
                    //                 ),
                    //               ),
                    //               GestureDetector(
                    //                 onTap: () {
                    //                   chooseImagefour("camera");
                    //                   Navigator.pop(context);
                    //                 },
                    //                 child: Column(
                    //                   children: [
                    //                     Icon(
                    //                       Icons.camera_alt_outlined,
                    //                       color: Kpink,
                    //                     ),
                    //                     SizedBox(
                    //                       height: 5.h,
                    //                     ),
                    //                     Text('camera',
                    //                         maxLines: 2,
                    //                         overflow: TextOverflow.ellipsis,
                    //                         style: GoogleFonts.roboto(
                    //                             fontSize: 12.sp,
                    //                             fontWeight: kFW700,
                    //                             color: KdarkText)),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     });
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Upload Authentication Image",
                              style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  color: Kpink,
                                  fontWeight: kFW600),
                            )
                          ],
                        ),
                      )),
                ),
                // CustomButton(
                //     borderRadius: BorderRadius.circular(10.r),
                //     margin: EdgeInsets.only(top: 20),
                //     Color: Kpink,
                //     textColor: Kwhite,
                //     height: 42.h,
                //     width: double.infinity,
                //     label: "Check images",
                //     fontSize: kSixteenFont,
                //     fontWeight: kFW500,
                //     isLoading: false,
                //     onTap: () {
                //       compareTwoImages();
                //     }

                //     // Fluttertoast.showToast(
                //     //   msg: "Registered Successfully",
                //     // );

                //     ),
                // ////////////////////////////////////////////////////////////////////////////////face matching
                // CustomButton(
                //     margin: EdgeInsets.only(top: 60),
                //     borderRadius: BorderRadius.circular(10.r),
                //     Color: Kpink,
                //     textColor: Kwhite,
                //     height: 42.h,
                //     width: double.infinity,
                //     label: "Face matching",
                //     fontSize: kSixteenFont,
                //     fontWeight: kFW500,
                //     isLoading: false,
                //     onTap: () async {
                //       //   String _capturedImagePath = "path_to_your_local_image";

                //       //   // Convert the file to base64 string
                //       // String? base64Image = await fileToBase64(
                //       //     userapicontroller.bioMetricImage.value);
                //       // print(base64Image);
                //       // imgtobase64
                //       // String imageUrl = "http://example.com/url-of-first-image";
                //       // String? base64Image = await imageToBase64(kBaseImageUrl +
                //       //     apicontroller.profileData["authenticationImage"]);
                //       // print(base64Image);
                //       // api
                //       var payload = {
                //         "image1B64":
                //             "base64 ${userapicontroller.urlbaseImage.value}",
                //         "image2B64":
                //             "base64 ${userapicontroller.filebaseImage.value}"
                //         // "getNumberOfFaces": false,
                //         // "clientData": {"caseId": "123456"}
                //       };
                //       //  {"pan": "", "consent": "Y"};

                //       apicontroller.captainFaceMatching(payload);
                //     }),
                //////////////////////////////////////////////////////////////////////////////////////////////

                // SizedBox(
                //   height: 60.h,
                // ),
                // Obx(() => apicontroller.useruploadDocsoading == true
                //     ? Center(
                //         child: CircularProgressIndicator(
                //           color: Kpink,
                //         ),
                //       )
                //     : CustomButton(
                //         borderRadius: BorderRadius.circular(10.r),
                //         Color: Kpink,
                //         textColor: Kwhite,
                //         height: 42.h,
                //         width: double.infinity,
                //         label: "Upload",
                //         fontSize: kSixteenFont,
                //         fontWeight: kFW500,
                //         isLoading: false,
                //         onTap: () {
                //           if (selectedImagetwo == null ||
                //               selectedImagethree == null) {
                //             Fluttertoast.showToast(
                //               msg: "Please Upload All Documents",
                //             );
                //           } else {
                //             apicontroller.userUploadVrrifyDocs(
                //                 selectedImagetwo!, selectedImagethree!);
                //           }
                //         }

                //         // Fluttertoast.showToast(
                //         //   msg: "Registered Successfully",
                //         // );

                //         )),

                SizedBox(
                  height: 120.h,
                ),
                ///////////////////////////////
              ],
            ),
          ),
        ),
      ),
    );
  }
}
