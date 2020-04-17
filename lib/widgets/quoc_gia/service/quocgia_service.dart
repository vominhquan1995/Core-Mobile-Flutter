import 'package:Midas/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Midas/widgets/quoc_gia/models/quocgia_model.dart';

import '../../../core/page-core/service_custom.dart';

abstract class IBaseQuocGiaService extends ServiceCustom {
  IBaseQuocGiaService(ErrorhandleBloc bloc) : super(bloc);

  Future<List<QuocGiaModel>> getDanhSachQG() async => <QuocGiaModel>[];
}

class QuocGiaService extends IBaseQuocGiaService {
  QuocGiaService() : super(null);

  @override
  Future<List<QuocGiaModel>> getDanhSachQG() async {
    // TODO: implement getDanhSachQG
    try {
      final response = await dioPub.get('/profile/get-thi-truong');

      final data = response.data["result"] as List;

      // final data = dataQuocGiaJson["result"] as List;

      return data.map((f) => QuocGiaModel.fromJson(f)).toList();
    } catch (e) {
      throw e;
    }
  }
}
