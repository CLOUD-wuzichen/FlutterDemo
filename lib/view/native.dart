import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/test/custom_view.dart';
import 'package:learn_flutter/utils/native_utils.dart';

class NativeWidget extends StatefulWidget {
  @override
  NativeState createState() => new NativeState();
}

class NativeState extends State<NativeWidget> {
  String _height = "";
  String _batteryLevel = "";

  Future<void> _getBatteryLevel() async {
    String batteryLevel = await NativePlugin.getBatteryLevel();
    if (!mounted) return;
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _getStatusBarHeight() async {
    String height = await NativePlugin.getStatusBarHeight();
    if (!mounted) return;
    setState(() {
      _height = height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TitleBar(
          title: "test",
          onBack: () {
            Navigator.of(context).pop();
          },
        ),
        body: new Center(
          child: new Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 100)),
              RaisedButton(
                child: new Text('status bar heigh: $_height'),
                onPressed: _getStatusBarHeight,
              ),
              RaisedButton(
                child: Text('battery level: $_batteryLevel'),
                onPressed: _getBatteryLevel,
              ),
            ],
          ),
        ));
  }
}
