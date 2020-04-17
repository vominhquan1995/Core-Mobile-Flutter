import 'package:Midas/core/page-core/widget_custom.dart';
import 'package:Midas/widgets/notification/notification_list_page.dart';
import 'package:flutter/material.dart';

class ThongBaoScreen extends StatefulWidget {
  @override
  _ThongBaoScreenState createState() => _ThongBaoScreenState();
}

class _ThongBaoScreenState extends State<ThongBaoScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WidgetsCore(widget: NotificationListPage());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
