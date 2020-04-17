import 'package:Core/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkToolWidget extends StatelessWidget {
  final dynamic data;

  const LinkToolWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        padding: EdgeInsets.all(paddingS),
        onPressed: () {
          launch("${data["link"] ?? ''}");
        },
        child: Card(
          elevation: 0.5,
          margin: EdgeInsets.all(0),
          child: Container(
            decoration: BoxDecoration(color: colorGrey_2),
            padding: EdgeInsets.all(paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${data["meta"]["title"] ?? ''}",
                  style: style15.copyWith(color: Colors.blue),
                  textAlign: TextAlign.left,
                ),
                RichText(
                  text: TextSpan(
                    text: "${data["meta"]["description"] ?? ''}",
                    style: style13,
                  ),
                )
              ],
            ),
          ),
        ));
    // return Html(
    //   defaultTextStyle: TextStyle(fontSize: 13),
    //   data: "${data["link"] ?? ''}",
    // );
  }
}
