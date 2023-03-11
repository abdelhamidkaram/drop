import 'package:flutter/material.dart';

class BrowserScreen extends StatefulWidget {
  final String url; 
  const BrowserScreen({Key? key, required this.url}) : super(key: key);
  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  bool isLoading = true;
  @override
  // void initState() {
  //   super.initState();
  //   // Enable virtual display.
  //   if (Platform.isAndroid) WebView.platform = AndroidWebView();
  // }

  @override
  Widget build(BuildContext context) {

    return SizedBox();
    // return Directionality(
    //   textDirection: TextDirection.ltr,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       leading: const Padding(
    //         padding: EdgeInsets.only(left: 18.0 ),
    //         child: CustomBackButton(),
    //       ),
    //     ),
    //     body: Stack(
    //       children: [
    //         WebView(
    //           onPageFinished: (url) {
    //             setState(() {
    //               isLoading = false;
    //             });
    //           },
    //           initialUrl: widget.url,
    //           javascriptMode: JavascriptMode.unrestricted,
    //         ),
    //         isLoading
    //             ? const Center(
    //                 child: CircularProgressIndicator(),
    //               )
    //             : Stack(),
    //       ],
    //     ),
    //
    //   ),
    // );
  }
}
