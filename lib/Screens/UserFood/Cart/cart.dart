// ignore_for_file: camel_case_types, prefer_final_fields

import 'package:womentaxi/untils/export_file.dart';

class Cart_screen extends StatefulWidget {
  Cart_screen({super.key});
  // const Cart_screen({
  //   super.key,
  // });

  @override
  State<Cart_screen> createState() => _Cart_screenState();
}

class _Cart_screenState extends State<Cart_screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Kbackground,
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

                        // Positioned(
                        //     top: 30.h,
                        //     left: 10.w,
                        //     child:_pageIndex  == 1 ?
                        //     Text(""):const Custombackbutton()),
                        Positioned(
                            bottom: 10,
                            left: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 2.h),
                                      child: Image.asset(
                                        "assets/images/home_location.png",
                                        width: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: SizedBox(
                                            width: 160.w,
                                            child: Text(
                                              "Add Address",
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                  height: 1.3,
                                                  fontSize: 14.sp,
                                                  fontWeight: kFW900,
                                                  color: Kgreen),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          "30  mins",
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                              fontSize: 12.sp,
                                              fontWeight: kFW700,
                                              color: KTextdark),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          "Delivering Fast",
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                              fontSize: 12.sp,
                                              fontWeight: kFW700,
                                              color: Kpuple),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Image.asset(
                                  "assets/images/mom2.png",
                                  width: 200.w,
                                ),
                              ],
                            ))
                      ],
                    )),
                Container(
                  margin: EdgeInsets.all(13.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Review your order and address details to avoid canncellations",
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                            height: 1.1.h,
                            fontSize: 12.sp,
                            fontWeight: kFW500,
                            color: KBlue),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.only(bottom: 10.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Kwhite),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                                itemCount: 2,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w, bottom: 8.h),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                padding: EdgeInsets.all(2.r),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                    border: Border.all(
                                                      color: Kgreen,
                                                    )),
                                                child: Icon(
                                                  Icons.circle_rounded,
                                                  color: Kgreen,
                                                  size: 12.sp,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 120.w,
                                                child: Text(
                                                  "halwa",
                                                  maxLines: 2,
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.roboto(
                                                      height: 1.5,
                                                      fontSize: 12.sp,
                                                      fontWeight: kFW600,
                                                      color: kblack),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Ktextcolor
                                                            .withOpacity(0.4)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r)),
                                                padding: EdgeInsets.only(
                                                    left: 7.w,
                                                    right: 7.w,
                                                    top: 3.h,
                                                    bottom: 3.h),
                                                child: Row(
                                                  children: <Widget>[
                                                    const Icon(
                                                      Icons.remove,
                                                      color: Kgreen,
                                                    ),
                                                    //     : InkWell(onTap: () {}, child: const Icon(Icons.remove, color: Kgreen)),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(5.r),
                                                      child: Text(
                                                        "4",
                                                        style: const TextStyle(
                                                            color: Kgreen,
                                                            fontWeight: kFW700),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Icon(
                                                      Icons.add,
                                                      color: Kgreen,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "₹ 400",
                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 13.sp,
                                                    fontWeight: kFW700,
                                                    color: kblacktext),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.r),
                                                      border: Border.all(
                                                        color: Kgreen,
                                                      )),
                                                  child: Icon(
                                                    Icons.keyboard_arrow_up,
                                                    color: Colors.amber,
                                                    size: 18,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 130.w,
                                                  child: Text(
                                                    "onions",
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 13.sp,
                                                        fontWeight: kFW600,
                                                        color: kblack),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Ktextcolor
                                                              .withOpacity(
                                                                  0.4)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r)),
                                                  padding: EdgeInsets.only(
                                                      left: 7.w,
                                                      right: 7.w,
                                                      top: 3.h,
                                                      bottom: 3.h),
                                                  child: Row(
                                                    children: <Widget>[
                                                      const Icon(
                                                        Icons.remove,
                                                        color: Kgreen,
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(5.r),
                                                        child: Text(
                                                          "4",
                                                          style:
                                                              const TextStyle(
                                                                  color: Kgreen,
                                                                  fontWeight:
                                                                      kFW700),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      const Icon(
                                                        Icons.add,
                                                        color: Kgreen,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                // SizedBox(
                                                //         width:
                                                //             20.w,
                                                //       ),
                                                Text(
                                                  "\u{20B9} 5",
                                                  maxLines: 1,
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 13.sp,
                                                      fontWeight: kFW700,
                                                      color: KBlue),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ));
                                })
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        height: 45.h,
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Apply Coupon",
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: kFW900,
                                  color: KTextdark),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              size: 20.sp,
                              color: Klightgery,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        height: 45.h,
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
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
                        child: RichText(
                          textScaleFactor: 1,
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: "Applied Copon :  ",
                            style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: kFW900,
                                color: KTextdark),
                            children: <TextSpan>[
                              TextSpan(
                                text: "CPOU10",
                                style: GoogleFonts.roboto(
                                    fontSize: 14.sp,
                                    fontWeight: kFW900,
                                    color: KBlue),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Delivery Instructions",
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              fontSize: 12.sp,
                              fontWeight: kFW900,
                              color: KTextdark),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomFormField(
                        enabled: true,
                        obscureText: false,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        fontSize: kFourteenFont,
                        fontWeight: FontWeight.w500,
                        hintText: "Instructions",
                        maxLines: 1,
                        readOnly: false,
                        hintStyle: GoogleFonts.roboto(
                            color: Ktextcolor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                        label: "Instructions",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Instructions';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    "Bill Details",
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                        fontSize: 12.sp, fontWeight: kFW900, color: KTextdark),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        margin: EdgeInsets.all(10.r),
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.r),
                            color: Kwhite),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  child: Text(
                                    "Price",
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        fontSize: 12.sp,
                                        fontWeight: kFW500,
                                        color: Ktextcolor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  child: Text(
                                    "\u{20B9} 400",
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        fontSize: 13.sp,
                                        fontWeight: kFW700,
                                        color: kblacktext),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  child: Text(
                                    "Discount",
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        fontSize: 12.sp,
                                        fontWeight: kFW500,
                                        color: Ktextcolor),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  child: Text(
                                    // widget
                                    //     .appliedCouponData

                                    // backresulr ?? "no data",
                                    "\u{20B9} 400",
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        fontSize: 13.sp,
                                        fontWeight: kFW700,
                                        color: KBlue),
                                  ),
                                ),
                              ],
                            ),
                            // Text(
                            //   // "result",
                            //   // backresulr ?? "no data",
                            //   //  discountData[""],
                            //   maxLines: 1,
                            //   textAlign: TextAlign.left,
                            //   overflow: TextOverflow.ellipsis,
                            //   style: GoogleFonts.roboto(
                            //       fontSize: 12.sp,
                            //       fontWeight: kFW500,
                            //       color: Ktextcolor),
                            // ),
                            SizedBox(
                              height: 5.h,
                            ),
                            //////////////
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Tax",
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        fontSize: 12.sp,
                                        fontWeight: kFW500,
                                        color: Ktextcolor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "\u{20B9} 400",
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        fontSize: 12.sp,
                                        fontWeight: kFW500,
                                        color: KTextdark),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            const Divider(),
                            SizedBox(
                              height: 5.h,
                            ),
                            ///////////////////
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total",
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        fontSize: 12.sp,
                                        fontWeight: kFW700,
                                        color: Ktextcolor),
                                  ),
                                  Text(
                                    "\u{20B9} 600",
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        fontSize: 13.sp,
                                        fontWeight: kFW700,
                                        color: kblacktext),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),

                            Container(
                              margin: EdgeInsets.all(10.r),
                              child: CustomButton(
                                width: double.infinity,
                                height: 50.h,
                                fontSize: 14.5.sp,
                                fontWeight: kFW700,
                                textColor: Kwhite,
                                borderRadius: BorderRadius.circular(30.r),
                                label: "Proceed to pay \u{20B9} 900",
                                isLoading: false,
                                onTap: () {
                                  Get.toNamed(kUserConfirmOrder);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 80.h,
                            )
                          ],
                        )))
              ]),
        ));
  }

  getAddonsList(List addonsList) {
    var addOnsList = [];
    for (int j = 0; j < addonsList.length; j++) {
      addOnsList.add({
        "addon_item_id": addonsList[j]["addon_item_id"],
        "quantity": addonsList[j]["quantity"]
      });
    }
    return addOnsList;
  }
}

// ignore: must_be_immutable
class ImageWithHeading extends StatelessWidget {
  String image;
  String heading;
  String? subheading;
  ImageWithHeading(
      {super.key, required this.image, required this.heading, this.subheading});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        SizedBox(
          height: 20.h,
        ),
        Image.asset(image),
        SizedBox(
          height: 20.h,
        ),
        Text(
          heading,
          style: GoogleFonts.roboto(
              color: kblack, fontSize: 16.sp, fontWeight: FontWeight.w900),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          height: 20.h,
          width: 300.w,
          alignment: Alignment.center,
          child: Text(
            subheading ?? "",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                color: Klightgery,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 200.h,
        ),
      ]),
    );
  }
}
