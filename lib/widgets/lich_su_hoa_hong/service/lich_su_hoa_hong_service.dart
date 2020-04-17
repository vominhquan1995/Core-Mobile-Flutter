import 'package:Midas/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Midas/widgets/hoa_hong_thang/model/index.dart';
import 'package:Midas/widgets/lich_su_diem/model/index.dart';
import 'package:Midas/widgets/lich_su_hoa_hong/model/index.dart';
import 'package:Midas/widgets/quan_ly_don_hang/model/don_hang_model_2.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:Midas/core/page-core/service_custom.dart';
import 'package:flutter/foundation.dart';
import '../../../core/page-core/service_custom.dart';

class LichSuHoaHongService extends ServiceCustom {
  LichSuHoaHongService(ErrorhandleBloc bloc) : super(bloc);

  Future<List<HoaHongModel>> listLichSuHoaHong(
      {int limit = 6, int offset = 0, String tu_ngay, String toi_ngay}) async {
    try {
      final response = await dioE.post(
        '/giao-dich/lich-su-hoa-hong',
        data: {
          "tu_ngay": tu_ngay,
          "toi_ngay": toi_ngay,
          "limit": limit,
          "offset": offset
        },
      );
      // If the call to the server was successful, parse the JSON
      final data = response.data["result"] as List;
      return data.map((f) => HoaHongModel.fromJson(f)).toList();
    } catch (e) {
      throw e;
    }
  }
}
