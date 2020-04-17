import 'package:json_annotation/json_annotation.dart';
part 'address_model.g.dart';

//explicitToJson:  true => Map<String, dynamic> toJson() => {'child': child?.toJson()};
//explicitToJson:  fasle => Map<String, dynamic> toJson() => {'child': child};
@JsonSerializable(explicitToJson: true)
class Province {
  @JsonKey(required: true, name: 'name', defaultValue: '')
  String name;
  @JsonKey(required: true, name: 'slug', defaultValue: '')
  String slug;
  @JsonKey(required: true, name: 'type', defaultValue: '')
  String type;
  @JsonKey(required: true, name: 'name_with_type', defaultValue: '')
  String fullName;
  @JsonKey(required: true, name: 'code', defaultValue: '')
  String id;
  Province({this.id, this.name, this.slug, this.type, this.fullName});

  factory Province.fromJson(Map<String, dynamic> json) =>
      _$ProvinceFromJson(json);
  Map<String, dynamic> toJson() => _$ProvinceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class District {
  @JsonKey(required: true, name: 'name', defaultValue: '')
  String name;
  @JsonKey(required: true, name: 'slug', defaultValue: '')
  String slug;
  @JsonKey(required: true, name: 'type', defaultValue: '')
  String type;
  @JsonKey(required: true, name: 'name_with_type', defaultValue: '')
  String fullName;
  @JsonKey(required: true, name: 'path', defaultValue: '')
  String path;
  @JsonKey(required: true, name: 'parent_code', defaultValue: '')
  String idParent;
  @JsonKey(required: true, name: 'code', defaultValue: '')
  String id;
  District(
      {this.id,
      this.idParent,
      this.name,
      this.slug,
      this.type,
      this.fullName,
      this.path});
  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);
  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Ward {
  @JsonKey(required: true, name: 'name', defaultValue: '')
  String name;
  @JsonKey(required: true, name: 'slug', defaultValue: '')
  String slug;
  @JsonKey(required: true, name: 'type', defaultValue: '')
  String type;
  @JsonKey(required: true, name: 'name_with_type', defaultValue: '')
  String fullName;
  @JsonKey(required: true, name: 'path', defaultValue: '')
  String path;
  @JsonKey(required: true, name: 'parent_code', defaultValue: '')
  String idParent;
  @JsonKey(required: true, name: 'code', defaultValue: '')
  String id;
  Ward(
      {this.id,
      this.idParent,
      this.name,
      this.slug,
      this.type,
      this.fullName,
      this.path});
  factory Ward.fromJson(Map<String, dynamic> json) =>
      _$WardFromJson(json);
  Map<String, dynamic> toJson() => _$WardToJson(this);
}

class DataAddress {
  final List<District> districts;
  final List<Province> provinces;
  final List<Ward> wards;
  DataAddress({this.provinces, this.districts,this.wards});
}

class AddressSelected {
  District district;
  Province province;
  AddressSelected({this.district, this.province});
  set setDistrict(District item) {
    district = item;
  }
}
