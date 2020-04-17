import 'package:json_annotation/json_annotation.dart';

part 'tracuu_model.g.dart';

@JsonSerializable()
class TraCuu {
  @JsonKey(name: 'noi_dung', defaultValue: '')
  String noiDung;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'link_seo', defaultValue: '')
  String linkSeo;

  TraCuu({this.noiDung, this.id, this.linkSeo});

  factory TraCuu.fromJson(Map<String, dynamic> json) => _$TraCuuFromJson(json);

  Map<String, dynamic> toJson() => _$TraCuuToJson(this);
}

@JsonSerializable(includeIfNull: false)
class TraCuuHeader {
  @JsonKey(name: 'title_header', defaultValue: '')
  String titleHeader;

  @JsonKey(name: 'tra_cuu', nullable: false)
  List<TraCuu> list;

  TraCuuHeader({this.titleHeader, List<TraCuu> data})
      : list = data ?? <TraCuu>[];

  factory TraCuuHeader.fromJson(Map<String, dynamic> json) =>
      _$TraCuuHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$TraCuuHeaderToJson(this);
}

@JsonLiteral('data.json')
Map get glossaryData => _$glossaryDataJsonLiteral;
