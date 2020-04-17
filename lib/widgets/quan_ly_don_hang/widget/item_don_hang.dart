import 'package:Core/core/translate/public.dart';
import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/quan_ly_don_hang/model/don_hang_model_2.dart';
import 'package:Core/widgets/quan_ly_don_hang/quan_ly_don_hang_detail_page.dart';
import 'package:flutter/material.dart';

class ItemDonHang extends StatelessWidget {
  final DonHangModel data;

  const ItemDonHang({Key key, this.data}) : super(key: key);

  goToDetail(context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => WidgetsCore(
                widget: QuanLyDonHangDetail(
              id: data.giaoDichId,
            ))));
  }

  /**
   *  Đã thanh toán: 1
   *  Đợi thanh toán: 2
   *  Đã hủy: 3
   */
  @override
  Widget build(BuildContext context) {
    String tinh_trang_text = data.tinhTrang == 1
        ? tr('order_management_5')
        : data.tinhTrang == 2
            ? tr('order_management_6')
            : tr('order_management_7');
    Color tinh_trang_color = data.tinhTrang == 1
        ? colorBlueV2
        : data.tinhTrang == 2 ? colorOrange : colorBlack;
    TextDecoration tinh_trang_decor = data.tinhTrang == 1
        ? TextDecoration.none
        : data.tinhTrang == 2
            ? TextDecoration.none
            : TextDecoration.lineThrough;
    return InkWell(
      onTap: () {
        goToDetail(context);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: borderSide,
        )),
        padding: EdgeInsets.only(bottom: paddingL, top: paddingL),
        margin: EdgeInsets.only(left: paddingL, right: paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              data.tieuDeDonHang ?? '',
              style: style15,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: paddingM),
            RichText(
              text: TextSpan(
                style: style13_lightgrey,
                children: [
                  TextSpan(
                    text: '${tr('order_management_2')}: ',
                  ),
                  TextSpan(
                    text: '${data.maGiaoDich}',
                    style: style15_semibold,
                  ),
                ],
              ),
            ),
            Text(tr('order_management_3') + ': ${data.thoiGianGiaoDich}',
                // 'Đặt hàng: ${data.thoi_gian_giao_dich}',
                style: style13_lightgrey.copyWith(height: lineHeight3)),
            RichText(
              text: TextSpan(
                text: tr('order_management_4') + ': ',
                style: style13_lightgrey.copyWith(height: lineHeight3),
                children: <TextSpan>[
                  TextSpan(
                    text: tinh_trang_text,
                    style: style15_semibold.copyWith(
                      color: tinh_trang_color,
                      decoration: tinh_trang_decor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
