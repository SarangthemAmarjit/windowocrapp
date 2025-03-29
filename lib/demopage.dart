import 'dart:io';

import 'package:camera_windows_example/controller/paymentcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'widgets/webtouchwrapper.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController? webViewController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    GetxTapController paycon = Get.put(GetxTapController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("InApp WebView Demo"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              webViewController?.reload();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    paycon.initNdpsPayment(
                      transId: "dfgsdgggsdg",
                      context: context,
                      responseHashKey: paycon.responseHashKey,
                      responseDecryptionKey: paycon.responseDecryptionKey,
                      amount: "2",
                      address: 'fsdfsdf',
                      name: 'amarjit',
                    );
                  },
                  child: Text('Pay Now')))
        ],
      ),
    );
  }
}
