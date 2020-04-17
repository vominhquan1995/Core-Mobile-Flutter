import 'package:json_annotation/json_annotation.dart';
part 'don_hang_model_2.g.dart';

@JsonSerializable(explicitToJson: true)
class DonHangModel {
  @JsonKey(name: 'giao_dich_id', defaultValue: '')
  final int giaoDichId;
  @JsonKey(name: 'ma_giao_dich', defaultValue: '')
  final String maGiaoDich;
  @JsonKey(name: 'tong_tien', defaultValue: '')
  final String tongTien;
  @JsonKey(name: 'tinh_trang', defaultValue: '')
  final int tinhTrang;
  @JsonKey(name: 'time_create', defaultValue: '')
  final String timeCreate;
  @JsonKey(name: 'thoi_gian_giao_dich', defaultValue: '')
  final String thoiGianGiaoDich;
  @JsonKey(name: 'thong_tin_giao_dich', defaultValue: '')
  final ThongTinGiaoDichModel thongTinGiaoDich;
  @JsonKey(name: 'tieu_de_don_hang', defaultValue: '')
  final String tieuDeDonHang;

  DonHangModel(
      {this.giaoDichId,
      this.maGiaoDich,
      this.tongTien,
      this.tinhTrang,
      this.timeCreate,
      this.thoiGianGiaoDich,
      this.thongTinGiaoDich,
      this.tieuDeDonHang});

  factory DonHangModel.fromJson(Map<String, dynamic> json) =>
      _$DonHangModelFromJson(json);

  Map<String, dynamic> toJson() => _$DonHangModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ThongTinGiaoDichModel {
  @JsonKey(name: 'san_pham', defaultValue: '')
  final List<SanPhamModel> sanPham;
  @JsonKey(name: 'giao_hang')
  final GiaoHangModel giaoHang;
  @JsonKey(name: 'khuyen_mai')
  final dynamic khuyenMai;
  @JsonKey(name: 'thanh_toan')
  final ThanhToanModel thanhToan;
  @JsonKey(name: 'don_vi_tien_te', defaultValue: '')
  final TienTeModel donViTienTe;

  ThongTinGiaoDichModel(
      {this.sanPham,
      this.giaoHang,
      this.khuyenMai,
      this.thanhToan,
      this.donViTienTe});

  factory ThongTinGiaoDichModel.fromJson(Map<String, dynamic> json) =>
      _$ThongTinGiaoDichModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThongTinGiaoDichModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GiaoHangModel {
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'ho_ten', defaultValue: '')
  final String hoTen;
  @JsonKey(name: 'dia_chi', defaultValue: '')
  final String diaChi;
  @JsonKey(name: 'ghi_chu', defaultValue: '')
  final String ghiChu;
  @JsonKey(name: 'so_dien_thoai', defaultValue: '')
  final String soDienThoai;

  GiaoHangModel(
      {this.email, this.hoTen, this.diaChi, this.ghiChu, this.soDienThoai});

  factory GiaoHangModel.fromJson(Map<String, dynamic> json) =>
      _$GiaoHangModelFromJson(json);

  Map<String, dynamic> toJson() => _$GiaoHangModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ThanhToanModel {
  @JsonKey(name: 'ngan_hang')
  final dynamic nganHang;
  @JsonKey(name: 'thong_tin', defaultValue: '')
  final ThongTinThanhToanModel thongTin;
  @JsonKey(name: 'loai_thanh_toan', defaultValue: '')
  final dynamic loaiThanhToan;

  ThanhToanModel({this.nganHang, this.thongTin, this.loaiThanhToan});

  factory ThanhToanModel.fromJson(Map<String, dynamic> json) =>
      _$ThanhToanModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThanhToanModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ThongTinThanhToanModel {
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'ho_ten', defaultValue: '')
  final String hoTen;
  @JsonKey(name: 'dia_chi', defaultValue: '')
  final String diaChi;
  @JsonKey(name: 'so_dien_thoai', defaultValue: '')
  final String soDienThoai;
  @JsonKey(name: 'nguoi_gioi_thieu', defaultValue: '')
  final String nguoiGioiThieu;

  ThongTinThanhToanModel(
      {this.email,
      this.hoTen,
      this.diaChi,
      this.soDienThoai,
      this.nguoiGioiThieu});

  factory ThongTinThanhToanModel.fromJson(Map<String, dynamic> json) =>
      _$ThongTinThanhToanModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThongTinThanhToanModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TienTeModel {
  @JsonKey(name: 'ma_vung', defaultValue: '')
  final String maVung;
  @JsonKey(name: 'ky_hieu_tien_te', defaultValue: '')
  final String kyHieuTienTe;

  TienTeModel({this.maVung, this.kyHieuTienTe});

  factory TienTeModel.fromJson(Map<String, dynamic> json) =>
      _$TienTeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TienTeModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SanPhamModel {
  @JsonKey(name: 'uid', defaultValue: '')
  final String uid;
  @JsonKey(name: 'mo_ta', defaultValue: '')
  final String moTa;
  @JsonKey(name: 'don_gia', defaultValue: '')
  final String donGia;
  @JsonKey(name: 'so_luong', defaultValue: '')
  final int soLuong;
  @JsonKey(name: 'time_create', defaultValue: '')
  final String timeCreate;
  @JsonKey(name: 'ma_san_pham', defaultValue: '')
  final String maSanPham;
  @JsonKey(name: 'san_pham_id', defaultValue: '')
  final int sanPhamId;
  @JsonKey(name: 'ten_san_pham', defaultValue: '')
  final String tenSanSham;
  @JsonKey(name: 'hinh_dai_dien', defaultValue: '')
  final String hinhDaiDien;
  @JsonKey(name: 'tieu_de_don_hang', defaultValue: '')
  final String tieuDeDonHang;

  SanPhamModel(
      {this.uid,
      this.moTa,
      this.donGia,
      this.soLuong,
      this.timeCreate,
      this.maSanPham,
      this.sanPhamId,
      this.tenSanSham,
      this.hinhDaiDien,
      this.tieuDeDonHang});

  factory SanPhamModel.fromJson(Map<String, dynamic> json) =>
      _$SanPhamModelFromJson(json);

  Map<String, dynamic> toJson() => _$SanPhamModelToJson(this);
}
