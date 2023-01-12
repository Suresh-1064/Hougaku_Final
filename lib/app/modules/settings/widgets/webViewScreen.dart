import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Webview widget .
class WebViewScreen extends StatelessWidget {
  WebViewScreen({Key? key, required this.title, required this.url})
      : super(key: key);

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text(title),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Container(
              height: 100.h -
                  MediaQueryData.fromWindow(window).padding.top -
                  appBar.preferredSize.height,
              child: WebView(
                initialUrl: url,
              ))
        ],
      ),
    );
  }
}
