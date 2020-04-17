// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quocgia_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuocGiaModel _$QuocGiaModelFromJson(Map<String, dynamic> json) {
  return QuocGiaModel(
    quocGiaId: json['quoc_gia_id'] as String,
    tiGiaTienTe: json['ti_gia_tien_te'] as String ?? '',
    kyHieuTienTe: json['ky_hieu_tien_te'] as String ?? '',
    maVung: json['ma_vung'] as String ?? '',
    tenQG: json['quoc_gia_name'] as String ?? '',
    status: json['current_status'] as String ?? 'deactive',
    locale: json['locale'] as String ?? 'en_US',
    flag: json['link_flag'] as String ?? '',
    linkWeb: json['link_web'] as String ?? '',
  );
}

Map<String, dynamic> _$QuocGiaModelToJson(QuocGiaModel instance) =>
    <String, dynamic>{
      'quoc_gia_id': instance.quocGiaId,
      'quoc_gia_name': instance.tenQG,
      'ma_vung': instance.maVung,
      'ti_gia_tien_te': instance.tiGiaTienTe,
      'ky_hieu_tien_te': instance.kyHieuTienTe,
      'current_status': instance.status,
      'locale': instance.locale,
      'link_flag': instance.flag,
      'link_web': instance.linkWeb,
    };

// **************************************************************************
// JsonLiteralGenerator
// **************************************************************************

final _$dataQuocGiaJsonJsonLiteral = {
  'result': [
    {
      'quoc_gia_id': '9',
      'quoc_gia_name': 'VIETNAM',
      'ma_vung': 'VN',
      'locale': 'vi',
      'ti_gia_tien_te': '23000.00000000',
      'current_status': 'active',
      'ky_hieu_tien_te': 'đ'
    },
    {
      'quoc_gia_id': '6',
      'quoc_gia_name': 'CAMBODIA',
      'ma_vung': 'KH',
      'locale': 'km',
      'ti_gia_tien_te': '1.00000000',
      'current_status': 'active',
      'ky_hieu_tien_te': 'USD'
    }
  ]
};
