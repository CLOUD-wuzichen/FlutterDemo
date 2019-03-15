import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:learn_flutter/event/event_bus.dart';
import 'package:learn_flutter/utils/widget-utils.dart';
import 'package:learn_flutter/widget/custom_view.dart';
import 'package:after_layout/after_layout.dart';
import 'package:learn_flutter/view/first/sql-collection.dart';

class WebViewWidget extends StatefulWidget {
  final String url;
  final String title;

  WebViewWidget({Key key, @required this.title, @required this.url})
      : super(key: key);

  @override
  WebViewState createState() => new WebViewState();
}

class WebViewState extends State<WebViewWidget>
    with AfterLayoutMixin<WebViewWidget> {
  bool _isCollected = false;
  var flutterWebViewPlugin;
  CollectionControlModel _collectionControl = new CollectionControlModel();

  @override
  void initState() {
    super.initState();
    _collectionControl.queryCollectStatus(widget.url).then((List list) {
      if (mounted) {
        setState(() {
          _isCollected = list.length > 0;
        });
      }
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    flutterWebViewPlugin = new FlutterWebviewPlugin();
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
//      print(" $url");
    });
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        title: widget.title,
        right: TitleBarRight(
            rightIcon: _collectedIcon(), onClickRight: _collection),
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

  Icon _collectedIcon() {
    if (_isCollected) {
      return Icon(Icons.favorite);
    } else {
      return Icon(Icons.favorite_border);
    }
  }

  _collection() {
    if (_isCollected) {
      // 删除操作
      _collectionControl.deleteByUrl(widget.url).then((result) {
        if (result > 0 && this.mounted) {
          setState(() {
            _isCollected = false;
          });
          WidgetUtils.showToast("取消收藏");
        }
      });
    } else {
      // 插入操作
      _collectionControl
          .insert(Collection(title: widget.title, url: widget.url).toJson())
          .then((result) {
        if (this.mounted) {
          setState(() {
            _isCollected = true;
          });
          WidgetUtils.showToast("收藏成功");
        }
      });
    }
    ApplicationEvent.getInstance().fire(CollectionEvent());
  }
}
