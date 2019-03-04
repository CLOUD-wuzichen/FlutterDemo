import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/bean/RowListBean.dart';
import 'package:learn_flutter/color.dart';
import 'package:learn_flutter/test/custom_view.dart';
import 'package:learn_flutter/utils/DateUtils.dart';

class RowList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RowListState();
  }
}

class _RowListState extends State<RowList> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<Feed> feedList = [];
  int lastKey = 0;
  int id;
  int showType;
  ScrollController _scrollController = new ScrollController();

  void getData() async {
    Dio dio = new Dio();
    Response response = await dio
        .get('http://app3.qdaily.com/app3/columns/index/$id/$lastKey.json');
    RowResult result = RowResult.fromJson(response.data);
    if (!result.response.hasMore) {
      return;
    }
    setState(() {
      lastKey = result.response.lastKey;
      feedList.addAll(result.response.feeds);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    id = 31;
    showType = 1;
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (feedList == null || feedList.length == 0) {
      return Container();
    }
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(
          top: 10,
        ),
        height: 320,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            buildTitleWidget(feedList[0].post.column),
            buildList()
          ],
        ));
  }

  Widget buildTitleWidget(MyColumn column) {
    return Container(
        height: 50,
        padding: EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(column.icon),
              radius: 10,
            ),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: textLabel(column.name,
                    fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ));
  }

  Widget buildList() {
    return Flexible(
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 270,
              height: 270,
              decoration: new BoxDecoration(
                border: new Border.all(
                    width: 0.5, color: Color.fromARGB(50, 183, 187, 197)),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(
                      feedList[index].image,
                      fit: BoxFit.fitWidth,
                    ),
                    height: 140,
                    width: 270,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 8),
                      child: textLabel(
                        feedList[index].post.title,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        maxLines: 2,
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: textLabel(
                        feedList[index].post.description,
                        fontWeight: FontWeight.w500,
                        color: textColor3,
                        fontSize: 12,
                        maxLines: 2,
                      )),
                  Flexible(
                      child: Container(
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: textLabel(
                            "发布于${DateUtils.getNewsTimeStr(feedList[index].post.publishTime * 1000)}",
                            fontWeight: FontWeight.w500,
                            color: textColor3,
                            fontSize: 10,
                            maxLines: 2,
                          )))
                ],
              ),
            );
          },
          separatorBuilder: (context, idx) {
            return Container(
              width: 10,
              color: Colors.white,
            );
          },
          itemCount: feedList.length),
    );
  }
}
