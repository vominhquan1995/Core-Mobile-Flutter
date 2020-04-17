import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/widgets/my_library/my_library.dart';

import 'package:flutter/material.dart';

class MyLibraryPage extends StatefulWidget {
  @override
  _MyLibraryPageState createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<MyLibraryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WidgetsCore(widget: MyLibrary());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
