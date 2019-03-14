import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:learn_flutter/color.dart';
import 'package:learn_flutter/utils/widget-utils.dart';
import 'package:learn_flutter/view/first/sql-search.dart';
import 'package:learn_flutter/widget/custom_view.dart';
import 'package:after_layout/after_layout.dart';
import 'package:learn_flutter/view/first/sql-collection.dart';
import 'package:learn_flutter/widget/search-bar.dart';

class SearchPageWidget extends StatefulWidget {
  @override
  SearchPageState createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPageWidget>
    with AfterLayoutMixin<SearchPageWidget> {
  SearchControlModel _searchControlModel = new SearchControlModel();
  List list = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    querySql();
  }

  void querySql() {
    _searchControlModel.getAll().then((List<Search> list) {
      if (!mounted) return;
      if (list == null) return;
      this.list.clear();
      setState(() {
        list.forEach((search) {
          this.list.add(search.title);
        });
        this.list = this.list.reversed.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchInputBar((String title) {
        _searchControlModel.queryByTitle(title).then((list) {
          if (list != null && list.length >= 0) {
            //重复 先删除
            _searchControlModel.delete(title);
          }
          _searchControlModel.insert(Search(title: title).toJson()); //重新插入 更新顺序
          querySql();
        });
      }),
      body: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(12, 12, 0, 0),
              child: TextLabel("热门搜索", fontSize: 14, color: textColor2)),
          Container(
            padding: EdgeInsets.only(left: 12, top: 8),
            alignment: Alignment.topLeft,
            child:
                Wrap(spacing: 10.0, runSpacing: 0.0, children: buildHotChip()),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(12, 12, 0, 0),
              child: Row(
                children: <Widget>[
                  TextLabel("历史搜索", fontSize: 14, color: textColor2),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(right: 12),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        _searchControlModel.deleteAll();
                        querySql();
                      },
                      child: Icon(
                        Icons.delete_outline,
                        size: 26,
                        color: Color(textColor2),
                      ),
                    ),
                  ))
                ],
              )),
          Container(
            padding: EdgeInsets.only(left: 12, top: 8),
            alignment: Alignment.topLeft,
            child: Wrap(
                spacing: 10.0, runSpacing: 0.0, children: buildHistoryChip()),
          ),
        ],
      ),
    );
  }

  List<Widget> buildHotChip() {
    List<Widget> childList = [];
    List list = ["千人千面", "UGC", "智能场景", "定制化", "大数据分析"];
    list.forEach((str) {
      childList.add(Chip(
        label: TextLabel(str, fontSize: 14, color: textColor2),
        padding: EdgeInsets.all(4),
      ));
    });
    return childList;
  }

  List<Widget> buildHistoryChip() {
    List<Widget> childList = [];
    list.forEach((str) {
      childList.add(Chip(
        label: TextLabel(str, fontSize: 14, color: textColor2),
        padding: EdgeInsets.all(4),
      ));
    });
    return childList;
  }
}
