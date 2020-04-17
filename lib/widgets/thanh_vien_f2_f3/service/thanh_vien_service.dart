import 'dart:async';
import 'package:Core/core/page-core/service_custom.dart';
import '../../../core/page-core/service_custom.dart';

class ThanhVienService extends ServiceCustom {
  ThanhVienService() : super(null);

  Future<dynamic> listPhanCap() async {
    try {
      final response = await dioE.get('/profile/get-phan-cap');
      final data = response.data["result"];
      return data;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
