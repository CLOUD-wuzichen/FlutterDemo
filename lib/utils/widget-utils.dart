import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WidgetUtils {
  static  showToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
