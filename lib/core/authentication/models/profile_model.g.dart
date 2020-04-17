// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    avatar: json['image'] as String ?? '',
    hoten: json['Ho_Ten'] as String ?? '',
    ngaysinh: Profile.toStringFromJson(json['ngay_sinh']),
    sodt: Profile.toStringFromJson(json['so_dien_thoai']),
    email: Profile.toStringFromJson(json['email']),
    diachi: Profile.toStringFromJson(json['dia_chi']),
    loai: json['loai_khach_hang'] as String ?? '',
    maso: Profile.toStringFromJson(json['maso']),
    menuID: Profile.menuIDFromJson(json['listmenu_active']),
    token: json['token'] as String ?? '',
    quocgia: json['quoc_gia'] as String ?? '',
    quaTang: Profile.isQuaTang(json['is_qua_tang_thanh_vien']),
    gioiTinh: Profile.toStringFromJson(json['gioi_tinh']),
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'image': instance.avatar,
      'Ho_Ten': instance.hoten,
      'maso': instance.maso,
      'ngay_sinh': instance.ngaysinh,
      'so_dien_thoai': instance.sodt,
      'email': instance.email,
      'dia_chi': instance.diachi,
      'loai_khach_hang': instance.loai,
      'listmenu_active': Profile.menuIDToString(instance.menuID),
      'token': instance.token,
      'quoc_gia': instance.quocgia,
      'is_qua_tang_thanh_vien': instance.quaTang,
      'gioi_tinh': instance.gioiTinh,
    };
