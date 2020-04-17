import 'package:Core/core/database/dbhelper.dart';
import 'package:Core/widgets/thanh_vien_f2_f3/model/index.dart';
import 'package:Core/widgets/thanh_vien_f2_f3/model/thanh_vien.m.dart';

///Kiểu bool trong sqlite: integers 0 (false) and 1 (true).
class ThanhVienDB {
  static const String TABLE_NAME = "table_ThanhVien";

  Future<bool> insert(List<PhanCapModel> _list) async {
    try {
      await DBHelper.dbHelper.getDatabase().transaction((action) async {
        var batch = action.batch();
        _list.forEach((tv) async {
          Map<String, dynamic> map = Map();
          map.addAll(tv.toJson());

          await action.insert(TABLE_NAME, map);
        });
        await batch.commit();
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  static Future<List<PhanCapModel>> search(body) async {
    var data;
    if (body != '') {
      body = '%' + body + '%';
      data = await DBHelper.dbHelper.getDatabase().query(TABLE_NAME,
          where: '$columnTaiKhoan like ? or $columnTenShop like ?',
          whereArgs: [body, body]);
    } else {
      data = await DBHelper.dbHelper.getDatabase().query(TABLE_NAME);
    }
    // print(body);
    // print(data);
    if (data == null) return [];
    return data.isEmpty ? [] : mapListDonHang(data);
  }

  Future<bool> clearAll() async {
    try {
      await DBHelper.dbHelper.getDatabase().delete(TABLE_NAME);
      return true;
    } catch (e) {
      return false;
    }
  }

  static List<PhanCapModel> mapListDonHang(List list) {
    return list.map((f) => PhanCapModel.fromJsonSqlite(f)).toList();
  }
}
