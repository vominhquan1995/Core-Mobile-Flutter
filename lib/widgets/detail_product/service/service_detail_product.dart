import 'package:Midas/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Midas/core/page-core/service_custom.dart';
import 'package:Midas/widgets/my_library/models/sanpham_model.dart';
class DetailProductService extends ServiceCustom {
  DetailProductService(ErrorhandleBloc bloc) : super(bloc);
  Future<SanPhamModel> getDataDetail(String sanPhamId) async {
    try {
      final response = await dioE.get(
        '/san-pham/getone',
        queryParameters: {"san_pham_id": sanPhamId},
      );
      SanPhamModel detail = SanPhamModel.fromJson(response.data["result"]);
      return detail;
    } catch (e) {
      throw e;
    }
  }

  Future<SanPhamModel> getDataDetailPrivate(String sanPhamId) async {
    try {
      final response = await dioE.get(
        '/san-pham/getone-private',
        queryParameters: {"san_pham_id": sanPhamId},
      );
      SanPhamModel detail = SanPhamModel.fromJson(response.data["result"]);
      return detail;
    } catch (e) {
      throw e;
    }
  }
}
