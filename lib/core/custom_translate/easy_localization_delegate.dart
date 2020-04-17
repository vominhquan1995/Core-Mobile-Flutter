import 'dart:convert';
import 'package:Core/core/custom_translate/service/localization_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'localization.dart';

class AppLocalizations {
  TranslateService service = TranslateService();
  AppLocalizations(
    this.locale, {
    this.path,
    this.loadPath,
    this.useOnlyLangCode = false,
  });

  Locale locale;
  final String path;
  final String loadPath;

  /// use only the lang code to generate i18n file path like en.json or ar.json
  final bool useOnlyLangCode;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, dynamic> _sentences = new Map();

  Future<bool> load(Locale locale) async {
    try {
      var _codeLang = locale.languageCode;
      var _codeCoun = locale.countryCode;

      this.locale = Locale(_codeLang, _codeCoun);

      //call service
      var data = await service.getLang(_codeLang).then((data) {
        _sentences = data;
        return _sentences;
      });
      if (data == null) {
        var basePath = path != null ? path : loadPath;
        var localePath = '$basePath/$_codeLang';
        localePath += useOnlyLangCode ? '.json' : '-$_codeCoun.json';
        final ByteData s = await rootBundle.load(localePath);
        String jsonContent = utf8.decode(s.buffer.asUint8List());
        _sentences = json.decode(jsonContent);
      }
      Localization.load(_sentences, locale);
      return true;
      // return true;
      // if (path != null) {
      //   data = await rootBundle.loadString(localePath);
      // } else if (loadPath != null) {
      //   data = await http
      //       .get(localePath)
      //       .then((response) => response.body.toString());
      // }
    } catch (e) {
      print('Error get file tranlate: $e');
    }
  }
}

class EasyLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale locale;
  final String path;

  ///  * use only the lang code to generate i18n file path like en.json or ar.json
  final bool useOnlyLangCode;

  EasyLocalizationDelegate({
    @required this.locale,
    this.path,
    this.useOnlyLangCode = false,
  });

  @override
  bool isSupported(Locale locale) => locale != null;

  @override
  Future<AppLocalizations> load(Locale value) async {
    AppLocalizations localizations =
        AppLocalizations(value, path: path, useOnlyLangCode: useOnlyLangCode);
    localizations.load(value);
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}
