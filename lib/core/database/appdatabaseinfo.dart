import 'package:Core/core/authentication/db/authen_provider.dart';
import 'package:Core/core/bao-tri/db/baotri_provider.dart';
import 'package:Core/core/config_json/db/config_json_provider.dart';
import 'package:Core/core/database/tables.dart';
import 'package:Core/core/notification/index.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/quoc_gia/db/quocgia_db.dart';
import 'package:sqflite/sqflite.dart';
import 'dbinfo.dart';
import 'imigrationtask.dart';

class AppDatabaseInfo implements DBInfo, IMigrationTask {
  static const String DATABASE_NAME = "Midas.db";
  static int DATABASE_VERSION = Variables.getVersionSqlite;

  @override
  String getDatabaseName() {
    return DATABASE_NAME;
  }

  @override
  int getDatabaseVersion() {
    return DATABASE_VERSION;
  }

  @override
  List<String> getTableCreationQueries() {
    return _generateCreationQueryList();
  }

  @override
  List<String> getTableNameList() {
    List<String> dbTableNameList = [];
    dbTableNameList.add(AuthenProvider.TABLE_NAME);
    dbTableNameList.add(BaoTriProvider.TABLE_NAME);
    dbTableNameList.add(QuocGiaDB.TABLE_NAME);
    dbTableNameList.add(NotificationCore.TABLE_NAME);
    dbTableNameList.add(ConfigJsonProvider.TABLE_NAME);
    return dbTableNameList;
  }

  @override
  Future<bool> onUpgrade(Database theDb, int oldVersion, int newVersion) async {
    List<String> dbDropList = _generateDropQueryList();
    List<String> dbSchemaQueryList = _generateCreationQueryList();

    for (var i = 0; i < dbDropList.length; i++) {
      theDb.execute(dbDropList[i]);
    }
    print('DB: table deleted');

    for (var i = 0; i < dbSchemaQueryList.length; i++) {
      await theDb.execute(dbSchemaQueryList[i]).then((onValue) {
        print('DB: new tables was create ${getTableNameList()[i]}');
      }).catchError((onError) {
        print('DB: new tables faile ${dbSchemaQueryList[i]}');
      });
    }
    print('DB: new tables created');

    return true;
  }

  List<String> _generateDropQueryList({List<String> exclude = const []}) {
    List<String> dbDropList = [];

    for (var i = 0; i < getTableNameList().length; i++) {
      if (exclude.indexOf(getTableNameList()[i]) == -1) {
        String query = "DROP TABLE IF EXISTS " + getTableNameList()[i];
        dbDropList.add(query);
      }
    }

    return dbDropList;
  }

  List<String> _generateCreationQueryList() {
    List<String> dbSchemaQueryList = [];

    dbSchemaQueryList.add(Tables.CRATE_TABLE_BAOTRI);
    dbSchemaQueryList.add(Tables.CRATE_TABLE_USER);
    dbSchemaQueryList.add(Tables.CREATE_TABLE_QUOCGIA);
    dbSchemaQueryList.add(Tables.CREATE_TABLE_NOTIFI);
    dbSchemaQueryList.add(Tables.CREATE_TABLE_DATAJSON);
    return dbSchemaQueryList;
  }

  @override
  IMigrationTask getMigrationTask() {
    return this;
  }

  @override
  Future<bool> clearExclude(
    Database theDb, {
    List<String> exclude = const [],
  }) async {
    // TODO: implement clearExclude

    try {
      List<String> dbDropList = _generateDropQueryList(exclude: exclude);

      for (var i = 0; i < dbDropList.length; i++) {
        await theDb.execute(dbDropList[i]);
        print('DB: table deleted ${dbDropList[i]}');
      }

      List<String> dbSchemaQueryList = _generateCreationQueryList();
      for (var i = 0; i < dbSchemaQueryList.length; i++) {
        await theDb.execute(dbSchemaQueryList[i]).then((onValue) {
          print('DB: new tables was create ${getTableNameList()[i]}');
        }).catchError((onError) {
          print('DB: new tables faile ${dbSchemaQueryList[i]}');
        });
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
