import 'package:womentaxi/untils/export_file.dart';

class ParcelScreen extends StatefulWidget {
  const ParcelScreen({super.key});

  @override
  State<ParcelScreen> createState() => _ParcelScreenState();
}

class _ParcelScreenState extends State<ParcelScreen> {
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
          "Parcel",
          style: GoogleFonts.roboto(
              fontSize: 22.sp, color: kcarden, fontWeight: kFW600),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/parcel_image.png",
              height: 200.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "What do you wish to do today?",
              style: GoogleFonts.roboto(
                  fontSize: 20.sp, color: kcarden, fontWeight: kFW600),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "You can send and receive packges with our parcel services",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontSize: kSixteenFont, color: KdarkText, fontWeight: kFW400),
            ),
            CustomButton(
                margin: EdgeInsets.only(top: 40.h),
                width: double.infinity,
                height: 42.h,
                fontSize: kFourteenFont,
                fontWeight: kFW700,
                textColor: Kwhite,
                borderRadius: BorderRadius.circular(30.r),
                label: "Send parcel",
                isLoading: false,
                onTap: () async {
                  Get.toNamed(kUserParcelAddress);
                }),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(kUserParcelAddress);
              },
              child: Container(
                width: double.infinity,
                height: 42.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(color: KdarkText, width: 1)),
                child: Text(
                  "Receive Parcel",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: kFourteenFont,
                      color: KdarkText,
                      fontWeight: kFW700),
                ),
              ),
            )
            // Custom_OutlineButton(
            //     label: "Receive Parcel", isLoading: false, onTap: () async {})
          ],
        ),
      ),
    );
  }
}
