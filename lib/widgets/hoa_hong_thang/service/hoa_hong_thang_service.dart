import 'package:Core/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Core/widgets/hoa_hong_thang/model/index.dart';
import 'dart:async';
import 'package:Core/core/page-core/service_custom.dart';
import '../../../core/page-core/service_custom.dart';

class HoaHongThangService extends ServiceCustom {
  HoaHongThangService(ErrorhandleBloc bloc) : super(bloc);

  Future<List<HoaHongThangModel>> listHoaHongThang(
      {int limit = 7, int offset = 0, String tu_ngay, String toi_ngay,int loai_khach_hang}) async {
    try {
      final response = await dioE.post(
        '/giao-dich/lich-su-hoa-hong-thang',
        data: {
          "tu_ngay": tu_ngay,
          "toi_ngay": toi_ngay,
          "limit": limit,
          "offset": offset,
          "loai_khach_hang": 1
        },
      );

      // If the call to the server was successful, parse the JSON
      final data = response.data["result"] as List;

      return data.map((f) => HoaHongThangModel.fromJson(f)).toList();
    } catch (e) {
      throw e;
    }
  }
}
