import 'package:womentaxi/untils/export_file.dart';
import 'dart:async';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  TimerController timercontroller = Get.put(TimerController());
  ApiController apiController = Get.put(ApiController());
  /////////////////////////////////////////////////////////////////////////
  int _seconds = 20;
  Timer? _timer;
  // @override
  // void initState() {
  //   super.initState();
  //   startTimer();
  // }

  void startTimer(String itemId) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer?.cancel();
        onTimerComplete(itemId);
      }
    });
  }

  void onTimerComplete(String itemId) {
    // apiController.declineOrder(itemId); // vvip code
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  //////////////////////////////////////////////////////
  @override
  void initState() {
    apiController.getCurrentLocation();

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
          "Orders List",
          style: GoogleFonts.roboto(
              fontSize: kEighteenFont, fontWeight: kFW500, color: kcarden),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(15.w),
            child: Obx(
              () => apiController.ordersLoadings == true
                  ? Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 100.h),
                      child: CircularProgressIndicator(
                        color: Kpink,
                      ),
                    )
                  : apiController.orders.isEmpty || apiController.orders == null
                      ? NoOrdersWidget()
                      //  Text(
                      //     "No Orders",
                      //     style: GoogleFonts.roboto(
                      //         fontSize: kSixteenFont,
                      //         color: KdarkText,
                      //         fontWeight: kFW500),
                      //   )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: apiController.orders.length,
                          itemBuilder: (context, index) {
                            startTimer(apiController.orders[index]["_id"]);
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
                                    children: [
                                      CircleAvatar(
                                          radius: 18.r,
                                          backgroundColor:
                                              Ktextcolor.withOpacity(0.5),
                                          child:
                                              Icon(Icons.pedal_bike_outlined)),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        apiController.orders[index]
                                            ["vehicleType"],
                                        style: GoogleFonts.roboto(
                                            fontSize: kFourteenFont,
                                            color: kcarden,
                                            fontWeight: kFW500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: greenColor,
                                        radius: 5.r,
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Pick",
                                            style: GoogleFonts.roboto(
                                                fontSize: kFourteenFont,
                                                color: kcarden,
                                                fontWeight: kFW500),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          SizedBox(
                                            width: 220.w,
                                            child: Text(
                                              apiController.orders[index]
                                                      ["pickupAddress"] ??
                                                  "NA",

                                              //   "325, High Tension Line Rd, Srinivas Colony, Aditya Nagar, Kukatpally, Hyderabad, Telangana 500072",
                                              maxLines: 2,
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
                                    height: 10.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Kpink,
                                        radius: 5.r,
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Drop Point",
                                            style: GoogleFonts.roboto(
                                                fontSize: kFourteenFont,
                                                color: kcarden,
                                                fontWeight: kFW500),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          SizedBox(
                                            width: 220.w,
                                            child: Text(
                                              apiController.orders[index]
                                                      ["dropAddress"] ??
                                                  "NA",

                                              //  "Suryey no 305 Opp Tulsi vanam Ladies Hostel Paradise Lane, South india Shopping mall, beside Lane, Kukatpally Housing Board Colony, Kukatpally, Hyderabad, Telangana 500072",
                                              maxLines: 2,
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
                                    height: 15.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Pick Up",
                                            style: GoogleFonts.roboto(
                                                fontSize: kFourteenFont,
                                                color: Ktextcolor,
                                                fontWeight: kFW500),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          SizedBox(
                                            width: 40.w,
                                            child: Text(
                                              "${apiController.orders[index]["pickUpdistance"]}" ??
                                                  "0",
                                              //    "0.4 km",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 13.sp,
                                                  color: kcarden,
                                                  fontWeight: kFW500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 25.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Drop",
                                            style: GoogleFonts.roboto(
                                                fontSize: kFourteenFont,
                                                color: Ktextcolor,
                                                fontWeight: kFW500),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          SizedBox(
                                            width: 40.w,
                                            child: Text(
                                              "${apiController.orders[index]["dropdistance"]}" ??
                                                  "0",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 13.sp,
                                                  color: kcarden,
                                                  fontWeight: kFW500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 25.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Men Count",
                                            style: GoogleFonts.roboto(
                                                fontSize: kFourteenFont,
                                                color: Ktextcolor,
                                                fontWeight: kFW500),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          SizedBox(
                                            width: 40.w,
                                            child: Text(
                                              "${apiController.orders[index]["howManyMans"]}" ??
                                                  "0",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 13.sp,
                                                  color: kcarden,
                                                  fontWeight: kFW500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              height: 50.h,
                                              width: 50.w,
                                              child: ClockWidget(
                                                  seconds: _seconds)),
                                          GestureDetector(
                                            onTap: () {
                                              apiController.declineOrder(
                                                  apiController.orders[index]
                                                      ["_id"]);
                                            },
                                            child: Container(
                                              //padding: Padding,
                                              height: 42.h,
                                              width: 100.w,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.r),
                                                  border: Border.all(
                                                      color: Kpink, width: 1)),
                                              child: Text(
                                                "Decline",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.roboto(
                                                    fontSize: kFourteenFont,
                                                    color: Kpink,
                                                    fontWeight: kFW700),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      CustomButton(
                                          width: 100.w,
                                          height: 42.h,
                                          fontSize: kFourteenFont,
                                          fontWeight: kFW700,
                                          textColor: Kwhite,
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          label: "Accept",
                                          isLoading: false,
                                          onTap: () async {
                                            apiController.acceptOrder(
                                                apiController.orders[index]
                                                    ["_id"]);
                                            // var payload = {"receiverId": "66912b20cd8503daed4fd667"};
                                            // apicontroller.socketioCreateChat(payload);
                                            // Get.toNamed(kArrivedScreen);
                                            //  KOtpVerification
                                            //  await Get.toNamed(kOtpVerify);
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
            )),
      ),
    );
  }
}

class ClockWidget extends StatelessWidget {
  final int seconds;

  ClockWidget({required this.seconds});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 60.w,
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Kpink, width: 1),
      ),
      child: Center(
        child: Text(
          '$seconds',
          style: GoogleFonts.roboto(fontSize: kSixteenFont, fontWeight: kFW500),
        ),
      ),
    );
  }
}
