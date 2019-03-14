import 'dart:async';

import 'package:learn_flutter/utils/provide.dart';

class Search {
  String title;

  Search({this.title});

  factory Search.fromJSON(Map json) {
    return Search(title: json['title']);
  }
  Map<String, dynamic> toJson() {
    return {'title': title};
  }
}

class SearchControlModel {
  static String tableName = 'T_Search';
  static String createSql =
      "CREATE TABLE T_Search (title TEXT PRIMARY KEY NOT NULL UNIQUE)";

  Sql sql;
  SearchControlModel() {
    sql = Sql(tableName);
  }

  // 插入新收藏
  Future insert(Map<String, dynamic> json) {
    return sql.insert(json);
  }

  // 获取全部
  Future<List<Search>> getAll() async {
    List jsonList = await sql.getByCondition();
    List<Search> resultList = [];
    jsonList.forEach((item) {
      resultList.add(Search.fromJSON(item));
    });
    return resultList;
  }

  // 删除
  Future delete(String title) async {
    return await sql.delete(title, 'title');
  }

  // 删除所有
  Future deleteAll() async {
    return await sql.deleteAll();
  }

  //
  Future queryByTitle(String title) async {
    return await sql.getByCondition(conditions: {'title': title});
  }

}
