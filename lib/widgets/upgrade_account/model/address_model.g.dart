// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Province _$ProvinceFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['name', 'slug', 'type', 'name_with_type', 'code']);
  return Province(
    id: json['code'] as String ?? '',
    name: json['name'] as String ?? '',
    slug: json['slug'] as String ?? '',
    type: json['type'] as String ?? '',
    fullName: json['name_with_type'] as String ?? '',
  );
}

Map<String, dynamic> _$ProvinceToJson(Province instance) => <String, dynamic>{
      'name': instance.name,
      'slug': instance.slug,
      'type': instance.type,
      'name_with_type': instance.fullName,
      'code': instance.id,
    };

District _$DistrictFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'name',
    'slug',
    'type',
    'name_with_type',
    'path',
    'parent_code',
    'code'
  ]);
  return District(
    id: json['code'] as String ?? '',
    idParent: json['parent_code'] as String ?? '',
    name: json['name'] as String ?? '',
    slug: json['slug'] as String ?? '',
    type: json['type'] as String ?? '',
    fullName: json['name_with_type'] as String ?? '',
    path: json['path'] as String ?? '',
  );
}

Map<String, dynamic> _$DistrictToJson(District instance) => <String, dynamic>{
      'name': instance.name,
      'slug': instance.slug,
      'type': instance.type,
      'name_with_type': instance.fullName,
      'path': instance.path,
      'parent_code': instance.idParent,
      'code': instance.id,
    };

Ward _$WardFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'name',
    'slug',
    'type',
    'name_with_type',
    'path',
    'parent_code',
    'code'
  ]);
  return Ward(
    id: json['code'] as String ?? '',
    idParent: json['parent_code'] as String ?? '',
    name: json['name'] as String ?? '',
    slug: json['slug'] as String ?? '',
    type: json['type'] as String ?? '',
    fullName: json['name_with_type'] as String ?? '',
    path: json['path'] as String ?? '',
  );
}

Map<String, dynamic> _$WardToJson(Ward instance) => <String, dynamic>{
      'name': instance.name,
      'slug': instance.slug,
      'type': instance.type,
      'name_with_type': instance.fullName,
      'path': instance.path,
      'parent_code': instance.idParent,
      'code': instance.id,
    };
