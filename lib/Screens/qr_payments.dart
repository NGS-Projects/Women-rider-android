import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';
import 'package:womentaxi/untils/export_file.dart';

//import 'payment_controller.dart';
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UPI Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.upiIdController,
              decoration: InputDecoration(labelText: "UPI ID"),
            ),
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(labelText: "Recipient Name"),
            ),
            TextField(
              controller: controller.amountController,
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: controller.noteController,
              decoration: InputDecoration(labelText: "Transaction Note"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.generateQrCode,
              child: Text("Generate QR Code"),
            ),
            SizedBox(height: 20),
            Obx(
              () => controller.upiDetails.value != null
                  ? UPIPaymentQRCode(
                      upiDetails: controller.upiDetails.value!,
                      size: 200,
                      embeddedImagePath: "assets/images/location.png",
                      embeddedImageSize: const Size(20, 20),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

// class PaymentScreen extends StatelessWidget {
//   final PaymentController controller = Get.put(PaymentController());

//   @override
//   Widget build(BuildContext context) {
//     return 
  
//   }
// }
