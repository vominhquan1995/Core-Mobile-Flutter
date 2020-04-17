import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/widgets/home/home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WidgetsCore(widget: HomeWidget());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
