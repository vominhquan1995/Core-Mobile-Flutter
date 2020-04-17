import 'package:Midas/core/database/base_db_provider.dart';
import 'package:Midas/core/database/dbhelper.dart';
import 'package:Midas/widgets/quoc_gia/models/quocgia_model.dart';

///Kiểu bool trong sqlite: integers 0 (false) and 1 (true).
class QuocGiaDB implements BaseProvider<QuocGiaModel> {
  static const String TABLE_NAME = "table_quoc_gia";

  @override
  Future<bool> delete() {
    // TODO: implement delete
    return null;
  }

  @override
  Future<bool> insert(QuocGiaModel p) async {
    // TODO: implement insert

    try {
      await DBHelper.dbHelper.getDatabase().delete(TABLE_NAME);
      await DBHelper.dbHelper.getDatabase().insert(TABLE_NAME, p.toJson());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<QuocGiaModel> select() async {
    // TODO: implement select
    final data =
        await DBHelper.dbHelper.getDatabase().query(TABLE_NAME, limit: 1);

    if (data == null) return null;
    return data.isEmpty ? null : QuocGiaModel.fromJson(data.first);
  }

  @override
  Future<bool> update() {
    // TODO: implement update
    return null;
  }

  static Future<String> getMaVungLocal() async {
    final data =
        await DBHelper.dbHelper.getDatabase().query(TABLE_NAME, limit: 1);

    if (data == null) return null;
    return data.isEmpty ? "" : QuocGiaModel.fromJson(data.first).codeC;
  }
}
