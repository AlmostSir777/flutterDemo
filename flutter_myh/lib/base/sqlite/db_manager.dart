import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'db_base_bean.dart';

export 'db_base_bean.dart';

class DbManager {
  static const String UserInfoTable = 'UserInfo';

  DbManager._();

  // 数据库路径
  String databasesPath;
  // 数据库
  Database database;
  // 数据库版本
  int dbVersion = 1;
  static DbManager dbManager;

  static DbManager instance() {
    if (null == dbManager) {
      dbManager = DbManager._();
    }
    return dbManager;
  }

  Future openDb(String dbName) async {
    if (null == databasesPath || databasesPath.isEmpty) {
      databasesPath = await getDatabasesPath();
    }
    // 存在先关闭
    await closeDb();

    database = await openDatabase(join(databasesPath, dbName + '.db'),
        version: dbVersion, onCreate: (db, version) async {
      // 用户表
      await db.execute(
          'CREATE TABLE UserInfo (userId TEXT PRIMARY KEY, nickName TEXT, headImgUrl TEXT, phone TEXT)');
    }, onUpgrade: (db, oldversion, newVersion) {
      // 版本更新可能牵扯到重新插入表、删除表、表中字段变更-具体更新相关sql语句进行操作
    });
  }

  // 插入数据
  Future<void> insertItem<T extends DbBaseBean>(T t) async {
    if (null == database || !database.isOpen) return;

    print('开始插入数据：${t.toJson()}');
    await database.insert(
      t.getTableName(),
      t.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 删除数据
  Future<void> deleteItem<T extends DbBaseBean>(T t,
      {String key, String value}) async {
    if (null == database || !database.isOpen) return null;

    // 删除表
    if ((key == null || key.isEmpty) || (value == null || value.isEmpty)) {
      await database.delete(t.getTableName());
    } else {
      // 删除数据
      await database.delete(
        t.getTableName(),
        where: (key + " = ?"),
        whereArgs: [value],
      );
    }
  }

  /// 更新数据
  Future<void> updateItem<T extends DbBaseBean>(
      T t, String key, String value) async {
    if (null == database || !database.isOpen) return null;

    // 更新数据
    await database.update(
      t.getTableName(),
      t.toJson(),
      where: (key + " = ?"),
      whereArgs: [value],
    );
  }

  // 查询数据
  Future<List<T>> queryItems<T extends DbBaseBean>(T t,
      {String key = "", String value = ""}) async {
    if (null == database || !database.isOpen) return null;

    List<Map<String, dynamic>> maps = List();

    // 列表数据
    if ((key == null || key.isEmpty) || (value == null || value.isEmpty)) {
      maps = await database.query(t.getTableName());
    } else {
      maps = await database.query(
        t.getTableName(),
        where: (key + " = ?"),
        whereArgs: [value],
      );
    }

    // map转换为List集合
    return List.generate(maps.length, (i) {
      return t.fromJson(maps[i]);
    });
  }

  // 关闭db
  closeDb() async {
    if (database == null) return;
    if (database != null || (database.isOpen)) {
      await database.close();
      database = null;
    }
  }

  /// 删除数据库
  deleteDb(String dbName) async {
    // 如果数据库路径不存在，赋值
    if (null == databasesPath || databasesPath.isEmpty)
      databasesPath = await getDatabasesPath();

    await deleteDatabase(join(databasesPath, dbName + '.db'));
  }
}
