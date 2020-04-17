import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class RawToolItemWidget extends StatelessWidget {
  final dynamic data;

  const RawToolItemWidget({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Html(
      defaultTextStyle: TextStyle(fontSize: 13),
      data: "${data["html"] ?? ''}",
    );
  }
}
