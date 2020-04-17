import 'package:Core/utils/index.dart';
import 'package:Core/widgets/hoa_hong_thang/model/index.dart';
import 'package:flutter/material.dart';

class ItemHoaHongThang extends StatelessWidget {
  final HoaHongThangModel data;

  const ItemHoaHongThang({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: borderSide,
      )),
      padding: EdgeInsets.only(bottom: paddingL, top: paddingXS),
      margin: EdgeInsets.only(left: paddingL, right: paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: paddingM),
            child: Text(
              data.noiDung,
              style: style17,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(data.thoiGianGiaoDich,
                      style: style13_lightgrey),
                ),
                Container(
                  child: Text(data.phanTramThem,
                      style: style17_semibold.copyWith(color: colorBlueV2)),
                      // style: style17_semibold.copyWith(color: tongTienColor)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
