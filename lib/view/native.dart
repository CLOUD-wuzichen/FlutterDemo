import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/widget/custom_view.dart';
import 'package:native_plugin/native_plugin.dart';

class NativeWidget extends StatefulWidget {
  @override
  NativeState createState() => new NativeState();
}

class NativeState extends State<NativeWidget> {
  String text = "";
  File _image;

  Future<void> _getBatteryLevel() async {
    String batteryLevel = await NativePlugin.getBatteryLevel();
    if (!mounted) return;
    setState(() {
      text = batteryLevel;
    });
  }

  Future<void> _getStatusBarHeight() async {
    String height = await NativePlugin.getStatusBarHeight();
    if (!mounted) return;
    setState(() {
      text = height;
    });
  }

  Future<void> _getImage() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//    setState(() {
//      _image = image;
//    });
  }

  Future<void> _getDeviece() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TitleBar(
          title: "test",
          onBack: () {
            Navigator.of(context).pop();
          },
        ),
        body: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              children: [
                RaisedButton(
                  child: new Text('状态栏高度'),
                  onPressed: _getStatusBarHeight,
                ),
                RaisedButton(
                  child: Text('电池电量'),
                  onPressed: _getBatteryLevel,
                ),
                RaisedButton(
                  child: Text('选择照片'),
                  onPressed: _getImage,
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 50)),
            _image == null ? Text(text) : Image.file(_image),
          ],
        ));
  }
}
