import 'package:dotted_border/dotted_border.dart';
import 'package:womentaxi/untils/export_file.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class CollectAmount extends StatefulWidget {
  const CollectAmount({super.key});

  @override
  State<CollectAmount> createState() => _CollectAmountState();
}

class _CollectAmountState extends State<CollectAmount> {
  ApiController apiController = Get.put(ApiController());
  final PaymentController controller = Get.put(PaymentController());
  @override
  void initState() {
    setState(() {
      controller.upiIdController.text = "saiv4004@oksbi";
      controller.nameController.text = "ngs pvt LTD";
      controller.nameController.text = "ngs pvt LTD";
      controller.amountController.text = "200";
      controller.noteController.text = "Thank you";
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          "CollectAmount",
          style: GoogleFonts.roboto(
              fontSize: kEighteenFont, fontWeight: kFW500, color: kcarden),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: controller.generateQrCode,
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
                          "Generate OR code",
                          style: GoogleFonts.roboto(
                              fontSize: 12.sp,
                              color: Kpink,
                              fontWeight: kFW600),
                        )
                      ],
                    ),
                  )),
            ),
            // ElevatedButton(
            //   onPressed: controller.generateQrCode,
            //   child: Text("Generate QR Code"),
            // ),
            SizedBox(height: 20),
            Obx(
              () => controller.upiDetails.value != null
                  ? UPIPaymentQRCode(
                      upiDetails: controller.upiDetails.value!,
                      size: 200,
                      embeddedImagePath: "assets/images/location.png",
                      embeddedImageSize: const Size(20, 20),
                    )
                  : Container(),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Or",
              style: GoogleFonts.roboto(
                  fontSize: kTwentyFont, color: kcarden, fontWeight: kFW600),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Please Collect Cash 450",
              style: GoogleFonts.roboto(
                  fontSize: kTwentyFont, color: kcarden, fontWeight: kFW600),
            ),
            CustomButton(
                margin: EdgeInsets.only(top: 80.h),
                width: double.infinity,
                height: 42.h,
                fontSize: kFourteenFont,
                fontWeight: kFW700,
                textColor: Kwhite,
                borderRadius: BorderRadius.circular(30.r),
                label: "Collected Cash",
                isLoading: false,
                onTap: () {
                  Get.toNamed(kCaptainReviews);
                  // apiController
                  //     .completeOrder(apiController.acceptOrderData["_id"]);
                }),
          ],
        ),
      ),
    );
  }
}
