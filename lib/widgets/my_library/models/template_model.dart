import 'package:Core/widgets/my_library/models/sanpham_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'template_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TemplateModel {
  @JsonKey(name: 'template', required: true)
  String template;

  @JsonKey(name: 'key', required: true)
  String key;

  @JsonKey(name: 'title', required: true)
  String title;

  @JsonKey(name: 'san_pham')
  List<SanPhamModel> listSanPham;

  TemplateModel({
    this.template,
    this.key,
    this.title,
    List<SanPhamModel> listSP,
  }) : listSanPham = listSP ?? <SanPhamModel>[];

  factory TemplateModel.fromJson(Map<String, dynamic> json) =>
      _$TemplateModelFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateModelToJson(this);
}

@JsonLiteral('data.json')
Map get glossaryData => _$glossaryDataJsonLiteral;
