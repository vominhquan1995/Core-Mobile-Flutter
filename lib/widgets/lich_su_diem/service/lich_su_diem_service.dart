import 'package:Core/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Core/widgets/lich_su_diem/model/index.dart';
import 'dart:async';
import 'package:Core/core/page-core/service_custom.dart';
import '../../../core/page-core/service_custom.dart';

class LichSuDiemService extends ServiceCustom {
  LichSuDiemService(ErrorhandleBloc bloc) : super(bloc);

  Future<List<LichSuDiemModel>> listLichSuDiem(
      {int limit = 10, int offset = 0}) async {
    try {
      final response = await dioE.post(
        '/rut-hoa-hong/lich-su-midas-rewards',
        data: {"limit": limit, "offset": offset},
      );

      // If the call to the server was successful, parse the JSON
      final data = response.data["result"] as List;

      return data.map((f) => LichSuDiemModel.fromJson(f)).toList();
    } catch (e) {
      throw e;
    }
  }
}