import 'dart:convert';

import 'package:Midas/core/config_json/models/config_json.dart';
import 'package:Midas/core/database/base_db_provider.dart';
import 'package:Midas/core/database/dbhelper.dart';

const String columnDataConfig = "data";

class ConfigJsonProvider extends BaseProvider<String> {
  static const String TABLE_NAME = "configs";
  @override
  Future<bool> delete() async {
    try {
      await DBHelper.dbHelper.getDatabase().delete(TABLE_NAME);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> insert(String data) async {
    try {
      Map<String, dynamic> dataMap = Map();
      dataMap.addAll({
        "data": data,
      });
      await DBHelper.dbHelper.getDatabase().delete(TABLE_NAME);

      await DBHelper.dbHelper.getDatabase().insert(TABLE_NAME, dataMap);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> select() async {
    try {
      var res = await DBHelper.dbHelper.getDatabase().query(TABLE_NAME);
      return null;
      // return res.isEmpty ? null : ConfigJson.fromJson(res.first);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> update() {
    return null;
  }

  void updateDataJson(String newDataJson) {
    try {
      Map<String, dynamic> _p = Map();
      _p.addAll({
        "data": newDataJson,
      });
      DBHelper.dbHelper.getDatabase().update(TABLE_NAME, _p);
    } catch (e) {}
  }

  Future<bool> isExistConfig() async {
    try {
      var res = await DBHelper.dbHelper
          .getDatabase()
          .query(TABLE_NAME, columns: [columnDataConfig]);
      return res.isEmpty ? false : true;
    } catch (e) {
      return false;
    }
  }

  Future<ConfigJson> getDataJsonLocal(String locate, String lang) async {
    try {
      var res = await DBHelper.dbHelper
          .getDatabase()
          .query(TABLE_NAME, columns: [columnDataConfig]);
      if (res.isEmpty) return null;
      var dataJson =
          jsonDecode(res.first['data'].toString()) as Map<String, dynamic>;
      var dataByLocate = dataJson[locate];
      var dataByLang = dataByLocate[lang];
      return ConfigJson.fromJson(dataByLang) ?? null;
    } catch (e) {
      return null;
    }
  }

  ConfigJson mapJsonStringToModel(
      String jsonString, String locate, String lang) {
    try {
      var dataJson = jsonDecode(jsonString) as Map<String, dynamic>;
      var dataByLocate = dataJson[locate];
      var dataByLang = dataByLocate[lang];
      return ConfigJson.fromJson(dataByLang) ?? null;
    } catch (e) {
      return null;
    }
  }
}

const String TABLE_DATAJSON =
    "CREATE TABLE IF NOT EXISTS ${ConfigJsonProvider.TABLE_NAME} (" +
        "${columnDataConfig} TEXT" +
        ")";
