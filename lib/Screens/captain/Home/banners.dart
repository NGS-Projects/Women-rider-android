import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:precached_network_image/precached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:womentaxi/untils/export_file.dart';

// Banners
class Banners extends StatefulWidget {
  const Banners({super.key});

  @override
  State<Banners> createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  int activeIndex = 0;
  final carouselcontroller = CarouselController();
  ApiController apiController = Get.put(ApiController());
  @override
  void initState() {
    // setState(() {
    //   _switchValue = apiController.profileData["isAvailable"];
    // });
    // setState(() {
    //   _switchValue = apiController.storedloginsData["isAvailable"];
    // });
    // apiController.storedloginsData = jsonDecode(UserSimplePreferences.getUserdata().toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => apiController.bannerDatadataLoading == true
        ? Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 100.h),
            child: CircularProgressIndicator(
              color: Kpink,
            ),
          )
        : apiController.bannersData.isEmpty || apiController.bannersData == null
            ? SizedBox()
            : Stack(
                children: [
                  CarouselSlider.builder(
                    carouselController: carouselcontroller,
                    itemCount: apiController.bannersData.length,
                    itemBuilder: (context, index, realIndex) {
                      return InkWell(
                        onTap: _launchURL,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            width: double.infinity,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: Obx(
                                  () => PrecachedNetworkImage(
                                    url: kBaseImageUrl +
                                        apiController.bannersData[index]
                                            ["bannerImage"],

                                    height: 140.h,
                                    width: 280.w,
                                    precache:
                                        true, // default is false, true for next time loading from memory in advance.
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => SizedBox(
                                      height: 80.h,
                                      width: 50.w,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.black12,
                                        highlightColor:
                                            Colors.white.withOpacity(0.5),
                                        child: Container(
                                          height: 80.h,
                                          color: Kwhite.withOpacity(0.5),
                                        ),
                                      ),
                                    ),

                                    // placeholder: (context, url) => const Icon(Icons.person),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                      height: 80.h,
                                      width: 50.w,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.black12,
                                        highlightColor:
                                            Colors.white.withOpacity(0.5),
                                        child: Container(
                                          height: 80.h,
                                          color: Kwhite.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                // Image.asset(
                                //   "assets/images/blood_banner.jpg",
                                //   fit: BoxFit.cover,
                                // )
                                )),
                      );
                    },
                    options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 1,
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index)),
                  ),
                  Positioned(bottom: 10, left: 100.w, child: buildIndicator()),
                ],
              ));
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(
            dotWidth: 6,
            dotColor: Kpink.withOpacity(0.8),
            dotHeight: 6,
            activeDotColor: Kpink),
        activeIndex: activeIndex,
        count: apiController.bannersData.length,
      );

  void animateToSlide(int index) => carouselcontroller.animateToPage(index);

  _launchURL() async {
    final Uri url = Uri.parse('https://www.nuhvin.com/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}


// class Banners extends StatefulWidget {
//   const Banners({super.key});

//   @override
//   State<Banners> createState() => _BannersState();
// }

// class _BannersState extends State<Banners> {
//   int activeIndex = 0;
//   final carouselcontroller = CarouselController();
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         CarouselSlider.builder(
//           carouselController: carouselcontroller,
//           itemCount: 10,
//           itemBuilder: (context, index, realIndex) {
//             return InkWell(
//               onTap: _launchURL,
//               child: Container(
//                   margin: EdgeInsets.only(left: 15.w, right: 15.w),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15.r),
//                   ),
//                   width: double.infinity,
//                   child: ClipRRect(
//                       borderRadius: BorderRadius.circular(15.r),
//                       child: Image.asset(
//                         "assets/images/taxiBanner.jpg",
//                         fit: BoxFit.cover,
//                       ))),
//             );
//           },
//           options: CarouselOptions(
//               enlargeCenterPage: true,
//               autoPlay: true,
//               aspectRatio: 16 / 9,
//               autoPlayCurve: Curves.fastOutSlowIn,
//               enableInfiniteScroll: true,
//               autoPlayAnimationDuration: const Duration(milliseconds: 800),
//               viewportFraction: 1,
//               onPageChanged: (index, reason) =>
//                   setState(() => activeIndex = index)),
//         ),
//         Positioned(bottom: 10, left: 100.w, child: buildIndicator()),
//       ],
//     );
//   }

//   Widget buildIndicator() => AnimatedSmoothIndicator(
//         onDotClicked: animateToSlide,
//         effect: ExpandingDotsEffect(
//             dotWidth: 6,
//             dotColor: Kpink.withOpacity(0.8),
//             dotHeight: 6,
//             activeDotColor: Kpink),
//         activeIndex: activeIndex,
//         count: 10,
//       );

//   void animateToSlide(int index) => carouselcontroller.animateToPage(index);

//   _launchURL() async {
//     final Uri url = Uri.parse('https://www.nuhvin.com/');
//     if (!await launchUrl(url)) {
//       throw Exception('Could not launch $url');
//     }
//   }
// }
