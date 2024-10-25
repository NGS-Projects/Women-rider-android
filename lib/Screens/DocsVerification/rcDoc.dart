import 'package:womentaxi/untils/export_file.dart';

// class AdhaarVerify extends StatefulWidget {
//   const AdhaarVerify({super.key});

//   @override
//   State<AdhaarVerify> createState() => _AdhaarVerifyState();
// }

// class _AdhaarVerifyState extends State<AdhaarVerify> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

class rcVerify extends StatefulWidget {
  const rcVerify({super.key});

  @override
  State<rcVerify> createState() => _rcVerifyState();
}

class _rcVerifyState extends State<rcVerify> {
  ApiController apiController = Get.put(ApiController());
  TextEditingController _rcController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 38.w,
                    height: 38.h,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      left: 2.w,
                    ),
                    // height: 47.88,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Kwhite,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(23.94),
                      // ),
                      boxShadow: const [
                        BoxShadow(
                          color: KBoxShadow,
                          blurRadius: 31.23,
                          offset: Offset(15.61, 15.61),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: KTextdark,
                      size: 18.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "RC Verification",
                  style: GoogleFonts.roboto(
                      fontSize: 30.sp,
                      fontWeight: kFW700,
                      height: 1.2,
                      color: kcarden),
                ),
                SizedBox(
                  height: 70.h,
                ),
                Text(
                  "Enter your RC Number to verify your account",
                  style: GoogleFonts.roboto(
                      fontSize: kFourteenFont,
                      fontWeight: kFW500,
                      color: KTextgery),
                ),
                CustomFormField(
                  controller: _rcController,
                  enabled: true,
                  // prefix: Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
                  //   child: Text(
                  //     " +91",
                  //     style: GoogleFonts.roboto(
                  //         fontSize: 14.sp, fontWeight: kFW500, color: kblack),
                  //   ),
                  // ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 16.w),

                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Your Vehicle RC number",
                  maxLines: 1,
                  readOnly: false,
                  label: "",

                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Vehicle RC No';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 180.h,
                ),
                Obx(() => apiController.rcDocLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Kpink,
                        ),
                      )
                    : CustomButton(
                        width: double.infinity,
                        height: 42.h,
                        fontSize: kFourteenFont,
                        fontWeight: kFW700,
                        textColor: Kwhite,
                        borderRadius: BorderRadius.circular(30.r),
                        label: "Send",
                        isLoading: false,
                        onTap: () async {
                          var payload =

                              //     {
                              //   "pan": _panController.text,

                              //   "consent": "Y"

                              // };
                              {"consent": "Y", "reg_no": _rcController.text};
                          apicontroller.rcDoc(payload);
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
