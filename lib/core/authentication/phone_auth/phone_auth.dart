import 'package:Midas/core/authentication/phone_auth/service/index.dart';
import 'package:dio/dio.dart';

import '../authentication_service.dart';
import 'index.dart';

class PhoneAuth extends PhoneModel {
  PhoneFirebase _signin;
  AuthenticationService _service;
  ContactService _contactService;

  PhoneAuth() {
    _signin = new PhoneFirebase();
    _service = new AuthenticationService();
    _contactService = new ContactService();
  }

  /* 
    gửi sms
   */
  Future<dynamic> guiSms(number) {
    return this._signin.guiSms(number);
  }

  /* 
  check số điện thoại
   */
  Future<dynamic> checkPhoneNumber(number) {
    return this._contactService.checkPhoneNumber(number);
  }

  /* 
  xác thực sms
  true-> thành công
  false thất bại
   */
  Future<dynamic> xacThucBangCodeSms(smsCode, number, quocGiaId) async {
    final result = await this._signin.xacThucBangCodeSms(smsCode);
    if (result == null) {
      return Future.value({'code': 400, 'message': 'otp_7'});
    }

    if (result == -1) {
      return Future.value({'code': 400, 'message': 'otp_8'});
    }
    try {
      final res_api = await this
          ._service
          .loginSMS(token_firebase: result, quoc_gia_id: quocGiaId);

      if (res_api['code'] == 200) {
        return Future.value(({'code': 200, 'message': '', 'data': res_api}));
      }

      if (res_api['code'] == 201) {
        return Future.value(({'code': 400, 'message': res_api['message']}));
      }
    } on DioError catch (e) {
      throw e.response.data;
    }
  }

  /* 
  đăng xuất
   */
  Future<void> dangXuat() async {
    await this._signin.sigOut();
  }
}
