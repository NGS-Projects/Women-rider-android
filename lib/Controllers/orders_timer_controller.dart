import 'dart:async';
import 'package:get/get.dart';
import 'package:womentaxi/untils/export_file.dart';

class TimerController extends GetxController {
  ApiController apicontroller = Get.put(ApiController());
  Timer? _timer;
  var isRunning = true.obs;

  @override
  void onInit() {
    super.onInit();
    // startTimer();
  }

  void startTimer() {
    if (_timer?.isActive ?? false) {
      return;
    }
    isRunning.value = true;
    _timer = Timer.periodic(Duration(seconds: 30), (Timer timer) {
      if (isRunning.value) {
        myFunction();
      } else {
        timer.cancel();
      }
    });
  }

  void myFunction() {
    apicontroller.getCurrentLocationTimer();

    // Your function implementation
    print('Function called');
  }

  void stopTimer() {
    isRunning.value = false;
    _timer?.cancel();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
//   Timer? _timer;
//   var isRunning = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     startTimer();
//   }

//   void startTimer() {
//     if (_timer?.isActive ?? false) {
//       return;
//     }
//     isRunning.value = true;
//     _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
//       if (isRunning.value) {
//         myFunction();
//       } else {
//         timer.cancel();
//       }
//     });
//   }

//   void myFunction() {
//     apicontroller.getCurrentLocation();
//     if (apicontroller.orders.isNotEmpty) {
//       Get.toNamed(kAcceptOrders);
//       Fluttertoast.showToast(
//         msg: "Working Periodically",
//       );
//     }
//     // Your function implementation
//     print('Function called');
//   }
//   // void myFunction() {

//   //   print('Function called');
//   // }

//   void stopTimer() {
//     isRunning.value = false;
//     _timer?.cancel();
//   }

//   @override
//   void onClose() {
//     _timer?.cancel();
//     super.onClose();
//   }

  // Timer? _timer;
  // var isRunning = true.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   startTimer();
  // }

  // void startTimer() {
  //   _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
  //     if (isRunning.value) {
  //       myFunction();
  //     }
  //   });
  // }

  // void myFunction() {
  //   apicontroller.getCurrentLocation();
  //   if (apicontroller.orders.isNotEmpty) {
  //     Get.toNamed(kAcceptOrders);
  //     Fluttertoast.showToast(
  //       msg: "Working Periodically",
  //     );
  //   }
  //   // Your function implementation
  //   print('Function called');
  // }

  // void stopTimer() {
  //   isRunning.value = false;
  //   _timer?.cancel();
  // }

  // @override
  // void onClose() {
  //   _timer?.cancel();
  //   super.onClose();
  // }
}
