import 'package:sqflite/sqflite.dart';

abstract class IMigrationTask {
  Future<bool> onUpgrade(Database theDb, int oldVersion, int newVersion);

  Future<bool> clearExclude(Database theDb, {List<String> exclude = const []});
}
