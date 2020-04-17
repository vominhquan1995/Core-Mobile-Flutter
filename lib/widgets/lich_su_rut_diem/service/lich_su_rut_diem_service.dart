import 'package:Core/core/page-core/bloc/bloc.dart';
import 'package:Core/widgets/lich_su_rut_diem/model/lich_su_rut_diem_model.dart';
import 'dart:async';
import 'package:Core/core/page-core/service_custom.dart';
import '../../../core/page-core/service_custom.dart';

class LichSuRutDiemService extends ServiceCustom {
  LichSuRutDiemService(ErrorhandleBloc bloc) : super(bloc);

  Future<List<LichSuRutDiemModel>> listLichSuRutDiem(
      {int limit = 10, int offset = 0}) async {
    try {
      final response = await dioE.post(
        '/rut-hoa-hong/lich-su-yeu-cau',
        data: {"limit": limit, "offset": offset},
      );

      // If the call to the server was successful, parse the JSON
      final data = response.data["result"] as List;

      return data.map((f) => LichSuRutDiemModel.fromJson(f)).toList();
    } catch (e) {
      throw e;
    }
  }
}

