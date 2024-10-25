// ignore_for_file: camel_case_types

import 'package:readmore/readmore.dart';
import 'package:womentaxi/untils/export_file.dart';

class restaurant_detail extends StatefulWidget {
  const restaurant_detail({
    super.key,
  });

  @override
  State<restaurant_detail> createState() => _restaurant_detailState();
}

class _restaurant_detailState extends State<restaurant_detail> {
  int _selectedIndex = 0;
  int _itemCount = 0;
  var addsonList = [];

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

////////////////////////
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Kbodycolor.withOpacity(1),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Container(
                  height: 220.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(0, 0),
                      colors: [kbrown, kviolet, kliteviolet, klightblue],
                      radius: 1.3,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/lightblue.png",
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Positioned(
                          top: 40.h,
                          left: 15,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                width: 38.w,
                                height: 35.h,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                  left: 2.w,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Kwhite,
                                  boxShadow: [
                                    BoxShadow(
                                      color: KTextdark.withOpacity(0.1),
                                      blurRadius: 18,
                                      offset: const Offset(2, 0),
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
                          )),
                      Positioned(
                        top: 50.h,
                        right: 20,
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: KRed.withOpacity(0.5),
                              size: 22.sp,
                            ),
                            // SizedBox(
                            //   width: 25.w,
                            // ),
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: Image.asset(
                            //     "assets/images/share1.png",
                            //     width: 20.w,
                            //     color: Kwhite,
                            //   ),
                            // ),
                            SizedBox(
                              width: 20.w,
                            ),
                            // const Icon(
                            //   Icons.more_vert,
                            //   color: Ktextcolor,
                            // )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "Kapil Foods",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16.sp,
                                      fontWeight: kFW700,
                                      color: kblack),
                                ),
                                SizedBox(
                                  width: 5.w,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text("3.0",
                                    style: GoogleFonts.roboto(
                                        color: kblack,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w900)),
                                // SizedBox(
                                //   width: 15.w,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(bottom: 0.0),
                                //   child: Icon(
                                //     Icons.star,
                                //     size: 18.sp,
                                //     color: Kgreen,
                                //   ),
                                // ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text("(10)",
                                    style: GoogleFonts.roboto(
                                        color: Ktextcolor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w900)),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(" | ",
                                    style: GoogleFonts.roboto(
                                        color: Ktextcolor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w900)),

                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(" Great Taste ",
                                    style: GoogleFonts.roboto(
                                        color: Ktextcolor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w900)),

                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(" | ",
                                    style: GoogleFonts.roboto(
                                        color: Ktextcolor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w900)),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(" Fabulous ",
                                    style: GoogleFonts.roboto(
                                        color: Ktextcolor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w900))
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     apicontroller
                            //                 .restaurantidData["rating"] !=
                            //             null
                            //         ? Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.start,
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             children: [
                            //               Text(
                            //                 apicontroller
                            //                     .restaurantidData[
                            //                         "rating"]
                            //                     .toString(),
                            //                 style: GoogleFonts.roboto(
                            //                     fontSize: 13.sp,
                            //                     fontWeight: kFW600,
                            //                     color: kblack),
                            //               ),
                            //               const Icon(
                            //                 Icons.star,
                            //                 color: Colors.amber,
                            //                 size: 17,
                            //               ),
                            //               Text(
                            //                 "(25+) | ",
                            //                 style: GoogleFonts.roboto(
                            //                     fontSize: 11.sp,
                            //                     fontWeight: kFW500,
                            //                     color: Ktextcolor),
                            //               ),
                            //             ],
                            //           )
                            //         : const SizedBox(),
                            //     // Text(
                            //     //   " | Mughlai | ",
                            //     //   style: GoogleFonts.roboto(
                            //     //       fontSize: 14.sp,
                            //     //       fontWeight: kFW500,
                            //     //       color: Ktextcolor),
                            //     // ),
                            //     Text(
                            //       apicontroller.restaurantidData[
                            //               "cuisine_type"] ??
                            //           "",
                            //       style: GoogleFonts.roboto(
                            //           fontSize: 14.sp,
                            //           fontWeight: kFW500,
                            //           color: Ktextcolor),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                  left: 15.w,
                                  right: 15.w,
                                  top: 4.h,
                                  bottom: 4.h),
                              margin: EdgeInsets.all(5.r),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Kwhite,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 2.h),
                                        child: Image.asset(
                                          "assets/images/time.png",
                                          scale: 1.2.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "30 mins",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13.sp,
                                            fontWeight: kFW900,
                                            color: Klight),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    "| Free delivery |",
                                    style: GoogleFonts.roboto(
                                        fontSize: 13.sp,
                                        fontWeight: kFW900,
                                        color: Klight),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    "518218",
                                    style: GoogleFonts.roboto(
                                        fontSize: 13.sp,
                                        fontWeight: kFW700,
                                        color: Kpuple),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, menuindex) {
                    return Container(
                        padding: EdgeInsets.all(13.r),
                        margin: EdgeInsets.only(
                            left: 13.r, right: 13.r, bottom: 10.r),
                        decoration: BoxDecoration(
                            color: Kwhite,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 180.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.all(2.r),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            border: Border.all(color: Kgreen)),
                                        child: Icon(
                                          Icons.circle_rounded,
                                          color: Kpink,
                                          size: 12.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      SizedBox(
                                        width: 150.w,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            "hlwa",
                                            maxLines: 2,
                                            style: GoogleFonts.roboto(
                                                fontSize: 16.sp,
                                                fontWeight: kFW700,
                                                color: kblack),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "\u{20B9} 500".toString(),
                                    style: GoogleFonts.roboto(
                                        fontSize: 12.sp,
                                        fontWeight: kFW700,
                                        color: Klight),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "5",
                                        style: GoogleFonts.roboto(
                                            fontSize: 12.sp,
                                            fontWeight: kFW900,
                                            color: kblack),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 15.sp,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "5",
                                        style: GoogleFonts.roboto(
                                            fontSize: 11.sp,
                                            fontWeight: kFW500,
                                            color: Ktextcolor),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Preperation Time :   30".toString(),
                                    style: GoogleFonts.roboto(
                                        fontSize: 12.sp,
                                        fontWeight: kFW700,
                                        color: Ktextcolor),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  ReadMoreText(
                                    "good taste",
                                    trimLines: 2,
                                    colorClickableText: Kgreen,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    style: GoogleFonts.roboto(
                                        fontSize: 12.sp,
                                        fontWeight: kFW600,
                                        color: kblack.withOpacity(0.8)),
                                    moreStyle: GoogleFonts.roboto(
                                        wordSpacing: 0.5,
                                        fontSize: 11.sp,
                                        fontWeight: kFW600,
                                        color: Kgreen),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 110.h,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 130.h,
                                    width: 110.h,
                                    child: Image.asset(
                                      "assets/images/sweet1.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 10.h,
                                      left: 15.w,
                                      child: Container(
                                          height: 28.h,
                                          width: 90.w,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Kwhite,
                                              border: Border.all(
                                                  color: KdarkText.withOpacity(
                                                      0.2)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.r))),
                                          child: Text("No Stock",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.roboto(
                                                  color: KdarkText,
                                                  fontSize: 13.5.sp,
                                                  fontWeight:
                                                      FontWeight.w900)))),
                                  Positioned(
                                    top: 5.h,
                                    right: 15.w,
                                    child: Container(
                                      height: 25.h,
                                      width: 25.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Kwhite,
                                          border: Border.all(
                                              color:
                                                  KdarkText.withOpacity(0.2)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.r))),
                                      child: Icon(
                                        Icons.favorite,
                                        color: KTextgery,
                                        // KTextgery,
                                        size: 15.sp,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ));
                  }),
              SizedBox(
                height: 30.h,
              )
            ])));
  }
}
