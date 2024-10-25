import 'package:womentaxi/untils/export_file.dart';

class UserRestaurantList extends StatefulWidget {
  const UserRestaurantList({super.key});

  @override
  State<UserRestaurantList> createState() => _UserRestaurantListState();
}

class _UserRestaurantListState extends State<UserRestaurantList> {
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
          "Restaurants",
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
                return InkWell(
                  onTap: () {
                    Get.toNamed(kUserRestaurantDetail);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    margin: EdgeInsets.all(10.r),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(10, 0),
                          color: Ktextcolor.withOpacity(0.2),
                        )
                      ],
                      color: Kwhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 80.w,
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13.r)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(13.r),
                              child: Image.asset(
                                "assets/images/mom2.png",
                                scale: 3,
                              )),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "kapil foods",
                                  style: GoogleFonts.roboto(
                                      fontSize: 14.sp, fontWeight: kFW500),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Image.asset(
                                  "assets/images/correct.png",
                                  width: 15,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Restaurant | ",
                                  style: GoogleFonts.roboto(
                                      fontSize: 11.sp,
                                      fontWeight: kFW500,
                                      color: Ktextcolor),
                                ),
                                Text(
                                  "Close",
                                  style: GoogleFonts.roboto(
                                      fontSize: 11.sp,
                                      fontWeight: kFW600,
                                      color: Kgreen),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Cuisine | ",
                                  style: GoogleFonts.roboto(
                                      fontSize: 11.sp,
                                      fontWeight: kFW500,
                                      color: Ktextcolor),
                                ),
                                Text(
                                  "Chinese",
                                  style: GoogleFonts.roboto(
                                      fontSize: 11.sp,
                                      fontWeight: kFW600,
                                      color: Kgreen),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            SizedBox(
                              width: 150.w,
                              child: Text(
                                "164/c, Addagutta Society - HMT Hills Rd, Addagutta Society, Western Hills, Jal Vayu Vihar, Kukatpally, Hyderabad, Telangana 500085",
                                maxLines: 3,
                                style: GoogleFonts.roboto(
                                    height: 1.1.h,
                                    fontSize: 10.sp,
                                    fontWeight: kFW500,
                                    color: Ktextcolor),
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            SizedBox(
                              width: 150.w,
                              child: Row(children: [
                                Text(
                                  "Delivery Time :",
                                  maxLines: 3,
                                  style: GoogleFonts.roboto(
                                      height: 1.1.h,
                                      fontSize: 10.sp,
                                      fontWeight: kFW900,
                                      color: Ktextcolor),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "30 min",
                                  maxLines: 3,
                                  style: GoogleFonts.roboto(
                                      height: 1.1.h,
                                      fontSize: 10.sp,
                                      fontWeight: kFW500,
                                      color: Ktextcolor),
                                )
                              ]),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
                // Container(
                //   margin: EdgeInsets.only(bottom: 12.h),
                //   width: double.infinity,
                //   padding: EdgeInsets.all(10.r),
                //   decoration: BoxDecoration(
                //     boxShadow: [
                //       BoxShadow(
                //         color: Ktextcolor.withOpacity(0.5),
                //         blurRadius: 5.r,
                //         offset: Offset(1, 1),
                //         spreadRadius: 1.r,
                //       )
                //     ],
                //     color: Kwhite,
                //     borderRadius: BorderRadius.circular(10.r),
                //   ),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: EdgeInsets.only(top: 5.h),
                //         child: CircleAvatar(
                //           backgroundColor: kcarden,
                //           radius: 6.r,
                //         ),
                //       ),
                //       SizedBox(
                //         width: 10.w,
                //       ),
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             "Refer Now and Earn Money",
                //             style: GoogleFonts.roboto(
                //                 fontSize: kSixteenFont,
                //                 color: kcarden,
                //                 fontWeight: kFW500),
                //           ),
                //           SizedBox(
                //             height: 15.h,
                //           ),
                //           SizedBox(
                //             width: 270.w,
                //             child: Text(
                //               "Don't forget to share your referal code to earn Bonus! ",
                //               maxLines: 1,
                //               overflow: TextOverflow.ellipsis,
                //               style: GoogleFonts.roboto(
                //                   fontSize: kTwelveFont,
                //                   color: Ktextcolor,
                //                   fontWeight: kFW500),
                //             ),
                //           ),
                //           SizedBox(
                //             height: 10.h,
                //           ),
                //           Text(
                //             "3 days ago",
                //             style: GoogleFonts.roboto(
                //                 fontSize: kTwelveFont,
                //                 color: KlightText,
                //                 fontWeight: kFW500), // KlightText
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // );
              }),
        ),
      ),
    );
  }
}
