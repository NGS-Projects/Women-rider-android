import 'dart:convert';
import 'dart:io';
import 'package:womentaxi/untils/export_file.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m7_livelyness_detection/m7_livelyness_detection.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

class UserBookRideAuth extends StatefulWidget {
  const UserBookRideAuth({Key? key}) : super(key: key);

  @override
  State<UserBookRideAuth> createState() => _UserBookRideAuthState();
}

class _UserBookRideAuthState extends State<UserBookRideAuth> {
  ApiController apicontroller = Get.put(ApiController());
  /////////////////
  UserApiController userapicontroller = Get.put(UserApiController());
  ///////////////
  String? _capturedImagePath;
  bool _startWithInfo = true;
  bool _allowAfterTimeOut = false;
  final List<M7LivelynessStepItem> _verificationSteps = [];
  int _timeOutDuration = 15;
  bool _switchValue = false;
  ////////////////////Face matching
  Future<String?> imageToBase64() async {
    try {
      // Fetch the image from the URL
      final response = await http.get(Uri.parse(
          kBaseImageUrl + apicontroller.profileData["authenticationImage"]));

      if (response.statusCode == 200) {
        // Convert image bytes to base64
        final bytes = response.bodyBytes;
        final base64String = base64Encode(bytes);
        setState(() {
          userapicontroller.urlbaseImage.value = base64String;
        });
        print(userapicontroller.urlbaseImage);
        var payload = {
          "image1B64": "base64 ${userapicontroller.urlbaseImage.value}",
          "image2B64": "base64 ${userapicontroller.filebaseImage.value}"
        };
        //  {"pan": "", "consent": "Y"};

        // apicontroller.captainFaceMatching(payload);
        // return base64String;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<String?> fileToBase64(String filePath) async {
    try {
      // Read the file as bytes
      final bytes = File(filePath).readAsBytesSync();

      // Convert the bytes to base64 string
      final base64String = base64Encode(bytes);
      setState(() {
        userapicontroller.filebaseImage.value = base64String;
      });
      print(userapicontroller.filebaseImage);
      imageToBase64();
      // return base64String;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  // var payload = {
  //                   "image1B64":
  //                       "base64 ${userapicontroller.urlbaseImage.value}",
  //                   "image2B64":
  //                       "base64 ${userapicontroller.filebaseImage.value}"
  //                   // "getNumberOfFaces": false,
  //                   // "clientData": {"caseId": "123456"}
  //                 };
  //                 //  {"pan": "", "consent": "Y"};

  //                 apicontroller.captainFaceMatching(payload);
  /////////////////////

  @override
  void initState() {
    setState(() {
      userapicontroller.bioMetricImage.value = "No Image";
    });
    _initValues();
    super.initState();
  }

  void _initValues() {
    _verificationSteps.addAll([
      // M7LivelynessStepItem(
      //   step: M7LivelynessStep.smile,
      //   title: "Smile",
      //   isCompleted: false,
      // ),
      M7LivelynessStepItem(
        step: M7LivelynessStep.blink,
        title: "Blink",
        isCompleted: false,
      ),
    ]);

    M7LivelynessDetection.instance.configure(
      thresholds: [
        M7SmileDetectionThreshold(
          probability: 0.8,
        ),
        M7BlinkDetectionThreshold(
          leftEyeProbability: 0.25,
          rightEyeProbability: 0.25,
        ),
      ],
    );
  }

  // void _onStartLivelyness() async {
  //   setState(() {
  //     _capturedImagePath = null;
  //   });

  //   final dynamic response =
  //       await M7LivelynessDetection.instance.detectLivelyness(
  //     context,
  //     config: M7DetectionConfig(
  //       steps: _verificationSteps,
  //       startWithInfoScreen: _startWithInfo,
  //       maxSecToDetect: _timeOutDuration == 100 ? 2500 : _timeOutDuration,
  //       allowAfterMaxSec: _allowAfterTimeOut,
  //       captureButtonColor: Kpink,
  //     ),
  //   );

  //   if (response is String) {
  //     setState(() {
  //       _capturedImagePath = response;
  //     });
  //   } else if (response is M7CapturedImage) {
  //     setState(() {
  //       _capturedImagePath = response.imgPath;
  //       userapicontroller.bioMetricImage.value = _capturedImagePath!;
  //       print(userapicontroller.bioMetricImage.value);
  //       // apicontroller.captainAvailability();

  //       // setState(() {
  //       //   _switchValue = apicontroller.switchedValueOrg.value;
  //       //   apicontroller.switchedValue.value = _switchValue;
  //       //   // _switchValue = apicontroller.switchedValue;
  //       //   apicontroller.duty == "ON DUTY"
  //       //       ? apicontroller.duty.value = "OFF DUTY"
  //       //       : apicontroller.duty.value = "ON DUTY";
  //       // });
  //       Get.back();
  //     });
  //   } else {
  //     // Handle unexpected response type or null case
  //     print('Unexpected response type: ${response.runtimeType}');
  //   }
  // }

  File? imageFile;
  void _onStartLivelyness() async {
    setState(() {
      _capturedImagePath = null;
    });

    final dynamic response =
        await M7LivelynessDetection.instance.detectLivelyness(
      context,
      config: M7DetectionConfig(
        steps: _verificationSteps,
        startWithInfoScreen: _startWithInfo,
        maxSecToDetect: _timeOutDuration == 100 ? 2500 : _timeOutDuration,
        allowAfterMaxSec: _allowAfterTimeOut,
        captureButtonColor: Kpink,
      ),
    );

    if (response is String) {
      setState(() {
        _capturedImagePath = response;
      });
    } else if (response is M7CapturedImage) {
      setState(() {
        _capturedImagePath = response.imgPath;
        userapicontroller.bioMetricImage.value = _capturedImagePath!;

// Assuming _capturedImagePath is not null, you can create a File object like this:

        if (_capturedImagePath != null) {
          imageFile = File(_capturedImagePath!);
        }

        print(userapicontroller.bioMetricImage.value);

        // apicontroller.captainAvailability();

        // setState(() {
        //   _switchValue = apicontroller.switchedValueOrg.value;
        //   apicontroller.switchedValue.value = _switchValue;
        //   // _switchValue = apicontroller.switchedValue;
        //   apicontroller.duty == "ON DUTY"
        //       ? apicontroller.duty.value = "OFF DUTY"
        //       : apicontroller.duty.value = "ON DUTY";
        // });
        //  Get.back();
      });
      // fileToBase64(_capturedImagePath!); // face matching
      apicontroller.convertFromFiletoUrl(imageFile!);
      // if (userapicontroller.ridebookTime == "") {
      //   userapicontroller.placeOrdersUser(
      //       apicontroller.userRideAutenticationBody.value, imageFile!);
      // } else {
      //   userapicontroller.timeplaceOrdersUser(
      //       apicontroller.userRideAutenticationBody.value, imageFile!);
      // }

      // Main Below
      // apicontroller.RegistrationwithImage(
      //     apicontroller.registerAutenticationBody, imageFile!

      //     );
    } else {
      // Handle unexpected response type or null case
      print('Unexpected response type: ${response.runtimeType}');
    }
  }

  String _getTitle(M7LivelynessStep step) {
    switch (step) {
      case M7LivelynessStep.blink:
        return "Blink";
      case M7LivelynessStep.turnLeft:
        return "Turn Your Head Left";
      case M7LivelynessStep.turnRight:
        return "Turn Your Head Right";
      case M7LivelynessStep.smile:
        return "Smile";
    }
  }

  String _getSubTitle(M7LivelynessStep step) {
    switch (step) {
      case M7LivelynessStep.blink:
        return "Detects Blink on the face visible in camera";
      case M7LivelynessStep.turnLeft:
        return "Detects Left Turn of the on the face visible in camera";
      case M7LivelynessStep.turnRight:
        return "Detects Right Turn of the on the face visible in camera";
      case M7LivelynessStep.smile:
        return "Detects Smile on the face visible in camera";
    }
  }

  bool _isSelected(M7LivelynessStep step) {
    final M7LivelynessStepItem? doesExist = _verificationSteps.firstWhereOrNull(
      (p0) => p0.step == step,
    );
    return doesExist != null;
  }

  void _onStepValChanged(M7LivelynessStep step, bool value) {
    if (!value && _verificationSteps.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              "Need to have atleast 1 step of verification",
              style: GoogleFonts.roboto(
                color: KdarkText,
                fontSize: 20,
              ),
            ),
            backgroundColor: Kpink.withOpacity(0.5)),
      );
      return;
    }

    final M7LivelynessStepItem? doesExist = _verificationSteps.firstWhereOrNull(
      (p0) => p0.step == step,
    );

    if (doesExist == null && value) {
      _verificationSteps.add(
        M7LivelynessStepItem(
          step: step,
          title: _getTitle(step),
          isCompleted: false,
        ),
      );
    } else {
      if (!value) {
        _verificationSteps.removeWhere(
          (p0) => p0.step == step,
        );
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
        "Live Face Recognition",
        style: GoogleFonts.roboto(
            fontSize: kEighteenFont, fontWeight: kFW500, color: kcarden),
      ),
    );
    // AppBar(
    //   title: const Text("Live Face Recognition"),
    // );
  }

  Widget _buildBody() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildContent(),
        Visibility(
          visible: _capturedImagePath != null,
          child: const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(
          flex: 4,
        ),
        Visibility(
          visible: _capturedImagePath != null,
          child: Expanded(
            flex: 7,
            child: Image.file(
              File(_capturedImagePath ?? ""),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Visibility(
          visible: _capturedImagePath != null,
          child: const Spacer(),
        ),
        Center(
          child: ElevatedButton(
            onPressed: _onStartLivelyness,
            style: TextButton.styleFrom(
              backgroundColor: Kpink,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
            ),
            child: Text(
              "Detect Livelyness",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const Spacer(),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     const Spacer(
        //       flex: 3,
        //     ),
        //     const Text(
        //       "Start with info screen:",
        //       style: GoogleFonts.roboto(
        //         fontSize: 18,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //     const Spacer(),
        //     CupertinoSwitch(
        //       value: _startWithInfo,
        //       onChanged: (value) => setState(
        //         () => _startWithInfo = value,
        //       ),
        //     ),
        //     const Spacer(
        //       flex: 3,
        //     ),
        //   ],
        // ),
        // const Spacer(),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     const Spacer(
        //       flex: 3,
        //     ),
        //     const Text(
        //       "Allow after timer is completed:",
        //       style: GoogleFonts.roboto(
        //         fontSize: 18,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //     const Spacer(),
        //     CupertinoSwitch(
        //       value: _allowAfterTimeOut,
        //       onChanged: (value) => setState(
        //         () => _allowAfterTimeOut = value,
        //       ),
        //     ),
        //     const Spacer(
        //       flex: 3,
        //     ),
        //   ],
        // ),
        // const Spacer(),
        // Text(
        //   "Detection Time-out Duration(In Seconds): ${_timeOutDuration == 100 ? "No Limit" : _timeOutDuration}",
        //   textAlign: TextAlign.center,
        //   style: const TextStyle(
        //     fontSize: 18,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        // Slider(
        //   min: 0,
        //   max: 100,
        //   value: _timeOutDuration.toDouble(),
        //   onChanged: (value) => setState(
        //     () => _timeOutDuration = value.toInt(),
        //   ),
        // ),
        // Expanded(
        //   flex: 14,
        //   child: ListView.builder(
        //     physics: const ClampingScrollPhysics(),
        //     itemCount: M7LivelynessStep.values.length,
        //     itemBuilder: (context, index) => ExpansionTile(
        //       title: Text(
        //         _getTitle(
        //           M7LivelynessStep.values[index],
        //         ),
        //         style: const TextStyle(
        //           fontSize: 18,
        //           fontWeight: FontWeight.w600,
        //         ),
        //       ),
        //       children: [
        //         ListTile(
        //           title: Text(
        //             _getSubTitle(
        //               M7LivelynessStep.values[index],
        //             ),
        //             style: const TextStyle(
        //               fontSize: 16,
        //               fontWeight: FontWeight.normal,
        //             ),
        //           ),
        //           trailing: CupertinoSwitch(
        //             value: _isSelected(
        //               M7LivelynessStep.values[index],
        //             ),
        //             onChanged: (value) => _onStepValChanged(
        //               M7LivelynessStep.values[index],
        //               value,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
