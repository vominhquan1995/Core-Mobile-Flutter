// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracuu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TraCuu _$TraCuuFromJson(Map<String, dynamic> json) {
  return TraCuu(
    noiDung: json['noi_dung'] as String ?? '',
    id: json['id'] as String,
    linkSeo: json['link_seo'] as String ?? '',
  );
}

Map<String, dynamic> _$TraCuuToJson(TraCuu instance) => <String, dynamic>{
      'noi_dung': instance.noiDung,
      'id': instance.id,
      'link_seo': instance.linkSeo,
    };

TraCuuHeader _$TraCuuHeaderFromJson(Map<String, dynamic> json) {
  return TraCuuHeader(
    titleHeader: json['title_header'] as String ?? '',
  )..list = (json['tra_cuu'] as List)
      .map((e) => TraCuu.fromJson(e as Map<String, dynamic>))
      .toList();
}

Map<String, dynamic> _$TraCuuHeaderToJson(TraCuuHeader instance) {
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

// **************************************************************************
// JsonLiteralGenerator
// **************************************************************************

final _$glossaryDataJsonLiteral = {
  'result': [
    {
      'title_header': 'Dự án The FAROSEA',
      'tra_cuu': [
        {'id': '1', 'noi_dung': 'Tổng quan dự án', 'link_seo': ''},
        {'id': '2', 'noi_dung': 'Thế kế căn hộ', 'link_seo': ''},
        {'id': '3', 'noi_dung': 'Vị trí và tiện ích', 'link_seo': ''},
        {'id': '4', 'noi_dung': 'Nhà mẫu', 'link_seo': ''},
        {'id': '5', 'noi_dung': 'Tìm năng', 'link_seo': ''}
      ]
    },
    {
      'title_header': 'Dự án The FAROSEA',
      'tra_cuu': [
        {'id': '1', 'noi_dung': 'Tổng quan dự án', 'link_seo': ''},
        {'id': '2', 'noi_dung': 'Thế kế căn hộ', 'link_seo': ''},
        {'id': '3', 'noi_dung': 'Vị trí và tiện ích', 'link_seo': ''},
        {'id': '4', 'noi_dung': 'Nhà mẫu', 'link_seo': ''},
        {'id': '5', 'noi_dung': 'Tìm năng', 'link_seo': ''}
      ]
    }
  ]
};
