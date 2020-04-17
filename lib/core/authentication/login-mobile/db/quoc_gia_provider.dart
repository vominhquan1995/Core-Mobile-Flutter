import 'package:Core/core/authentication/login-mobile/index.dart';

import '../../../database/dbhelper.dart';

///Kiểu bool trong sqlite: integers 0 (false) and 1 (true).
class QuocGiaDB {
  static const String TABLE_NAME = "table_quoc_gia";

  Future<bool> insertAlls(List<QuocGia> _list) async {
    try {
      await DBHelper.dbHelper.getDatabase().transaction((action) async {
        var batch = action.batch();
        _list.forEach((quocgia) async {
          Map<String, dynamic> map = Map();
          map.addAll({
            columnTenQuocGia: quocgia.ten_quoc_gia,
            columnFlag: quocgia.icon,
            columnMaVung: quocgia.ma_vung,
            columnCode: quocgia.code
          });

          /// Update trước

          await DBHelper.dbHelper.getDatabase().delete(TABLE_NAME);
          await action.insert(TABLE_NAME, map);
        });
        await batch.commit();
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<QuocGia>> getQuocGias() async {
    try {
      var res = await DBHelper.dbHelper.getDatabase().query(TABLE_NAME);
      dynamic quocgias = QuocGiafromJson(res);
      return quocgias as List<QuocGia>;
    } catch (e) {
      return null;
    }
  }

  Future<bool> clearAll() async {
    try {
      await DBHelper.dbHelper.getDatabase().delete(TABLE_NAME);
      return true;
    } catch (e) {
      return false;
    }
  }
}
