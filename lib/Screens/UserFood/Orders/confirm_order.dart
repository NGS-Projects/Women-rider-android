// ignore_for_file: camel_case_types

import 'package:womentaxi/untils/export_file.dart';

class Confirm_order extends StatefulWidget {
  const Confirm_order({super.key});

  @override
  State<Confirm_order> createState() => _Confirm_orderState();
}

class _Confirm_orderState extends State<Confirm_order> {
  // final PageController _pageController = PageController(initialPage: 0);
  // int _activePage = 0;
  // int selectedIndex = -1;
  //////////////////////////////////////
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  int selectedIndex = -1;
  /////////////////
  late List<bool> _isChecked;

  // @override
  // void initState() {
  //   super.initState();
  //   _isChecked = List<bool>.filled(_texts.length, false);
  // }
//  void CheckboxTheme() {
//    _isChecked = List<bool>.filled(_texts.length, false);
//   }
//   void printSelectedBoxes() {
//     for (int i = 0; i < _texts.length; i++) {
//       if (_isChecked[i]) {
//         print("Selected: ${_texts[i]}");
//       }
//     }
//   }
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  List<bool> checked = [];
  List selectedItems = [];

  //////////////////////////////////
  @override
  void initState() {
    // showModalBottomSheet<dynamic>(
    //     enableDrag: true,
    //     elevation: 0,
    //     isScrollControlled: true,
    //     context: context,
    //     builder: (BuildContext context) {
    //       return Survey();
    //     });
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 2), () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/order_done.json'),
            Text(
              "order placed successfully",
              style: GoogleFonts.roboto(
                  fontSize: 16.sp, fontWeight: kFW700, color: KdarkText),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Chef is getting your order ready stay tuned.",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(fontSize: 12.sp, color: KdarkText),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
                Color: Kgreen,
                textColor: Kwhite,
                height: 40.h,
                width: 250.w,
                fontSize: kFourteenFont,
                borderRadius: BorderRadius.circular(15.r),
                label: "Home",
                isLoading: false,
                onTap: () {
                  //  Get.toNamed(kTakeSurvey);
                  // showModalBottomSheet<dynamic>(
                  //     enableDrag: true,
                  //     elevation: 0,
                  //     isScrollControlled: true,
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return Survey();
                  //     });
                  Get.toNamed(kUserDashboard);
                }),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
