// ignore_for_file: camel_case_types

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:womentaxi/untils/export_file.dart';

class My_orders extends StatefulWidget {
  const My_orders({super.key});

  @override
  State<My_orders> createState() => _My_ordersState();
}

class _My_ordersState extends State<My_orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Kbackground,
        appBar: AppBar(
          backgroundColor: Kwhite,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Klightgery,
              size: 15.sp,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          elevation: 0,
          title: Text("Order History",
              style: GoogleFonts.roboto(
                  color: kblack, fontSize: 12.sp, fontWeight: FontWeight.w900)),
        ),
        body: SingleChildScrollView(
          child: ListView.builder(
              reverse: true,
              itemCount: 4,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      EdgeInsets.only(left: 13.r, right: 13.r, bottom: 13.r),
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r), color: Kwhite),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              )
                              //  Image.asset(
                              //   "assets/images/sweet1.png",
                              //   fit: BoxFit.fill,
                              //   width: 80.w,
                              //   height: 80.w,
                              // )
                              ),
                        ),
                        SizedBox(
                          width: 10.w,
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
                                  "Kapil foods".capitalizeFirst!,
                                  style: GoogleFonts.roboto(
                                      fontSize: 12.sp, fontWeight: kFW900),
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
                              height: 8.h,
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
                                      fontWeight: kFW900,
                                      color: Kgreen),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "View Menu",
                              style: GoogleFonts.roboto(
                                  fontSize: 11.sp,
                                  fontWeight: kFW500,
                                  color: KBlue),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 18.h,
                                  width: 18.h,
                                  padding: EdgeInsets.all(2.r),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      border: Border.all(
                                        color: Kgreen,
                                      )),
                                  child: Icon(
                                    Icons.circle_rounded,
                                    color: Kpink,
                                    size: 12.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.r,
                                ),
                                Text(
                                  "Jalebi".capitalizeFirst!,
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: 13.sp,
                                      fontWeight: kFW800,
                                      color: Ktextcolor),
                                ),
                              ]),
                          Text(
                            "\u{20B9} 300",
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: kFW700,
                                color: KBlue.withOpacity(0.6)),
                          ),
                        ]),
                    SizedBox(
                      height: 7.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount",
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              fontSize: 12.sp,
                              fontWeight: kFW700,
                              color: kblack),
                        ),
                        Text(
                          "\u{20B9} 1000",
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              fontSize: 13.sp,
                              fontWeight: kFW700,
                              color: KBlue),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    const Divider(),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "14/06/2024",
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              fontSize: 11.sp,
                              fontWeight: kFW600,
                              color: Ktextcolor),
                        ),
                        Text(
                          "Delivered",
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              fontSize: 11.sp,
                              fontWeight: kFW700,
                              color: Kgreen),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ]),
                );
              }),
        ));
  }
}
