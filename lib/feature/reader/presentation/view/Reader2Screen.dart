import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Reader2Screen extends StatefulWidget {
  @override
  _Reader2ScreenState createState() => _Reader2ScreenState();
}

class _Reader2ScreenState extends State<Reader2Screen> {

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: "https://image.shutterstock.com/image-photo/beautiful-water-drop-on-dandelion-260nw-789676552.jpg",
//      initialUrl: "https://bestmanga.club//wp-content//uploads//WP-manga//data//manga_5c8974fbf2f56//2c36320a8ef3fc07444b3ff07ae34131//podniatie_urovnia_v_odinochku_1_0_0.jpg",
      javascriptMode: JavascriptMode.unrestricted,
      debuggingEnabled: true,
      gestureNavigationEnabled: true,
      initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
      onWebViewCreated: (WebViewController webViewController) {
//        _controller.complete(webViewController);
      },
    );
  }
}
