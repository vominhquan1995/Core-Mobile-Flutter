
import 'package:json_annotation/json_annotation.dart';
part 'huong_dang_model.g.dart';

@JsonSerializable(includeIfNull: false)
class HuongDanHeader {
  @JsonKey(name: 'title_header', defaultValue: '')
  String titleHeader;

  @JsonKey(name: 'tra_cuu', nullable: false)
  List<HuongDan> list;

  HuongDanHeader({this.titleHeader, List<HuongDan> data})
      : list = data ?? <HuongDan>[];

  factory HuongDanHeader.fromJson(Map<String, dynamic> json) =>
      _$HuongDanHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$HuongDanHeaderToJson(this);
}

@JsonSerializable()
class HuongDan {
  @JsonKey(name: 'noi_dung', defaultValue: '')
  String noiDung;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'link_seo', defaultValue: '')
  String linkSeo;

  HuongDan({this.noiDung, this.id, this.linkSeo});

  factory HuongDan.fromJson(Map<String, dynamic> json) => _$HuongDanFromJson(json);

  Map<String, dynamic> toJson() => _$HuongDanToJson(this);
}