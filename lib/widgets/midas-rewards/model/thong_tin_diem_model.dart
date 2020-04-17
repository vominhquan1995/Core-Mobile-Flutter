import 'package:json_annotation/json_annotation.dart';
part 'thong_tin_diem_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ThongTinDiemModel {
  @JsonKey(name: 'tien_hoa_hong', defaultValue: '0')
  final String tienHoaHong;
  @JsonKey(name: 'tai_khoan_ngan_hang', defaultValue: '')
  final String taiKhoanNganHang;
  @JsonKey(name: 'ten_ngan_hang', defaultValue: '')
  final String tenNganHang;
  @JsonKey(name: 'ten_nguoi_nhan', defaultValue: '')
  final String tenNguoiNhan;

  ThongTinDiemModel(
      {this.tienHoaHong,
      this.taiKhoanNganHang,
      this.tenNganHang,
      this.tenNguoiNhan});

  factory ThongTinDiemModel.fromJson(Map<String, dynamic> json) =>
      _$ThongTinDiemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThongTinDiemModelToJson(this);
}
