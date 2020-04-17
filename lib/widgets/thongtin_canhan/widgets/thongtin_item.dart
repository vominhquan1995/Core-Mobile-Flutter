import 'package:Midas/utils/index.dart';
import 'package:flutter/material.dart';

class ThongTinItem extends StatelessWidget {
  final String title;

  final String subtitle;

  const ThongTinItem({Key key, this.title = "", this.subtitle = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Text(title, style: style15)),
        Expanded(flex: 2, child: Text(subtitle, style: style15_semibold)),
      ],
    );
  }
}
