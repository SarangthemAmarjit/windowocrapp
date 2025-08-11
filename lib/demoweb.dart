import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:win32/win32.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late InAppWebViewController _webViewController;
  final String _initialUrl = 'https://www.google.com';
  String inputText = ""; // To store the input from the custom keyboard

  void openTouchKeyboard() {
    final hInstance = ShellExecute(
      0,
      TEXT('open'),
      TEXT(r'C:\Program Files\Common Files\microsoft shared\ink\TabTip.exe'),
      nullptr,
      nullptr,
      SHOW_WINDOW_CMD.SW_SHOWNORMAL,
    );

    if (hInstance <= 32) {
      print('Failed to open touch keyboard with error code: $hInstance');
    }
  }

// Focus the target input field after page load
  Future<void> _focusWebViewTextField() async {
    await Future.delayed(const Duration(seconds: 1));
    _webViewController.evaluateJavascript(
      source: '''
      (function() {
        var textField = document.querySelector('input[name="debit_name_on_card"], input.custom-input');
        if (textField) {
          textField.focus();
          console.log("Text field focused successfully.");
        } else {
          console.log("Text field not found.");
        }
      })();
    ''',
    );
  }

// Send text to the target WebView text field by ID or class
  void _updateWebViewTextField() {
    _webViewController.evaluateJavascript(
      source: '''
      (function() {
        var textField = document.querySelector('input[name="debit_name_on_card"], input.custom-input');
        if (textField) {
          textField.value = "$inputText";
          console.log("Text field updated: " + textField.value);
        } else {
          console.log("Text field not found for update.");
        }
      })();
    ''',
    );
  }

  // Called when a key is tapped on the custom keyboard
  void _onKeyTap(String key) {
    setState(() {
      inputText += key;
    });
    _updateWebViewTextField(); // Update the input field
  }

  // Called when backspace is tapped on the custom keyboard
  void _onBackspace() {
    if (inputText.isNotEmpty) {
      setState(() {
        inputText = inputText.substring(0, inputText.length - 1);
      });
      _updateWebViewTextField(); // Update the input field
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _webViewController.reload(); // Reload the current page
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(_initialUrl)),
              initialSettings: InAppWebViewSettings(
                isInspectable: true,
                mediaPlaybackRequiresUserGesture: false,
                allowsInlineMediaPlayback: true,
                iframeAllow: "*",
                javaScriptEnabled: true,
                iframeAllowFullscreen: true,
              ),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onLoadStart: (controller, url) {
                debugPrint('Page started loading: $url');
              },
              onLoadStop: (controller, url) async {
                debugPrint('Page finished loading: $url');
                openTouchKeyboard();
              },
              onPrintRequest: (controller, url, printJobController) async {
                return await true;
              },
              onLoadError: (controller, url, code, message) {
                debugPrint('Failed to load $url: $message');
              },
              onJsAlert: (controller, jsAlertRequest) async {
                return await JsAlertResponse(action: JsAlertResponseAction.fromNativeValue(10));
              },
              onConsoleMessage: (controller, consoleMessage) {
                debugPrint("Console Message: ${consoleMessage.message}"); // Log console messages
              },
            ),
          ),
        ],
      ),
    );
  }
}
