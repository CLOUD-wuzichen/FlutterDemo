import 'package:learn_flutter/view/first/collection.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Provider {
  static Database db;

  Future init() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'flutter.db');
    print(path);
    try {
      db = await openDatabase(path);
    } catch (e) {
      print("Error $e");
    }
    bool tableIsRight = await this.checkTableIsRight();

    if (!tableIsRight) {
      // 关闭上面打开的db，否则无法执行open
      db.close();
      // Delete the database
      await deleteDatabase(path);

      db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(CollectionControlModel.createSql);
        print('db created version is $version');
      }, onOpen: (Database db) async {
        print('db opened');
      });
    } else {
      print("Opening existing database");
    }
  }

  // 检查数据库中, 表是否完整, 在部份android中, 会出现表丢失的情况
  Future checkTableIsRight() async {
    List<String> expectTables = [CollectionControlModel.tableName];
    List<String> tables = await getTables();
    for (int i = 0; i < expectTables.length; i++) {
      if (!tables.contains(expectTables[i])) {
        return false;
      }
    }
    return true;
  }

  // 获取数据库中所有的表
  Future<List> getTables() async {
    if (db == null) {
      return Future.value([]);
    }
    List tables = await db
        .rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    List<String> targetList = [];
    tables.forEach((item) {
      targetList.add(item['name']);
    });
    return targetList;
  }
}

class Sql {
  final String tableName;

  Sql(this.tableName);

  Future<List> get() async {
    return await Provider.db.query(tableName);
  }

  String getTableName() {
    return tableName;
  }

  Future<Map<String, dynamic>> insert(Map<String, dynamic> json) async {
    var id = await Provider.db.insert(tableName, json);
    json['id'] = id;
    return json;
  }

  Future<int> delete(String value, String key) async {
    return await Provider.db
        .delete(tableName, where: '$key = ?', whereArgs: [value]);
  }

  Future<List> getByCondition({Map<dynamic, dynamic> conditions}) async {
    if (conditions == null || conditions.isEmpty) {
      return this.get();
    }
    String stringConditions = '';

    int index = 0;
    conditions.forEach((key, value) {
      if (value == null) {
        return;
      }
      if (value.runtimeType == String) {
        stringConditions = '$stringConditions $key = "$value"';
      }
      if (value.runtimeType == int) {
        stringConditions = '$stringConditions $key = $value';
      }

      if (index >= 0 && index < conditions.length - 1) {
        stringConditions = '$stringConditions and';
      }
      index++;
    });
    return await Provider.db.query(tableName, where: stringConditions);
  }

  Future<List> search(
      {Map<String, dynamic> conditions, String mods = 'Or'}) async {
    if (conditions == null || conditions.isEmpty) {
      return this.get();
    }
    String stringConditions = '';
    int index = 0;
    conditions.forEach((key, value) {
      if (value == null) {
        return;
      }

      if (value.runtimeType == String) {
        stringConditions = '$stringConditions $key like "%$value%"';
      }
      if (value.runtimeType == int) {
        stringConditions = '$stringConditions $key = "%$value%"';
      }

      if (index >= 0 && index < conditions.length - 1) {
        stringConditions = '$stringConditions $mods';
      }
      index++;
    });
    return await Provider.db.query(tableName, where: stringConditions);
  }
}
