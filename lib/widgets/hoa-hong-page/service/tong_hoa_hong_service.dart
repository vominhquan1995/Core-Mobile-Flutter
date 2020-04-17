import 'package:Core/core/page-core/bloc/errorhandle_bloc.dart';
import 'dart:async';
import 'package:Core/core/page-core/service_custom.dart';
import '../../../core/page-core/service_custom.dart';

class HoaHongCaNhanService extends ServiceCustom {
  HoaHongCaNhanService(ErrorhandleBloc bloc) : super(bloc);

  Future<dynamic> hoaHOngCaNhan(
   { String tu_ngay,
    String toi_ngay,}
  ) async {
    try {
      final response = await dioE.post(
        '/giao-dich/tong-hoa-hong-thang',
        data: {"tu_ngay": tu_ngay, "toi_ngay": toi_ngay},
      );
      // If the call to the server was successful, parse the JSON
      final data = response.data["result"];
      return data;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
