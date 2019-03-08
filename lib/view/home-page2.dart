import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/color.dart';
import 'package:learn_flutter/route/application.dart';
import 'package:learn_flutter/test/layout.dart';
import 'package:learn_flutter/view/Third-page.dart';
import 'package:learn_flutter/view/first/first-page.dart';
import 'package:learn_flutter/view/fourth-page.dart';
import 'package:learn_flutter/view/second-page.dart';

class AppPage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<AppPage2>
    with SingleTickerProviderStateMixin {
  TabController controller;

  static List tabData = [
    {'text': '业界动态', 'icon': new Icon(Icons.language)},
    {'text': 'WIDGET', 'icon': new Icon(Icons.extension)},
    {'text': '组件收藏', 'icon': new Icon(Icons.favorite)},
    {'text': '关于手册', 'icon': new Icon(Icons.import_contacts)}
  ];

  List<Widget> myTabs = [];
  @override
  void initState() {
    super.initState();
    controller = new TabController(
        initialIndex: 0, vsync: this, length: 4); // 这里的length 决定有多少个底导 submenus
    for (int i = 0; i < tabData.length; i++) {
      myTabs.add(new Tab(text: tabData[i]['text'], icon: tabData[i]['icon']));
    }
    controller.addListener(() {
      if (controller.indexIsChanging) {
        _onTabChange();
      }
    });
    Application.controller = controller;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          FirstPage(),
          SecondPage(),
          ThirdPage(),
          FourthPage(),
        ],
      ),
      bottomNavigationBar: Material(
        color: const Color(0xFFF0EEEF), //底部导航栏主题颜色
        child: SafeArea(
          child: Container(
            height: 65.0,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFFd0d0d0),
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                  offset: Offset(-1.0, -1.0),
                ),
              ],
            ),
            child: TabBar(
                controller: controller,
                indicatorColor: Theme.of(context).primaryColor,
                //tab标签的下划线颜色
                // labelColor: const Color(0xFF000000),
                indicatorWeight: 3.0,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: const Color(0xFF8E8E8E),
                tabs: myTabs),
          ),
        ),
      ),
    );
  }

  String appBarTitle = tabData[0]['text'];
  void _onTabChange() {
    if (this.mounted) {
      this.setState(() {
        appBarTitle = tabData[controller.index]['text'];
      });
    }
  }
}
