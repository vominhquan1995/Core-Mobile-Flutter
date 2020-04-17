import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Image.asset(
              'assets/icon_app/mobile_icon.png',
              fit: BoxFit.contain,
              width: ScreenUtil().setWidth(750),
              height: ScreenUtil().setWidth(750),
            ),
          ),
        ),
      ),
    );
  }
}
