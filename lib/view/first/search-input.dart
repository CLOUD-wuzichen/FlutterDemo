import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:learn_flutter/utils/widget-utils.dart';
import 'package:learn_flutter/widget/custom_view.dart';
import 'package:after_layout/after_layout.dart';
import 'package:learn_flutter/view/first/collection.dart';
import 'package:learn_flutter/widget/search-bar.dart';

class SearchPageWidget extends StatefulWidget {
  @override
  SearchPageState createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPageWidget>
    with AfterLayoutMixin<SearchPageWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchInputBar((String str){
        WidgetUtils.showToast(str);
      }),
    );
  }
}