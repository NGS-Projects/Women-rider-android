import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:womentaxi/untils/export_file.dart';

class HelpDesk extends StatefulWidget {
  const HelpDesk({super.key});

  @override
  State<HelpDesk> createState() => _HelpDeskState();
}

class _HelpDeskState extends State<HelpDesk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Kwhite,
        appBar: AppBar(
          backgroundColor: Kwhite,
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
            "Help Desk",
            style: GoogleFonts.roboto(
                fontSize: kEighteenFont, fontWeight: kFW500, color: kcarden),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hello, How Can we help you?',
                style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  fontWeight: kFW500,
                  color: KdarkText,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                " If You're experiencing issues with the process. We're here to help. Contact us now to resolve the problem. ",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: kTwelveFont,
                  fontWeight: kFW400,
                  color: KText,
                ),
              ),
              SizedBox(
                height: 120.h,
              ),

              // GestureDetector(
              //   onTap: () {
              //     launchUrl(
              //         Uri.parse('https://wa.me/${27}${817789040}?text=Hi '),
              //         // Uri.parse('https://wa.me/${91}${6281682528}?text=Hi '),
              //         mode: LaunchMode.externalApplication);
              //   },
              //   //               onTap: whatsapp() async{
              //   //    var contact = "+880123232333";
              //   //    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
              //   //    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

              //   //    try{
              //   //       if(Platform.isIOS){
              //   //          await launchUrl(Uri.parse(iosUrl));
              //   //       }
              //   //       else{
              //   //          await launchUrl(Uri.parse(androidUrl));
              //   //       }
              //   //    } on Exception{
              //   //      EasyLoading.showError('WhatsApp is not installed.');
              //   //   }
              //   // }
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         "Contact WhatsApp :  ",
              //         style: GoogleFonts.roboto(
              //             fontSize: 13.sp,
              //             fontWeight: kFW500,
              //             color: Klightgray),
              //       ),
              //       Text(
              //         "Message +27 817789040",
              //         style: GoogleFonts.roboto(
              //             // wordSpacing: 2,
              //             fontSize: 13.sp,
              //             fontWeight: kFW500,
              //             color: KdarkText),
              //       ),
              //     ],
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  launchUrl(
                      Uri.parse(
                          'https://wa.me/${91}${9392296850}?text=Hi,I have got problem '),
                      mode: LaunchMode.externalApplication);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(
                      color: Kwhite,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0.5,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                          color: Ktextcolor.withOpacity(0.2),
                        )
                      ],
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Ktextcolor.withOpacity(0.01),
                      //     blurRadius: 5,
                      //     offset: const Offset(0, 0),
                      //     spreadRadius: 2,
                      //   )
                      // ],
                      borderRadius: BorderRadius.circular(10.r)),
                  //margin: EdgeInsets.all(13.r),
                  child: ListTile(
                      title: Text(
                        "Contact WhatsApp",
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: KdarkText,
                        ),
                      ),
                      // subtitle: Text(
                      //   Setting[i]["name"],
                      // ),
                      // subtitle: Text(
                      //   //"Lorem Epson is a Dummy Text",
                      //    Setting_list[i]["Subtext"],
                      //   maxLines: 2,
                      //   textAlign: TextAlign.left,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: GoogleFonts.roboto(
                      //       fontSize: kTenFont,
                      //       fontWeight: kFW500,
                      //       color: Klight),
                      // ),
                      trailing: Image.asset(
                        "assets/images/watsapp.png",
                        // "assets/images/watsapp.png",
                        width: 40.w,
                        fit: BoxFit.fill,
                      )
                      // color: KOrange,
                      // alignment: Alignment.bottomLeft,
                      // fit: BoxFit.fill,
                      // semanticsLabel: 'Acme Logo'
                      ),
                ),
              ),

              // _infoTile('App version', _packageInfo.version),
              SizedBox(
                height: 60.h,
              ),
            ],
          ),
        ));
  }
}
