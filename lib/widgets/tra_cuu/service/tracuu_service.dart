import 'package:Core/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Core/core/page-core/service_custom.dart';
import 'package:Core/widgets/tra_cuu/models/tracuu_model.dart';

abstract class IBaseTraCuuService extends ServiceCustom {
  IBaseTraCuuService(ErrorhandleBloc bloc) : super(bloc);

  Future<List<TraCuuHeader>> getDanhSachTraCuu(String language) async =>
      <TraCuuHeader>[];
}

class TraCuuService extends IBaseTraCuuService {
  TraCuuService(ErrorhandleBloc bloc) : super(bloc);

  @override
  Future<List<TraCuuHeader>> getDanhSachTraCuu(String language) async {
    final response = await dioE.get('/cauhinhchung/get-tracuu',
        queryParameters: {"language": language});
    final list = response.data["result"] as List;
    return list.map((f) => TraCuuHeader.fromJson(f)).toList();
  }
}
