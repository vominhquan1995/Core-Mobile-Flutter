import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:Midas/core/authentication/models/profile_model.dart';

import '../../authentication_service.dart';
import './index.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService authenticationService;

  LoginBloc({
    @required this.authenticationService,
  }) : assert(authenticationService != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final Profile user = await authenticationService.login(
          username: event.username,
          password: event.password,
        );
        yield LoginSucess(user);
      } catch (e) {
        var message = 'Lỗi bất thường';
        var linkRedirect;
        var linkRedirectName;
        if (e.type == DioErrorType.DEFAULT) {
          message = 'Mất kết nối, vui lòng kiểm tra lại kết nối mạng.';
        }
        if (e.type == DioErrorType.RESPONSE) {
          if (!(e.response.data is String) &&
              e.response.data['message'] != null) {
            message = e.response.data['message'];
            linkRedirect = e.response.data['redirectLink'];
            linkRedirectName = e.response.data['redirectName'];
          } else {
            message = e.response.data;
          }
        }
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          message = 'Thời gian phản hồi lâu';
        }
        yield LoginFailure(
            error: message,
            linkRedirect: linkRedirect,
            linkRedirectName: linkRedirectName);
      }
    }
  }
}
