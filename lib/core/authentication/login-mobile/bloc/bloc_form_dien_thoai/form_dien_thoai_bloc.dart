import 'dart:async';
import 'package:Midas/core/authentication/login-mobile/bloc/bloc_form_dien_thoai/index.dart';
import 'package:Midas/core/authentication/phone_auth/index.dart';
import 'package:bloc/bloc.dart';

class FormDienThoaiBloc extends Bloc<FormDienThoaiEvent, FormDienThoaiState> {
  final PhoneAuth service;
  FormDienThoaiBloc({this.service});

  @override
  FormDienThoaiState get initialState => InitialFormDienThoaiState();

  @override
  Stream<FormDienThoaiState> mapEventToState(FormDienThoaiEvent event) async* {
    /*
    kiểm tra điện thoại + show message nếu có
    */
    if (event is SendNumber && event.is_call_api == true) {
      /* 
      clear message trước
     */

      if (state is WaitingFormState) {
        yield (state as WaitingFormState).copyWith(loadingNew: true);
      } else {
        yield WaitingFormState(loading: true);
      }

      if (event.number == null || event.number.trim().length == 0) {
        if (state is SendNumberState) {
          yield (state as SendNumberState).copyWith(
              codeNew: 201,
              messageNew: 'login_4',
              iconNew: event.iconLang,
              codeLangNew: event.codeLang);
        } else {
          yield SendNumberState(
              code: 201,
              message: 'login_4',
              iconLang: event.iconLang,
              codeLang: event.codeLang);
        }
      } else {
        try {
          if (event.number != null) {
            // final resultCheckNumber =
            //     await service.checkPhoneNumber(event.codeLang + event.number);

            /* 
            lỗi format số điện thoại
             */
            // if (resultCheckNumber['code'] == 201) {
            //   if (state is SendNumberState) {
            //     yield (state as SendNumberState).copyWith(
            //         codeNew: 400,
            //         messageNew: resultCheckNumber['message'],
            //         iconNew: event.iconLang,
            //         codeLangNew: event.codeLang);
            //   } else {
            //     yield SendNumberState(
            //         code: 400,
            //         message: resultCheckNumber['message'],
            //         iconLang: event.iconLang,
            //         codeLang: event.codeLang);
            //   }
            // } else {
            final result = await service
                .guiSms(event.codeLang + event.number)
                .then((onValue) {
              return Future.value(onValue);
            }).catchError((onError) {
              return Future.value(onError);
            });
            if (result['code'] == 200) {
              add(NavigatorSmsCode(number: event.codeLang + event.number));
            }

            if (result['code'] == 400) {
              if (state is SendNumberState) {
                yield (state as SendNumberState).copyWith(
                    codeNew: 400,
                    messageNew: result['result'],
                    iconNew: event.iconLang,
                    codeLangNew: event.codeLang);
              } else {
                yield SendNumberState(
                    code: 400,
                    message: result['result'],
                    iconLang: event.iconLang,
                    codeLang: event.codeLang);
              }
            }
            // }
          }
        } catch (ex) {
          yield SendNumberState(
              code: 400,
              message: 'login_5',
              iconLang: event.iconLang,
              codeLang: event.codeLang);
        }
      }
    }

    if (event is SendNumber && event.is_call_api == false) {
      yield WaitingFormState(loading: true);

      yield SendNumberState(
          iconLang: event.iconLang,
          codeLang: event.codeLang);
    }

    /* 
    show loading
     */
    if (event is NavigatorSmsCode) {
      yield NavigatorSmsCodeState(number: event.number);
    }

    if (event is WaitingFormDienThoai) {
      if (state is WaitingFormState) {
        yield (state as WaitingFormState).copyWith(loadingNew: event.loading);
      } else {
        yield WaitingFormState(loading: event.loading);
      }
    }
  }
}
