import 'package:Core/utils/theme.dart';
import 'package:flutter/material.dart';

class WaitingXacThuc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 1.5,
        color: Colors.white,
        padding:
            EdgeInsets.symmetric(horizontal: paddingL, vertical: paddingXS),
        child: Center(child: CircularProgressIndicator()));
  }
}
