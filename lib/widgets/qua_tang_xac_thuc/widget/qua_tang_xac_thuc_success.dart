import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/core/config_json/models/config_json.dart';
import 'package:Core/core/custom_translate/easy_localization_delegate.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/utils/theme.dart';
import 'package:Core/widgets/midas-rewards/midas_rewards_page.dart';
import 'package:Core/widgets/shared/text_html/text_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuaTangXacThucSuccess extends StatefulWidget {
  const QuaTangXacThucSuccess({Key key}) : super(key: key);
  @override
  _QuaTangXacThucSuccessState createState() => _QuaTangXacThucSuccessState();
}

class _QuaTangXacThucSuccessState extends State<QuaTangXacThucSuccess> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            child: Image(
                fit: BoxFit.contain, image: AssetImage('assets/success.jpg'))),
        Container(
            padding:
                EdgeInsets.symmetric(horizontal: paddingL, vertical: paddingXS),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(bottom: paddingL),
                    child: BlocBuilder<ConfigjsonBloc, ConfigJson>(
                        builder: (BuildContext context, ConfigJson state) {
                      return Container(
                        child: DefaultTextStyle(
                            style: style15,
                            child: HtmlText(
                                data:
                                    tr('gift_8', args: [state?.dataQT?.text]))),
                      );
                    })),
                Container(
                  padding: EdgeInsets.only(bottom: paddingL),
                  alignment: Alignment.topLeft,
                  child: BlocBuilder<ConfigjsonBloc, ConfigJson>(
                      builder: (BuildContext context, ConfigJson state) {
                    return DefaultTextStyle(
                        style: style15, child: HtmlText(data: tr('gift_9')));
                  }),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WidgetsCore(widget: MidasRewardsPage())));
                    },
                    child: Container(
                      padding: EdgeInsets.only(bottom: paddingXXS),
                      alignment: Alignment.topLeft,
                      child: new Text(
                        tr('gift_10'),
                        style: style13.copyWith(
                            color: colorBlue,
                            decoration: TextDecoration.underline),
                      ),
                    )),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: colorWhite,
                          border: Border.all(color: colorViolet, width: 1)),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          vertical: paddingL, horizontal: paddingXS),
                      child: Text(
                        tr('gift_11'),
                        style: style17.copyWith(
                            color: colorBlack, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ))
              ],
            ))
      ],
    ));
  }
}
