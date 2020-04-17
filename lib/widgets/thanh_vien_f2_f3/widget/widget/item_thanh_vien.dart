import 'package:Core/core/translate/public.dart';
import 'package:Core/utils/index.dart';
import 'package:flutter/material.dart';

class ItemThanhVien extends StatelessWidget {
  final String tenShop;
  final String taiKhoan;
  final String diaChi;

  const ItemThanhVien({Key key, this.tenShop, this.taiKhoan, this.diaChi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: borderSide,
      )),
      padding: EdgeInsets.only(bottom: paddingL, top: paddingXS),
      // margin: EdgeInsets.only(left: paddingL, right: paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: paddingM),
            child: Text(
              tenShop + ' ($taiKhoan)',
              style: style15_semibold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            child: Text(
              diaChi != ''
                  ? diaChi
                  : tr('member_6'),
              style: style13_lightgrey.copyWith(height: lineHeight3),
            ),
          ),
        ],
      ),
    );
  }
}
