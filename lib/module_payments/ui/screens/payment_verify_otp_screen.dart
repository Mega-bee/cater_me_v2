import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentVerifyOtpScreen extends StatefulWidget {
  final String webUrl;
  const PaymentVerifyOtpScreen(  { required this.webUrl})  ;

  @override
  State<PaymentVerifyOtpScreen> createState() => _PaymentVerifyOtpState();
}

class _PaymentVerifyOtpState extends State<PaymentVerifyOtpScreen> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    print('in web view');
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl:widget.webUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
      ),
    );
  }
}
