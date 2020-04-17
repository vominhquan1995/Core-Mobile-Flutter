

import '../../../page-core/service_custom.dart';
import '../index.dart';

class QuocGiaLoginService extends ServiceCustom {
  QuocGiaLoginService() : super(null);

  /* 
   load thông tin cá nhân
   */
  Future<dynamic> getQuocGia() async {
    try {
      final response = await dioE.get('/quoc-gia/json/gets');

      final data = response.data["result"];
      if (data != null) {
        return QuocGiafromJson(data);
      } else {
        return [];
      }
    } catch (e) {
      throw e;
    }
  }
}
