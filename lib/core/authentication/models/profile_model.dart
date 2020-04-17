import 'package:Midas/core/authentication/db/authen_provider.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

const String columnDiaChi = "dia_chi";
const String columnEmail = "email";
const String columnHoTen = "Ho_Ten";
const String columnNgaySinh = "ngay_sinh";
const String columnSDTDD = "so_dien_thoai";
const String columnLoai = "loai_khach_hang";
const String columnMaSo = "maso";
const String columnToken = "token";
const String columnMenuActive = "listmenu_active";
const String columnQuaTang = "is_qua_tang_thanh_vien";
const String columnGioiTinh = "gioi_tinh";
const String columnImage = "image";
const String columnQuocGia = "quoc_gia";

const String TABLE_USER =
    "CREATE TABLE IF NOT EXISTS ${AuthenProvider.TABLE_NAME} (" +
        "$columnMaSo TEXT," +
        "$columnHoTen TEXT," +
        "$columnLoai TEXT," +
        "$columnDiaChi TEXT," +
        "$columnEmail TEXT," +
        "$columnNgaySinh TEXT," +
        "$columnSDTDD TEXT," +
        "$columnToken TEXT," +
        "$columnQuaTang BOOLEAN," +
        "$columnGioiTinh TEXT," +
        "$columnImage TEXT," +
        "$columnQuocGia TEXT," +
        "$columnMenuActive TEXT)";

enum LOAI_USER {
  KHACHLE,
  SALON,
  QUANLY,
  UNKNOWN,
}

@JsonSerializable(explicitToJson: true)
class Profile extends Equatable {
  @JsonKey(name: 'image', defaultValue: '')
  final String avatar;

  @JsonKey(name: 'Ho_Ten', defaultValue: '')
  final String hoten;

  @JsonKey(name: 'maso', fromJson: toStringFromJson)
  final String maso;

  @JsonKey(name: 'ngay_sinh', fromJson: toStringFromJson)
  final String ngaysinh;

  @JsonKey(name: 'so_dien_thoai', fromJson: toStringFromJson)
  final String sodt;

  @JsonKey(name: 'email', fromJson: toStringFromJson)
  final String email;

  @JsonKey(name: 'dia_chi', fromJson: toStringFromJson)
  final String diachi;

  @JsonKey(name: 'loai_khach_hang', defaultValue: '')
  final String loai;

  @JsonKey(
      name: 'listmenu_active', fromJson: menuIDFromJson, toJson: menuIDToString)
  List<String> menuID;

  @JsonKey(name: 'token', defaultValue: '')
  final String token;

  @JsonKey(ignore: true)
  LOAI_USER userEnum;

  @JsonKey(name: 'quoc_gia', defaultValue: '')
  final String quocgia;

  @JsonKey(name: 'is_qua_tang_thanh_vien', fromJson: isQuaTang)
  final bool quaTang;

  @JsonKey(name: 'gioi_tinh', fromJson: toStringFromJson)
  final String gioiTinh;

  Profile({
    this.avatar,
    this.hoten,
    this.ngaysinh,
    this.sodt,
    this.email,
    this.diachi,
    this.loai,
    this.maso,
    List<dynamic> menuID,
    this.token,
    this.quocgia,
    this.quaTang,
    this.gioiTinh,
  }) : menuID = menuID ?? <String>[] {
    userEnum = _mapUserToEnum(this.loai);
  }

  static String toStringFromJson(dynamic value) =>
      value != null ? '$value' : tr('profile_9');

  static bool isQuaTang(dynamic t) {
    if (t == null) return false;

    if (t is int) {
      return t == 1 ? true : false;
    }

    if (t is bool) return t;

    return false;
  }

  static List<String> menuIDFromJson(dynamic t) {
    if (t != null) {
      if (t is List<dynamic>) {
        return t.map((f) => f.toString()).toList();
      }

      if (t is String) {
        return t.split(",");
      }
    }

    return <String>[];
  }

  static String menuIDToString(List<String> t) {
    return t.join(',');
  }

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  Profile copyWith({
    Profile profile,
  }) {
    return Profile(
        avatar: profile.avatar ?? this.avatar,
        hoten: profile.hoten ?? this.hoten,
        ngaysinh: profile.ngaysinh ?? this.ngaysinh,
        sodt: profile.sodt ?? this.sodt,
        email: profile.email ?? this.email,
        diachi: profile.diachi ?? this.diachi,
        maso: profile.maso ?? this.maso,
        gioiTinh: profile.gioiTinh ?? this.gioiTinh,
        quaTang: profile.quaTang ?? this.quaTang,
        quocgia: profile.quocgia ?? this.quocgia,
        loai: this.loai,
        token: this.token,
        menuID: this.menuID);
  }

  static LOAI_USER _mapUserToEnum(String loai) {
    if (loai == null) {
      return LOAI_USER.UNKNOWN;
    }

    switch (loai.toLowerCase()) {
      case '0':
        return LOAI_USER.QUANLY;
      case '1':
        return LOAI_USER.SALON;
      case '2':
        return LOAI_USER.KHACHLE;
      default:
        return LOAI_USER.UNKNOWN;
    }
  }

  @override
  // TODO: implement props
  List get props => [
        avatar,
        hoten,
        ngaysinh,
        sodt,
        email,
        diachi,
        loai,
        maso,
        token,
        quaTang
      ];

  @override
  String toString() => 'Profile { id: $maso $userEnum $token}';
}
