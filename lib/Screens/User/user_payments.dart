import 'package:womentaxi/untils/export_file.dart';

class UserPayments extends StatefulWidget {
  const UserPayments({super.key});

  @override
  State<UserPayments> createState() => _UserPaymentsState();
}

class _UserPaymentsState extends State<UserPayments> {
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
          "User Paymnets",
          style: GoogleFonts.roboto(
              fontSize: kEighteenFont, fontWeight: kFW500, color: kcarden),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wallet",
                style: GoogleFonts.roboto(
                    fontSize: kEighteenFont,
                    fontWeight: kFW500,
                    color: kcarden),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.money,
                    color: Kpink.withOpacity(
                      0.5,
                    ),
                    size: 24.sp,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rapido wallet",
                        style: GoogleFonts.roboto(
                            fontSize: kSixteenFont,
                            color: KdarkText,
                            fontWeight: kFW500),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        width: 270.w,
                        child: Text(
                          "Balance : ₹ 40",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              fontSize: kTwelveFont,
                              color: Ktextcolor,
                              fontWeight: kFW500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Divider(),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "UPI",
                style: GoogleFonts.roboto(
                    fontSize: kEighteenFont,
                    fontWeight: kFW500,
                    color: kcarden),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.money,
                        color: Kpink.withOpacity(
                          0.5,
                        ),
                        size: 24.sp,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select App",
                            style: GoogleFonts.roboto(
                                fontSize: kSixteenFont,
                                color: KdarkText,
                                fontWeight: kFW500),
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          SizedBox(
                            width: 270.w,
                            child: Text(
                              "Pay with any UPI app",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  fontSize: kTwelveFont,
                                  color: Ktextcolor,
                                  fontWeight: kFW500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Kpink.withOpacity(
                      0.5,
                    ),
                    size: 24.sp,
                  ),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Divider(),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Others",
                style: GoogleFonts.roboto(
                    fontSize: kEighteenFont,
                    fontWeight: kFW500,
                    color: kcarden),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.money,
                    color: Kpink.withOpacity(
                      0.5,
                    ),
                    size: 24.sp,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cash",
                        style: GoogleFonts.roboto(
                            fontSize: kSixteenFont,
                            color: KdarkText,
                            fontWeight: kFW500),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        width: 270.w,
                        child: Text(
                          "You can pay via  cash or UPI for your ride",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              fontSize: kTwelveFont,
                              color: Ktextcolor,
                              fontWeight: kFW500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
