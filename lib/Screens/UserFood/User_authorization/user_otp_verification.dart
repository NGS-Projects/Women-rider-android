import 'package:womentaxi/untils/export_file.dart';

class UserOtpVerify extends StatefulWidget {
  const UserOtpVerify({super.key});

  @override
  State<UserOtpVerify> createState() => _UserOtpVerifyState();
}

class _UserOtpVerifyState extends State<UserOtpVerify> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Kwhite,
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
              "Verification Code",
              style: GoogleFonts.roboto(
                  fontSize: 28.sp,
                  fontWeight: kFW700,
                  height: 1.2,
                  color: KTextdark),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Please type the verification code Form Mobile No (or) Email Id",
              style: GoogleFonts.roboto(
                  fontSize: kFourteenFont,
                  fontWeight: kFW500,
                  color: KTextgery),
            ),
            SizedBox(
              height: 32.h,
            ),
            Center(
              child: OTPTextField(
                otpFieldStyle: OtpFieldStyle(
                    enabledBorderColor: KTextgery.withOpacity(0.4),
                    focusBorderColor: Kpink),
                length: 4,
                width: double.infinity,
                fieldWidth: 55.w,
                contentPadding: const EdgeInsets.symmetric(vertical: 2),
                margin: EdgeInsets.only(right: 8.w),
                fieldStyle: FieldStyle.box,

                //  fieldStyle: FieldStyle.box,
                outlineBorderRadius: 10,
                style: GoogleFonts.roboto(
                    fontSize: kEighteenFont, fontWeight: kFW500, color: Kpink),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                //  otpFieldStyle: BoxDecoration(borderRadius: 10),
                // fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  // Get.toNamed(kDashboardScreen);
                  // print("Completed: " + pin);
                },
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
            RichText(
              maxLines: 1,
              textAlign: TextAlign.left,
              text: TextSpan(
                text: "I didn’t receive a code! ",
                style: GoogleFonts.roboto(
                    fontSize: kTwelveFont,
                    fontWeight: kFW500,
                    color: KTextdarkgery),
                children: <TextSpan>[
                  TextSpan(
                    text: "Please resend",
                    style: GoogleFonts.roboto(
                        fontSize: kSixteenFont,
                        fontWeight: kFW500,
                        color: Kpink),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
            CustomButton(
                width: double.infinity,
                height: 42.h,
                fontSize: kFourteenFont,
                fontWeight: kFW700,
                textColor: Kwhite,
                borderRadius: BorderRadius.circular(30.r),
                label: "Verify",
                isLoading: false,
                onTap: () async {
                  Get.toNamed(kUserDashboard);
                  //  KOtpVerification
                  //  await Get.toNamed(kOtpVerify);
                }),
          ],
        ),
      ),
    );
  }
}
