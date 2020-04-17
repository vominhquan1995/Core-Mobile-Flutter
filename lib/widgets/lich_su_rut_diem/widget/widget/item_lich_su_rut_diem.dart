import 'package:Core/core/translate/public.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/lich_su_rut_diem/model/lich_su_rut_diem_model.dart';
import 'package:flutter/material.dart';

class ItemLichSuRutDiem extends StatelessWidget {
  final LichSuRutDiemModel data;

  const ItemLichSuRutDiem({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color tinhTrangColor = data.tinhTrang == 0
        ? colorBlueV2
        : data.tinhTrang == 1 ? colorOrange : colorBlack;
    String tinhTrangText = data.tinhTrang == 0
        ? tr('log_point_request_2')
        : data.tinhTrang == 1
            ? tr('log_point_request_4')
            : tr('log_point_request_3');
    TextDecoration tinhTrangDecor =
        data.tinhTrang == 2 ? TextDecoration.lineThrough : TextDecoration.none;
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: paddingM),
                  child: Text(
                    data.soTienRut,
                    style: style22_semibold,
                  ),
                ),
                Container(
                  child: Text(
                    tinhTrangText,
                    style: style17_semibold.copyWith(
                        color: tinhTrangColor, decoration: tinhTrangDecor),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Container(
              child: Text('${data.thoiGianYeuCau}', style: style13_lightgrey),
            ),
          ),
          data.tinhTrang == 2
              ? Container(
                  padding: EdgeInsets.only(top: paddingM),
                  child: Text(
                    tr('log_point_request_5'),
                    style:
                        style15.copyWith(decoration: TextDecoration.underline),
                  ),
                )
              : Container(),
          data.tinhTrang == 2
              ? Container(
                  child: Text(
                    data.logXuLy[0].text,
                    style: style15.copyWith(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
