import 'package:Midas/core/custom_translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/detail_product/widget/app_bar_simple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';

class ViewDetailNotifiHtml extends StatefulWidget {
  final String html;
  ViewDetailNotifiHtml({Key key, @required this.html}) : super(key: key);

  @override
  _ViewDetailNotifiHtmlState createState() => _ViewDetailNotifiHtmlState();
}

class _ViewDetailNotifiHtmlState extends State<ViewDetailNotifiHtml> {
  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarBackSimple(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: _parseHtmlString(widget.html) != ''
              ? Html(
                  data: widget.html,
                  padding: EdgeInsets.all(paddingL),
                  backgroundColor: colorWhite,
                  defaultTextStyle: style17,
                  onLinkTap: (url) {},
                  onImageTap: (src) {},
                )
              : Center(
                  child: Container(
                    child: Text(tr('notification_3'), style: style17),
                  ),
                ),
        ));
  }
}
