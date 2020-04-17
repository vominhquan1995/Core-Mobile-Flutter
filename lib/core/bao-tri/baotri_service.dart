import 'package:Midas/core/page-core/service_custom.dart';

class BaoTriService extends ServiceCustom {
  BaoTriService() : super(null);

  Future getBaoTri() async {
    try {
      final response = await dioE.get('/cauhinhchung/thongtin-baotri');

      return response.data;
    } catch (e) {
      throw e;
    }
  }
}
