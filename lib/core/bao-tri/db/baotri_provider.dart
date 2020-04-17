import 'package:Midas/core/bao-tri/models/baotri.dart';
import 'package:Midas/core/database/base_db_provider.dart';
import 'package:Midas/core/database/dbhelper.dart';

class BaoTriProvider extends BaseProvider<BaoTriLocal> {
  static const TABLE_NAME = "bao_tri";

  static const KEY = 'MAINTENANCE_APP';

  @override
  Future<bool> delete() async {
    // TODO: implement delete
    try {
      await DBHelper.dbHelper
          .getDatabase()
          .delete(TABLE_NAME, where: '$columnKey = ?', whereArgs: [KEY]);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> insert(BaoTriLocal p) async {
    // TODO: implement insert
    try {
      Map<String, dynamic> _p = Map();
      _p.addAll({
        columnKey: p.key,
        columnHtml: p.html,
        columnTinhTrang: p.tinhTrang,
      });
      await DBHelper.dbHelper.getDatabase().insert(TABLE_NAME, _p);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<BaoTriLocal> select() async {
    // TODO: implement select
    try {
      var res = await DBHelper.dbHelper
          .getDatabase()
          .query(TABLE_NAME, where: '$columnKey = ?', whereArgs: [KEY]);

      return res.isEmpty
          ? null
          : BaoTriLocal(
              key: KEY,
              html: res.first[columnHtml],
              tinhTrang: res.first[columnTinhTrang] == 1 ? true : false,
            );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> update() {
    // TODO: implement update
    return null;
  }
}
