import 'dart:ui';

import 'util_language.dart';

class Localization {
  Map<String, dynamic> _sentences = {};
  Locale _locale;
  Localization._();
  static Localization _instance;
  static Localization get instance =>
      _instance ?? (_instance = Localization._());
  static Locale get locate =>
      _instance._locale ?? Locale(UtilLanguage.langDef, UtilLanguage.conDef);
  static void saveInstance(Map<String, dynamic> sentences, Locale locale) {
    instance._sentences = sentences;
    instance._locale = locale;
  }

  String tr(String key, {List<String> args}) {
    String res;
    if (res == null) {
      res = this._resolve(key, this._sentences);
    }

    if (args != null) {
      args.forEach((String str) {
        res = res.replaceFirst(RegExp(r'{}'), str);
      });
    }

    return res;
  }

  String _resolve(String path, dynamic obj) {
    List<String> keys = path.split('.');
    if (keys.length > 1) {
      for (int index = 0; index <= keys.length; index++) {
        if (obj.containsKey(keys[index]) && obj[keys[index]] is! String) {
          return _resolve(
              keys.sublist(index + 1, keys.length).join('.'), obj[keys[index]]);
        }
        return obj[path] ?? path;
      }
    }
    return obj[path] ?? path;
  }
}

String tr(String key, {List<String> args}) {
  return Localization.instance.tr(key, args: args);
}
