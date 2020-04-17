import 'package:Midas/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

//TODO
//custom element <b></b> => bold 600
class ParaGraphItemWidget extends StatelessWidget {
  final dynamic data;

  const ParaGraphItemWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
        onImageError: null,
        onImageTap: null,
        onLinkTap: (url) {
          _launchURL(url);
        },
        defaultTextStyle: style10.copyWith(
            fontSize: fontSizeByScreen * 1.3,
            fontWeight: FontWeight.w300,
            height: lineHeight2),
        data: "${data["text"] ?? ''}",
        padding: EdgeInsets.only(bottom: paddingM),
        customTextStyle: (dom.Node node, TextStyle baseStyle) {
          if (node is dom.Element) {
            switch (node.localName) {
              case "b":
                return style10.copyWith(
                    fontSize: fontSizeByScreen * 1.3,
                    height: lineHeight2,
                    fontWeight: FontWeight.w500);
            }
          }
          return baseStyle;
        });
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
