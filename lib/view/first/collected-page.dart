import 'package:flutter/material.dart';
import 'package:learn_flutter/color.dart';
import 'package:learn_flutter/route/application.dart';
import 'package:learn_flutter/route/routers.dart';
import 'package:learn_flutter/view/first/sql-collection.dart';
import 'package:learn_flutter/widget/custom_view.dart';

class CollectedPage extends StatefulWidget {
  @override
  CollectedPageState createState() => new CollectedPageState();
}

class CollectedPageState extends State<CollectedPage> {
  CollectionControlModel _collectionControl = new CollectionControlModel();
  List _data = [];

  @override
  void initState() {
    super.initState();
    _collectionControl.getAllCollection().then((List list) {
      if (mounted) {
        setState(() {
          _data = list;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TitleBar(
          title: "我的收藏",
          onBack: () {
            Navigator.of(context).pop();
          },
        ),
        body: Container(
          color: Color(backgroundColor),
          child: ListView.separated(
              physics: new AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Application.router.navigateTo(context,
                        '${Routes.webView}?title=${Uri.encodeComponent(_data[index].title)}&url=${Uri.encodeComponent(_data[index].url)}');
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 12, right: 12),
                    height: 60,
                    child: TextLabel(_data[index].title,
                        fontSize: 15, maxLines: 1),
                  ),
                );
              },
              separatorBuilder: (context, idx) {
                return Container(
                  height: 1,
                  color: Color(dividerColor),
                );
              },
              itemCount: _data.length),
        ));
  }
}
