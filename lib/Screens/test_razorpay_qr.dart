// import 'dart:async';
// import 'dart:convert';

// import 'package:barcode_scan2/barcode_scan2.dart';
// import 'package:womentaxi/untils/export_file.dart';

// class RazorpayQRImage extends StatefulWidget {
//   const RazorpayQRImage({super.key});

//   @override
//   State<RazorpayQRImage> createState() => _RazorpayQRImageState();
// }

// class _RazorpayQRImageState extends State<RazorpayQRImage> {
//   UserApiController userapicontroller = Get.put(UserApiController());
//   void sendTOBackend() {
//     // order_id, amount
//     var payload = {
//       "amount": "10",
//       "order_id": "1hblkb0",
//     };
//     userapicontroller.qrimagesendRazorpayCompletionDetails(payload);
//   }

//   Future<void> scanQRCode() async {
//     var result = await BarcodeScanner.scan();
//     if (result.type == ResultType.Barcode) {
//       // Decode the scanned QR code data
//       final qrData = jsonDecode(result.rawContent);

//       // Retrieve order_id and amount
//       final String orderId = qrData['order_id'];
//       final int amount = qrData['amount'];
//       var payload = {
//         "amount": "${amount}",
//         "order_id": orderId,
//       };
//       userapicontroller.qrimagesendRazorpayCompletionDetails(payload);
//       // Verify the payment
//       // await verifyPayment(orderId, amount);
//     }
//   }

//   @override
//   void initState() {
//     var payload = {
//       "amount": "10",
//     };

//     userapicontroller.sendRazorpayRequest(payload);

//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
/////////////////////////////////////////////////////////////////////////////////////////one change
// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:barcode_scan2/barcode_scan2.dart';
// import 'package:get/get.dart';
// import 'package:womentaxi/untils/export_file.dart';

// class RazorpayQRImage extends StatefulWidget {
//   const RazorpayQRImage({super.key});

//   @override
//   State<RazorpayQRImage> createState() => _RazorpayQRImageState();
// }

// class _RazorpayQRImageState extends State<RazorpayQRImage> {
//   UserApiController userapicontroller = Get.put(UserApiController());
//   String? base64Image; // Store the QR code Base64 string here.

//   // Send initial request to generate the QR code.
//   @override
//   void initState() {
//     var payload = {
//       "amount": "10",
//     };
//     userapicontroller.sendRazorpayRequest(payload).then((response) {
//       if (userapicontroller.razorpayRequestDataBackend != null &&
//           userapicontroller.razorpayRequestDataBackend["qr_code"] != null) {
//         setState(() {
//           final base64String = userapicontroller
//               .razorpayRequestDataBackend["qr_code"]
//               .split(',')
//               .last;
//           base64Image = base64String;
//           // base64Image = userapicontroller
//           //     .razorpayRequestDataBackend["qr_code"]; // Store Base64 QR image.
//         });
//       }
//     }).catchError((error) {
//       print("Error fetching QR image: $error");
//     });

//     super.initState();
//   }

//   // Function to send scanned details to the backend.
//   void sendToBackend(Map<String, dynamic> payload) {
//     userapicontroller.qrimagesendRazorpayCompletionDetails(payload);
//   }

//   // Function to scan the QR code.
//   Future<void> scanQRCode() async {
//     try {
//       var result = await BarcodeScanner.scan();
//       if (result.type == ResultType.Barcode) {
//         // Decode the scanned QR code data.
//         final qrData = jsonDecode(result.rawContent);

//         // Retrieve order_id and amount.
//         final String orderId = qrData['order_id'];
//         final int amount = qrData['amount'];

//         // Send scanned data to the backend.
//         var payload = {
//           "amount": "$amount",
//           "order_id": orderId,
//         };
//         sendToBackend(payload);
//       }
//     } catch (e) {
//       print("QR scan failed: $e");
//     }
//   }

//   // Function to decode Base64 string to Uint8List.
//   Uint8List base64DecodeImage(String base64Image) {
//     return base64Decode(base64Image);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Razorpay QR Code Payment'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (base64Image != null)
//               Image.memory(
//                 base64DecodeImage(base64Image!),
//                 width: 200,
//                 height: 200,
//                 fit: BoxFit.contain,
//               )
//             else
//               const CircularProgressIndicator(), // Loader while QR code loads.

//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: scanQRCode,
//               child: const Text('Scan QR Code'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:get/get.dart';
import 'package:womentaxi/untils/export_file.dart';

class RazorpayQRImage extends StatefulWidget {
  const RazorpayQRImage({super.key});

  @override
  State<RazorpayQRImage> createState() => _RazorpayQRImageState();
}

class _RazorpayQRImageState extends State<RazorpayQRImage> {
  UserApiController userapicontroller = Get.put(UserApiController());
  String? base64Image; // Store the QR code Base64 string here.

  // Send initial request to generate the QR code.
  @override
  void initState() {
    super.initState();
    var payload = {
      "amount": "10",
    };
    userapicontroller.sendRazorpayRequest(payload).then((response) {
      if (userapicontroller.razorpayRequestDataBackend != null &&
          userapicontroller.razorpayRequestDataBackend["qr_code"] != null) {
        setState(() {
          final base64String = userapicontroller
              .razorpayRequestDataBackend["qr_code"]
              .split(',')
              .last;
          base64Image = base64String;
        });
      }
    }).catchError((error) {
      print("Error fetching QR image: $error");
    });
  }

  // Function to send scanned details to the backend.
  void sendToBackend(Map<String, dynamic> payload) {
    userapicontroller.qrimagesendRazorpayCompletionDetails(payload);
  }

  // Function to scan the QR code.
  Future<void> scanQRCode() async {
    try {
      var result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        // Decode the scanned QR code data.
        final qrData = jsonDecode(result.rawContent);

        // Retrieve order_id and amount in paise.
        final String orderId = qrData['order_id'];
        final int amountInPaise = qrData['amount'];

        // Convert amount from paise to rupees.
        final double amountInRupees = amountInPaise / 100;

        // Send scanned data to the backend.
        var payload = {
          "amount": "$amountInRupees", // Store amount in rupees
          "order_id": orderId,
        };
        sendToBackend(payload);
      }
    } catch (e) {
      print("QR scan failed: $e");
    }
  }

  // Function to decode Base64 string to Uint8List.
  Uint8List base64DecodeImage(String base64Image) {
    return base64Decode(base64Image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Razorpay QR Code Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (base64Image != null)
              Image.memory(
                base64DecodeImage(base64Image!),
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              )
            else
              const CircularProgressIndicator(), // Loader while QR code loads.

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: scanQRCode,
              child: const Text('Scan QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
