import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:womentaxi/untils/export_file.dart';

class NewAuthenticationImageUpload extends StatefulWidget {
  const NewAuthenticationImageUpload({super.key});

  @override
  State<NewAuthenticationImageUpload> createState() =>
      _NewAuthenticationImageUploadState();
}

class _NewAuthenticationImageUploadState
    extends State<NewAuthenticationImageUpload> {
  ApiController apiController = Get.put(ApiController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apicontroller.getRapidoEmpProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/womenriders.png",
                  height: 80.h,
                  // width: 150.w,
                ),
                Obx(
                  () => apiController.profileData["signUpCompletePercentage"] ==
                          null
                      ? SizedBox()
                      : LinearProgressIndicator(
                          value: apiController
                                  .profileData["signUpCompletePercentage"] /
                              100,
                          backgroundColor: Colors.grey,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.pink),
                        ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Image.asset(
                "assets/images/cut_person.png",

                height: MediaQuery.of(context).size.height / 3,
                // fit: BoxFit.fitHeight,
                // width: 150.w,
              ),
            ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Biometrics",
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
                  "Please upload Face Biometrics ",
                  style: GoogleFonts.roboto(
                      fontSize: 13.sp, fontWeight: kFW400, color: kcarden),
                ),
                SizedBox(
                  height: 15.h,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(kUserUploadDocs);
                  },
                  child: DottedBorder(
                      dashPattern: [8, 2],
                      strokeWidth: 1,
                      color: Kpink,
                      child: Container(
                        height: 100.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: Kwhite,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Upload",
                              style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  color: Kpink,
                                  fontWeight: kFW600),
                            )
                          ],
                        ),
                      )),
                ),
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

                SizedBox(
                  height: 60.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
