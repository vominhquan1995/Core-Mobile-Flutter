import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double height;
  Logo({this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        height: height,
        child: Image.asset('assets/logo_hutech.png'));
  }
}
