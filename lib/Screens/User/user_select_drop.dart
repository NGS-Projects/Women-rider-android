import 'package:womentaxi/untils/export_file.dart';

class UserSelectDrop extends StatefulWidget {
  const UserSelectDrop({super.key});

  @override
  State<UserSelectDrop> createState() => _UserSelectDropState();
}

class _UserSelectDropState extends State<UserSelectDrop> {
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
          "Drops",
          style: GoogleFonts.roboto(
              fontSize: kEighteenFont, fontWeight: kFW500, color: kcarden),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15.w),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 12.h),
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
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 7.h),
                            child: CircleAvatar(
                              backgroundColor: greenColor,
                              radius: 5.r,
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          SizedBox(
                            height: 20.h,
                            width: 200.w,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Your Current Location',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 7.h),
                            child: CircleAvatar(
                              backgroundColor: Kpink,
                              radius: 5.r,
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          SizedBox(
                            height: 20.h,
                            width: 200.w,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Drop Location',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  // Text(
                  //   "KPHB",
                  //   style: GoogleFonts.roboto(
                  //       fontSize: kSixteenFont,
                  //       color: kcarden,
                  //       fontWeight: kFW500),
                  // ),
                  ),
              SizedBox(
                height: 20.h,
              ),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(kUserBookRide);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 12.h),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_searching,
                              color: Kpink.withOpacity(
                                0.5,
                              ),
                              size: 18.sp,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "KPHB",
                                  style: GoogleFonts.roboto(
                                      fontSize: kSixteenFont,
                                      color: kcarden,
                                      fontWeight: kFW500),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SizedBox(
                                  width: 200.w,
                                  child: Text(
                                    "Survey No. 1050, Balanagar Mandal, Rd Number 3, Kukatpally Housing Board Colony, Kukatpally, Hyderabad, Telangana 500072",
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
                            Icon(
                              Icons.favorite_outline,
                              color: Kpink.withOpacity(
                                0.5,
                              ),
                              size: 18.sp,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
