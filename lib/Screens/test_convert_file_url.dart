import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:womentaxi/untils/export_file.dart';

class FileConvert extends StatefulWidget {
  const FileConvert({super.key});

  @override
  State<FileConvert> createState() => _FileConvertState();
}

class _FileConvertState extends State<FileConvert> {
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
        apicontroller.convertFromFiletoUrl(selectedImage!); //
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                              borderRadius: BorderRadius.circular(200.r),
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
                        : apicontroller.profileData["profilePic"] == null
                            ? Image.asset(
                                "assets/images/null_profile.png",
                                height: 100.h,
                                width: 100.w,
                                fit: BoxFit.cover,
                              )
                            : CircleAvatar(
                                backgroundColor: Kwhite,
                                radius: 56.r,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200.r),
                                  child: CachedNetworkImage(
                                    imageUrl: kBaseImageUrl +
                                        apicontroller.profileData["profilePic"],
                                    // authentication
                                    //     .profileData["profile"],
                                    placeholder: (context, url) => SizedBox(
                                      height: 100.h,
                                      width: 100.w,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.black12,
                                        highlightColor:
                                            Colors.white.withOpacity(0.5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Kwhite.withOpacity(0.5),
                                          ),
                                          height: 100.h,
                                          width: 100.w,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        CircleAvatar(
                                      backgroundColor: Kwhite,
                                      radius: 56.r,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(200.r),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        overflow: TextOverflow.ellipsis,
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
                                        overflow: TextOverflow.ellipsis,
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
    );
  }
}
