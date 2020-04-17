import 'package:Core/core/translate/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:Core/utils/index.dart';
import 'package:url_launcher/url_launcher.dart';

class BaoTriPage extends StatelessWidget {
  final String message;

  BaoTriPage(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(paddingL, 0, paddingL, paddingL),
        child: DefaultTextStyle.merge(
          textAlign: TextAlign.justify,
          child: Html(
            useRichText: true,
            defaultTextStyle:
                style13.copyWith(letterSpacing: -0.3, height: 1.2),
            data: this.message,
            onLinkTap: (url) {
              _launchURL(url);
            },
          ),
        ),
      ),
    );
  }

  // xem file bằng browser
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('file chạy k dc');
      return;
    }
  }

  Widget appBar() {
    return AppBar(
      title: Text(tr('core_17'), style: style20.copyWith(color: Colors.black)),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: colorBlue),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingL),
          child: Divider(color: borderSide.color, height: borderSide.width),
        ),
      ),
    );
  }
}
