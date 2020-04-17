import 'dart:convert';

import 'package:Core/core/config_json/models/config_json.dart';
import 'package:Core/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Core/core/page-core/service_custom.dart';

abstract class IBaseConfigJsonService extends ServiceCustom {
  IBaseConfigJsonService(ErrorhandleBloc bloc) : super(bloc);

  Future<ConfigJson> getConfigJson(String codeC, String codeL) async =>
      ConfigJson();
  Future<String> getConfigJsonFull();
}

class ConfigJsonService extends IBaseConfigJsonService {
  ConfigJsonService() : super(null);

  @override
  Future<ConfigJson> getConfigJson(String codeC, String codeL) async {
    // TODO: implement getConfigJson
    try {
      final response = await dioE.get('/cauhinhchung/get-config',
          queryParameters: {"locate": codeC, "language": codeL});

      final dataJson = response.data;

      if ((dataJson as Map<String, dynamic>).isEmpty) {
        return ConfigJson();
      }
      return ConfigJson.fromJson(dataJson);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<String> getConfigJsonFull() async {
    try {
      final response =
          await dioE.get('/cauhinhchung/get-config-data', queryParameters: {});
      final dataJsonString =json.encode(response.data);
      return dataJsonString ?? '{}';
    } catch (e) {
      throw e;
    }
  }
}
