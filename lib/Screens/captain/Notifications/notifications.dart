import 'package:womentaxi/untils/export_file.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
          "Notifications",
          style: GoogleFonts.roboto(
              fontSize: kEighteenFont, fontWeight: kFW500, color: kcarden),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15.w),
          child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  width: double.infinity,
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Ktextcolor.withOpacity(0.5),
                        blurRadius: 5.r,
                        offset: Offset(1, 1),
                        spreadRadius: 1.r,
                      )
                    ],
                    color: Kwhite,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Refer Now and Earn Money",
                            style: GoogleFonts.roboto(
                                fontSize: kSixteenFont,
                                color: kcarden,
                                fontWeight: kFW500),
                          ),
                          Icon(
                            Icons.delete_rounded,
                            color: Kpink.withOpacity(
                              0.5,
                            ),
                            size: 18.sp,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Don't forget to share your referal code to earn Bonus! ",
                        style: GoogleFonts.roboto(
                            fontSize: kTwelveFont,
                            color: Ktextcolor,
                            fontWeight: kFW500),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "3 days ago",
                        style: GoogleFonts.roboto(
                            fontSize: kTwelveFont,
                            color: KlightText,
                            fontWeight: kFW500), // KlightText
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
