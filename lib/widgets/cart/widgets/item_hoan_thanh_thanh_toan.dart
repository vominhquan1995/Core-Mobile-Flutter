import 'package:Core/core/cart/model/cart_model.dart';
import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/core/config_json/models/config_json.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/utils/theme.dart';
import 'package:Core/widgets/quan_ly_don_hang/quan_ly_don_hang_detail_page.dart';
import 'package:Core/widgets/shared/text_html/text_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ItemTienMat extends StatelessWidget {
  final CartResultModel result;
  final String currency;
  ItemTienMat({Key key, this.result, this.currency}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: paddingL, bottom: paddingM),
              child: Text(
                tr("cart_result_3"),
                style: style15,
              ),
            ),
            Container(
              child: Text(
                '${NumberFormat(currency).format(result.tongtien)}',
                style: style22_semibold.copyWith(color: colorBlueV2),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: paddingL, bottom: paddingXS),
              child: Text(
                tr("cart_result_4"),
                style: style15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemMaDonHang extends StatelessWidget {
  final CartResultModel result;
  ItemMaDonHang({Key key, this.result}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingL),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              '${tr("cart_result_5")}: ${result.madonhang}',
              style: style15_semibold,
            ),
          ),
          InkWell(
            onTap: () => openDonHangPage(context),
            child: Container(
              child: Text(
                tr("cart_result_6"),
                style: style15.copyWith(color: colorBlueV2),
              ),
            ),
          )
        ],
      ),
    );
  }

  openDonHangPage(context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => WidgetsCore(
            widget: QuanLyDonHangDetail(id: int.parse(result.id)))));
  }
}

class ItemThanhToanNganHang extends StatelessWidget {
  final CartResultModel result;
  final String currency;
  ItemThanhToanNganHang({Key key, this.result, this.currency})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              alignment: AlignmentDirectional.center,
              padding: EdgeInsets.all(paddingL),
              color: Colors.white,
              child: Text(
                tr("cart_result_8"),
                style: style15,
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: paddingL),
            color: Colors.white,
            child: DefaultTextStyle(
                style: style15.copyWith(height: lineHeight3),
                softWrap: true,
                textAlign: TextAlign.center,
                child: BlocBuilder<ConfigjsonBloc, ConfigJson>(
                  builder: (BuildContext _, state) {
                    if (state is ConfigJson && state.dataPayment != null) {
                      final list = state.dataPayment.toList() ?? [];
                      return HtmlText(
                          data: list
                                  .where((f) => f.value == 3)
                                  .first
                                  .descriptionht ??
                              "");
                    }

                    return HtmlText(data: "");
                  },
                )),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                bottom: paddingM, left: paddingL + paddingS, right: paddingL),
            child: Row(
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child:
                            Text(tr("cart_result_12") + ": ", style: style15),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: paddingM),
                        child:
                            Text(tr("cart_result_13") + ": ", style: style15),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: paddingS),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: paddingS),
                        child: Text(
                          '${result.sodienthoai} - ${result.madonhang}',
                          style: style15_black,
                        ),
                      ),
                      Container(
                        child: Text(
                          '${NumberFormat(currency).format(result.tongtien)}',
                          style: style22_semibold.copyWith(color: colorBlueV2),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
