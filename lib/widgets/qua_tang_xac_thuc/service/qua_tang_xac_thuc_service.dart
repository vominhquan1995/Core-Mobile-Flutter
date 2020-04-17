import 'package:Core/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Core/widgets/lich_su_diem/model/index.dart';
import 'dart:async';
import 'package:Core/core/page-core/service_custom.dart';
import '../../../core/page-core/service_custom.dart';

class QuaTangXacThucService extends ServiceCustom {
  QuaTangXacThucService(ErrorhandleBloc bloc) : super(bloc);

  Future<dynamic> xacThucThanhVien(String maPin) async {
    // TODO: implement getDanhSachQG
    try {
      final response = await dioE
          .post('/profile/xac-thuc-thanh-vien', data: {'ma_pin': maPin});

      final data = response.data;

      return data;
    } catch (e) {
      throw e;
    }
  }
}
