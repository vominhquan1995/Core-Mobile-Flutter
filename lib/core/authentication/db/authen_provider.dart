import 'package:Core/core/authentication/models/profile_model.dart';
import 'package:Core/core/database/base_db_provider.dart';
import 'package:Core/core/database/dbhelper.dart';

class AuthenProvider extends BaseProvider<Profile> {
  static const String TABLE_NAME = "contacts";

  @override
  Future<bool> delete() async {
    // TODO: implement delete
    try {
      await DBHelper.dbHelper.getDatabase().delete(TABLE_NAME);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> insert(Profile p) async {
    // TODO: implement insert
    try {
      await DBHelper.dbHelper.getDatabase().insert(TABLE_NAME, p.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Profile> select() async {
    // TODO: implement select
    try {
      var res = await DBHelper.dbHelper.getDatabase().query(TABLE_NAME);
      return res.isEmpty ? null : Profile.fromJson(res.first);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> update() {
    // TODO: implement update
    return null;
  }

  static Future<String> getToken() async {
    try {
      var res = await DBHelper.dbHelper
          .getDatabase()
          .query(TABLE_NAME, columns: [columnToken]);

      return res.isEmpty ? '' : res.first[columnToken];
    } catch (e) {
      return '';
    }
  }
}
