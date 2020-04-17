import 'dart:ui';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:json_annotation/json_annotation.dart';
part 'request_upgrade_model.g.dart';

enum STATUS_REQUEST { DA_DUYET, DANG_DOI, TU_CHOI }

//explicitToJson:  true => Map<String, dynamic> toJson() => {'child': child?.toJson()};
//explicitToJson:  fasle => Map<String, dynamic> toJson() => {'child': child};
@JsonSerializable(explicitToJson: true)
class RequestUpgrade {
  @JsonKey(required: true, name: 'user_request_id', defaultValue: '')
  String idRequest;
  @JsonKey(required: true, name: 'ma_nguoi_gioi_thieu', defaultValue: '')
  String maGioiThieu;
  @JsonKey(required: false, name: 'ma_cua_toi', defaultValue: '')
  String maCuaToi;
  @JsonKey(required: true, name: 'tinh_trang', defaultValue: -1)
  int tinhTrang;
  @JsonKey(required: true, name: 'time_create', defaultValue: '')
  String timeCreate;
  @JsonKey(required: true, name: 'quan_id', defaultValue: '')
  String quanId;
  @JsonKey(required: true, name: 'tinh_id', defaultValue: '')
  String tinhId;
  @JsonKey(required: true, name: 'hinh_anh', defaultValue: '')
  String hinhAnh;
  @JsonKey(required: true, name: 'ten_shop', defaultValue: '')
  String tenShop;
  @JsonKey(required: true, name: 'phuong_id', defaultValue: '')
  String phuongId;
  @JsonKey(required: true, name: 'quan_name', defaultValue: '')
  String quanName;
  @JsonKey(required: true, name: 'tinh_name', defaultValue: '')
  String tinhName;
  @JsonKey(required: true, name: 'phuong_name', defaultValue: '')
  String phuongName;
  @JsonKey(required: true, name: 'quoc_gia_id', defaultValue: '')
  String quocGiaId;
  @JsonKey(required: true, name: 'dia_chi_shop', defaultValue: '')
  String diaChiShop;
  @JsonKey(required: true, name: 'quoc_gia_name', defaultValue: '')
  String quocGiaName;
  @JsonKey(required: true, name: 'don_vi_tien_te_id', defaultValue: '')
  String tienTeId;
  @JsonKey(required: true, name: 'ly_do', defaultValue: '')
  String lyDo;
  @JsonKey(ignore: true)
  ItemStatus dataStatus;
  RequestUpgrade(
      {this.idRequest,
      this.maGioiThieu,
      this.maCuaToi,
      this.tinhTrang,
      this.timeCreate,
      this.quanId,
      this.tinhId,
      this.hinhAnh,
      this.tenShop,
      this.phuongId,
      this.quanName,
      this.tinhName,
      this.phuongName,
      this.quocGiaId,
      this.diaChiShop,
      this.quocGiaName,
      this.tienTeId,
      this.lyDo}) {
    dataStatus = _mapStatus(this.tinhTrang);
  }

  static ItemStatus _mapStatus(int status) {
    if (status == 0) {
      return ItemStatus(
          name: tr('upgrade_salon_20'),
          color: colorRed,
          type: STATUS_REQUEST.DANG_DOI);
    } else if (status == 1) {
      return ItemStatus(
          name: tr('upgrade_salon_45'),
          color: colorGreen,
          type: STATUS_REQUEST.DA_DUYET);
    } else {
      return ItemStatus(
          name: tr('upgrade_salon_46'),
          color: colorRed,
          type: STATUS_REQUEST.TU_CHOI);
    }
  }

  factory RequestUpgrade.fromJson(Map<String, dynamic> json) =>
      _$RequestUpgradeFromJson(json);
  Map<String, dynamic> toJson() => _$RequestUpgradeToJson(this);
}

class ItemStatus {
  String name;
  Color color;
  STATUS_REQUEST type;
  ItemStatus({this.name, this.color, this.type});
}
