import 'package:json_annotation/json_annotation.dart';
part 'thanh_vien.m.g.dart';
@JsonSerializable(explicitToJson: true)
class ThongTinCaNhan {
  @JsonKey(name: 'dia_chi_shop', defaultValue: '')
  final String diaChiShop;
  @JsonKey(name: 'ten_shop', defaultValue: '')
  final String tenShop;

  ThongTinCaNhan({
    this.diaChiShop,
    this.tenShop,
  });

   factory ThongTinCaNhan.fromJson(Map<String, dynamic> json) =>
      _$ThongTinCaNhanFromJson(json);

  Map<String, dynamic> toJson() => _$ThongTinCaNhanToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PhanCap{
  @JsonKey(name: 'tai_khoan', defaultValue: '')
  final String taiKhoan;
  @JsonKey(name: 'thong_tin_ca_nhan')
  final ThongTinCaNhan thongTinCaNhan;

  PhanCap({this.taiKhoan, this.thongTinCaNhan});

   factory PhanCap.fromJson(Map<String, dynamic> json) =>
      _$PhanCapFromJson(json);

  Map<String, dynamic> toJson() => _$PhanCapToJson(this);

}

@JsonSerializable(explicitToJson: true)
class ThanhVienModel{
   @JsonKey(name: 'phan_cap_lv1')
  final List<PhanCap> phanCapLv1;
   @JsonKey(name: 'phan_cap_lv2')
  final int phanCapLv2;

  ThanhVienModel({this.phanCapLv1, this.phanCapLv2});
   factory ThanhVienModel.fromJson(Map<String, dynamic> json) =>
      _$ThanhVienModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThanhVienModelToJson(this);
  
}

@JsonLiteral('data.json')
Map get dataQuocGiaJson => _$dataQuocGiaJsonJsonLiteral;