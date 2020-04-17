import 'package:Core/utils/index.dart';
import 'package:flutter/material.dart';

class ButtonMidas extends StatelessWidget {
  final Widget child;

  final Function onPressed;

  const ButtonMidas({Key key, this.onPressed, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        textColor: Colors.white,
        elevation: 8.0,
        padding: EdgeInsets.zero,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
                image: AssetImage('assets/images/background_appbar.jpg'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: paddingL),
            child: Center(child: child ?? Container()),
          ),
        ),
        onPressed: onPressed);
  }
}
