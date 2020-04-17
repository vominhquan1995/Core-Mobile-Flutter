import 'package:Core/core/translate/public.dart';
import 'package:Core/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScrollToTop extends StatelessWidget {
  final Function onPressed;

  const ScrollToTop({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed ?? null,
      child: Text.rich(TextSpan(
        children: <InlineSpan>[
          TextSpan(text: tr('home_7'), style: style15),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset('assets/images/up.svg'),
            ),
          ),
        ],
      )),
    );
  }
}
