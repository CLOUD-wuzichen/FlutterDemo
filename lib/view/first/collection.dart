import 'dart:async';

import 'package:learn_flutter/utils/provide.dart';

class Collection   {
  String title;
  String url;

  Collection({this.title, this.url});

  factory Collection.fromJSON(Map json) {
    return Collection(title: json['title'], url: json['url']);
  }
  Map<String, dynamic> toJson() {
    return {'title': title, 'url': url};
  }
}

class CollectionControlModel {
  static String tableName = 'T_Collection';
  static String createSql = "CREATE TABLE T_Collection (title TEXT NOT NULL, url TEXT NOT NULL PRIMARY KEY NOT NULL)";

  Sql sql;
  CollectionControlModel() {
    sql = Sql(tableName);
  }

  // 插入新收藏
  Future insert(Map<String, dynamic> json) {
    return sql.insert(json);
  }

  // 获取全部的收藏
  Future<List<Collection>> getAllCollection() async {
    List jsonList = await sql.getByCondition();
    List<Collection> resultList = [];
    jsonList.forEach((item) {
//      print(item);
      resultList.add(Collection.fromJSON(item));
    });
    return resultList;
  }

  Future<List>queryCollectStatus(String url) async {
    List list = await sql.getByCondition(conditions: {'url': url});
    return list;
  }

  // 删除
  Future deleteByUrl(String url) async {
    return await sql.delete(url, 'url');
  }
}
