import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:learn_flutter/test/custom_view.dart';

class WebViewWidget extends StatefulWidget {
  final String url;
  final String title;

  const WebViewWidget({Key key, this.url, this.title}) : super(key: key);

  @override
  WebViewState createState() => new WebViewState();
}

class WebViewState extends State<WebViewWidget> {

  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
        print(" $url");
    });
  }
  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(),
      appBar: TitleBar(
        title: widget.title,
        onBack: () {
          Navigator.of(context).pop();
        },
      ),
      body: WebviewScaffold(
        url: widget.url,
        withZoom: false,
        withLocalStorage: true,
        withJavascript: true,

      ),
    );
  }
}
