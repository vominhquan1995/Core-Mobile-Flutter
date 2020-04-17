import 'package:json_annotation/json_annotation.dart';
part 'lich_su_hoa_hong_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HoaHongModel {
  @JsonKey(name: 'thoi_gian_giao_dich', defaultValue: '')
  final String thoiGianGiaoDich;
  @JsonKey(name: 'noi_dung', defaultValue: '')
  final String noiDung;
  @JsonKey(name: 'phan_tram_them', defaultValue: '')
  final String phanTramThem;

  HoaHongModel({
    this.thoiGianGiaoDich,
    this.noiDung,
    this.phanTramThem,
  });

  factory HoaHongModel.fromJson(Map<String, dynamic> json) =>
      _$HoaHongModelFromJson(json);

  Map<String, dynamic> toJson() => _$HoaHongModelToJson(this);
}
