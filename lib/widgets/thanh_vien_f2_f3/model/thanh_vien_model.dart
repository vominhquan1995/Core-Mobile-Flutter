import 'package:Midas/core/google_analytics/google_analytics_page.dart';
import 'package:Midas/widgets/thanh_vien_f2_f3/db/news_provider.dart';

class PhanCapModel {
  String tai_khoan;
  String dia_chi_shop;
  String ten_shop;
  // int level_vip;
  // String cmnd;
  // String email;
  // String ho_ten;
  // String dia_chi;
  // String quan_id;
  // String tinh_id;
  // String ngay_cap;
  // String gioi_tinh;
  // String ngay_sinh;
  // String quan_name;
  // String tinh_name;
  // String quoc_gia_id;
  // String quoc_gia_name;
  // String so_dien_thoai;
  // String ten_ngan_hang;
  // String ho_ten_khong_dau;
  // String don_vi_tien_te_id;
  // String don_vi_tien_te_name;
  // String tai_khoan_ngan_hang;

  PhanCapModel({
    this.tai_khoan,
    this.dia_chi_shop,
    this.ten_shop,
    // this.level_vip,
    // this.cmnd,
    // this.email,
    // this.ho_ten,
    // this.dia_chi,
    // this.quan_id,
    // this.tinh_id,
    // this.ngay_cap,
    // this.gioi_tinh,
    // this.ngay_sinh,
    // this.quan_name,
    // this.tinh_name,
    // this.quoc_gia_id,
    // this.quoc_gia_name,
    // this.so_dien_thoai,
    // this.ten_ngan_hang,
    // this.ho_ten_khong_dau,
    // this.don_vi_tien_te_id,
    // this.don_vi_tien_te_name,
    // this.tai_khoan_ngan_hang,
  });

  factory PhanCapModel.fromJson(Map<String, dynamic> doc) {
    PhanCapModel phanCap = new PhanCapModel(
      tai_khoan: doc['tai_khoan'],
      dia_chi_shop: doc['thong_tin_ca_nhan']['dia_chi_shop'],
      ten_shop: doc['thong_tin_ca_nhan']['ten_shop'],
      // cmnd: doc['cmnd'],
      // email: doc['thong_tin_ca_nhan']['email'],
      // ho_ten: doc['thong_tin_ca_nhan']['ho_ten'],
      // dia_chi: doc['thong_tin_ca_nhan']['dia_chi'],
      // quan_id: doc['thong_tin_ca_nhan']['quan_id'],
      // tinh_id: doc['thong_tin_ca_nhan']['tinh_id'],
      // ngay_cap: doc['thong_tin_ca_nhan']['ngay_cap'],
      // gioi_tinh: doc['thong_tin_ca_nhan']['gioi_tinh'],
      // ngay_sinh: doc['thong_tin_ca_nhan']['ngay_sinh'],
      // quan_name: doc['thong_tin_ca_nhan']['quan_name'],
      // tinh_name: doc['thong_tin_ca_nhan']['dia_chi'],
      // quoc_gia_id: doc['thong_tin_ca_nhan']['quoc_gia_id'],
      // quoc_gia_name: doc['thong_tin_ca_nhan']['quoc_gia_name'],
      // so_dien_thoai: doc['thong_tin_ca_nhan']['so_dien_thoai'],
      // ten_ngan_hang: doc['thong_tin_ca_nhan']['ten_ngan_hang'],
      // ho_ten_khong_dau: doc['thong_tin_ca_nhan']['ho_ten_khong_dau'],
      // don_vi_tien_te_id: doc['thong_tin_ca_nhan']['don_vi_tien_te_id'],
      // don_vi_tien_te_name: doc['thong_tin_ca_nhan']['don_vi_tien_te_name'],
      // tai_khoan_ngan_hang: doc['thong_tin_ca_nhan']['tai_khoan_ngan_hang'],
      // level_vip: doc['level_vip'],
    );
    return phanCap;
  }
  factory PhanCapModel.fromJsonSqlite(Map<String, dynamic> doc) {
    PhanCapModel phanCap = new PhanCapModel(
      tai_khoan: doc['tai_khoan'],
      dia_chi_shop: doc['dia_chi_shop'],
      ten_shop: doc['ten_shop'],
    );
    return phanCap;
  }

/**
 * Dùng cho Sqlite
 */
  Map<String, Object> toJson() {
    return {
      'tai_khoan': tai_khoan,
      'dia_chi_shop': dia_chi_shop,
      'ten_shop': ten_shop,
    };
  }
}

const String columnTaiKhoan = 'tai_khoan';
const String columnDiaChiShop = 'dia_chi_shop';
const String columnTenShop = 'ten_shop';

const String TABLE_THANHVIEN =
    "CREATE TABLE IF NOT EXISTS ${ThanhVienDB.TABLE_NAME} (" +
        "tai_khoan TEXT," +
        "dia_chi_shop TEXT," +
        "ten_shop TEXT" +
        ")";
