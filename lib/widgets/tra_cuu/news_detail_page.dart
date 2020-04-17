import 'package:Core/core/connection-status/index.dart';
import 'package:Core/core/data-status/index.dart';
import 'package:Core/core/google_analytics/index.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/detail_product/widget/app_bar_simple.dart';
import 'package:Core/widgets/tra_cuu/models/news_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class NewsDetail extends StatefulWidget {
  final News data;
  final String id;
  NewsDetail({this.data, this.id})
      : assert(id != null, 'Data or Id phải có một trong 2');

  @override
  NewsDetailState createState() => NewsDetailState();
}

class NewsDetailState extends State<NewsDetail> with TickerProviderStateMixin {
  //Tình trạng mạng. True: Có mạng False: Mất mạng
  bool isOffline = true;

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  @override
  void initState() {
    super.initState();
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    isOffline = connectionStatus.hasConnection;
    GoogleAnalytics.trackScreen(news_detail_page);
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final headers = DioUtil.headers;
    print('${DioUtil.getApiMidas()}/tintuc/tra-cuu-getone?tin_tuc_id=${widget.id}');
    return WillPopScope(
        onWillPop: () async {
          await flutterWebviewPlugin.hide();
          return true;
        },
        child: isOffline
            ? Padding(
                padding: EdgeInsets.all(0),
                child: WebviewScaffold(
                  appBar: new AppBarBackSimple(),
                  withJavascript: true,
                  clearCookies: true,
                  scrollBar: false,
                  clearCache: true,
                  hidden: true,
                  headers: headers,
                  url:
                      '${DioUtil.getApiMidas()}/tintuc/tra-cuu-getone?tin_tuc_id=${widget.id}',
                  initialChild: Container(
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ))
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: colorBlue),
                ),
                backgroundColor: Colors.white,
                body: DataStatusWidget(
                  style: DataStatus.disconnect,
                  onPress: null,
                ),
              ));
  }

  _share() {
    if (widget.data.linkseo.isNotEmpty) {
      Share.share('${widget.data.linkseo}');
    }
  }
}
