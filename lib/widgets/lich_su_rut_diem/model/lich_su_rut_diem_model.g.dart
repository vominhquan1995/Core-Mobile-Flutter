// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lich_su_rut_diem_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LichSuRutDiemModel _$LichSuRutDiemModelFromJson(Map<String, dynamic> json) {
  return LichSuRutDiemModel(
    thoiGianYeuCau: json['thoi_gian_yeu_cau'] as String ?? '',
    soTienRut: json['so_tien_rut'] as String ?? '',
    ghiChu: json['ghi_chu'] as String ?? '',
    tinhTrang: json['tinh_trang'] as int ?? '',
    logXuLy: (json['log_xu_ly'] as List)
            ?.map((e) => e == null
                ? null
                : LogXuLyModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        '',
  );
}

Map<String, dynamic> _$LichSuRutDiemModelToJson(LichSuRutDiemModel instance) =>
    <String, dynamic>{
      'thoi_gian_yeu_cau': instance.thoiGianYeuCau,
      'so_tien_rut': instance.soTienRut,
      'ghi_chu': instance.ghiChu,
      'tinh_trang': instance.tinhTrang,
      'log_xu_ly': instance.logXuLy?.map((e) => e?.toJson())?.toList(),
    };

LogXuLyModel _$LogXuLyModelFromJson(Map<String, dynamic> json) {
  return LogXuLyModel(
    text: json['text'] as String ?? '',
    nguoiThaoTac: json['nguoi_thao_tac'] as String ?? '',
    thoiGianThaoTac: json['thoi_gian_thao_tac'] as String ?? '',
  );
}

Map<String, dynamic> _$LogXuLyModelToJson(LogXuLyModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'nguoi_thao_tac': instance.nguoiThaoTac,
      'thoi_gian_thao_tac': instance.thoiGianThaoTac,
    };
