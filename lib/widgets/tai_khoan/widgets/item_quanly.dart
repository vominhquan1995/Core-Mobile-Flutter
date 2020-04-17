import 'package:Midas/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemQuanLy extends StatelessWidget {
  final String title;

  final String subtitle;

  final String image;

  final bool divider;

  final Function onPressed;

  const ItemQuanLy({
    Key key,
    this.title = '',
    this.subtitle,
    this.image = '',
    this.divider = true,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onPressed != null ? onPressed : null,
        child: Padding(
          padding: EdgeInsets.only(
            left: paddingL,
            right: paddingL,
            top: paddingL,
          ),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SvgPicture.asset(
                    image,
                    width: 35,
                    height: 35,
                  ),
                  SizedBox(width: paddingL),
                  Expanded(child: _buildSubtitle()),
                  Icon(
                    Icons.navigate_next,
                    color: colorGrey_2,
                    size: 36,
                  )
                ],
              ),
              SizedBox(height: paddingL),
              divider
                  ? Divider(color: borderSide.color, height: 1)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  _buildSubtitle() {
    if (subtitle != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(title, style: style15),
          SizedBox(height: subtitle != null ? paddingM : 0),
          Text(subtitle ?? '', style: style13_lightgrey),
        ],
      );
    }

    return Text(title, style: style15);
  }
}
