// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'huong_dang_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HuongDanHeader _$HuongDanHeaderFromJson(Map<String, dynamic> json) {
  return HuongDanHeader(
    titleHeader: json['title_header'] as String ?? '',
  )..list = (json['tra_cuu'] as List)
      .map((e) => HuongDan.fromJson(e as Map<String, dynamic>))
      .toList();
}

Map<String, dynamic> _$HuongDanHeaderToJson(HuongDanHeader instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title_header', instance.titleHeader);
  val['tra_cuu'] = instance.list;
  return val;
}

HuongDan _$HuongDanFromJson(Map<String, dynamic> json) {
  return HuongDan(
    noiDung: json['noi_dung'] as String ?? '',
    id: json['id'] as String,
    linkSeo: json['link_seo'] as String ?? '',
  );
}

Map<String, dynamic> _$HuongDanToJson(HuongDan instance) => <String, dynamic>{
      'noi_dung': instance.noiDung,
      'id': instance.id,
      'link_seo': instance.linkSeo,
    };
