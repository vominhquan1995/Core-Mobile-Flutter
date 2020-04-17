import 'package:Midas/utils/index.dart';

import 'index.dart';
import 'package:flutter/material.dart';

class QuoteItemWidget extends StatelessWidget {
  final dynamic data;

  const QuoteItemWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, left: 15, right: 15),
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: colorGrey_3,
        border: Border(
          left: BorderSide(
            color: Colors.black,
            width: 3.0,
          ),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: <Widget>[
            Text(
              data["text"],
              textAlign: TextAlign.left,
            ),
          ],
        ),
        Text(
          data["caption"],
          textAlign: TextAlign.left,
          style: TextStyle(color: colorGrey_3, fontSize: 12),
        ),
      ]),
    );
  }
}
