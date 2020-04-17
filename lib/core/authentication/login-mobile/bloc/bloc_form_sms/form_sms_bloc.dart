import 'dart:async';
import 'package:Midas/core/authentication/login-mobile/bloc/bloc_form_sms/index.dart';
import 'package:Midas/core/authentication/phone_auth/index.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class FormSMSBloc extends Bloc<FormSMSEvent, FormSMSState> {
  final PhoneAuth service;
  FormSMSBloc({this.service});

  @override
  Stream<FormSMSState> transformEvents(
    Stream<FormSMSEvent> events,
    Stream<FormSMSState> Function(FormSMSEvent event) next,
  ) {
    return super.transformEvents(
      (events as Observable<FormSMSEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  FormSMSState get initialState => InitialFormSMSState();

  @override
  Stream<FormSMSState> mapEventToState(FormSMSEvent event) async* {
    if (event is SendSMSAgain) {
      if (event.number != null) {
        final result = await service.guiSms(event.number).then((onValue) {
          return Future.value(onValue);
        }).catchError((onError) {
          return Future.value(onError);
        });

        if (result['code'] == 400) {
          if (state is CheckValidFormSMSState) {
            yield (state as CheckValidFormSMSState)
                .copyWith(codeOld: 400, messageOld: result['result']);
          } else {
            yield CheckValidFormSMSState(code: 400, message: result['result']);
          }
        }
      }
    }

    if (event is MessageSmsFail) {
      yield MessageSMSState(
          code: event.code, message: event.message, errorCode: event.errorCode);
    }

    if (event is LoginEvent) {
      if (state is WaitingFormState) {
        yield (state as WaitingFormState).copyWith(loadingNew: true);
      } else {
        yield WaitingFormState(loading: true);
      }

      if (event.sms == null || event.sms.trim().length == 0) {
        this.add(MessageSmsFail(code: 400, message: 'otp_6'));
      } else {
        try {
          var result = await this
              .service
              .xacThucBangCodeSms(event.sms, event.number, event.quocGiaId);
          if (result['code'] == 400) {
            result['message'] = result['message'] == 'otp_10'
                ? tr(result['message'], args: [event.quocGiaName])
                : result['message'];

            this.add(MessageSmsFail(code: 400, message: result['message']));
          }

          if (result['code'] == 200) {
            this.add(NavigatorSmsCode(
                user: result['data']['profile'],
                quocGia: result['data']['quocGia']));
          }
          
        } catch (ex) {
          try {
            if (ex['code'] != null && ex['message'] != null) {
              this.add(MessageSmsFail(
                  code: 400, message: 'otp_9', errorCode: ex['code']));
            } else {
              this.add(MessageSmsFail(code: 400, message: 'otp_9'));
            }
          } catch (ex) {
            this.add(MessageSmsFail(code: 400, message: 'otp_9'));
          }
        }
      }
    }

    if (event is NavigatorSmsCode) {
      yield NavigatorSmsCodeState(user: event.user, quocGia: event.quocGia);
    }

    if (event is WaitingFormSMS) {
      if (state is WaitingFormState) {
        yield (state as WaitingFormState).copyWith(loadingNew: event.loading);
      } else {
        yield WaitingFormState(loading: event.loading);
      }
    }
  }
}
