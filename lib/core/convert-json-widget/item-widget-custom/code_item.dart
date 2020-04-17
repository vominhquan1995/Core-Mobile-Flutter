import 'package:Midas/utils/index.dart';
import 'package:flutter/material.dart';

class CodeItemWidget extends StatelessWidget {
  final dynamic data;

  const CodeItemWidget({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: colorGrey_3,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          )),
      child: Text(
        data["code"],
      ),
    );
  }
}
