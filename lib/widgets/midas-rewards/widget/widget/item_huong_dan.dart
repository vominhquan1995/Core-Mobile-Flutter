import 'package:Midas/utils/theme.dart';
import 'package:flutter/material.dart';

class ItemHuongDan extends StatelessWidget {
  final String tieuDe;

  const ItemHuongDan({Key key, this.tieuDe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: borderSide,
        )),
        padding: EdgeInsets.only(bottom: paddingL, top: paddingL),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: style15,
                children: [
                  WidgetSpan(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 1, right: paddingM),
                      child: Icon(
                        Icons.brightness_1,
                        color: colorPurple.withOpacity(0.5),
                        size: 17,
                      ),
                    ),
                  ),
                  TextSpan(text: tieuDe, style: style15),
                ],
              ),
            ),
            Container(
              child: Icon(
                Icons.chevron_right,
                color: colorGrey_2,
                size: 30,
              ),
            )
          ],
        ));
  }
}