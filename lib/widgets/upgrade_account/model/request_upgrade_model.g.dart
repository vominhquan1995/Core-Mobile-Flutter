// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_upgrade_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestUpgrade _$RequestUpgradeFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'user_request_id',
    'ma_nguoi_gioi_thieu',
    'tinh_trang',
    'time_create',
    'quan_id',
    'tinh_id',
    'hinh_anh',
    'ten_shop',
    'phuong_id',
    'quan_name',
    'tinh_name',
    'phuong_name',
    'quoc_gia_id',
    'dia_chi_shop',
    'quoc_gia_name',
    'don_vi_tien_te_id',
    'ly_do'
  ]);
  return RequestUpgrade(
    idRequest: json['user_request_id'] as String ?? '',
    maGioiThieu: json['ma_nguoi_gioi_thieu'] as String ?? '',
    maCuaToi: json['ma_cua_toi'] as String ?? '',
    tinhTrang: json['tinh_trang'] as int ?? -1,
    timeCreate: json['time_create'] as String ?? '',
    quanId: json['quan_id'] as String ?? '',
    tinhId: json['tinh_id'] as String ?? '',
    hinhAnh: json['hinh_anh'] as String ?? '',
    tenShop: json['ten_shop'] as String ?? '',
    phuongId: json['phuong_id'] as String ?? '',
    quanName: json['quan_name'] as String ?? '',
    tinhName: json['tinh_name'] as String ?? '',
    phuongName: json['phuong_name'] as String ?? '',
    quocGiaId: json['quoc_gia_id'] as String ?? '',
    diaChiShop: json['dia_chi_shop'] as String ?? '',
    quocGiaName: json['quoc_gia_name'] as String ?? '',
    tienTeId: json['don_vi_tien_te_id'] as String ?? '',
    lyDo: json['ly_do'] as String ?? '',
  );
}

Map<String, dynamic> _$RequestUpgradeToJson(RequestUpgrade instance) =>
    <String, dynamic>{
      'user_request_id': instance.idRequest,
      'ma_nguoi_gioi_thieu': instance.maGioiThieu,
      'ma_cua_toi': instance.maCuaToi,
      'tinh_trang': instance.tinhTrang,
      'time_create': instance.timeCreate,
      'quan_id': instance.quanId,
      'tinh_id': instance.tinhId,
      'hinh_anh': instance.hinhAnh,
      'ten_shop': instance.tenShop,
      'phuong_id': instance.phuongId,
      'quan_name': instance.quanName,
      'tinh_name': instance.tinhName,
      'phuong_name': instance.phuongName,
      'quoc_gia_id': instance.quocGiaId,
      'dia_chi_shop': instance.diaChiShop,
      'quoc_gia_name': instance.quocGiaName,
      'don_vi_tien_te_id': instance.tienTeId,
      'ly_do': instance.lyDo,
    };
