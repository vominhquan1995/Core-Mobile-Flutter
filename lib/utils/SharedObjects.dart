import 'package:shared_preferences/shared_preferences.dart';

class CachedSharedPreferences {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final CachedSharedPreferences _singleton =
      new CachedSharedPreferences._internal();

  SharedPreferences _sharedPreferences;

  CachedSharedPreferences._internal() {
    initialize();
  }

  SharedPreferences get sharedPreferences => _sharedPreferences;

  static CachedSharedPreferences getInstance() => _singleton;

  void initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}
