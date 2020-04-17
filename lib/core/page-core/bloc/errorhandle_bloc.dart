import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import './bloc.dart';

class ErrorhandleBloc extends Bloc<ErrorhandleEvent, ErrorhandleState> {
  @override
  ErrorhandleState get initialState => InitialErrorhandleState();

  @override
  Stream<ErrorhandleState> mapEventToState(
    ErrorhandleEvent event,
  ) async* {
    // TODO: Add Logic

    if (event is ErrorCustom) {
      // yield ErrorState(event.e);

      if (event.e is DioError) {
        DioError error = (event.e as DioError);
        if (error.type == DioErrorType.RESPONSE) {
          if (error?.response?.statusCode == 401) {
            yield KhongCoToken();
          }

          if (error?.response?.statusCode == 403) {
            yield KhongCoQuyen();
          }

          print(
              'API: ${error?.request?.path}, Http Error code: ${error?.response?.statusCode}, Message: ${error?.message}');
        }
      }
    }

    if (event is KhongCoLoi) {
      yield InitialErrorhandleState();
    }
  }
}
