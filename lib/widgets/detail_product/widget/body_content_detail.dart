import 'package:Midas/core/authentication/models/profile_model.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/detail_product/widget/view_detail_html.dart';
import 'package:Midas/widgets/my_library/models/sanpham_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyContentDetail extends StatelessWidget {
  final SanPhamModel detail;
  final LOAI_USER typeUser;
  const BodyContentDetail(
      {Key key, @required this.detail, @required this.typeUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorWhite,
      padding: EdgeInsets.fromLTRB(paddingL, paddingM, paddingL, paddingM),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[SizedBox(height: paddingL)] +
              buildItemPolicy(detail.policy, typeUser) +
              [
                TitleCodeProduct(title: detail.maSanPham),
                SizedBox(height: paddingS),
                TitleProduct(title: detail.tenSanPham),
                SizedBox(height: paddingL),
                PriceItem(
                  lastPrice: detail.donGia,
                  salePrice: detail.donGiaSale,
                  percent: detail.phanTram,
                  type: detail.typeDisplay,
                ),
                // PriceSale(data: detail.donGiaSale),
                SizedBox(height: paddingL),
                ButtonViewDetail(
                  html: detail.content,
                ),
                SizedBox(height: paddingXXS * 2)
              ]),
    );
  }
}

buildItemPolicy(List<Policy> policy, LOAI_USER typeUser) {
  List<Widget> out = [];
  if (policy.length > 0 && typeUser != LOAI_USER.SALON) {
    out.add(Text(
      '${policy[0].content}',
      style: style15.copyWith(color: colorRed),
    ));
    out.add(SizedBox(height: paddingL));
  }
  return out;
}

class PriceItem extends StatelessWidget {
  const PriceItem(
      {Key key,
      @required this.lastPrice,
      @required this.salePrice,
      @required this.percent,
      @required this.type})
      : super(key: key);

  final String lastPrice;
  final String salePrice;
  final String percent;
  final TYPE_DISPLAY_PRICE type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: buildContent(context),
    );
  }

  buildContent(BuildContext context) {
    List<Widget> items = [];
    switch (type) {
      case TYPE_DISPLAY_PRICE.TYPE_1:
        //row 1 => last price

        items.addAll([
          Text(lastPrice, style: style17_black),
          SizedBox(height: paddingS),
          Text(
            tr('product_details_2').toUpperCase(),
            maxLines: 1,
            style: style13.copyWith(color: Colors.redAccent),
          )
        ]);

        break;
      case TYPE_DISPLAY_PRICE.TYPE_2:
        //row 1 => last price

        items.addAll([
          Row(
            children: <Widget>[
              Text(salePrice, style: style17_black),
              SizedBox(width: paddingL),
              Text(('(-${percent}%)'),
                  style: style17_semibold.copyWith(color: Colors.red))
            ],
          ),
          SizedBox(height: paddingS),
          Text(
            lastPrice,
            style: style13_lightgrey.copyWith(
              decoration: TextDecoration.lineThrough,
            ),
          )
        ]);

        break;
      case TYPE_DISPLAY_PRICE.TYPE_3:
        items.add(Text(lastPrice, style: style17_black));
        break;
      default:
    }
    return items;
  }
}

class PriceSale extends StatelessWidget {
  const PriceSale({
    Key key,
    @required this.data,
  }) : super(key: key);
  final String data;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style13_lightgrey.copyWith(
        decoration: TextDecoration.lineThrough,
      ),
    );
  }
}

class ButtonViewDetail extends StatelessWidget {
  final String html;
  const ButtonViewDetail({Key key, @required this.html}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ViewDetailHtml(
                html: html,
              );
            },
          ),
        );
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            color: colorGrey_3,
          ),
          Text(
            tr('product_details_3'),
            style: style15.copyWith(
                color: colorBlue, decoration: TextDecoration.underline),
          )
        ],
      ),
    );
  }
}

class TitleCodeProduct extends StatelessWidget {
  final String title;
  const TitleCodeProduct({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      '${tr('product_details_1')}: ${title}',
      style: style13_lightgrey.copyWith(fontStyle: FontStyle.italic),
    );
  }
}

class TitleProduct extends StatelessWidget {
  final String title;
  const TitleProduct({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style15,
    );
  }
}
