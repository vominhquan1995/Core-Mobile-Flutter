import 'package:Midas/core/page-core/widget_custom.dart';
import 'package:Midas/widgets/danh_muc/danh_muc_page.dart';
import 'package:Midas/widgets/notification/notification_list_page.dart';
import 'package:flutter/material.dart';

class DanhMucScreen extends StatefulWidget {
  @override
  _DanhMucScreenState createState() => _DanhMucScreenState();
}

class _DanhMucScreenState extends State<DanhMucScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WidgetsCore(widget: DanhMucPage());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
