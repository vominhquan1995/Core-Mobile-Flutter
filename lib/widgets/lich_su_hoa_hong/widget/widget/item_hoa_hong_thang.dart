import 'package:Core/utils/index.dart';
import 'package:Core/widgets/lich_su_diem/model/index.dart';
import 'package:Core/widgets/lich_su_hoa_hong/model/index.dart';
import 'package:flutter/material.dart';

class ItemHoaHong extends StatelessWidget {
  final HoaHongModel data;

  const ItemHoaHong({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /**
     * loai_khach_hàng đang set cứng là 1, chưa biết sẽ chuyền gì vào
     * Phần text tiêu để thì sẽ có những gì (tài khoản, sđt) ??
     */
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
                  child: Text(data.thoiGianGiaoDich, style: style13_lightgrey),
                ),
                Container(
                  child: Text(data.phanTramThem,
                      style: style17_semibold.copyWith(
                          color: colorBlueV2)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
