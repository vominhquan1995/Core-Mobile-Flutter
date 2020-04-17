import 'package:Core/widgets/shared/image-custom/image-custom.dart';
import 'package:flutter/material.dart';

class ItemInListView extends StatelessWidget {
  final String hinhAnh;
  final Widget widgetContent;

  ItemInListView({this.hinhAnh = '', Widget widget})
      : widgetContent = widget ?? Container();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
              width: 120, height: 100, child: HinhAnh(image: hinhAnh)),
        ),
        Expanded(
            flex: 4,
            child: Container(
              width: 120,
              height: 100,
              child: widgetContent,
            ))
      ],
    );
  }
}
