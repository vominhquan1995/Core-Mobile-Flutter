// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'don_hang_model_2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonHangModel _$DonHangModelFromJson(Map<String, dynamic> json) {
  return DonHangModel(
    giaoDichId: json['giao_dich_id'] as int ?? '',
    maGiaoDich: json['ma_giao_dich'] as String ?? '',
    tongTien: json['tong_tien'] as String ?? '',
    tinhTrang: json['tinh_trang'] as int ?? '',
    timeCreate: json['time_create'] as String ?? '',
    thoiGianGiaoDich: json['thoi_gian_giao_dich'] as String ?? '',
    thongTinGiaoDich: json['thong_tin_giao_dich'] == null
        ? null
        : ThongTinGiaoDichModel.fromJson(
                json['thong_tin_giao_dich'] as Map<String, dynamic>) ??
            '',
    tieuDeDonHang: json['tieu_de_don_hang'] as String ?? '',
  );
}

Map<String, dynamic> _$DonHangModelToJson(DonHangModel instance) =>
    <String, dynamic>{
      'giao_dich_id': instance.giaoDichId,
      'ma_giao_dich': instance.maGiaoDich,
      'tong_tien': instance.tongTien,
      'tinh_trang': instance.tinhTrang,
      'time_create': instance.timeCreate,
      'thoi_gian_giao_dich': instance.thoiGianGiaoDich,
      'thong_tin_giao_dich': instance.thongTinGiaoDich?.toJson(),
      'tieu_de_don_hang': instance.tieuDeDonHang,
    };

ThongTinGiaoDichModel _$ThongTinGiaoDichModelFromJson(
    Map<String, dynamic> json) {
  return ThongTinGiaoDichModel(
    sanPham: (json['san_pham'] as List)
            ?.map((e) => e == null
                ? null
                : SanPhamModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        '',
    giaoHang: json['giao_hang'] == null
        ? null
        : GiaoHangModel.fromJson(json['giao_hang'] as Map<String, dynamic>),
    khuyenMai: json['khuyen_mai'],
    thanhToan: json['thanh_toan'] == null
        ? null
        : ThanhToanModel.fromJson(json['thanh_toan'] as Map<String, dynamic>),
    donViTienTe: json['don_vi_tien_te'] == null
        ? null
        : TienTeModel.fromJson(
                json['don_vi_tien_te'] as Map<String, dynamic>) ??
            '',
  );
}

Map<String, dynamic> _$ThongTinGiaoDichModelToJson(
        ThongTinGiaoDichModel instance) =>
    <String, dynamic>{
      'san_pham': instance.sanPham?.map((e) => e?.toJson())?.toList(),
      'giao_hang': instance.giaoHang?.toJson(),
      'khuyen_mai': instance.khuyenMai,
      'thanh_toan': instance.thanhToan?.toJson(),
      'don_vi_tien_te': instance.donViTienTe?.toJson(),
    };

GiaoHangModel _$GiaoHangModelFromJson(Map<String, dynamic> json) {
  return GiaoHangModel(
    email: json['email'] as String ?? '',
    hoTen: json['ho_ten'] as String ?? '',
    diaChi: json['dia_chi'] as String ?? '',
    ghiChu: json['ghi_chu'] as String ?? '',
    soDienThoai: json['so_dien_thoai'] as String ?? '',
  );
}

Map<String, dynamic> _$GiaoHangModelToJson(GiaoHangModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'ho_ten': instance.hoTen,
      'dia_chi': instance.diaChi,
      'ghi_chu': instance.ghiChu,
      'so_dien_thoai': instance.soDienThoai,
    };

ThanhToanModel _$ThanhToanModelFromJson(Map<String, dynamic> json) {
  return ThanhToanModel(
    nganHang: json['ngan_hang'],
    thongTin: json['thong_tin'] == null
        ? null
        : ThongTinThanhToanModel.fromJson(
                json['thong_tin'] as Map<String, dynamic>) ??
            '',
    loaiThanhToan: json['loai_thanh_toan'] ?? '',
  );
}

Map<String, dynamic> _$ThanhToanModelToJson(ThanhToanModel instance) =>
    <String, dynamic>{
      'ngan_hang': instance.nganHang,
      'thong_tin': instance.thongTin?.toJson(),
      'loai_thanh_toan': instance.loaiThanhToan,
    };

ThongTinThanhToanModel _$ThongTinThanhToanModelFromJson(
    Map<String, dynamic> json) {
  return ThongTinThanhToanModel(
    email: json['email'] as String ?? '',
    hoTen: json['ho_ten'] as String ?? '',
    diaChi: json['dia_chi'] as String ?? '',
    soDienThoai: json['so_dien_thoai'] as String ?? '',
    nguoiGioiThieu: json['nguoi_gioi_thieu'] as String ?? '',
  );
}

Map<String, dynamic> _$ThongTinThanhToanModelToJson(
        ThongTinThanhToanModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'ho_ten': instance.hoTen,
      'dia_chi': instance.diaChi,
      'so_dien_thoai': instance.soDienThoai,
      'nguoi_gioi_thieu': instance.nguoiGioiThieu,
    };

TienTeModel _$TienTeModelFromJson(Map<String, dynamic> json) {
  return TienTeModel(
    maVung: json['ma_vung'] as String ?? '',
    kyHieuTienTe: json['ky_hieu_tien_te'] as String ?? '',
  );
}

Map<String, dynamic> _$TienTeModelToJson(TienTeModel instance) =>
    <String, dynamic>{
      'ma_vung': instance.maVung,
      'ky_hieu_tien_te': instance.kyHieuTienTe,
    };

SanPhamModel _$SanPhamModelFromJson(Map<String, dynamic> json) {
  return SanPhamModel(
    uid: json['uid'] as String ?? '',
    moTa: json['mo_ta'] as String ?? '',
    donGia: json['don_gia'] as String ?? '',
    soLuong: json['so_luong'] as int ?? '',
    timeCreate: json['time_create'] as String ?? '',
    maSanPham: json['ma_san_pham'] as String ?? '',
    sanPhamId: json['san_pham_id'] as int ?? '',
    tenSanSham: json['ten_san_pham'] as String ?? '',
    hinhDaiDien: json['hinh_dai_dien'] as String ?? '',
    tieuDeDonHang: json['tieu_de_don_hang'] as String ?? '',
  );
}

Map<String, dynamic> _$SanPhamModelToJson(SanPhamModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'mo_ta': instance.moTa,
      'don_gia': instance.donGia,
      'so_luong': instance.soLuong,
      'time_create': instance.timeCreate,
      'ma_san_pham': instance.maSanPham,
      'san_pham_id': instance.sanPhamId,
      'ten_san_pham': instance.tenSanSham,
      'hinh_dai_dien': instance.hinhDaiDien,
      'tieu_de_don_hang': instance.tieuDeDonHang,
    };
