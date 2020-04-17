import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/quan_ly_don_hang/model/don_hang_model_2.dart';
import 'package:Midas/widgets/shared/image-custom/image-custom.dart';
import 'package:flutter/material.dart';

class ItemThongTinDonHang extends StatelessWidget {
  final String ma_giao_dich;
  final String thoi_gian_giao_dich;
  final int tinh_trang;

  const ItemThongTinDonHang(
      {Key key, this.ma_giao_dich, this.thoi_gian_giao_dich, this.tinh_trang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String tinh_trang_text = tinh_trang == 1
        ? tr('order_management_5')
        : tinh_trang == 2 ? tr('order_management_6') : tr('order_management_7');
    return Container(
      padding: EdgeInsets.all(paddingL),
      margin: EdgeInsets.only(bottom: paddingM),
      color: colorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              tr('order_management_2') + ': ${ma_giao_dich}',
              style: style15_semibold.copyWith(height: lineHeight3),
            ),
          ),
          Container(
            child: Text(
              tr('order_management_18') + ': ${thoi_gian_giao_dich}',
              style: style15.copyWith(height: lineHeight3),
            ),
          ),
          Container(
            child: Text(
              tr('order_management_4') + ': ${tinh_trang_text}',
              style: style15.copyWith(height: lineHeight3),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemDiaChiNhan extends StatelessWidget {
  final dynamic nguoiNhan;
  final dynamic soDienThoai;
  final dynamic diaChi;
  final dynamic ghiChu;
  final bool isNull;

  const ItemDiaChiNhan(
      {Key key,
      this.nguoiNhan,
      this.soDienThoai,
      this.diaChi,
      this.ghiChu,
      this.isNull})
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
              tr('order_management_10'),
              style: style15_semibold.copyWith(height: lineHeight3),
            ),
          ),
          !isNull
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '- ${nguoiNhan} (${soDienThoai})',
                        style: style15.copyWith(height: lineHeight3),
                      ),
                    ),
                    Container(
                      child: Text(
                        '- ${diaChi}',
                        style: style15.copyWith(height: lineHeight3),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: paddingM),
                      child: Text(
                        tr('order_management_11'),
                        style: style15.copyWith(
                            height: lineHeight3,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    Container(
                      child: Text(
                        '${ghiChu}',
                        style: style15.copyWith(height: lineHeight3),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: Text(
                    tr('order_management_17'),
                    style: style13_lightgrey.copyWith(height: lineHeight3),
                  ),
                ),
        ],
      ),
    );
  }
}

class ItemHinhThucThanhToan extends StatelessWidget {
  final dynamic hinhThucThanhToan;

  const ItemHinhThucThanhToan({Key key, this.hinhThucThanhToan})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var hinhThuc = hinhThucThanhToan.toString() == '4'
        ? tr('order_management_13')
        : tr('order_management_14');
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
              tr('order_management_12'),
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
  final String tongTien;
  final String tienTe;

  const ItemListSanPham({Key key, this.sanPham, this.tongTien, this.tienTe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              tr('order_management_15'),
              style: style15_semibold.copyWith(height: lineHeight3),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
              bottom: borderSide,
            )),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: sanPham.length ?? 0,
                itemBuilder: (context, i) {
                  return ItemSanPham(data: sanPham[i], tienTe: tienTe);
                }),
          ),
          Container(
            padding: EdgeInsets.only(top: paddingL, bottom: paddingXS),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    tr('order_management_16'),
                    style: style15.copyWith(height: lineHeight3),
                  ),
                ),
                Container(
                    child: RichText(
                  text: TextSpan(
                      text: tongTien + ' ',
                      style: style22_semibold.copyWith(
                          height: lineHeight3, color: colorOrange),
                      children: [
                        TextSpan(
                            text: tienTe,
                            style: style22_semibold.copyWith(
                              color: colorOrange,
                              height: lineHeight3,
                            )),
                      ]),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ItemSanPham extends StatelessWidget {
  final SanPhamModel data;
  final dynamic tienTe;

  const ItemSanPham({Key key, this.data, this.tienTe}) : super(key: key);
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
              image: data.hinhDaiDien,
            ),
          ),
          Container(
            child: Expanded(
                child: Container(
              child: Text(
                data.tenSanSham,
                style: style15.copyWith(height: lineHeight3),
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
                      text: data.donGia,
                      style: style15.copyWith(height: lineHeight3),
                      children: [
                        TextSpan(
                            text: tienTe,
                            style: style15.copyWith(
                              height: lineHeight3,
                            )),
                      ]),
                )),
                Container(
                  child: Text(
                    'x${data.soLuong}',
                    style: style15.copyWith(height: lineHeight3),
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
