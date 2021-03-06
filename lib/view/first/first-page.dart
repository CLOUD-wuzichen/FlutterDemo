import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/bean/first_page_bean.dart';
import 'package:learn_flutter/color.dart';
import 'package:learn_flutter/utils/net_utils.dart';
import 'package:learn_flutter/utils/utils.dart';
import 'package:learn_flutter/view/first/item-first-page-bottom.dart';
import 'package:learn_flutter/view/first/item-first-page.dart';
import 'package:after_layout/after_layout.dart';
import 'package:learn_flutter/widget/search-bar.dart';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstPageState();
  }
}

class _FirstPageState extends State<FirstPage>
    with AutomaticKeepAliveClientMixin, AfterLayoutMixin<FirstPage> {
  ScrollController _scrollController = new ScrollController();
  CustomScrollController _customScrollController = new CustomScrollController();

  List items = new List();
  int _pageIndex = 0;
  int _pageTotal = 0;
  bool _hasMore = true;
  bool isLoading = false;
  bool firstLoad = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _getMoreData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
      _customScrollController.notify(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
        bottom: false,
        child: RefreshIndicator(
            onRefresh: _refresh,
            child: Stack(
              children: <Widget>[
                Container(
                  color: Color(backgroundColor),
                  child: ListView.separated(
                      physics: new AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == items.length) {
                          return HomePageBottom(_hasMore);
                        } else {
                          return ListViewItem(items[index]);
                        }
                      },
                      separatorBuilder: (context, idx) {
                        return Container(
                          height: idx == 0 ? 6 : 10,
                        );
                      },
                      itemCount: items.length + 1),
                ),
                SearchTitleBar(_customScrollController),
              ],
            )));
  }

  Future<Null> _refresh() async {
    _pageIndex = 0;
    List data = await httpRequest();
    if (this.mounted) {
      setState(() {
        items.clear();
        addMultipleType();
        items.addAll(data);
        isLoading = false;
        _hasMore = true;
        return null;
      });
    }
  }

  Future _getMoreData() async {
    if (!isLoading && _hasMore) {
      if (mounted) {
        setState(() => isLoading = true);
      }
      List newEntries = await httpRequest();
      _hasMore = (_pageIndex <= _pageTotal);
      if (this.mounted) {
        setState(() {
          if (firstLoad) {
            addMultipleType();
            firstLoad = !firstLoad;
          }
          items.addAll(newEntries);
          isLoading = false;
        });
      }
    } else if (!isLoading && !_hasMore) {
      _pageIndex = 0;
    }
  }

  void addMultipleType() {
    items.add(ListViewItem.type_head);
    items.add(ListViewItem.type_list);
  }

  Future<List> httpRequest() async {
    final listObj = await requestApi(params: {'pageIndex': _pageIndex});
    _pageIndex = listObj['pageIndex'];
    _pageTotal = listObj['total'];
    return listObj['list'];
  }

  Future<Map> requestApi({Map<String, dynamic> params}) async {
    const url =
        'https://timeline-merger-ms.juejin.im/v1/get_tag_entry?src=web&tagId=5a96291f6fb9a0535b535438';
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    final _param = {'page': pageIndex, 'pageSize': 20, 'sort': 'rankIndex'};
    var responseList = [];
    var pageTotal = 0;

    try {
      var response = await NetUtils.get(url, params: _param);
      responseList = response['d']['entrylist'];
      pageTotal = response['d']['total'];
      if (!(pageTotal is int) || pageTotal <= 0) {
        pageTotal = 0;
      }
    } catch (e) {
      print("$e");
    }
    pageIndex += 1;
    List resultList = new List();
    for (int i = 0; i < responseList.length; i++) {
      try {
        FirstPageBean cellData = new FirstPageBean.fromJson(responseList[i]);
        resultList.add(cellData);
      } catch (e) {
        // No specified type, handles all
      }
    }
    Map<String, dynamic> result = {
      "list": resultList,
      'total': pageTotal,
      'pageIndex': pageIndex
    };
    return result;
  }
}
