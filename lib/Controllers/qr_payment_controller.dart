import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';
import 'package:womentaxi/untils/export_file.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class PaymentController extends GetxController {
  final upiIdController = TextEditingController();
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  var upiDetails = Rxn<UPIDetails>();

  void generateQrCode() {
    String upiId = upiIdController.text;
    String name = nameController.text;
    double amount = double.tryParse(amountController.text) ?? 0.0;
    String note = noteController.text;

    UPIDetails details = UPIDetails(
      upiID: upiId,
      payeeName: name,
      amount: amount,
      transactionNote: note,
    );

    upiDetails.value = details;
  }
}
