// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thong_tin_diem_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThongTinDiemModel _$ThongTinDiemModelFromJson(Map<String, dynamic> json) {
  return ThongTinDiemModel(
    tienHoaHong: json['tien_hoa_hong'] as String ?? '0',
    taiKhoanNganHang: json['tai_khoan_ngan_hang'] as String ?? '',
    tenNganHang: json['ten_ngan_hang'] as String ?? '',
    tenNguoiNhan: json['ten_nguoi_nhan'] as String ?? '',
  );
}

Map<String, dynamic> _$ThongTinDiemModelToJson(ThongTinDiemModel instance) =>
    <String, dynamic>{
      'tien_hoa_hong': instance.tienHoaHong,
      'tai_khoan_ngan_hang': instance.taiKhoanNganHang,
      'ten_ngan_hang': instance.tenNganHang,
      'ten_nguoi_nhan': instance.tenNguoiNhan,
    };
