import 'dart:async';

import 'package:dio/dio.dart';
import 'package:Core/core/page-core/service_custom.dart';

class MaintenanceService extends ServiceCustom {
  MaintenanceService() : super(null);

  Future maintenance() async {
    try {
      final response = await dioE.get('/cauhinhchung/maintenance');

      return response.data["result"];
    } on DioError catch (e) {
      throw e;
    }
  }

  Future getHtml(String fileName) async {
    try {
      final response = await dioE
          .get('/cauhinhchung/get-html', queryParameters: {"html": fileName});

      return response.data["result"];
    } on DioError catch (e) {
      throw e;
    }
  }
}
