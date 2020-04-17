import 'package:Core/utils/index.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  AppBarCustom({this.title = ''});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.fromLTRB(
        paddingL,
        MediaQuery.of(context).padding.top + paddingXS,
        paddingL,
        0,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: style34_black),
            ],
          ),
          Divider(color: borderSide.color),
          SizedBox(height: paddingM)
        ],
      ),
    );
  }
}
