import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double _userTextScale;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;
  static double fontSize;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _userTextScale = MediaQuery.textScaleFactorOf(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    fontSize = _caculatorFontSize(
      (blockSizeHorizontal * 3.3333).ceilToDouble(),
      _userTextScale,
    );
  }

  /// setting text scale của user [userTextScale]
  _caculatorFontSize(double defaultFontSize, double userTextScale) {
    print(
      '''
        Font size default app is ${defaultFontSize / userTextScale}, 
        textscale $userTextScale''',
    );
    return defaultFontSize / userTextScale;
  }
}
