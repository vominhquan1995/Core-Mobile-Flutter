// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lich_su_hoa_hong_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HoaHongModel _$HoaHongModelFromJson(Map<String, dynamic> json) {
  return HoaHongModel(
    thoiGianGiaoDich: json['thoi_gian_giao_dich'] as String ?? '',
    noiDung: json['noi_dung'] as String ?? '',
    phanTramThem: json['phan_tram_them'] as String ?? '',
  );
}

Map<String, dynamic> _$HoaHongModelToJson(HoaHongModel instance) =>
    <String, dynamic>{
      'thoi_gian_giao_dich': instance.thoiGianGiaoDich,
      'noi_dung': instance.noiDung,
      'phan_tram_them': instance.phanTramThem,
    };
