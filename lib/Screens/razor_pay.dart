import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:womentaxi/untils/export_file.dart';

class SampleRazorPay extends StatefulWidget {
  const SampleRazorPay({super.key});

  @override
  State<SampleRazorPay> createState() => _SampleRazorPayState();
}

class _SampleRazorPayState extends State<SampleRazorPay> {
  UserApiController userapicontroller = Get.put(UserApiController());
  //////////////////
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    // api here
    var payload = {
      "amount": "10",
    };

    userapicontroller.sendRazorpayRequest(payload);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Successful"),
        content: Text("Payment ID: ${response.paymentId}"),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
    // api
    // body- razorpay_order_id, razorpay_payment_id, razorpay_signature
    var payload = {
      //   razorpay_order_id
      "razorpay_order_id":
          userapicontroller.razorpayRequestDataBackend["order_id"],
      "razorpay_payment_id": "${response.paymentId}",
      "razorpay_signature": "${response.signature}",
    };

    userapicontroller.sendRazorpayCompletionDetails(payload);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Failed"),
        content: Text("Error: ${response.code} - ${response.message}"),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("External Wallet Selected"),
        content: Text("Wallet Name: ${response.walletName}"),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_live_zbmR4QaoePLouz',
      'amount': 10, // amount in the smallest currency unit
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  ///////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: openCheckout,
          child: Text('Pay with Razorpay'),
        ),
      ),
    );
  }
}
