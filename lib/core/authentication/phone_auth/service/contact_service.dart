import '../../../page-core/service_custom.dart';

class ContactService extends ServiceCustom {
  ContactService() : super(null);

  /* 
   check xem có số điện thoại đã nhập chưa
   */
  Future<dynamic> checkPhoneNumber(so_dien_thoai) async {
    try {
      final response = await dioE.post('/contact/check-so-dien-thoai',
          data: {"so_dien_thoai": so_dien_thoai});

      final data = response.data;
      return data;
    } catch (e) {
      throw e;
    }
  }
}
