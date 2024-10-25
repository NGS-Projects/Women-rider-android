// import 'package:flutter/material.dart';

// import 'package:womentaxi/untils/export_file.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   ApiController apiController = Get.put(ApiController());
//   bool? isUserLoggedIn;
//   @override
//   void initState() {
//     super.initState();

//     isUserLoggedIn = UserSimplePreferences.getLoginStatus();
//     Future.delayed(Duration(seconds: 2), () async {
//       if (isUserLoggedIn != null && isUserLoggedIn == true) {
//         await apiController.getRapidoEmpProfileNvaigation();
//       } else {
//         Get.toNamed(KOnboarding);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Kwhite,
//       body: Container(
//         alignment: Alignment.center,
//         margin: EdgeInsets.all(15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               "assets/images/wor_logos.png",
//               height: 200.h,
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             Text(
//               "Woman Rider",
//               style: GoogleFonts.roboto(
//                   fontSize: kTwentyFont, color: kcarden, fontWeight: kFW600),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:womentaxi/untils/export_file.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ApiController apiController = Get.put(ApiController());
  bool? isUserLoggedIn;

  @override
  void initState() {
    super.initState();

    isUserLoggedIn = UserSimplePreferences.getLoginStatus();
    Future.delayed(Duration(seconds: 2), () async {
      if (isUserLoggedIn == true) {
        try {
          await apiController.getRapidoEmpProfileNvaigation();
        } catch (e) {
          // Handle any errors here (optional)
        }
      } else {
        Get.offNamed(KOnboarding); // Prevent navigating back to splash
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/wor_logos.png",
              height: 200.h, // Ensure you're using a responsive package
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Woman Rider",
              style: GoogleFonts.roboto(
                fontSize: kTwentyFont,
                color: kcarden,
                fontWeight: kFW600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
