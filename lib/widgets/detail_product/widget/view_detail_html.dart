import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/detail_product/widget/app_bar_simple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ViewDetailHtml extends StatefulWidget {
  final String html;
  ViewDetailHtml({Key key, @required this.html}) : super(key: key);

  @override
  _ViewDetailHtmlState createState() => _ViewDetailHtmlState();
}

class _ViewDetailHtmlState extends State<ViewDetailHtml> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarBackSimple(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: !(["", null].contains(widget.html))
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
                    child: Text(tr('product_details_7'), style: style17),
                  ),
                ),
        ));
  }
}
