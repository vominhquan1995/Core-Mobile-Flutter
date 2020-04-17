import 'package:json_annotation/json_annotation.dart';

part 'danhmuc_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DanhMucModel {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name', defaultValue: '')
  String name;

  @JsonKey(name: 'image', defaultValue: '')
  String image;

  // @JsonKey(
  //   name: 'nganh_hang',
  // )
  // List<NganhHang> nganhHang;
  @JsonKey(name: 'value', defaultValue: '')
  String value;
  @JsonKey(name: 'key', defaultValue: '')
  String key;

  DanhMucModel({this.id, this.name, this.image, this.key, this.value});

  factory DanhMucModel.fromJson(Map<String, dynamic> json) =>
      _$DanhMucModelFromJson(json);
  Map<String, dynamic> toJson() => _$DanhMucModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NganhHang {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name', defaultValue: '')
  String name;

  @JsonKey(name: 'image', defaultValue: '')
  String image;

  NganhHang({this.id, this.name, this.image});

  factory NganhHang.fromJson(Map<String, dynamic> json) =>
      _$NganhHangFromJson(json);
  Map<String, dynamic> toJson() => _$NganhHangToJson(this);
}
