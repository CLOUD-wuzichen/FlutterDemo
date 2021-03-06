import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/route/application.dart';
import 'package:learn_flutter/route/routers.dart';
import 'package:learn_flutter/test/layout.dart';

class FourthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FourthPageState();
  }
}

class _FourthPageState extends State<FourthPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Material(
      child: new Center(
        child: new Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 100)),
            RaisedButton(
              child: new Text('原生'),
              onPressed: () {
                Application.router.navigateTo(context, Routes.native);
              },
            ),
          ],
        ),
      ),
    );
  }
}
