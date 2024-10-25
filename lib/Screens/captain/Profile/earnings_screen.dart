import 'package:womentaxi/untils/export_file.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Kpink,
            unselectedLabelStyle: GoogleFonts.roboto(
              fontSize: kFourteenFont,
              fontWeight: kFW500,
              color: kblack,
              letterSpacing: 0.5,
            ),
            unselectedLabelColor: KdarkText,
            labelColor: Kpink,
            labelStyle: GoogleFonts.roboto(
              fontSize: kSixteenFont,
              fontWeight: kFW500,
              color: Kpink.withOpacity(0.5),
              letterSpacing: 0.5,
            ),
            tabs: [
              Tab(text: "Today"),
              Tab(text: "Wallet"),
            ],
          ), // TabBar
          title: Text(
            "Earnings",
            style: GoogleFonts.roboto(
                fontSize: kTwentyFont, color: kcarden, fontWeight: kFW500),
          ),
          backgroundColor: Kwhite,
        ),

        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(15.w),
                child: Column(
                  children: [
                    Container(
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
                        children: [
                          Text(
                            "₹ 0.0",
                            style: GoogleFonts.roboto(
                                fontSize: 20.sp,
                                fontWeight: kFW500,
                                color: greenColor),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Today's Earnings ->",
                            style: GoogleFonts.roboto(
                                fontSize: kSixteenFont,
                                fontWeight: kFW400,
                                color: kcarden),
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          Divider(),
                          SizedBox(
                            height: 7.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cash Collected",
                                style: GoogleFonts.roboto(
                                    fontSize: kFourteenFont,
                                    fontWeight: kFW400,
                                    color: Ktextcolor),
                              ),
                              Text(
                                "₹ 0.0",
                                style: GoogleFonts.roboto(
                                    fontSize: kFourteenFont,
                                    fontWeight: kFW500,
                                    color: kcarden),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(15.w),
                child: Column(
                  children: [
                    Container(
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
                        children: [
                          Text(
                            "₹ 0.0",
                            style: GoogleFonts.roboto(
                                fontSize: 20.sp,
                                fontWeight: kFW500,
                                color: Kpink),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Your Wallet Balance",
                            style: GoogleFonts.roboto(
                                fontSize: kSixteenFont,
                                fontWeight: kFW400,
                                color: Kpink),
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/bank.png",
                                    // height: 150.h,
                                    height: 28.h,
                                    // width: 100.w,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "Money Transfer",
                                    style: GoogleFonts.roboto(
                                        fontSize: kFourteenFont,
                                        fontWeight: kFW400,
                                        color: Ktextcolor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50.h,
                                child: VerticalDivider(
                                  color: Ktextcolor,
                                ),
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/tranfer.png",
                                    // height: 150.h,
                                    height: 28.h,
                                    // width: 100.w,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "Transfer Left : 1",
                                    style: GoogleFonts.roboto(
                                        fontSize: kFourteenFont,
                                        fontWeight: kFW400,
                                        color: Ktextcolor),
                                  ),
                                ],
                              ),
                              // Text(
                              //   "Transfer Left : 1",
                              //   style: GoogleFonts.roboto(
                              //       fontSize: kFourteenFont,
                              //       fontWeight: kFW500,
                              //       color: kcarden),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Transactions History",
                          style: GoogleFonts.roboto(
                            fontSize: kTwentyFont,
                            fontWeight: kFW500,
                            color: KdarkText,
                          ),
                        )),
                    SizedBox(
                      height: 8.h,
                    ),
                    ListView.builder(
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/bank.png",
                                  height: 28.h,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 270.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Money Transfer Credited",
                                            style: GoogleFonts.roboto(
                                                fontSize: kFourteenFont,
                                                fontWeight: kFW400,
                                                color: kcarden),
                                          ),
                                          Text(
                                            "-₹ 789",
                                            style: GoogleFonts.roboto(
                                                fontSize: kFourteenFont,
                                                fontWeight: kFW400,
                                                color: kcarden),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    SizedBox(
                                      width: 270.w,
                                      child: Text(
                                        "Transfer ID : 87897248jjbwjhfbejrjk bkbcsdlb",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                            fontSize: kFourteenFont,
                                            fontWeight: kFW400,
                                            color: Ktextcolor),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    SizedBox(
                                      width: 270.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "01 : 47 PM",
                                            style: GoogleFonts.roboto(
                                                fontSize: kFourteenFont,
                                                fontWeight: kFW400,
                                                color: Ktextcolor),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            color: kcarden,
                                            size: 28.sp,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            )
          ],
        ), // TabBarView
      ),
    );
  }
}
