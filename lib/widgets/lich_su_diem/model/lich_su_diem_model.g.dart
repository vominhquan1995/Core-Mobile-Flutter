// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lich_su_diem_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LichSuDiemModel _$LichSuDiemModelFromJson(Map<String, dynamic> json) {
  return LichSuDiemModel(
    id: json['id'] as String ?? '',
    nguoiGiaoDich: json['nguoi_giao_dich'] as String ?? '',
    soTien: json['so_tien'] as String ?? '',
    noiDungGiaoDich: json['noi_dung_giao_dich'] as String ?? '',
    timeCreate: json['time_create'] as String ?? '',
    loaiGiaoDich: json['loai_giao_dich'] as int ?? '',
  );
}

Map<String, dynamic> _$LichSuDiemModelToJson(LichSuDiemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nguoi_giao_dich': instance.nguoiGiaoDich,
      'so_tien': instance.soTien,
      'noi_dung_giao_dich': instance.noiDungGiaoDich,
      'time_create': instance.timeCreate,
      'loai_giao_dich': instance.loaiGiaoDich,
    };
