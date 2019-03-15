import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/view/first/collected-page.dart';
import 'package:learn_flutter/view/first/search-input.dart';
import 'package:learn_flutter/view/native.dart';
import 'package:learn_flutter/view/first/web-view-page.dart';
import 'package:learn_flutter/view/home-page.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String webView = '/web-view';
  static String search = '/search';
  static String collected= '/collected';
  static String native = '/native';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc:
            (BuildContext context, Map<String, List<String>> params) {});
    router.define(home, handler: homeHandler);
    router.define(webView,
        handler: webViewHandler, transitionType: TransitionType.inFromRight);
    router.define(native,
        handler: nativeHandler, transitionType: TransitionType.inFromRight);
    router.define(search,
        handler: searchHandler, transitionType: TransitionType.fadeIn);
    router.define(collected,
        handler: collectedHandler, transitionType: TransitionType.inFromRight);
  }
}

// app的首页
var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new AppPage();
  },
);

// webView
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

// 原生
var nativeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new NativeWidget();
  },
);

// 搜索
var searchHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new SearchPageWidget();
  },
);

// 收藏列表
var collectedHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new CollectedPage();
  },
);
