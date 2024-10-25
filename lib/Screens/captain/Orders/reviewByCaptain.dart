import 'package:womentaxi/untils/export_file.dart';

class CaptainReview extends StatefulWidget {
  const CaptainReview({super.key});

  @override
  State<CaptainReview> createState() => _CaptainReviewState();
}

class _CaptainReviewState extends State<CaptainReview> {
  ApiController apiController = Get.put(ApiController());
  int _rating = 4;
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
          "CaptainReview",
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
            Text(
              "Please give review",
              style: GoogleFonts.roboto(
                  fontSize: kTwentyFont, color: kcarden, fontWeight: kFW600),
            ),
            StarRating(
              rating: _rating,
              onRatingChanged: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
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
                  ////////////////////////////////
                  var payload = {
                    "ratingByCaptain": _rating,
                  };
                  apiController.ratingByCaptain(
                      payload, apiController.acceptOrderData["_id"]);
                  //    userapicontroller.reviewOrder(payload);
                  ///////////////////////////////
                }),
          ],
        ),
      ),
    );
  }
}
