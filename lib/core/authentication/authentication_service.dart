import 'dart:core';
import 'dart:io';

import 'package:Midas/widgets/quoc_gia/models/quocgia_model.dart';
import 'package:dio/dio.dart';
import 'package:Midas/core/page-core/service_custom.dart';
import 'package:Midas/utils/index.dart';
import 'package:meta/meta.dart';
import 'package:package_info/package_info.dart';

import 'models/profile_model.dart';

class AuthenticationService extends ServiceCustom {
  AuthenticationService() : super(null);

  Future<Profile> login(
      {@required String username, @required String password}) async {
    try {
      final response = await dioP.post('/login-mobile',
          data: {'username': username, 'password': password});

      Map<String, dynamic> map = Map();
      map.addAll({
        "maso": username,
        "token": response.data['token'],
        "listmenu": response.data['listmenu_active'],
      });
      map.addAll(response.data['result']);

      return Profile.fromJson(map);
    } catch (e) {
      throw e;
    }
  }

  Future insertActive() async {
    try {
      final PackageInfo info = await PackageInfo.fromPlatform();
      await dioE.post('/cauhinhchung/insert-activity', data: {
        'platform': Platform.isAndroid ? 'Android' : 'Ios',
        'version_api': Variables.isDevelop
            ? Variables.developVersionAPI
            : Variables.releaseVersionAPI,
        'version_code': info.buildNumber
      });
    } catch (e) {
      throw e;
    }
  }

  Future logout() async {
    try {
      final response = await dioA.post('/auth/logout-mobile', data: {});
      return true;
    } catch (e) {
      return true;
      // String code = '105';
      // if (e.type == DioErrorType.DEFAULT) {
      //   code = '103';
      // }
      // if (e.type == DioErrorType.RESPONSE) {
      //   List listErrors = e.response.data['errors'] as List;
      //   code = listErrors.map((f) => f['code']).join(' - ');
      // }
      // if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      //   code = '104';
      // }
      // throw {
      //   'code': code,
      //   'message':
      //       'Không thể đăng xuất. Vui lòng thử lại sau hoặc gỡ bỏ ứng dụng và cài đặt lại.'
      // };
    }
  }

  Future<dynamic> loginSMS(
      {@required String token_firebase, @required String quoc_gia_id}) async {
    try {
      final response = await dioA.post('/auth/login-sms',
          data: {'token': token_firebase, 'quoc_gia_id': quoc_gia_id});
      /* 
      add token
        */
      // await AuthenticationService.addToken(response.data['token']);

      final data = response.data;

      if (data['code'] == 200) {
        Map<String, dynamic> map = Map();
        map.addAll(
          {
            "maso": data['result']['NhanVienID'],
            "token": data['token'],
            "listmenu_active": data["listmenu_active"]
          },
        );
        map.addAll(data['result']);

        Map<String, dynamic> mapQuocGia = Map();
        mapQuocGia
            .addAll({'locale': data['quoc_gia_info']['ngon_ngu_mac_dinh']});
        mapQuocGia.addAll(data['quoc_gia_info']);

        return {
          'code': 200,
          'profile': Profile.fromJson(map),
          'quocGia': QuocGiaModel.fromJson(mapQuocGia)
        };
      }

      if (data['code'] == 201) {
        return {'message': data['message'], 'code': 201};
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
