import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truthywallet/utility/ToastUtil.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:truthywallet/utility/common/Device.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';
import 'package:truthywallet/utility/widgets/ImageUtil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TYWebViewWidget extends StatefulWidget {
  static void open(BuildContext context, String url) {
    if (url.length == 0) {
      return;
    }
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => TYWebViewWidget(url: url),
      ),
    );
  }

  final String url;
  TYWebViewWidget({Key? key, required this.url});

  @override
  State<StatefulWidget> createState() => _TYWebViewWidgetState();
}

class _TYWebViewWidgetState extends State<TYWebViewWidget> {
  late WebViewController _webViewController;
  late String navTitle = "";

  late double loadingBarProgress = 0.05;
  bool hideProgressBar = false;

  @override
  void initState() {
    super.initState();
    if (Device.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    var pageScaffold = Scaffold(
      backgroundColor: PublicColors.grayBackground,
      resizeToAvoidBottomInset: false,
      appBar: CupertinoNavigationBar(
        backgroundColor: PublicColors.pureWhite,
        padding: EdgeInsetsDirectional.only(start: 8, end: 8),
        leading: GestureDetector(
          child: Container(
            width: 44,
            height: 44,
            padding: EdgeInsets.only(left: 8, top: 10, right: 10, bottom: 10),
            child: ImageUtil.getBackButtonImage(),
          ),
          onTap: () {
            // EasyLoading.dismiss();
            Navigator.of(context).pop();
          },
        ),
        middle: Text(navTitle),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              _webViewController = controller;
              ToastUtil.show(message: "Loading...", seconds: 3);
            },
            onPageStarted: (url) {
              updateProgressValue(0.1);
            },
            onProgress: (progressVal) { 
              updateProgressValue(progressVal / 100.0);
            },
            onPageFinished: (url) async {
              updateProgressValue(1.0);
              hideTopProgBar();

              String title = await _webViewController
                  .evaluateJavascript("document.title;");
              if (title.length > 0) {
                navTitle = title;
                setState(() {});
              }
            },
            onWebResourceError: (error) {
              hideTopProgBar();
              // print("加载网页失败$error");
              setState(() {navTitle = widget.url;});
            },
          ),
          hideProgressBar ? Container() :
          Container(
            height: 2,
            child: LinearProgressIndicator(
              value: loadingBarProgress,
              backgroundColor: PublicColors.pureBlack.withAlpha(50),
              valueColor: AlwaysStoppedAnimation<Color>(PublicColors.mainBlue),
            ),
          ),
        ],
      ),
    );
    return pageScaffold;
  }

  void updateProgressValue(double v) {
    if (mounted) {
      setState(() {
        loadingBarProgress = v;
      });
    }
  }

  void hideTopProgBar() {
    if (mounted) {
      setState(() {
        hideProgressBar = true;
      });
    }
  }
}
