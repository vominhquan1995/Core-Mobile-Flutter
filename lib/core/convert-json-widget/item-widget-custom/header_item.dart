import 'dart:io';

import 'package:Midas/utils/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderItem extends StatelessWidget {
  final dynamic data;

  const HeaderItem({Key key, this.data}) : super(key: key);
  /* 
  dùng cho loại header
   */
  buildHeader() {
    var fontSize = fontSizeByScreen;
    var paddingT = paddingS;
    var paddingB = paddingS;
    var fontWei = FontWeight.normal;
    switch (data['level'] ?? 1) {
      // header
      case 1:
        fontSize = fontSize * (32 / 12);
        paddingT = paddingT * 2;
        paddingB = paddingB * 2;
        fontWei = FontWeight.w700;
        break;
      case 2:
        fontSize = fontSize * (24 / 12);
        fontWei = FontWeight.w700;
        paddingT = paddingT * 2;
        paddingB = paddingB * 2;
        break;
      case 3:
        fontSize = fontSize * (18 / 12);
        fontWei = FontWeight.w700;
        paddingT = paddingT * 2;
        paddingB = paddingB * 2;
        break;
      case 4:
        fontSize = fontSize * (14 / 12);
        fontWei = FontWeight.w700;
        paddingT = paddingT * 2;
        paddingB = paddingB * 2;
        break;
      // case 5:
      //   fontSize = fontSize * 1.2;
      //   break;
      // case 6:
      //   fontSize = fontSize * 1.0;
      //   break;
      default:
        break;
    }
    return Html(
      onImageError: null,
      onImageTap: null,
      onLinkTap: (url) {
        _launchURL(url);
      },
      defaultTextStyle: style10.copyWith(
        fontSize: fontSize,
        height: 1,
        fontWeight: fontWei,
        letterSpacing: Platform.isIOS ? 2.0 : 0.0,
      ),
      padding: EdgeInsets.fromLTRB(0, paddingT, 0, paddingB),
      data: "${data["text"] ?? ''}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildHeader();
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
