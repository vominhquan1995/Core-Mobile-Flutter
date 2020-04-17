import 'package:Core/utils/index.dart';
import 'package:flutter/material.dart';

class ItemTaiKhoan extends StatelessWidget {
  final Widget child;

  final bool icon;

  final Function onPressed;

  const ItemTaiKhoan({Key key, this.icon, this.child, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed ?? null,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            paddingL,
            paddingL,
            paddingL,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  child ?? Container(),
                  Opacity(
                    opacity: icon ? 1 : 0,
                    child: Icon(
                      Icons.navigate_next,
                      color: colorGrey_2,
                      size: 36,
                    ),
                  )
                ],
              ),
              SizedBox(height: paddingM),
              Divider(color: borderSide.color, height: 1),
            ],
          ),
        ),
      ),
    );
  }
}
