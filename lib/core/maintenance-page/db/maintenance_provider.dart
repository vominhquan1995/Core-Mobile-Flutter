import 'package:Midas/core/bao-tri/db/baotri_provider.dart';
import 'package:Midas/core/bao-tri/models/baotri.dart';
import 'package:Midas/core/database/base_db_provider.dart';
import 'package:Midas/core/database/dbhelper.dart';

class MaintenanceProvider extends BaseProvider<BaoTriLocal> {
  static const KEY = 'MAINTENANCE_PAGE';

  @override
  Future<bool> delete() async {
    // TODO: implement delete
    return null;
  }

  @override
  Future<bool> insert(BaoTriLocal p) async {
    try {
      Map<String, dynamic> map = Map();
      map.addAll(
          {columnKey: p.key, columnTinhTrang: p.tinhTrang, columnHtml: p.html});

      /// Update trước
      final raw = await DBHelper.dbHelper.getDatabase().update(
          BaoTriProvider.TABLE_NAME, map,
          where: '$columnKey = ?', whereArgs: [p.key]);

      ///Nếu ko có dòng nào đc update thì insert vì nó k có
      if (raw <= 0) {
        await DBHelper.dbHelper
            .getDatabase()
            .insert(BaoTriProvider.TABLE_NAME, map);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<BaoTriLocal> select() async {
    try {
      var res = await DBHelper.dbHelper.getDatabase().query(
          BaoTriProvider.TABLE_NAME,
          where: '$columnKey = ?',
          whereArgs: [KEY]);

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

  Future<Map<String, dynamic>> selectBaoTriPage() async {
    try {
      var res = await DBHelper.dbHelper.getDatabase().query(
          BaoTriProvider.TABLE_NAME,
          where: '$columnKey <> ? AND $columnKey <> ?',
          whereArgs: [BaoTriProvider.KEY, KEY]);

      Map<String, dynamic> map = Map<String, dynamic>();
      res.forEach((f) => map.addAll({
            f[columnKey]: {
              "mode": f[columnTinhTrang] == 1 ? true : false,
              "html": f[columnHtml]
            }
          }));

      return res.isEmpty ? null : map;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteByKey(String key) async {
    // TODO: implement delete
    try {
      await DBHelper.dbHelper.getDatabase().delete(BaoTriProvider.TABLE_NAME,
          where: '$columnKey = ?', whereArgs: [key]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertObject(dynamic ob) async {
    try {
      await DBHelper.dbHelper.getDatabase().transaction((action) async {
        var batch = action.batch();
        ob.forEach((k, v) async {
          BaoTriLocal p =
              BaoTriLocal(key: k, html: v["html"], tinhTrang: v["mode"]);

          Map<String, dynamic> map = Map();
          map.addAll({
            columnKey: p.key,
            columnTinhTrang: p.tinhTrang,
            columnHtml: p.html
          });

          await action.delete(BaoTriProvider.TABLE_NAME,
              where: '$columnKey = ?', whereArgs: [p.key]);

          await action.insert(BaoTriProvider.TABLE_NAME, map);

          print('Insert Thanh Cong ${p.key} ${p.tinhTrang}');
        });
        await batch.commit();
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
