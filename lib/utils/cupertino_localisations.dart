import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/cupertino.dart';

class CupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const CupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['vi'].contains(locale.languageCode);

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return SynchronousFuture<_DefaultCupertinoLocalizations>(
        _DefaultCupertinoLocalizations(locale.languageCode));
  }

  @override
  bool shouldReload(CupertinoLocalizationsDelegate old) => false;
}

class _DefaultCupertinoLocalizations extends CupertinoLocalizations {
  final _vi = DefaultCupertinoLocalizations();
  final String _languageCode;

  static Map<String, Map<String, String>> _dict = {
    'vi': {
      'alert': 'Thông báo',
      'copy': 'Sao chép',
      'paste': 'Dán',
      'cut': 'Cắt',
      'selectAll': 'Chọn tất cả'
    }
  };

  _DefaultCupertinoLocalizations(this._languageCode)
      : assert(_languageCode != null);

  @override
  String get alertDialogLabel => _get('alert');

  @override
  String get anteMeridiemAbbreviation => _vi.anteMeridiemAbbreviation;

  @override
  String get postMeridiemAbbreviation => _vi.postMeridiemAbbreviation;

  @override
  String get copyButtonLabel => _get('copy');

  @override
  String get cutButtonLabel => _get('cut');

  @override
  String get pasteButtonLabel => _get('paste');

  @override
  String get selectAllButtonLabel => _get('selectAll');

  @override
  DatePickerDateOrder get datePickerDateOrder => _vi.datePickerDateOrder;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder =>
      _vi.datePickerDateTimeOrder;

  @override
  String datePickerDayOfMonth(int dayIndex) =>
      _vi.datePickerDayOfMonth(dayIndex);

  @override
  String datePickerHour(int hour) => _vi.datePickerHour(hour);

  @override
  String datePickerHourSemanticsLabel(int hour) =>
      _vi.datePickerHourSemanticsLabel(hour);

  @override
  String datePickerMediumDate(DateTime date) => _vi.datePickerMediumDate(date);

  @override
  String datePickerMinute(int minute) => _vi.datePickerMinute(minute);

  @override
  String datePickerMinuteSemanticsLabel(int minute) =>
      _vi.datePickerMinuteSemanticsLabel(minute);

  @override
  String datePickerMonth(int monthIndex) => _vi.datePickerMonth(monthIndex);

  @override
  String datePickerYear(int yearIndex) => _vi.datePickerYear(yearIndex);

  @override
  String timerPickerHour(int hour) => _vi.timerPickerHour(hour);

  @override
  String timerPickerHourLabel(int hour) => _vi.timerPickerHourLabel(hour);

  @override
  String timerPickerMinute(int minute) => _vi.timerPickerMinute(minute);

  @override
  String timerPickerMinuteLabel(int minute) =>
      _vi.timerPickerMinuteLabel(minute);

  @override
  String timerPickerSecond(int second) => _vi.timerPickerSecond(second);

  @override
  String timerPickerSecondLabel(int second) =>
      _vi.timerPickerSecondLabel(second);

  String _get(String key) {
    return _dict[_languageCode][key];
  }

  @override
  // TODO: implement todayLabel
  String get todayLabel => null;
}
