import 'package:flutter/material.dart';

class RowList extends StatelessWidget {
  final listData = [
    {"id": 1, "title": "金证", "value": "+9.89"},
    {"id": 2, "title": "华为", "value": "+4.63"},
    {"id": 3, "title": "金微蓝", "value": "+10.00"},
    {"id": 4, "title": "阿里巴巴", "value": "+2.16"},
    {"id": 5, "title": "腾讯", "value": "+0.53"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ListView(
        primary: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            color: Colors.blue,
            width: 100,
            height: 100,
          ),
          Container(
            width: 100,
            color: Colors.green,
            height: 100,
          ),
          Container(
            color: Colors.blue,
            width: 100,
            height: 100,
          ),
          Container(
            width: 100,
            color: Colors.green,
            height: 100,
          ),
          Container(
            color: Colors.blue,
            width: 100,
            height: 100,
          ),
          Container(
            width: 100,
            color: Colors.green,
            height: 100,
          ),
          Container(
            color: Colors.blue,
            width: 100,
            height: 100,
          ),
          Container(
            width: 100,
            color: Colors.green,
            height: 100,
          ),
          Container(
            color: Colors.blue,
            width: 100,
            height: 100,
          ),
          Container(
            width: 100,
            color: Colors.green,
            height: 100,
          ),
        ],
      ),
    );


//    return Padding(
//      padding: EdgeInsets.only(top: 10),
//      child: Column(
//        children: <Widget>[
//          Container(
//            color: Colors.blue,
//            height: 40,
//          ),
//          Container(
//            color: Colors.green,
//            height: 40,
//          ),
//          ListView(
//            scrollDirection: Axis.horizontal,
//            children: <Widget>[
//              Container(
//                color: Colors.blue,
//                width: 40,
//                height: 40,
//              ),
//              Container(
//                width: 40,
//                color: Colors.green,
//                height: 40,
//              ),
//            ],
//          )
////          ListView.builder(
////            scrollDirection: Axis.vertical,
////            itemCount: listData.length,
////            itemBuilder: (BuildContext context, int index) {
////              return Container(
////                width: 50,
////                height: 50,
////                child: Text("}"),
////              );
////
//////                return Padding(
//////                  padding: EdgeInsets.only(left: 5, right: 5),
//////                  child: Card(
//////                    elevation: 2.0,
//////                    color: Colors.white,
//////                    child: Container(
//////                      width: 50,
//////                      height: 50,
//////                      child: Text("}"),
//////                    ),
//////                  ),
//////                );
////            },
////          ),
//        ],
//      ),
//    );
  }
}

class RowList2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RowList2State();
  }
}

class _RowList2State extends State<RowList2> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          color: Colors.blue,
          width: 40,
          height: 40,
        ),
        Container(
          width: 40,
          color: Colors.green,
          height: 40,
        ),
      ],
    );
  }
}
