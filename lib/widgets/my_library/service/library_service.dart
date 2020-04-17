import 'package:Midas/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Midas/core/page-core/service_custom.dart';
import 'package:Midas/widgets/my_library/models/banner_model.dart';
import 'package:Midas/widgets/my_library/models/danhmuc_model.dart';
import 'package:Midas/widgets/my_library/models/sanpham_model.dart';
import 'package:Midas/widgets/my_library/models/template_model.dart';

abstract class IBaseLibraryService extends ServiceCustom {
  IBaseLibraryService(ErrorhandleBloc bloc) : super(bloc);

  Future<List<BannerModel>> getBanner() async => <BannerModel>[];

  Future<List<DanhMucModel>> getDanhMuc() async => <DanhMucModel>[];

  Future<List<SanPhamModel>> getSanPham(
    String key, {
    int limit = 15,
    int offset = 0,
  }) async =>
      <SanPhamModel>[];

  Future<List<TemplateModel>> getTemplate() async =>
      (glossaryData["result"] as List)
          .map((f) => TemplateModel.fromJson(f))
          .toList();

  Future<List<SanPhamModel>> getSanPhamGoiY({
    int limit = 15,
    int page = 1,
  }) async =>
      <SanPhamModel>[];

  Future<List<TemplateModel>> getTemplatePrivate() async =>
      (glossaryData["result"] as List)
          .map((f) => TemplateModel.fromJson(f))
          .toList();

  Future<List<SanPhamModel>> getSanPhamGoiYPrivate({
    int limit = 15,
    int page = 1,
  }) async =>
      <SanPhamModel>[];
}

class LibraryService extends IBaseLibraryService {
  LibraryService(ErrorhandleBloc bloc) : super(bloc);

  @override
  Future<List<DanhMucModel>> getDanhMuc() async {
    // TODO: implement getDanhMuc
    try {
      final response = await dioE.post(
        '/san-pham/get-tag',
        data: {
          "tieu_de": "",
          "loai_tag": ["dong_san_pham"],
          "limit": 100,
        },
      );

      final danhmuc = response.data["result"] as List;

      return danhmuc.map((f) => DanhMucModel.fromJson(f)).toList();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<BannerModel>> getBanner() async {
    // TODO: implement getBanner
    // return super.getBanner();

    try {
      final response = await dioE.get(
        '/san-pham/get-slide',
      );

      final banner = response.data["result"] as List;

      return banner.map((f) => BannerModel.fromJson(f)).toList();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<SanPhamModel>> getSanPham(String key,
      {int limit = 15, int offset = 0}) async {
    // TODO: implement getSanPham
    // return super.getSanPham(key, limit, offset);

    try {
      final response = await dioE.get(
        '/san-pham/get-top',
        queryParameters: {"key": key, "limit": limit, "offset": offset},
      );
      final data = response.data["result"] as List;
      return data.map((f) => SanPhamModel.fromJson(f)).toList();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<TemplateModel>> getTemplate() async {
    // TODO: implement getTemplate
    // return super.getTemplate();

    try {
      final response = await dioE.get(
        '/san-pham/get-template-homepage',
      );
      final data = response.data["result"] as List;
      return data.map((f) => TemplateModel.fromJson(f)).toList();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<SanPhamModel>> getSanPhamGoiY(
      {int limit = 15, int page = 1}) async {
    // TODO: implement getSanPhamGoiY
    // return super.getSanPhamGoiY(limit, page);

    try {
      final response =
          await dioE.get('/san-pham/get-sanpham-goiy', queryParameters: {
        "page": page,
        "per_page": limit,
      });
      final data = response.data["result"] as List;
      return data.map((f) => SanPhamModel.fromJson(f)).toList();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<SanPhamModel>> getSanPhamGoiYPrivate(
      {int limit = 15, int page = 1}) async {
    // TODO: implement getSanPhamGoiYPrivate
    try {
      final response = await dioE
          .get('/san-pham/get-sanpham-goiy-private', queryParameters: {
        "page": page,
        "per_page": limit,
      });
      final data = response.data["result"] as List;
      return data.map((f) => SanPhamModel.fromJson(f)).toList();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<TemplateModel>> getTemplatePrivate() async {
    // TODO: implement getTemplatePrivate
    // return super.getTemplatePrivate();

    try {
      final response = await dioE.get(
        '/san-pham/get-template-homepage-private',
      );
      final data = response.data["result"] as List;
      return data.map((f) => TemplateModel.fromJson(f)).toList();
    } catch (e) {
      throw e;
    }
  }
}
