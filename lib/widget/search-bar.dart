import 'package:flutter/material.dart';
import 'package:learn_flutter/color.dart';
import 'package:learn_flutter/route/application.dart';
import 'package:learn_flutter/route/routers.dart';
import 'package:learn_flutter/utils/utils.dart';
import 'package:learn_flutter/widget/custom_view.dart';

////搜索标题bar start
class SearchTitleBar extends StatefulWidget {
  final ScrollListenable _listenable;
  SearchTitleBar(this._listenable);
  @override
  SearchTitleState createState() => new SearchTitleState();
}

class SearchTitleState extends State<SearchTitleBar> {
  int _alpha = 0;
  @override
  void initState() {
    super.initState();
    widget._listenable.addListener((value) {
      if (!mounted) return;
      setState(() {
        double percent;
        if (value <= 200) {
          percent = value / 200;
        } else {
          percent = 1;
        }
        this._alpha = (percent * 255).round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Color.fromARGB(_alpha, 255, 255, 255),
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          Application.router.navigateTo(context, Routes.search);
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: 32,
          margin: EdgeInsets.only(left: 50, right: 50),
          decoration: BoxDecoration(
              color: Colors.white70, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: <Widget>[
              Padding(
                padding: new EdgeInsets.only(right: 8.0, left: 14.0),
                child: new Icon(
                  Icons.search,
                  size: 20.0,
                  color: Color(textColor3),
                ),
              ),
              TextLabel("搜索",
                  color: textColor3, fontWeight: FontWeight.w500, fontSize: 14),
            ],
          ),
        ),
      ),
    );
  }
}
////搜索标题bar end

////搜索输入bar start
class SearchInputBar extends StatefulWidget implements PreferredSizeWidget {
  final SearchCallback _callback;
  SearchInputBar(this._callback);

  @override
  SearchInputState createState() => new SearchInputState();

  @override
  Size get preferredSize => Size.fromHeight(45.5);
}

class SearchInputState extends State<SearchInputBar> {
  bool hideDelete = true;
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (!mounted) return;
      setState(() {
        hideDelete = controller.value.text.length <= 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          color: Color(whiteColor),
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 50, right: 50),
                    child: TextField(
                      controller: controller,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (str) {
                        controller.clear();
                        widget._callback(str);
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.search,
                          size: 22.0,
                          color: Color(textColor3),
                        ),
                        border: InputBorder.none,
                        hintText: "搜索",
                      ),
                      maxLines: 1,
                    )),
              ),
              buildBackWidget(context),
              buildRightWidget(),
            ],
          ),
        ),
        Container(
          color: Color(dividerColor),
          height: 0.5,
        )
      ]),
    );
  }

  Widget buildBackWidget(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
            height: 45,
            width: 50,
            alignment: Alignment.center,
            child: SizedBox.fromSize(
              size: Size(23, 23),
              child: Image.asset("assets/ic_back.png"),
            )));
  }

  Widget buildRightWidget() {
    return GestureDetector(
        onTap: () {
          controller.clear();
        },
        child: Offstage(
          offstage: hideDelete,
          child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 45,
                width: 50,
                alignment: Alignment.center,
                child: Icon(
                  Icons.close,
                  size: 26,
                ),
              )),
        ));
  }
}
////搜索输入bar end
