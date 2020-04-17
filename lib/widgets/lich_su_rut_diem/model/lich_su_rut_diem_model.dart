import 'package:json_annotation/json_annotation.dart';
part 'lich_su_rut_diem_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LichSuRutDiemModel {
  @JsonKey(name: 'thoi_gian_yeu_cau', defaultValue: '')
  final String thoiGianYeuCau;
  @JsonKey(name: 'so_tien_rut', defaultValue: '')
  final String soTienRut;
  @JsonKey(name: 'ghi_chu', defaultValue: '')
  final String ghiChu;
  @JsonKey(name: 'tinh_trang', defaultValue: '')
  final int tinhTrang;
  @JsonKey(name: 'log_xu_ly', defaultValue: '')
  final List<LogXuLyModel> logXuLy;

  LichSuRutDiemModel({this.thoiGianYeuCau, this.soTienRut, this.ghiChu, this.tinhTrang, this.logXuLy});

   factory LichSuRutDiemModel.fromJson(Map<String, dynamic> json) =>
      _$LichSuRutDiemModelFromJson(json);

  Map<String, dynamic> toJson() => _$LichSuRutDiemModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LogXuLyModel {
  @JsonKey(name: 'text', defaultValue: '')
  final String text;
  @JsonKey(name: 'nguoi_thao_tac', defaultValue: '')
  final String nguoiThaoTac;
  @JsonKey(name: 'thoi_gian_thao_tac', defaultValue: '')
  final String thoiGianThaoTac;

  LogXuLyModel({this.text, this.nguoiThaoTac, this.thoiGianThaoTac});

   factory LogXuLyModel.fromJson(Map<String, dynamic> json) =>
      _$LogXuLyModelFromJson(json);

  Map<String, dynamic> toJson() => _$LogXuLyModelToJson(this);
}