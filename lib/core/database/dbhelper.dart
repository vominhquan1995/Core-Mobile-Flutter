import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appdatabaseinfo.dart';
import 'dbinfo.dart';

class DBHelper {
  static const String DB_VERSION = "db_version";

  DBInfo dbInfo;

  Database _db;

  DBHelper._privateConstructor();

  static final DBHelper dbHelper = DBHelper._privateConstructor();

  Database getDatabase() {
    return _db;
  }

  Future<bool> init(DBInfo dbInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int oldVersion = prefs.getInt(DB_VERSION) ?? 0;

    if (AppDatabaseInfo.DATABASE_VERSION != oldVersion) {
      await prefs.setInt(DB_VERSION, AppDatabaseInfo.DATABASE_VERSION);

      // upgrade db on version increased
      print('''
          upgrade db on version increased 
          oldVersion: $oldVersion , 
          newVersion: ${AppDatabaseInfo.DATABASE_VERSION}
          ''');
      return await dbInfo.getMigrationTask().onUpgrade(
          getDatabase(), oldVersion, AppDatabaseInfo.DATABASE_VERSION);
    } else {
      print('''
          No change in db 
          oldVersion: $oldVersion , 
          newVersion: ${AppDatabaseInfo.DATABASE_VERSION}
          ''');
      return true;
    }
  }

  Future openDB() async {
    Directory userDirectory = await getApplicationDocumentsDirectory();
    String path = join(userDirectory.path, AppDatabaseInfo.DATABASE_NAME);
    try {
      _db = await openDatabase(path, version: AppDatabaseInfo.DATABASE_VERSION);
    } catch (e) {
      print('Error while tring to open db: ' + e.toString());
    }
  }

  Future<bool> clearExclude(DBInfo dbInfo, {List<String> exclude = const []}) {
    return dbInfo.getMigrationTask().clearExclude(_db, exclude: exclude);
  }

  Future close() async => _db?.close();
}
