import 'package:Midas/core/page-core/widget_custom.dart';
import 'package:Midas/widgets/tai_khoan/tai_khoan.dart';
import 'package:flutter/material.dart';

class ThongTinCaNhanScreen extends StatefulWidget {
  @override
  _ThongTinCaNhanScreenState createState() => _ThongTinCaNhanScreenState();
}

class _ThongTinCaNhanScreenState extends State<ThongTinCaNhanScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WidgetsCore(widget: TaiKhoan());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
