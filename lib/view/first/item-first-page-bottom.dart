import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageBottom extends StatelessWidget {
  final bool _hasMore;
  const HomePageBottom(this._hasMore);

  @override
  Widget build(BuildContext context) {
    if (_hasMore) {
      return Container(
          alignment: Alignment.center,
          height: 50,
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ));
    } else {
      return Container(
          alignment: Alignment.center,
          height: 40,
          child: Text("没有更多了~",
              style: TextStyle(color: Colors.grey, fontSize: 14)));
    }
  }
}
