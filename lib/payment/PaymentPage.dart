import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:camera_windows_example/cons/constant.dart';
import 'package:camera_windows_example/controller/imagecapture.dart';
import 'package:camera_windows_example/controller/managementcontroller.dart';
import 'package:camera_windows_example/controller/pagecontroller.dart';
import 'package:camera_windows_example/controller/paymentcontroller.dart';
import 'package:camera_windows_example/widgets/permitgenerate%20copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/webtouchwrapper.dart';
import 'atom_pay_helper.dart';

class PaymentFinalPage extends StatefulWidget {
  const PaymentFinalPage({super.key});

  @override
  createState() => _PaymentFinalPageState();
}

class _PaymentFinalPageState extends State<PaymentFinalPage> {
  // final mode;
  // final payDetails;
  // final _responsehashKey;
  // final _responseDecryptionKey;
  final _key = UniqueKey();
  late InAppWebViewController _controller;
  bool loadComplete = false;
  final GlobalKey _keys = GlobalKey();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    // if (Platform.isAndroid) WebView.platform  = SurfaceAndroidViewController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GetxTapController gcontroller = Get.find<GetxTapController>();
    return GetBuilder<Imagecontroller>(builder: (imgcon) {
      return GetBuilder<PagenavControllers>(builder: (pagectrl) {
        return GetBuilder<Managementcontroller>(builder: (mngctrl) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 162, 207, 240),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 2,
            ),
            body: Stack(
              children: [
                mngctrl.paymentresult != null &&
                        mngctrl.paymentresult!.permitNo!.isNotEmpty &&
                        mngctrl.getPermit != null &&
                        imgcon.profileImage != null
                    ? Stack(
                        children: [
                          PermitGenerateWidgetcopy(
                            applicantId: mngctrl.paymentresult!.permitNo!,
                            keys: _keys,
                            deviceId: mngctrl.deviceId ?? '',
                            paymentResponse: mngctrl.paymentresult!,
                            permit: mngctrl.getPermit!,
                            permitfee: mngctrl.getPermitPrice!.fee,
                            image: imgcon.profileImage!,
                          ),
                          Positioned.fill(
                              child: Container(
                            color: Colors.transparent,
                          )),
                        ],
                      )
                    : SizedBox(),
                Container(
                  color: const Color.fromARGB(255, 160, 207, 240),
                  child: Column(
                    children: [
                      Expanded(
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontFamily: Theme.of(context).textTheme.bodyLarge!.fontFamily,
                            // Retrieve fontFamily from the current theme
                          ),
                          child: Center(
                            child: Container(
                              height: 1300,
                              width: 700,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: CircularProgressIndicator()),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text("Processing your Payment",
                                              style: GoogleFonts.inter(
                                                  color: Theme.of(context).colorScheme.secondary,
                                                  fontSize: 30))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child: WebviewTouchWrapper(
                                      child: InAppWebView(
                                        initialSettings: InAppWebViewSettings(
                                          javaScriptEnabled: true, // ✅ Enable JS
                                          allowFileAccessFromFileURLs:
                                              true, // ✅ Allow asset file access
                                          allowUniversalAccessFromFileURLs:
                                              true, // ✅ Avoid CORS issues
                                          useShouldOverrideUrlLoading: true,
                                          useOnLoadResource: true,
                                          allowContentAccess: true,
                                          // javaScriptCanOpenWindowsAutomatically: true
                                        ),
                                        // initialUrl: 'about:blank',
                                        key: UniqueKey(),
                                        initialData: InAppWebViewInitialData(
                                          data: isDebugmode
                                              ? '''
                                                    <!DOCTYPE html>
                                                    <html>
                                                    <head>
                                                      <meta name="viewport" content="width=device-width, initial-scale=1">
                                                      <script src="https://pgtest.atomtech.in/staticdata/ots/js/atomcheckout.js"></script>
                                                      <style>
                                                        body { margin: 0; padding: 0; width: 100%; height: 100%; }
                                                        #payment-form { width: 100%; height: 100%; }
                                                      </style>
                                                    </head>
                                                    <body>
                                                      <div id="payment-form"></div>
                                                      <script>
                                                        function openPay() {
                                                          const options = {
                                                            "atomTokenId": "${gcontroller.atomTokenId}",
                                                                  "merchId": "${gcontroller.login}",
                                                                  "custEmail": "test.user@gmail.com",
                                                                  "custMobile": "8888888888",
                                                                  "returnUrl": "https://pgtest.atomtech.in/mobilesdk/param",
                                                                  "userAgent": "mobile_webView"
                                                                };
                                                                
                                                                new AtomPaynetz(options, 'uat');
                                                              }
                                                              document.addEventListener('DOMContentLoaded', openPay);
                                                            </script>
                                                          </body>
                                                          </html>
                                                        '''
                                              : '''
                                                  <!DOCTYPE html>
                                                  <html>
                                                  <head>
                                                    <meta name="viewport" content="width=device-width, initial-scale=1">
                                                    // <script src="https://psa.atomtech.in/staticdata/ots/js/atomcheckout.js"></script>
                                                    
                                                    <style>
                                                      body { margin: 0; padding: 0; width: 100%; height: 100%; }
                                                      #payment-form { width: 100%; height: 100%; }
                                                    </style>
                                                  </head>
                                                  <body>
                                                    <div id="payment-form"></div>
                                                    <script>
                                                      function openPay() {
                                                        const options = {
                                                          "atomTokenId": "${gcontroller.atomTokenId}",
                                                "merchId": "${gcontroller.login}",
                                                "custEmail": "${mngctrl.getPermit?.applcntEmail ?? "nouser@gmail.com"}",
                                                "custMobile": "${mngctrl.getPermit?.applcntMobile ?? "9898989898"}",
                                                "returnUrl": "https://payment.atomtech.in/mobilesdk/param",
                                                "userAgent": "mobile_webView"
                                              };
                                              new AtomPaynetz(options, 'uat');
                                            }
                                            document.addEventListener('DOMContentLoaded', openPay);
                                          </script>
                                        </body>
                                        </html>
                                      ''',
                                        ),
                                        onWebViewCreated: (controller) {
                                          _controller = controller;
                                          gcontroller.resetloading();
                                        },

                                        onConsoleMessage: (controller, consoleMessage) {
                                          debugPrint("WebView Console: ${consoleMessage.message}");
                                        },
                                        shouldOverrideUrlLoading:
                                            (controller, navigationAction) async {
                                          String url = navigationAction.request.url.toString();
                                          var uri = navigationAction.request.url!;
                                          if (url.startsWith("upi://")) {
                                            debugPrint("upi url started loading");
                                            try {
                                              await launchUrl(uri);
                                            } catch (e) {
                                              _closeWebView(
                                                  callback: () {},
                                                  context: context,
                                                  transactionResult:
                                                      "Transaction Status = cannot open UPI applications",
                                                  txid: '',
                                                  transstatus: 0,
                                                  paymentname: 'NA',
                                                  totalamount: '');

                                              throw 'custom error for UPI Intent';
                                            }
                                            return NavigationActionPolicy.CANCEL;
                                          }
                                          return NavigationActionPolicy.ALLOW;
                                        },

                                        onLoadStop: (controller, url) async {
                                          debugPrint("onloadstop_url: $url");

                                          if (url.toString().contains("AIPAYLocalFile")) {
                                            debugPrint(" AIPAYLocalFile Now url loaded: $url");
                                            await _controller.evaluateJavascript(
                                                source:
                                                    "${"openPay('" + gcontroller.payDetails}')");

                                            log('Checking 1 $url');
                                          }

                                          if (url.toString().contains('/mobilesdk/param')) {
                                            log('Checking 2');
                                            final String response =
                                                await _controller.evaluateJavascript(
                                                    source:
                                                        "document.getElementsByTagName('h5')[0].innerHTML");
                                            debugPrint("HTML response : $response");
                                            var transactionResult = "";
                                            String transactionid = '';
                                            int? transactionstatus;
                                            String paymentmethodname = '';
                                            String totalamount = '';
                                            String processingfee = '';
                                            String remark = "";
                                            if (response.trim().contains("cancelTransaction")) {
                                              remark = remark.isEmpty || remark != 'failed'
                                                  ? "Cancelled"
                                                  : remark;
                                              totalamount = "0";
                                              transactionResult = "CANCELLED";
                                              transactionstatus = 100;
                                            } else {
                                              final split = response.trim().split('|');
                                              final Map<int, String> values = {
                                                for (int i = 0; i < split.length; i++) i: split[i]
                                              };

                                              final splitTwo = values[1]!.split('=');
                                              // const platform = MethodChannel('flutter.dev/NDPSAESLibrary');

                                              try {
                                                final String result = await gcontroller
                                                    .decrypt(splitTwo[1].toString());
                                                //     await platform.invokeMethod('NDPSAESInit', {
                                                //   'AES_Method': 'decrypt',
                                                //   'text': splitTwo[1].toString(),
                                                //   'encKey': _responseDecryptionKey
                                                // });
                                                var respJsonStr = result.toString();
                                                Map<String, dynamic> jsonInput =
                                                    jsonDecode(respJsonStr);
                                                debugPrint("read full respone : $jsonInput");

                                                //calling validateSignature function from atom_pay_helper file
                                                var checkFinalTransaction = validateSignature(
                                                    jsonInput, gcontroller.responseHashKey);

                                                if (checkFinalTransaction) {
                                                  if (jsonInput["payInstrument"]["responseDetails"]
                                                              ["statusCode"] ==
                                                          'OTS0000' ||
                                                      jsonInput["payInstrument"]["responseDetails"]
                                                              ["statusCode"] ==
                                                          'OTS0551') {
                                                    debugPrint("Transaction success");
                                                    transactionid = jsonInput['payInstrument']
                                                        ['merchDetails']['merchTxnId'];

                                                    var paymethod = jsonInput['payInstrument']
                                                            ['payModeSpecificData']['subChannel'][0]
                                                        .toString();
                                                    paymentmethodname = paymentmethod[paymethod];
                                                    totalamount = jsonInput['payInstrument']
                                                            ['payDetails']['amount']
                                                        .toStringAsFixed(2);
                                                    processingfee = jsonInput['payInstrument']
                                                            ['payDetails']['surchargeAmount']
                                                        .toStringAsFixed(2);
                                                    remark = "SUCCESS";
                                                    transactionResult = "SUCCESS";
                                                    transactionstatus = 200;
                                                  } else {
                                                    var paymethod = jsonInput['payInstrument']
                                                            ['payModeSpecificData']['subChannel'][0]
                                                        .toString();
                                                    paymentmethodname = paymentmethod[paymethod];
                                                    totalamount = jsonInput['payInstrument']
                                                            ['payDetails']['totalAmount']
                                                        .toStringAsFixed(2);
                                                    processingfee = jsonInput['payInstrument']
                                                            ['payDetails']['surchargeAmount']
                                                        .toStringAsFixed(2);
                                                    remark = "Failed";
                                                    debugPrint("Transaction failed");
                                                    transactionResult = "FAILED";
                                                    transactionstatus = 300;
                                                  }
                                                } else {
                                                  var paymethod = jsonInput['payInstrument']
                                                          ['payModeSpecificData']['subChannel'][0]
                                                      .toString();
                                                  paymentmethodname = paymentmethod[paymethod];
                                                  totalamount = jsonInput['payInstrument']
                                                          ['payDetails']['totalAmount']
                                                      .toStringAsFixed(2);
                                                  processingfee = jsonInput['payInstrument']
                                                          ['payDetails']['surchargeAmount']
                                                      .toStringAsFixed(2);
                                                  remark = "Failed";

                                                  transactionResult = "FAILED";
                                                  transactionstatus = 300;
                                                }
                                                debugPrint("Transaction Response : $jsonInput");
                                              } on PlatformException catch (e) {
                                                debugPrint("Failed to decrypt: '${e.message}'.");
                                              }
                                            }

                                            _closeWebView(
                                                callback: () async {
                                                  await gcontroller.updatepaymentremark(
                                                      context: context,
                                                      processingfee: processingfee,
                                                      amount: totalamount,
                                                      key: _keys,
                                                      transactionid: gcontroller.transacid,
                                                      paymentmethod: paymentmethodname,
                                                      status: transactionResult);
                                                },
                                                context: context,
                                                transactionResult: transactionResult,
                                                txid: transactionid,
                                                transstatus: transactionstatus!,
                                                paymentname: paymentmethodname,
                                                totalamount: totalamount);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      });
    });
  }

  _closeWebView(
      {required BuildContext context,
      required String transactionResult,
      required int transstatus,
      required String txid,
      required String paymentname,
      required String totalamount,
      required VoidCallback callback}) async {
    callback();
  }

  Future<bool> _handleBackButtonAction(BuildContext context) async {
    debugPrint("_handleBackButtonAction called");
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Do you want to exit the payment ?'),
              actions: <Widget>[
                // ignore: deprecated_member_use
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'),
                ),
                // ignore: deprecated_member_use
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).pop(); // Close current window
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Transaction Status = Transaction cancelled")));
                  },
                  child: const Text('Yes'),
                ),
              ],
            ));
    return Future.value(true);
  }
}
