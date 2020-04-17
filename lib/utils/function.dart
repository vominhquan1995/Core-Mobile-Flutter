import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter/services.dart';

changeStatusColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setStatusBarColor(color);
    if (useWhiteForeground(color)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    }
  } on PlatformException catch (e) {
    debugPrint(e.toString());
  }
}

// setStatusColor(Brightness birghtness) {
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
//       statusBarIconBrightness: birghtness ?? Brightness.light,
//       statusBarColor: Colors.transparent));
// }
