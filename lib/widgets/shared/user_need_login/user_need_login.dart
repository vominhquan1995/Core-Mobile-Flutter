import 'package:Core/core/authentication/login-mobile/index.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/shared/buttonMidas/button_midas.dart';
import 'package:flutter/material.dart';

class UserNeedLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/no_internet.png',
              fit: BoxFit.contain,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 4,
              ),
              child: ButtonMidas(
                child: Text(
                  tr('login_1'),
                  style: style15_semibold.copyWith(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => LoginDienThoai()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
