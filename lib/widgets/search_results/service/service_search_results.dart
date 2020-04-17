import 'package:Core/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Core/core/page-core/service_custom.dart';
import 'package:Core/widgets/my_library/models/sanpham_model.dart';
import 'package:Core/widgets/search_results/model/parram_filter_model.dart';
import 'package:dio/dio.dart';

class SearchResultsService extends ServiceCustom {
  SearchResultsService(ErrorhandleBloc bloc) : super(bloc);
  Future<List<SanPhamModel>> searchData(
      {ParamFilter filter,
      String id,
      int perPage,
      bool upperbound = true}) async {
    try {
      var object = filter.toJson();
      object['per_page'] = perPage ?? 8;
      object['upper_bound'] = upperbound;
      object['id'] = id ?? '';
      final response = await dioE.post(
        '/san-pham/seek',
        data: object,
      );
      final data = response.data["result"] as List;
      return data.map((f) => SanPhamModel.fromJson(f)).toList();
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<List<SanPhamModel>> searchDataPrivate(
      {ParamFilter filter,
      String id,
      int perPage,
      bool upperbound = true}) async {
    try {
      var object = filter.toJson();
      object['per_page'] = perPage ?? 8;
      object['upper_bound'] = upperbound;
      object['id'] = id ?? '';
      final response = await dioE.post(
        '/san-pham/seek-private',
        data: object,
      );
      final data = response.data["result"] as List;
      return data.map((f) => SanPhamModel.fromJson(f)).toList();
    } on DioError catch (e) {
      throw e;
    }
  }
}
