import 'package:json_annotation/json_annotation.dart';

part 'sanpham_model.g.dart';

enum TYPE_DISPLAY_PRICE { TYPE_1, TYPE_2, TYPE_3 }

@JsonSerializable(explicitToJson: true)
class SanPhamModel {
  @JsonKey(name: 'san_pham_id', required: true)
  String id;

  @JsonKey(name: 'ten_san_pham', defaultValue: '')
  String tenSanPham;

  @JsonKey(name: 'ma_san_pham', defaultValue: '')
  String maSanPham;

  @JsonKey(name: 'mo_ta', defaultValue: '')
  String moTa;

  @JsonKey(name: 'hinh_dai_dien', defaultValue: '')
  String image;

  @JsonKey(name: 'don_gia', defaultValue: '')
  String donGia;

  @JsonKey(name: 'gia_khuyen_mai', fromJson: toStringFromJson)
  String donGiaSale;

  @JsonKey(name: 'khuyen_mai', defaultValue: false)
  bool khuyenMai;

  @JsonKey(name: 'phan_tram', fromJson: toStringFromJson)
  String phanTram;

  @JsonKey(name: 'list_tinh_chat', fromJson: toListTinhChat)
  List<int> listTinhChat;

  @JsonKey(name: 'het_hang', defaultValue: false)
  bool hetHang;

  @JsonKey(ignore: true)
  TYPE_DISPLAY_PRICE typeDisplay;

  @JsonKey(name: 'hinh_lien_quan', fromJson: toListHinhLienQuan)
  List<HinhLienQuan> hinhLienQuan;

  @JsonKey(name: 'videos', fromJson: toListVideos)
  List<VideoItem> videos;

  @JsonKey(name: 'url_seo', defaultValue: '')
  String urlSeo;

  @JsonKey(name: 'content', defaultValue: '')
  String content;

  @JsonKey(name: 'policy', fromJson: toListPolicy)
  List<Policy> policy;

  static String toStringFromJson(dynamic value) =>
      value != null ? '$value' : '';

  static List<int> toListTinhChat(List<int> value) =>
      value != null ? value : [];

  static List<HinhLienQuan> toListHinhLienQuan(List<Object> values) =>
      values != null
          ? values.map((f) => HinhLienQuan.fromJson(f)).toList()
          : <HinhLienQuan>[];

  static List<VideoItem> toListVideos(List<Object> values) => values != null
      ? values.map((f) => VideoItem.fromJson(f)).toList()
      : <VideoItem>[];

  static List<Policy> toListPolicy(List<Object> values) => values != null
      ? values.map((f) => Policy.fromJson(f)).toList()
      : <Policy>[];

  SanPhamModel({
    this.image,
    this.id,
    this.donGia,
    this.donGiaSale,
    this.khuyenMai,
    this.maSanPham,
    this.moTa,
    this.phanTram,
    this.tenSanPham,
    this.hinhLienQuan,
    this.hetHang,
    this.urlSeo,
  }) {
    typeDisplay = _mapDataToTypeTemplate(this.hetHang, this.phanTram);
  }

  factory SanPhamModel.fromJson(Map<String, dynamic> json) =>
      _$SanPhamModelFromJson(json);
  Map<String, dynamic> toJson() => _$SanPhamModelToJson(this);

  static TYPE_DISPLAY_PRICE _mapDataToTypeTemplate(
      bool outOff, String percent) {
    if (outOff) {
      /// HẾT HÀNG
      return TYPE_DISPLAY_PRICE.TYPE_1;
    } else if (!outOff && int.parse(percent) > 0) {
      // CÓ GIẢM GIÁ
      return TYPE_DISPLAY_PRICE.TYPE_2;
    } else {
      ///BÌNH THƯỜNG
      return TYPE_DISPLAY_PRICE.TYPE_3;
    }
  }
}

@JsonSerializable(explicitToJson: true)
class HinhLienQuan {
  @JsonKey(name: 'path', defaultValue: '')
  String path;
  @JsonKey(name: 'w100', defaultValue: '')
  String w100;
  @JsonKey(name: 'w280', defaultValue: '')
  String w280;
  @JsonKey(name: 'w480', defaultValue: '')
  String w480;
  @JsonKey(name: 'w520', defaultValue: '')
  String w520;
  @JsonKey(name: 'w1280', defaultValue: '')
  String w1280;
  @JsonKey(name: 'file_system_guid', defaultValue: '')
  String fileSystemGuid;
  HinhLienQuan({
    this.path,
    this.w100,
    this.w280,
    this.w480,
    this.w520,
    this.w1280,
    this.fileSystemGuid,
  });
  factory HinhLienQuan.fromJson(Map<String, dynamic> json) =>
      _$HinhLienQuanFromJson(json);
  Map<String, dynamic> toJson() => _$HinhLienQuanToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VideoItem {
  @JsonKey(name: 'id', defaultValue: '')
  String id;

  @JsonKey(name: 'path', defaultValue: '')
  String path;

  @JsonKey(name: 'thumnail', defaultValue: '')
  String thumnail;
  VideoItem({this.id, this.path, this.thumnail});

  factory VideoItem.fromJson(Map<String, dynamic> json) =>
      _$VideoItemFromJson(json);
  Map<String, dynamic> toJson() => _$VideoItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Policy {
  @JsonKey(name: 'image', defaultValue: '')
  final String image;

  @JsonKey(name: 'content', defaultValue: '')
  final String content;

  Policy({
    this.image,
    this.content,
  });

  factory Policy.fromJson(Map<String, dynamic> json) => _$PolicyFromJson(json);
  Map<String, dynamic> toJson() => _$PolicyToJson(this);
}
