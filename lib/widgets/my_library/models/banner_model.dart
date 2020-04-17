import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BannerModel {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'link_file', defaultValue: '')
  String image;

  BannerModel({this.id, this.image});

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
