import 'package:camera_windows_example/widgets/customkeys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late InAppWebViewController _webViewController;
  final String _initialUrl = 'https://www.atomtech.in/aipay-demo/uat_response';
  String inputText = ""; // To store the input from the custom keyboard

  // Focus and update WebView text field after page load
  void _focusWebViewTextField() {
    _webViewController.evaluateJavascript(
      source: '''
        var textField = document.querySelector('input[type="text"]');
        if (textField) {
          textField.focus();  // Focus the text field
        }
      ''',
    );
  }

void _updateWebViewTextField() {
  if (_webViewController != null) {
    _webViewController.evaluateJavascript(
      source: '''
        let activeEel = document.activeElement;  // Renamed variable
        if (activeEel && activeEel.tagName === 'INPUT' && activeEel.type === 'text') {
          activeEel.value = "$inputText";
        }
      ''',
    );
  }
}


  // Called when a key is tapped on the custom keyboard
  void _onKeyTap(String key) {
    setState(() {
      inputText += key;
    });
    _updateWebViewTextField(); // Update the focused text field
  }

  // Called when backspace is tapped on the custom keyboard
  void _onBackspace() {
    if (inputText.isNotEmpty) {
      setState(() {
        inputText = inputText.substring(0, inputText.length - 1);
      });
      _updateWebViewTextField(); // Update the focused text field
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google WebView'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _webViewController.reload(); // Reload the current page
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(_initialUrl)),
            initialSettings: InAppWebViewSettings(
                isInspectable: true,
                mediaPlaybackRequiresUserGesture: false,
                allowsInlineMediaPlayback: true,
                iframeAllow: "camera; microphone",
                javaScriptEnabled: true,
                iframeAllowFullscreen: true),
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onLoadStart: (controller, url) {
              debugPrint('Page started loading: $url');
            },
            onLoadStop: (controller, url) async {
              debugPrint('Page finished loading: $url');
              _focusWebViewTextField(); // Focus the text field after loading
            },
            onLoadError: (controller, url, code, message) {
              debugPrint('Failed to load $url: $message');
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.grey[200], // Background for custom keyboard
                  child: CustomKeyboard(
                    onKeyTap: _onKeyTap,
                    onBackspace: _onBackspace,
                    onToggle: () {},
                    isAlpha: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
