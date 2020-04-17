import 'package:device_id/device_id.dart';
import 'package:dio/dio.dart';
import 'package:Midas/core/authentication/db/authen_provider.dart';
import 'package:Midas/utils/index.dart';

import 'bloc/bloc.dart';

class ServiceCustom1 {
  ErrorhandleBloc bloc;

  static Map<String, String> headers = {
    "app-key": "MIDAS",
  };

  static BaseOptions options = new BaseOptions(
      baseUrl: DioUtil.getApiMidas(),
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: headers);

  static BaseOptions optionsP = new BaseOptions(
      baseUrl: DioUtil.getApiPhanQuyen(),
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: headers);

  static BaseOptions optionsA = new BaseOptions(
      baseUrl: DioUtil.getApiAuthentication(),
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: headers);

  static BaseOptions optionsU = new BaseOptions(
      baseUrl: DioUtil.getApiUploadFile(),
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: headers);

  Dio dioE = Dio(options);
  Dio dioP = Dio(optionsP);
  Dio dioU = Dio(optionsU);
  Dio dioA = Dio(optionsA);

  final List<int> _defaultError = [403, 401];

  ServiceCustom1(ErrorhandleBloc bloc) : bloc = bloc ?? ErrorhandleBloc() {
    initialDio();
  }

  initialDio() {
    dioE.interceptors.add(InterceptorsWrapper(
        onError: _onError,
        onRequest: (requestOption) => _onRequest(requestOption, dioE)));

    dioP.interceptors.add(InterceptorsWrapper(
        onError: _onError,
        onRequest: (requestOption) => _onRequest(requestOption, dioP)));

    dioU.interceptors.add(InterceptorsWrapper(
        onError: _onError,
        onRequest: (requestOption) => _onRequest(requestOption, dioU)));

    dioA.interceptors.add(InterceptorsWrapper(
        onError: _onError,
        onRequest: (requestOption) => _onRequest(requestOption, dioA)));
  }

  /// On Error
  _onError(DioError error) {
    if (error.type == DioErrorType.RESPONSE &&
        _defaultError.contains(error.response.statusCode)) {
      bloc?.add(ErrorCustom(error));
      return;
    }
  }

  _onRequest(RequestOptions options, Dio dio) async {
    ///Header
    dio.interceptors.requestLock.lock();

    options.headers
        .addAll({"Authorization": 'JWT ${await AuthenProvider.getToken()}'});

    ///Add uuid
    if (options.method == 'GET') {
      options.queryParameters.addAll(
        {
          "diuu": await DeviceId.getID,
        },
      );
    }

    ///Add uuid in POST
    if (options.method == 'POST') {
      if (options.data is Map) {
        Map map = Map.from(options.data);
        map.addAll(
          {
            "diuu": await DeviceId.getID,
          },
        );
        options.data = map;
      }
    }
    dio.interceptors.requestLock.unlock();

    return options;
  }
}
