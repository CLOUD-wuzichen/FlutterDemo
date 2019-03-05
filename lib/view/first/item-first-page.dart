import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/color.dart';
import 'package:learn_flutter/route/application.dart';
import 'package:learn_flutter/route/routers.dart';
import 'package:learn_flutter/view/first/banner-view.dart';
import 'package:learn_flutter/bean/first_page_bean.dart';
import 'package:learn_flutter/view/first/row-page.dart';

class ListViewItem extends StatelessWidget {
  static const type_head = "type_head";
  static const type_classify = "type_classify";
  static const type_list = "type_list";

  final List<PostData> banner = [
    PostData(
        "1",
        "https://ws1.sinaimg.cn/large/0065oQSqly1g0ajj4h6ndj30sg11xdmj.jpg",
        ""),
    PostData(
        "2",
        "https://ws1.sinaimg.cn/large/0065oQSqly1g04lsmmadlj31221vowz7.jpg",
        ""),
    PostData(
        "3",
        "https://ws1.sinaimg.cn/large/0065oQSqgy1fze94uew3jj30qo10cdka.jpg",
        ""),
    PostData(
        "4",
        "https://ws1.sinaimg.cn/large/0065oQSqly1fytdr77urlj30sg10najf.jpg",
        ""),
    PostData("5",
        "https://ws1.sinaimg.cn/large/0065oQSqly1fymj13tnjmj30r60zf79k.jpg", "")
  ];

  final item;
  ListViewItem(this.item);

  @override
  Widget build(BuildContext context) {
    if (item == type_head) {
      return HomeBanner(banner, 200.0);
    }
    if (item == type_list) {
      return RowList();
    }
    return GestureDetector(
      onTap: (){
        Application.router.navigateTo(context,
            '${Routes.webView}?title=${Uri.encodeComponent(item.title)}&url=${Uri.encodeComponent(item.detailUrl)}');
      },
      child: Card(
          color: Color(whiteColor),
          elevation: 3.0,
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Container(
            alignment: Alignment.centerLeft,
            height: 70,
            child: ListTile(
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 24.0,
                ),
                title: Text(
                  "${item.title}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color(textColor1), fontSize: 15),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    "${'👲'}:  ${item.username}",
                    style: TextStyle(
                      color: Color(textColor3),
                      fontSize: 12,
                    ),
                  ),
                )),
          )),
    );
  }
}
