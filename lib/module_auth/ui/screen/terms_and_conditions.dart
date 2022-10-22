import 'dart:async';
import 'dart:io';

import 'package:cater_me_v2/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions() ;

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
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
      appBar: AppBar(title: Text(S.of(context).terms),),
      body: WebView(
        initialUrl:'https://caterme.azurewebsites.net/caterme/termsandconditions?lang=${Localizations.localeOf(context).languageCode}',
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
