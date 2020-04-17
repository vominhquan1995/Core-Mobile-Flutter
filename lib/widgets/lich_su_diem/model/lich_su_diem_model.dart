import 'package:json_annotation/json_annotation.dart';
part 'lich_su_diem_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LichSuDiemModel {
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'nguoi_giao_dich', defaultValue: '')
  final String nguoiGiaoDich;
  @JsonKey(name: 'so_tien', defaultValue: '')
  final String soTien;
  @JsonKey(name: 'noi_dung_giao_dich', defaultValue: '')
  final String noiDungGiaoDich;
  @JsonKey(name: 'time_create', defaultValue: '')
  final String timeCreate;
  @JsonKey(name: 'loai_giao_dich', defaultValue: '')
  final int loaiGiaoDich;

  LichSuDiemModel(
      {this.id,
      this.nguoiGiaoDich,
      this.soTien,
      this.noiDungGiaoDich,
      this.timeCreate,
      this.loaiGiaoDich});

  factory LichSuDiemModel.fromJson(Map<String, dynamic> json) =>
      _$LichSuDiemModelFromJson(json);

  Map<String, dynamic> toJson() => _$LichSuDiemModelToJson(this);
}
