import 'dart:async';
import 'dart:io' as io;
import 'package:Midas/utils/notification_util.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class BadgeHelper {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "notification.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE badge_setting (id TEXT PRIMARY KEY, name TEXT, count INTEGER)");
    await db.execute(
        "CREATE TABLE notifi_setting (key TEXT PRIMARY KEY, value BOOLEAN)");
    // Insert some records in a transaction
    await db.transaction((txn) async {
      NotificationUtil.list_page_notification.forEach((key, data) {
        txn.rawInsert(
            'INSERT INTO badge_setting(id, name, count) VALUES(?,?,?)',
            [int.tryParse(key), data["name"], 0]);
      });
    });
    await db.transaction((txn) async {
      NotificationUtil.list_topic_notification.forEach((key, data) {
        txn.rawInsert('INSERT INTO notifi_setting(key, value) VALUES(?,?)',
            [data["key"], data["value"]]);
      });
    });
  }

  Future<List<dynamic>> getBadge(id) async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery('SELECT id,name,count FROM badge_setting WHERE id = ?', [id]);
    List badge = list.toList();
//    FlutterAppBadger.updateBadgeCount(badge[0]['count']);
    return badge;
  }

  Future increaseBadge(id) async {
    var dbClient = await db;
    List<Map> list =
        await dbClient.rawQuery('SELECT id,name,count FROM badge_setting');
    List badge = list.toList();
//    FlutterAppBadger.updateBadgeCount(badge[0]['count'] + 1);
    return await dbClient.rawQuery(
        'UPDATE badge_setting SET count = count + 1 WHERE id = ?', [id]);
  }

  Future removeBadge(id) async {
    var dbClient = await db;
    // List<Map> list = await dbClient.rawQuery('SELECT id,name,count FROM badge_setting');
    // List badge = list.toList();
    // FlutterAppBadger.updateBadgeCount(badge[0]['count'] == 0 ? 0 : badge[0]['count']-1);
    // return await dbClient.rawQuery('UPDATE badge_setting SET count = CASE WHEN count > 0 THEN count - 1 ELSE 0  END WHERE id = ?', [id]);
//    FlutterAppBadger.updateBadgeCount(0);
    return await dbClient
        .rawQuery('UPDATE badge_setting SET count = 0 WHERE id = ?', [id]);
  }

  Future updateConfigNotifi(String key, bool value) async {
    try {
      var dbClient = await db;
      return await dbClient.rawQuery(
          'UPDATE notifi_setting SET value = ? WHERE key = ?', [value, key]);
    } catch (ex) {}
  }

  //use for logout
  Future resetConfigNotifi() async {
    try {
      var dbClient = await db;
      return await dbClient.rawQuery('UPDATE notifi_setting SET value = ? ',
          [NotificationUtil.configStateDefault]);
    } catch (ex) {}
  }

  Future getStateWithKey(String key) async {
    try {
      var dbClient = await db;
      List<Map> list = await dbClient.rawQuery(
          'SELECT key,value FROM notifi_setting WHERE key = ? ', [key]);
      if (list.isNotEmpty) {
        bool result = list.toList().first['value'];
        return result;
      } else {
        return false;
      }
    } catch (ex) {
      return false;
    }
  }
}
