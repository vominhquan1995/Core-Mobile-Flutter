import 'package:Midas/core/page-core/bloc/bloc.dart';
import 'package:Midas/core/page-core/service_custom.dart';
import 'package:Midas/widgets/upgrade_account/model/request_upgrade_model.dart';
import 'package:dio/dio.dart';

class UpgradeAccountService extends ServiceCustom {
  UpgradeAccountService(ErrorhandleBloc bloc) : super(bloc);
  Future<RequestUpgrade> checkRequestAccount() async {
    try {
      final response = await dioE.get('/profile/check-upgrade-account');
      RequestUpgrade data = RequestUpgrade.fromJson(response.data);
      return data;
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<bool> insertRequest(RequestUpgrade request) async {
    try {
      final body = {
        "ma_nguoi_gioi_thieu": request.maGioiThieu,
        "thong_tin_quan_ly": {
          "quan_id": request.quanId,
          "tinh_id": request.tinhId,
          "hinh_anh": request.hinhAnh,
          "ten_shop": request.tenShop,
          "phuong_id": request.phuongId,
          "quan_name": request.quanName,
          "tinh_name": request.tinhName,
          "phuong_name": request.phuongName,
          "quoc_gia_id": request.quocGiaId,
          "dia_chi_shop": request.diaChiShop,
          "quoc_gia_name": request.quocGiaName,
          "don_vi_tien_te_id": request.tienTeId
        }
      };
      final response =
          await dioE.post('/profile/request-upgrade-account', data: body);
      return true;
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<RequestUpgrade> getInfoSalon() async {
    try {
      final response = await dioE.get('/profile/info-salon');
      RequestUpgrade data = RequestUpgrade.fromJson(response.data);
      return data;
    } on DioError catch (e) {
      throw e;
    }
  }
}
