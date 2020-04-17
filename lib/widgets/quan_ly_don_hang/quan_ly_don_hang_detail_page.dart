import 'package:Midas/core/translate/public.dart';
import 'package:Midas/core/page-core/bloc/bloc.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/quan_ly_don_hang/widget/item_news.dart';
import 'package:Midas/widgets/quan_ly_don_hang/widget/items_detail-don-hang.dart';
import 'package:flutter/material.dart';
import 'package:Midas/core/connection-status/index.dart';
import 'package:Midas/core/function/snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/quan_ly_don_hang_bloc.dart';
import 'service/quan_ly_don_hang_service.dart';

class QuanLyDonHangDetail extends StatefulWidget {
  final int id;

  const QuanLyDonHangDetail({Key key, this.id}) : super(key: key);

  // const QuanLyDonHangDetail({Key key, this.id})
  //     : assert(id != null, 'Bắt buộc phải có id truyền vào');
  @override
  _QuanLyDonHangDetailState createState() => _QuanLyDonHangDetailState();
}

class _QuanLyDonHangDetailState extends State<QuanLyDonHangDetail> {
  QuanLyDonHangBloc bloc;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = QuanLyDonHangBloc(
        service:
            QuanLyDonHangService(BlocProvider.of<ErrorhandleBloc>(context)));
    bloc.add(GetOneData(id: widget.id ?? -1));
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      bloc.add(GetOneData(id: widget.id ?? -1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorGrey_1,
        appBar: appBar(),
        body: SafeArea(
          child: listNews(),
        ));
  }

  Widget listNews() {
    return BlocBuilder<QuanLyDonHangBloc, QuanLyDonHangState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is LoadedOneQuanLyDonHang) {
          return ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              ItemThongTinDonHang(
                ma_giao_dich: state.donhang.maGiaoDich,
                thoi_gian_giao_dich: state.donhang.thoiGianGiaoDich,
                tinh_trang: state.donhang.tinhTrang,
              ),
              ItemDiaChiNhan(
                  diaChi: state.donhang.thongTinGiaoDich.giaoHang.diaChi,
                  nguoiNhan: state.donhang.thongTinGiaoDich.giaoHang.hoTen,
                  soDienThoai:
                      state.donhang.thongTinGiaoDich.giaoHang.soDienThoai,
                  ghiChu: state.donhang.thongTinGiaoDich.giaoHang.ghiChu,
                  isNull: state.donhang.thongTinGiaoDich.giaoHang
                              .toJson()
                              .values
                              .join() ==
                          ''
                      ? true
                      : false),
              ItemHinhThucThanhToan(
                hinhThucThanhToan:
                    state.donhang.thongTinGiaoDich.thanhToan.loaiThanhToan,
              ),
              ItemListSanPham(
                sanPham: state.donhang.thongTinGiaoDich.sanPham,
                tongTien: state.donhang.tongTien,
                tienTe: state.donhang.thongTinGiaoDich.donViTienTe.kyHieuTienTe,
              )
            ],
          );
        }
        if (state is ErrorQuanLyDonHangState) {
          return Connection(
            errorType: state.e,
            onPressed: () => setState(() {
              bloc.add(GetData());
            }),
          );
        }

        return Container(
          padding: EdgeInsets.only(top: paddingL),
          child: NewsItemShimmer(),
        );
      },
    );
  }

  Widget appBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: colorWhite, //change your color here
      ),
      flexibleSpace: Image(
        image: AssetImage('assets/images/background_appbar.jpg'),
        fit: BoxFit.cover,
        alignment: AlignmentDirectional.center,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        tr('order_management_8'),
        style: style15_semibold.copyWith(color: colorWhite),
      ),
      // centerTitle: true,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // this._blocQuocGia.dispose();
    // _blocFormDienThoai.close();
  }

  Future<Null> _handleRefresh() async {
    bloc.add(GetData());
    showSnackBarUpdateDataKey(_scaffoldKey);
    return null;
  }
}
