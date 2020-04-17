import 'package:Midas/core/cart/model/cart_model.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpandableItem extends StatelessWidget {
  final num total;
  final CartInfoModel info;
  final ExpandableController controller;
  final String currency;
  ExpandableItem(
      {Key key, this.info, this.total, this.controller, this.currency})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    buildCollapsed1() {
      return Builder(builder: (_) {
        return InkWell(
          child: Row(),
        );
      });
    }

    buildExpanded1() {
      return Builder(
        builder: (BuildContext _) {
          return Container(
            margin: EdgeInsets.only(top: paddingL),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: paddingM),
                            child: Text(tr("cart_payment_3"), style: style15),
                          ),
                          Text(
                              '${NumberFormat(currency).format(info.tienhoahong)}',
                              style: style17_semibold),
                        ],
                      ),
                      if (info.tienhoahong >= total)
                        Column()
                      else
                        Column(children: <Widget>[
                          SizedBox(height: paddingM),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(tr("cart_payment_4"),
                                  style: style15.copyWith(
                                      fontWeight: FontWeight.w400)),
                              Text(
                                  '${NumberFormat(currency).format(total - info.tienhoahong)}',
                                  style: style17_semibold),
                            ],
                          ),
                          SizedBox(height: paddingXS),
                          Text(tr("cart_payment_5"),
                              style:
                                  style15_semibold.copyWith(color: colorRed)),
                        ])
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    }

    return ExpandableNotifier(
      controller: controller,
      child: ScrollOnExpand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expandable(
              collapsed: buildCollapsed1(),
              expanded: buildExpanded1(),
            ),
          ],
        ),
      ),
    );
  }
}
