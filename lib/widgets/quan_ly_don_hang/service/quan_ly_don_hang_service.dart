import 'package:Midas/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Midas/widgets/quan_ly_don_hang/model/don_hang_model_2.dart';
import 'dart:async';
import 'package:Midas/core/page-core/service_custom.dart';
import '../../../core/page-core/service_custom.dart';

class QuanLyDonHangService extends ServiceCustom {
  QuanLyDonHangService(ErrorhandleBloc bloc) : super(bloc);

  Future<List<DonHangModel>> listDonHang(
      {int id, bool upperbound = true}) async {
    int limit = 10;

    Map<String, dynamic> map = Map();

    map.addAll({
      "per_page": limit,
      "upper_bound": upperbound,
      "id": id ?? '',
    });
    try {
      final response = await dioE.get('/giao-dich/seek', queryParameters: map);

      // If the call to the server was successful, parse the JSON
      final data = response.data["result"] as List;
      return data.map((f) => DonHangModel.fromJson(f)).toList();
    } catch (e) {
      throw e;
    }
  }

  Future<DonHangModel> getOne({int id}) async {
    Map<String, dynamic> map = Map();

    map.addAll({
      "id": id,
    });
    try {
      final response =
          await dioE.get('/giao-dich/getone', queryParameters: map);

      final data = response.data;
      return DonHangModel.fromJson(data);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}

// List<DonHangModel> mapListDonHang(List list) {
//   return list
//       .map((f) => DonHangModel(
//             giao_dich_id: f['giao_dich_id'],
//             don_vi_tien_te: f['don_vi_tien_te'].toString(),
//             giao_hang: f['giao_hang'],
//             loai_thanh_toan: f['loai_thanh_toan'].toString(),
//             ma_giao_dich: f['ma_giao_dich'].toString(),
//             thanh_toan: f['thanh_toan'],
//             thoi_gian_giao_dich: f['thoi_gian_giao_dich'].toString(),
//             thong_tin_giao_dich: f['thong_tin_giao_dich'],
//             time_create: f['time_create'],
//             tinh_trang: f['tinh_trang'],
//             tong_tien: f['tong_tien'],
//             tieu_de_don_hang: f['tieu_de_don_hang'],
//           ))
//       .toList();
// }
