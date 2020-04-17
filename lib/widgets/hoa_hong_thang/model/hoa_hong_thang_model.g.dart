// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hoa_hong_thang_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HoaHongThangModel _$HoaHongThangModelFromJson(Map<String, dynamic> json) {
  return HoaHongThangModel(
    thoiGianGiaoDich: json['thoi_gian_giao_dich'] as String ?? '',
    noiDung: json['noi_dung'] as String ?? '',
    phanTramThem: json['phan_tram_them'] as String ?? '',
  );
}

Map<String, dynamic> _$HoaHongThangModelToJson(HoaHongThangModel instance) =>
    <String, dynamic>{
      'thoi_gian_giao_dich': instance.thoiGianGiaoDich,
      'noi_dung': instance.noiDung,
      'phan_tram_them': instance.phanTramThem,
    };

HoaHongThangHienTaiModel _$HoaHongThangHienTaiModelFromJson(
    Map<String, dynamic> json) {
  return HoaHongThangHienTaiModel(
    result: (json['result'] as List)
        ?.map((e) => e == null
            ? null
            : HoaHongThangModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    sum: json['sum'] as String ?? '',
  );
}

Map<String, dynamic> _$HoaHongThangHienTaiModelToJson(
        HoaHongThangHienTaiModel instance) =>
    <String, dynamic>{
      'result': instance.result?.map((e) => e?.toJson())?.toList(),
      'sum': instance.sum,
    };
