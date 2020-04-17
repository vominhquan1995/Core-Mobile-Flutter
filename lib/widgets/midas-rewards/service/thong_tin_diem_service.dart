import 'package:Midas/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Midas/widgets/midas-rewards/model/huong_dang_model.dart';
import 'package:Midas/widgets/midas-rewards/model/thong_tin_diem_model.dart';
import 'dart:async';
import 'package:Midas/core/page-core/service_custom.dart';
import '../../../core/page-core/service_custom.dart';

class ThongTinDiemService extends ServiceCustom {
  ThongTinDiemService(ErrorhandleBloc bloc) : super(bloc);

  Future<ThongTinDiemModel> getThongTinDiem() async {
    try {
      final response = await dioE.get('/profile/get-thong-tin-diem');

      final data = response.data["result"];
      return ThongTinDiemModel.fromJson(data);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> updateThongTin(
      {tai_khoan_ngan_hang, ten_ngan_hang, ten_nguoi_nhan}) async {
    try {
      final response = await dioE.post(
        '/profile/update-profile-nganhang',
        data: {
          "tai_khoan_ngan_hang": tai_khoan_ngan_hang,
          "ten_ngan_hang": ten_ngan_hang,
          "ten_nguoi_nhan": ten_nguoi_nhan
        },
      );

      return response;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> taoYeuCauRutDiem({so_tien_rut}) async {
    try {
      final response = await dioE.post(
        '/rut-hoa-hong/tao-yeu-cau',
        data: {"so_tien_rut": so_tien_rut},
      );
      return response.data['result']['code'];
    } catch (e) {
      print(e);
      throw e;
    }
  }
}

abstract class IBaseHuongDanService extends ServiceCustom {
  IBaseHuongDanService(ErrorhandleBloc bloc) : super(bloc);

  Future<HuongDanHeader> getDanhSachHuongDan(String language) async =>
      HuongDanHeader();
}

class HuongDanService extends IBaseHuongDanService {
  HuongDanService(ErrorhandleBloc bloc) : super(bloc);

  @override
  Future<HuongDanHeader> getDanhSachHuongDan(String language) async {
    final response = await dioE.get('/cauhinhchung/get-huongdan',
        queryParameters: {"language": language}).catchError((onError){
          print(onError);
        });
    final list = response.data["result"];
    return  HuongDanHeader.fromJson(list);
  }
}
