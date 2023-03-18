import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'custom_back_button.dart';

class BrowserScreen extends StatefulWidget {
  final String url; 
  const BrowserScreen({Key? key, required this.url}) : super(key: key);
  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  bool isLoading = true;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {

          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url))
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {


    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.only(left: 18.0 ),
            child: CustomBackButton(),
          ),
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: controller),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(),
          ],
        ),

      ),
    );
  }
}
