import 'dart:async';
import 'dart:io';
import 'package:Core/core/page-core/bloc/bloc.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:Core/core/page-core/service_custom.dart';
import 'package:path/path.dart';

class ImageService extends ServiceCustom {
  ImageService(ErrorhandleBloc bloc) : super(bloc);
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
        "uploadPath": 'public/images/file',
        "tableName": 'banner_salon',
        "size_image": "[[640,320]]",
        "quality_image": '["hq", "mq"]',
        "file_system_guid": 0,
        "linkFile": ''
      });
      final response = await dioU.post('/api/files/upload', data: formdata,
          onSendProgress: (x, y) {
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
}
