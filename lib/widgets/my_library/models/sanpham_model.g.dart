// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sanpham_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SanPhamModel _$SanPhamModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['san_pham_id']);
  return SanPhamModel(
    image: json['hinh_dai_dien'] as String ?? '',
    id: json['san_pham_id'] as String,
    donGia: json['don_gia'] as String ?? '',
    donGiaSale: SanPhamModel.toStringFromJson(json['gia_khuyen_mai']),
    khuyenMai: json['khuyen_mai'] as bool ?? false,
    maSanPham: json['ma_san_pham'] as String ?? '',
    moTa: json['mo_ta'] as String ?? '',
    phanTram: SanPhamModel.toStringFromJson(json['phan_tram']),
    tenSanPham: json['ten_san_pham'] as String ?? '',
    hinhLienQuan:
        SanPhamModel.toListHinhLienQuan(json['hinh_lien_quan'] as List),
    hetHang: json['het_hang'] as bool ?? false,
    urlSeo: json['url_seo'] as String ?? '',
  )
    ..listTinhChat =
        SanPhamModel.toListTinhChat(json['list_tinh_chat'] as List<int>)
    ..videos = SanPhamModel.toListVideos(json['videos'] as List)
    ..content = json['content'] as String ?? ''
    ..policy = SanPhamModel.toListPolicy(json['policy'] as List);
}

Map<String, dynamic> _$SanPhamModelToJson(SanPhamModel instance) =>
    <String, dynamic>{
      'san_pham_id': instance.id,
      'ten_san_pham': instance.tenSanPham,
      'ma_san_pham': instance.maSanPham,
      'mo_ta': instance.moTa,
      'hinh_dai_dien': instance.image,
      'don_gia': instance.donGia,
      'gia_khuyen_mai': instance.donGiaSale,
      'khuyen_mai': instance.khuyenMai,
      'phan_tram': instance.phanTram,
      'list_tinh_chat': instance.listTinhChat,
      'het_hang': instance.hetHang,
      'hinh_lien_quan':
          instance.hinhLienQuan?.map((e) => e?.toJson())?.toList(),
      'videos': instance.videos?.map((e) => e?.toJson())?.toList(),
      'url_seo': instance.urlSeo,
      'content': instance.content,
      'policy': instance.policy?.map((e) => e?.toJson())?.toList(),
    };

HinhLienQuan _$HinhLienQuanFromJson(Map<String, dynamic> json) {
  return HinhLienQuan(
    path: json['path'] as String ?? '',
    w100: json['w100'] as String ?? '',
    w280: json['w280'] as String ?? '',
    w480: json['w480'] as String ?? '',
    w520: json['w520'] as String ?? '',
    w1280: json['w1280'] as String ?? '',
    fileSystemGuid: json['file_system_guid'] as String ?? '',
  );
}

Map<String, dynamic> _$HinhLienQuanToJson(HinhLienQuan instance) =>
    <String, dynamic>{
      'path': instance.path,
      'w100': instance.w100,
      'w280': instance.w280,
      'w480': instance.w480,
      'w520': instance.w520,
      'w1280': instance.w1280,
      'file_system_guid': instance.fileSystemGuid,
    };

VideoItem _$VideoItemFromJson(Map<String, dynamic> json) {
  return VideoItem(
    id: json['id'] as String ?? '',
    path: json['path'] as String ?? '',
    thumnail: json['thumnail'] as String ?? '',
  );
}

Map<String, dynamic> _$VideoItemToJson(VideoItem instance) => <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'thumnail': instance.thumnail,
    };

Policy _$PolicyFromJson(Map<String, dynamic> json) {
  return Policy(
    image: json['image'] as String ?? '',
    content: json['content'] as String ?? '',
  );
}

Map<String, dynamic> _$PolicyToJson(Policy instance) => <String, dynamic>{
      'image': instance.image,
      'content': instance.content,
    };
