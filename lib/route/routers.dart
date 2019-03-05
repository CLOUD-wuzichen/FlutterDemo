import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/test/test.dart';
import 'package:learn_flutter/view/home-page.dart';
import 'package:learn_flutter/view/web-view-page.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String webView = '/web-view';

  static String test = '/test';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc:
            (BuildContext context, Map<String, List<String>> params) {});
    router.define(home, handler: homeHandler);
    router.define(webView, handler: webViewHandler,transitionType: TransitionType.inFromRight);

    router.define(test, handler: testHandler);
  }
}

//// app的首页
var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new AppPage();
  },
);

//// webView
var webViewHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String title = params["title"]?.first;
    String url = params["url"]?.first;
    return new WebViewWidget(
      title: title,
      url: url,
    );
  },
);

var testHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String filePath = params["filePath"]?.first;
    return new TestWidget(filePath: filePath);
  },
);
