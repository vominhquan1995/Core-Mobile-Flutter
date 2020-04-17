import 'dart:async';
import 'package:dio/dio.dart';
import 'package:Core/core/page-core/service_custom.dart';

class VersionService extends ServiceCustom {
  VersionService() : super(null);

  Future<dynamic> getVersion() async {
    try {
      final response = await dioE.get(
        '/cauhinhchung/thietbi/version',
      );

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
