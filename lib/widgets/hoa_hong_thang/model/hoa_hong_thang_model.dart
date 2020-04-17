import 'package:json_annotation/json_annotation.dart';
part 'hoa_hong_thang_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HoaHongThangModel {
  @JsonKey(name: 'thoi_gian_giao_dich', defaultValue: '')
  final String thoiGianGiaoDich;
  @JsonKey(name: 'noi_dung', defaultValue: '')
  final String noiDung;
  @JsonKey(name: 'phan_tram_them', defaultValue: '')
  final String phanTramThem;

  HoaHongThangModel({
    this.thoiGianGiaoDich,
    this.noiDung,
    this.phanTramThem,
  });

  factory HoaHongThangModel.fromJson(Map<String, dynamic> json) =>
      _$HoaHongThangModelFromJson(json);

  Map<String, dynamic> toJson() => _$HoaHongThangModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HoaHongThangHienTaiModel {
  @JsonKey(name: 'result')
  final List<HoaHongThangModel> result;
  @JsonKey(name: 'sum', defaultValue: '')
  final String sum;

  HoaHongThangHienTaiModel({this.result, this.sum});

  factory HoaHongThangHienTaiModel.fromJson(Map<String, dynamic> json) =>
      _$HoaHongThangHienTaiModelFromJson(json);

  Map<String, dynamic> toJson() => _$HoaHongThangHienTaiModelToJson(this);
}
