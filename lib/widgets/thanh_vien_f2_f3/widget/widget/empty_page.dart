import 'package:Core/core/translate/public.dart';
import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/shared/text_html/text_html.dart';
import 'package:Core/widgets/tra_cuu/tra_cuu_page.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    goToPage(page) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => WidgetsCore(widget: page)));
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      padding: EdgeInsets.all(paddingL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: paddingXS),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/your-friends.png'))),
          ),
          Container(
            padding: EdgeInsets.all(paddingL),
            margin: EdgeInsets.only(top: paddingM),
            child: Text(
              tr('member_2'),
              style: style28_semibold,
            ),
          ),
          Center(
            child: DefaultTextStyle(
              style: style15,
              softWrap: true,
              textAlign: TextAlign.center,
              child: HtmlText(
                data: tr('member_3'),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              goToPage(TraCuuPage());
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(blurRadius)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/background_appbar.jpg'),
                      fit: BoxFit.cover)),
              margin: EdgeInsets.only(top: paddingXXS),
              padding: EdgeInsets.only(
                  left: paddingXS,
                  right: paddingXS,
                  top: paddingL,
                  bottom: paddingL),
              child: Text(
                tr('member_4'),
                style: style15_semibold.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
