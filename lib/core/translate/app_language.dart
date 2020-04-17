import 'dart:convert';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/core/translate/service/translate_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'util_language.dart';

class AppLanguage {
  TranslateService service = TranslateService();
  Locale _appLocale;
  Locale get appLocal =>
      _appLocale ?? Locale(UtilLanguage.langDef, UtilLanguage.conDef);
  Future<Locale> initLang() async {
    Map<String, dynamic> _localizedStrings = new Map();
    //first get lang local or set lang default;
    var _preferences = await SharedPreferences.getInstance();
    var _codeLang = _preferences.getString('codeL');
    var _codeCoun = _preferences.getString('codeC');
    if (_codeLang == null) {
      _codeCoun = UtilLanguage.conDef;
      _codeLang = UtilLanguage.langDef;
      await _preferences.setString('codeC', UtilLanguage.conDef);
      await _preferences.setString('codeL', UtilLanguage.langDef);
      _appLocale = Locale(UtilLanguage.langDef, UtilLanguage.conDef);
    } else {
      _appLocale = Locale(_codeLang, _codeCoun);
    }
    //call service
    return service.getLang(_codeLang).then((data) {
      _localizedStrings = data;
      Localization.saveInstance(_localizedStrings, _appLocale);
      return _appLocale;
    }).catchError((onError) {
      var localePath = '${UtilLanguage.rootPathLang}$_codeLang.json';
      rootBundle.load(localePath).then((byteData) {
        String jsonContent = utf8.decode(byteData.buffer.asUint8List());
        _localizedStrings = json.decode(jsonContent);
        Localization.saveInstance(_localizedStrings, _appLocale);
        return _appLocale;
      });
    });
  }

  Future<bool> changeLanguage(Locale locate) async {
    var _preferences = await SharedPreferences.getInstance();
    await _preferences.setString('codeC', locate.countryCode);
    await _preferences.setString('codeL', locate.languageCode);
    await initLang();
    return true;
  }
}
