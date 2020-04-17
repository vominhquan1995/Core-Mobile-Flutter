import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/shared/text_html/text_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemUserNormal extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  final Function onPressed;

  bool detail;

  ItemUserNormal({
    Key key,
    this.image = '',
    this.title = '',
    this.subtitle,
    this.onPressed,
    this.detail = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onPressed != null ? onPressed : null,
        child: Padding(
          padding: EdgeInsets.only(
              left: paddingL, right: paddingL, top: paddingL, bottom: paddingL),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset(
                image,
                width: 25,
                height: 25,
              ),
              SizedBox(width: paddingL),
              Expanded(child: _buildTitle()),
              Opacity(
                opacity: detail ? 1 : 0,
                child: Icon(
                  Icons.navigate_next,
                  color: colorGrey_2,
                  size: 36,
                ),
              )
            ],
          ),
        ),
      ),
    );
    // return ListTile(
    //   contentPadding: EdgeInsets.all(paddingL),
    //   dense: true,
    //   leading: SvgPicture.asset(
    //     image,
    //     width: 25,
    //     height: 25,
    //   ),
    //   title: _buildTitle(),
    //   subtitle: subtitle != null ? _buildSubtitle() : null,
    //   trailing: Icon(
    //     Icons.navigate_next,
    //     color: colorGrey_2,
    //     size: 36,
    //   ),
    // );
  }

  _buildSubtitle() {
    return Text(
      subtitle,
      style: style13_lightgrey,
    );
  }

  _buildTitle() {
    if (subtitle != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DefaultTextStyle(
            style: style15,
            softWrap: true,
            textAlign: TextAlign.start,
            child: HtmlText(
              data: title,
            ),
          ),
          SizedBox(height: paddingM),
          _buildSubtitle()
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DefaultTextStyle(
          style: style15,
          softWrap: true,
          textAlign: TextAlign.start,
          child: HtmlText(
            data: title,
          ),
        ),
      ],
    );
  }
}
