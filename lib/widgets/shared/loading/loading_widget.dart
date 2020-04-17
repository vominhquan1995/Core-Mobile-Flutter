import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              color: Colors.white,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    'assets/logo_login.png',
                    width: ScreenUtil().setWidth(250),
                    height: ScreenUtil().setWidth(250),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
