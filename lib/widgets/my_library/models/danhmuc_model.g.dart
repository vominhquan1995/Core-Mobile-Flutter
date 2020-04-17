// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'danhmuc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DanhMucModel _$DanhMucModelFromJson(Map<String, dynamic> json) {
  return DanhMucModel(
    id: json['id'] as String,
    name: json['name'] as String ?? '',
    image: json['image'] as String ?? '',
    key: json['key'] as String ?? '',
    value: json['value'] as String ?? '',
  );
}

Map<String, dynamic> _$DanhMucModelToJson(DanhMucModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'value': instance.value,
      'key': instance.key,
    };

NganhHang _$NganhHangFromJson(Map<String, dynamic> json) {
  return NganhHang(
    id: json['id'] as String,
    name: json['name'] as String ?? '',
    image: json['image'] as String ?? '',
  );
}

Map<String, dynamic> _$NganhHangToJson(NganhHang instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };
