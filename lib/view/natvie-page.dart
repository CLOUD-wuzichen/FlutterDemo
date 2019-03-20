import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learn_flutter/color.dart';
import 'package:learn_flutter/utils/widget-utils.dart';
import 'package:learn_flutter/widget/custom_view.dart';
import 'package:native_plugin/native_plugin.dart';
import 'package:image_picker/image_picker.dart';


class NativePageWidget extends StatefulWidget {
  @override
  NativePageState createState() => new NativePageState();
}

class NativePageState extends State<NativePageWidget> {
  String text = "";
  File _image;

  Future _getStatusBarHeight() async {
    String height = await NativePlugin.getStatusBarHeight();
    if (!mounted) return;
    setState(() {
      text = height;
    });
  }

  Future _getBatteryLevel() async {
    String batteryLevel = await NativePlugin.getBatteryLevel();
    if (!mounted) return;
    setState(() {
      text = batteryLevel;
    });
  }

  void _pickImage() {
    showModalBottomSheet(context: context, builder: (BuildContext context){
      return Container(
          child: Column(
            mainAxisSize:MainAxisSize.min ,
            children: <Widget>[
              GestureDetector(
                onTap:(){
                  WidgetUtils.showToast("相机");
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 56,
                  alignment: Alignment.center,
                  child: TextLabel("相机", fontSize: 16),
                ),
              ),
              Container(height:1,color: Color(dividerColor),),
              GestureDetector(
                onTap: () async {
                  Navigator.of(context).pop();
                  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    _image = image;
                  });
                },
                child: Container(
                  height: 56,
                  alignment: Alignment.center,
                  child: TextLabel("图库", fontSize: 16),
                ),
              )

            ],
          ),
      );

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
                  onPressed: _pickImage,
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 50)),
            _image == null ? Text(text) : Image.file(_image),
          ],
        ));
  }
}
