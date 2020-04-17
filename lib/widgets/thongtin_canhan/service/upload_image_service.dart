import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:Midas/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Midas/core/page-core/service_custom.dart';
import 'package:Midas/utils/index.dart';
import 'package:path/path.dart';

class UploadImageService extends ServiceCustom {
  UploadImageService(ErrorhandleBloc bloc) : super(bloc);

  Future<dynamic> uploadImage(File asset) async {
    try {
      (dioU.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
      };
      FormData formdata = new FormData.fromMap({
        "files": [
          await MultipartFile.fromFile(asset.path,
              filename: basename(asset.path)),
        ],
        "uploadPath": 'public/avatar/file',
        "tableName": 'contacts',
        "size_image": "[[120,60]]",
        "quality_image": '["hq", "mq"]',
        "file_system_guid": 0,
        "linkFile": ''
      });

      final response = await dioU.post('/api/files/upload-avatar',
          data: formdata, onSendProgress: (x, y) {
        print('$x va $y');
      });

      // If the call to the server was successful, parse the JSON
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response;
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<bool> updateThongTinTaiKhoan(
      {String avatar, String file_system_guid, dynamic path_resize}) async {
    try {
      Map<String, dynamic> map = Map.from({
        "avatar": '${DioUtil.getApiUploadFile()}/$avatar',
        "file_system_guid": file_system_guid,
        "path_resize": path_resize
      });
      final response =
          await dioP.post('/api/thong-tin-tai-khoan/update', data: map);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw false;
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
