part of 'news_model.dart';

///Column chính để hiện dữ liệu
const String columnId = 'tin_tuc_id';
const String columnTieuDe = 'tieu_de';
const String columnHinhThumbnail = 'hinh_thumbnail';
const String columnLinkSeo = 'link_seo';
const String columnTimeCreate = 'time_create';
const String columnTimeCreateFormat = 'time_create_format';
const String columnTinMoi = 'time_create_format';
const String columnDanhMuc = 'danh_muc_tin_text';

/// Column mình tự sinh thêm vào để thuận tiện cho việc lấy dữ liệu
/// Dùng để nhận biết dữ liệu này nằm ở Widget nào
const String columnWidgets = 'widgets';
const String columnHeader = 'header';
const String columnTinTucDonVi = 'tintuc_donvi';
const String columnTinMoiNhat = 'tintuc_moinhat';

News _$FromJson(Map<String, dynamic> json) {
  return News(
      tintucid: json[columnId] ?? '',
      tieude: json[columnTieuDe] ?? '',
      hinhthumbnail: json[columnHinhThumbnail] ?? '',
      linkseo: json[columnLinkSeo] ?? '',
      timecreate: json[columnTimeCreate] ?? '',
      timeCreateFormat: json[columnTimeCreateFormat] ?? '',
      danhMuc: json[columnDanhMuc] ?? '');
}

Map<String, dynamic> _$ToJson(News instance) => <String, dynamic>{
      columnId: instance.tintucid ?? '',
      columnTieuDe: instance.tieude ?? '',
      columnHinhThumbnail: instance.hinhthumbnail ?? '',
      columnLinkSeo: instance.linkseo ?? '',
      columnTimeCreate: instance.timecreate ?? '',
      columnTimeCreateFormat: instance.timeCreateFormat ?? '',
      columnDanhMuc: instance.danhMuc ?? ''
    };
