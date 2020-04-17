import 'package:equatable/equatable.dart';
import 'package:Midas/core/database/dbhelper.dart';

const TAG = 'NOFITICATION_PROVIDER: ';

class NotifiProvider {
  static const String TABLE_NAME = "notification";
  static const String KEY_TOKEN_LAST = "TokenLast";
  static const String KEY_TOKEN_NEW = "TokenNew";
  Future<String> getTokenLocal(String key) async {
    try {
      var res = await DBHelper.dbHelper
          .getDatabase()
          .query(TABLE_NAME, where: 'key = ?', whereArgs: [key]);
      return res.isEmpty ? null : res.first['value'];
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateWithKey(String key, String value) async {
    try {
      //check exist
      var res = await DBHelper.dbHelper
          .getDatabase()
          .query(TABLE_NAME, where: 'key = ?', whereArgs: [key]);
      if (res.length == 0) {
        //insert
        Map<String, dynamic> _p = Map();
        _p.addAll({
          "key": key,
          "value": value,
        });
        await DBHelper.dbHelper.getDatabase().insert(TABLE_NAME, _p);
      } else {
        Map<String, dynamic> _p = Map();
        _p.addAll({
          "value": value,
        });
        await DBHelper.dbHelper
            .getDatabase()
            .update(TABLE_NAME, _p, where: 'key = ?', whereArgs: [key]);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future deleteLastToken() async {
    print('${TAG} Delete last token');
    try {
      Map<String, dynamic> _p = Map();
      _p.addAll({
        "value": null,
      });
      await DBHelper.dbHelper.getDatabase().update(TABLE_NAME, _p,
          where: 'key = ?', whereArgs: [KEY_TOKEN_LAST]);
    } catch (ex) {}
  }
}

/*
 * model item table notfi
 */
class NotifiDataLocal extends Equatable {
  String key;
  String value;
  NotifiDataLocal({this.key, this.value});

  @override
  String toString() => '$key, $value';

  @override
  List<Object> get props => null;
}
