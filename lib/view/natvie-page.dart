import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learn_flutter/color.dart';
import 'package:learn_flutter/utils/permission-utils.dart';
import 'package:learn_flutter/utils/widget-utils.dart';
import 'package:learn_flutter/widget/custom_view.dart';
import 'package:native_plugin/native_plugin.dart';

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
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
                    int status = await PermissionUtils.checkPermission(
                        PermissionType.camera);
                    if (status == PermissionUtils.denied) {
                      WidgetUtils.showToast("获取权限失败");
                      return;
                    } else if (status == PermissionUtils.denied_forever) {
                      WidgetUtils.showToast("用户已拒绝相机权限，请去设置更改");
                      return;
                    }
                    String path = await NativePlugin.takePhoto();
                    setState(() {
                      _image = File(path);
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: TextLabel("相机", fontSize: 16),
                  ),
                ),
                Container(
                  height: 1,
                  color: Color(dividerColor),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
                    String path = await NativePlugin.pickPhoto();
                    setState(() {
                      _image = File(path);
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    color: Colors.white,
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
            Text(text),
            _image == null
                ? Text("")
                : Image.file(
                    _image,
                    width: 250,
                    height: 250,
                  ),
          ],
        ));
  }
}
