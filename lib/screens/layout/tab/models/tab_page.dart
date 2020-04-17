import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class TabPage {
  Widget page;
  final Widget icon;
  final String text;
  final String id;
  final Widget iconActive;
  TabPage(
      {@required this.page,
      @required this.icon,
      @required this.text,
      this.id = "-1",
      this.iconActive})
      : assert(page != null),
        assert(icon != null),
        assert(text != null);
}
