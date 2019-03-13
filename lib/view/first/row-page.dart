import 'package:flutter/material.dart';
import 'package:learn_flutter/bean/RowListBean.dart';
import 'package:learn_flutter/color.dart';
import 'package:learn_flutter/utils/dateUtils.dart';
import 'package:learn_flutter/utils/net_utils.dart';
import 'package:learn_flutter/widget/custom_view.dart';

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
    RowResult result =  RowResult.fromJson(await NetUtils.get('http://app3.qdaily.com/app3/columns/index/$id/$lastKey.json'));
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
        height: 310,
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
                child: TextLabel(column.name,
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
                      child: TextLabel(
                        feedList[index].post.title,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        maxLines: 2,
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: TextLabel(
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/ic_comment.png",
                                      fit: BoxFit.fitHeight,
                                      width: 12,
                                    ),
                                    Padding(padding: EdgeInsets.only(right: 2)),
                                    TextLabel(
                                      " ${feedList[index].post.commentCount} ",
                                      color: textColor3,
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(right: 4)),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/ic_star.png",
                                      fit: BoxFit.fitHeight,
                                      width: 12,
                                    ),
                                    Padding(padding: EdgeInsets.only(right: 2)),
                                    TextLabel(
                                      "${feedList[index].post.praiseCount}",
                                      color: textColor3,
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(right: 8)),
                              Container(
                                child: TextLabel(
                                  DateUtils.getNewsTimeStr(
                                      feedList[index].post.publishTime * 1000),
                                  color: textColor3,
                                  fontSize: 12,
                                ),
                              ),
                            ],
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
