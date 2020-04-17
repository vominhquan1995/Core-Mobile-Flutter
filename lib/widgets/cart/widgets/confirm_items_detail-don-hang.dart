import 'package:Core/core/cart/model/cart_model.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/quan_ly_don_hang/model/don_hang_model_2.dart';
import 'package:Core/widgets/shared/image-custom/image-custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemDiaChiNhan extends StatelessWidget {
  final CartInfoModel data;

  const ItemDiaChiNhan({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingL),
      margin: EdgeInsets.only(bottom: paddingM),
      color: colorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: paddingM),
            child: Text(
              tr('cart_confirm_3'),
              style: style15_semibold.copyWith(height: lineHeight3),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  '- ${data.ten} (${data.sodienthoai})',
                  style: style15.copyWith(height: lineHeight3),
                ),
              ),
              Container(
                child: Text(
                  '- ${data.diachi}',
                  style: style15.copyWith(height: lineHeight3),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: paddingM),
                child: Text(
                  tr('cart_confirm_4'),
                  style: style15.copyWith(
                      height: lineHeight3,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline),
                ),
              ),
              Container(
                child: Text(
                  '${data.ghichu}',
                  style: style15.copyWith(height: lineHeight3),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ItemHinhThucThanhToan extends StatelessWidget {
  final CartInfoModel data;

  const ItemHinhThucThanhToan({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var hinhThuc =
        (data.withmidaswallet == 1 ? '${tr("cart_payment_3")} + ' : '') +
            (data.loaithanhtoan.toString() == '4'
                ? tr('cart_confirm_6')
                : tr('cart_confirm_7'));
    return Container(
      padding: EdgeInsets.all(paddingL),
      margin: EdgeInsets.only(bottom: paddingXXS),
      color: colorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: paddingM),
            child: Text(
              tr('cart_confirm_5'),
              style: style15_semibold.copyWith(height: lineHeight3),
            ),
          ),
          Container(
            child: Text(
              hinhThuc,
              style: style15.copyWith(height: lineHeight3),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemListSanPham extends StatelessWidget {
  final dynamic sanPham;
  final String currency;

  const ItemListSanPham({Key key, this.sanPham, this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingL),
      margin: EdgeInsets.only(bottom: paddingM),
      color: colorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: paddingM),
            child: Text(
              tr('cart_confirm_2'),
              style: style15_semibold.copyWith(height: lineHeight3),
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border()),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: sanPham.length ?? 0,
                itemBuilder: (context, i) {
                  return ItemSanPham(data: sanPham[i], currency: currency);
                }),
          ),
        ],
      ),
    );
  }
}

class ItemSanPham extends StatelessWidget {
  final CartItemModel data;
  final String currency;

  const ItemSanPham({Key key, this.data, this.currency}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: paddingXS),
      child: Row(
        children: <Widget>[
          Container(
            width: 46,
            height: 46,
            margin: EdgeInsets.only(right: paddingL),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(blurRadius)),
            ),
            child: HinhAnh(
              image: data.hinhdaidien,
            ),
          ),
          Container(
            child: Expanded(
                child: Container(
              child: Text(
                data.tensanpham,
                style: style15.copyWith(
                    fontWeight: FontWeight.w400, height: lineHeight3),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )),
          ),
          Container(
            margin: EdgeInsets.only(left: paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                    child: RichText(
                  text: TextSpan(
                      text: NumberFormat(currency).format(data.dongia),
                      style: style15.copyWith(
                          fontWeight: FontWeight.w400, height: lineHeight3)),
                )),
                Container(
                  child: Text(
                    'x${data.soluong}',
                    style: style15.copyWith(
                        fontWeight: FontWeight.w400, height: lineHeight3),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
