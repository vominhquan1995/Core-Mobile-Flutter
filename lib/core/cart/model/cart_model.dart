import 'package:Core/core/cart/db/cart_provider.dart';
import 'package:equatable/equatable.dart';

class CartItemModel extends Equatable {
  final String uid;
  final String sanphamid;
  final String masanpham;
  final String tensanpham;
  final String mota;
  final num dongia;
  final num dongiagoc;
  final num percent;
  final String hinhdaidien;
  final int soluong;
  final bool iskhuyenmai;
  List<int> listtinhchatids = new List<int>(); // [80, 84]
  List<String> listtinhchatname = new List<String>();

  CartItemModel(
      {this.uid = '',
      this.sanphamid = '',
      this.masanpham = '',
      this.tensanpham = '',
      this.mota = '',
      this.hinhdaidien = '',
      this.soluong = 1,
      this.iskhuyenmai = false,
      this.percent = 0,
      this.dongia = 0,
      this.dongiagoc = 0,
      List<int> listtinhchatids,
      List<String> listtinhchatname})
      : listtinhchatids = listtinhchatids ?? [],
        listtinhchatname = listtinhchatname ?? [];

  @override
  // TODO: implement props
  List<Object> get props => [
        uid,
        sanphamid,
        masanpham,
        tensanpham,
        mota,
        percent,
        dongia,
        dongiagoc,
        hinhdaidien,
        soluong,
        iskhuyenmai,
        listtinhchatids,
        listtinhchatname,
      ];
}

class CartInfoModel {
  String id;
  String ten;
  String sodienthoai;
  String diachi;
  String ghichu;
  String tinhid;
  String quanid;
  String phuongid;
  String tinhname;
  String quanname;
  String phuongname;
  num tienhoahong;
  int withmidaswallet;
  int loaithanhtoan;
  CartInfoModel(
      {this.id = "",
      this.ten = "",
      this.sodienthoai = "",
      this.diachi = "",
      this.ghichu = "",
      this.tinhid = "",
      this.quanid = "",
      this.phuongid = "",
      this.tinhname = "",
      this.quanname = "",
      this.phuongname = "",
      this.tienhoahong = 0,
      this.withmidaswallet = 0,
      this.loaithanhtoan = 0});
}

class CartResultModel {
  String id;
  String madonhang;
  String sodienthoai;
  String ten;
  num tongtien;
  int tinhtrang;
  int loaithanhtoan;
  CartResultModel(
      {this.id = "",
      this.madonhang = "",
      this.ten = "",
      this.sodienthoai = "",
      this.tongtien = 0,
      this.loaithanhtoan = 0,
      this.tinhtrang = 0});
}

const String TABLE_CART =
    "CREATE TABLE IF NOT EXISTS ${CartProvider.CART_TABLE_NAME} (" +
        "uid TEXT PRIMARY KEY," +
        "sanphamid TEXT," +
        "tensanpham TEXT," +
        "masanpham TEXT," +
        "hinhdaidien TEXT," +
        "dongia REAL," +
        "listtinhchatids TEXT," +
        "soluong INTEGER )";

const String TABLE_CART_INFO =
    "CREATE TABLE IF NOT EXISTS ${CartProvider.INFO_TABLE_NAME} (" +
        "id TEXT PRIMARY KEY," +
        "ten TEXT," +
        "sodienthoai TEXT," +
        "diachi TEXT," +
        "tinhid TEXT," +
        "quanid TEXT," +
        "phuongid TEXT," +
        "tinhname TEXT," +
        "quanname TEXT," +
        "phuongname TEXT," +
        "tienhoahong REAL," +
        "withmidaswallet INTEGER," +
        "loaithanhtoan INTEGER," +
        "ghichu TEXT )";
