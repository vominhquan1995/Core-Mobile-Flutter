import 'package:json_annotation/json_annotation.dart';
part 'hoa_hong_ca_nhan_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HoaHongCaNhanModel {
  @JsonKey(name: 'tien_hoa_hong', defaultValue: '')
  final String tien_hoa_hong;

  HoaHongCaNhanModel({
    this.tien_hoa_hong,
  });

  factory HoaHongCaNhanModel.fromJson(Map<String, dynamic> json) =>
      _$HoaHongCaNhanModelFromJson(json);

  Map<String, dynamic> toJson() => _$HoaHongCaNhanModelToJson(this);
}

