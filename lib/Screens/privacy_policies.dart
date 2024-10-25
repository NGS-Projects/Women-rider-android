// import 'package:womentaxi/untils/export_file.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// // import 'package:webview_flutter/webview_flutter.dart';

// // PrivacyPolicies
// class PrivacyPolicies extends StatefulWidget {
//   @override
//   _PrivacyPoliciesState createState() => _PrivacyPoliciesState();
// }

// class _PrivacyPoliciesState extends State<PrivacyPolicies> {
//   bool isLoading = true;

//   late WebViewController webView;

//   Future<bool> _onBack() async {
//     var value = await webView.canGoBack();

//     if (value) {
//       await webView.goBack();
//       return false;
//     } else {
//       return true;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => _onBack(),
//       child: Scaffold(
//         backgroundColor: Kwhite,
//         appBar: AppBar(
//           title: Text("Privacy Polocies"),
//         ),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               WebView(
//                 initialUrl: "https://www.flipkart.com/",
//                 javascriptMode: JavascriptMode.unrestricted,
//                 onPageStarted: (url) {
//                   setState(() {
//                     isLoading = true;
//                   });
//                 },
//                 onPageFinished: (status) {
//                   setState(() {
//                     isLoading = false;
//                   });
//                 },
//                 onWebViewCreated: (WebViewController controller) {
//                   webView = controller;
//                 },
//               ),
//               isLoading
//                   ? Center(
//                       child: CircularProgressIndicator(
//                         color: Kpink,
//                       ),
//                     )
//                   : Stack(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PrivacyPolicies extends StatefulWidget {
//   const PrivacyPolicies({super.key});

//   @override
//   State<PrivacyPolicies> createState() => _PrivacyPoliciesState();
// }

// class _PrivacyPoliciesState extends State<PrivacyPolicies> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

import 'package:womentaxi/untils/export_file.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicies extends StatefulWidget {
  @override
  _PrivacyPoliciesState createState() => _PrivacyPoliciesState();
}

class _PrivacyPoliciesState extends State<PrivacyPolicies> {
  bool isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (status) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://sites.google.com/view/womenrider/privacy-policy'));
  }

  Future<bool> _onBack() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        backgroundColor: Kwhite,
        appBar: AppBar(
          title: Text("Privacy Policies"),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: Kpink,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
