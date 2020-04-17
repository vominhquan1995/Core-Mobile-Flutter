class DonHangModel {
  int giao_dich_id;
  String ma_giao_dich;
  String tong_tien;
  int tinh_trang;
  String time_create;
  String thoi_gian_giao_dich;
  dynamic thong_tin_giao_dich;
  String tieu_de_don_hang;
  dynamic giao_hang;
  dynamic thanh_toan;
  dynamic loai_thanh_toan;
  String don_vi_tien_te;

  DonHangModel({
    this.giao_dich_id = 0,
    this.ma_giao_dich = '',
    this.tong_tien = '',
    this.tinh_trang = 0,
    this.time_create = '',
    this.thoi_gian_giao_dich = '',
    this.thong_tin_giao_dich ,
    this.giao_hang ,
    this.thanh_toan,
    this.loai_thanh_toan = '',
    this.don_vi_tien_te = '',
    this.tieu_de_don_hang = '',
  });
  // Map<String, Object> toJson() {
  //   return {
  //     'ten_san_pham': ten_san_pham,
  //     'ma_don_hang': ma_don_hang,
  //     'thoi_gian': thoi_gian,
  //     'tinh_trang': tinh_trang,
  //     'nguoi_nhan': nguoi_nhan,
  //     'so_dien_thoai': so_dien_thoai,
  //     'dia_chi_nhan': dia_chi_nhan,
  //     'ghi_chu': ghi_chu,
  //     'hinh_thuc_thanh_toan': hinh_thuc_thanh_toan,
  //     'san_pham': san_pham,
  //     'tong_tien': tong_tien,
  //   };
  // }

  factory DonHangModel.fromJson(Map<String, dynamic> doc) {
    // DonHangModel donHang = new DonHangModel(
    //   ten_san_pham: doc['ten_san_pham'],
    //   ma_don_hang: doc['ma_don_hang'],
    //   thoi_gian: doc['thoi_gian'],
    //   tinh_trang: doc['tinh_trang'],
    //   nguoi_nhan: doc['nguoi_nhan'],
    //   so_dien_thoai: doc['so_dien_thoai'],
    //   dia_chi_nhan: doc['dia_chi_nhan'],
    //   ghi_chu: doc['ghi_chu'],
    //   hinh_thuc_thanh_toan: doc['hinh_thuc_thanh_toan'],
    //   san_pham: doc['san_pham'],
    //   tong_tien: doc['tong_tien'],
    // );
    // return donHang;
  }

  factory DonHangModel.fromDocument(dynamic doc) {
    return DonHangModel.fromJson(doc);
  }
}
