import 'package:Midas/utils/index.dart';

import 'index.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final dynamic data;

  ListItemWidget({this.data});

  buildList() {
    switch (data["style"]) {
      case "ordered":
        List<Widget> items = new List<Widget>();
        var index = 1;
        for (var item in data["items"]) {
          items.add(Container(
            padding: EdgeInsets.only(bottom: paddingM),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, paddingS, paddingM, 0),
                      child: Icon(
                        Icons.fiber_manual_record,
                        size: 10,
                        color: colorGrey_1,
                      )),
                  Expanded(
                    flex: 9,
                    child: RichText(
                      text: TextSpan(
                        // text: index.toString() + ". ",
                        // style: style22,
                        children: <TextSpan>[
                          TextSpan(
                              text: item,
                              style: style10.copyWith(
                                  fontSize: fontSizeByScreen * 1.3,
                                  fontWeight: FontWeight.w300,
                                  height: lineHeight1)),
                        ],
                      ),
                    ),
                  )

                  // Text(
                  //   index.toString() + ". ",
                  //   style: style22,
                  // ),
                  // Text(
                  //   item,
                  //   style: style22,
                  // )
                ]),
          ));
          index++;
        }
        return Column(children: items.toList());
        break;

      default:
        List<Widget> items = new List<Widget>();
        for (var item in data["items"]) {
          items.add(
            Row(children: [Icon(Icons.chevron_right), Text(item)]),
          );
        }
        return Column(children: items.toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, paddingS, 0, paddingS),
        child: buildList());
  }
}
