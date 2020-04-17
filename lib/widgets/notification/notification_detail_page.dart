import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:Midas/widgets/notification/widgets/notification_detail.dart';

import 'model/notification_model.dart';

//const tAG = 'NOFITICATION_DETAIL_PAGE: ';

class NotificationDetail extends StatefulWidget {
  final NotificationModel data;
  NotificationDetail({this.data});
  @override
  NotificationDetailState createState() => NotificationDetailState();
}

class NotificationDetailState extends State<NotificationDetail> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      elevation: 0.0,
    );
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await flutterWebviewPlugin.hide();
        return true;
      },
      child: Scaffold(
        body: NotificationHtml(
          appBar: appBar(),
          notifiid: widget.data.notifiid,
        ),
      ),
    );
  }
}
