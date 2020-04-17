import 'dart:async';

import 'package:Core/core/authentication/bloc/bloc.dart';
import 'package:Core/core/authentication/login-mobile/bloc/bloc_form_dien_thoai/form_dien_thoai_bloc.dart';
import 'package:Core/core/authentication/login-mobile/bloc/bloc_form_dien_thoai/form_dien_thoai_event.dart';
import 'package:Core/core/authentication/login-mobile/bloc/bloc_form_sms/index.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/core/notification/bloc/index.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/quoc_gia/bloc/quocgia_bloc.dart';
import 'package:Core/widgets/shared/buttonMidas/button_midas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef void Login(String sms);
typedef void WaitingFormDT();

class FormNhapSms extends StatefulWidget {
  final TextEditingController smsTextController;
  final FocusNode focusSMSText;
  final Login login;
  final String number;
  final FormSMSBloc bloc;
  final String numberApi;

  const FormNhapSms({
    Key key,
    this.login,
    this.smsTextController,
    this.focusSMSText,
    this.number,
    this.bloc,
    this.numberApi,
  }) : super(key: key);
  @override
  _FormNhapSmsState createState() => _FormNhapSmsState();
}

class _FormNhapSmsState extends State<FormNhapSms> {
  Timer _timer;
  int _start = 90;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this._timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocListener(
        bloc: widget.bloc,
        listener: (BuildContext _, FormSMSState state) {
          if (state is NavigatorSmsCodeState) {
            /// Hiện loading
            BlocProvider.of<FormDienThoaiBloc>(context)
                .add(WaitingFormDienThoai(loading: true));

            /// Chạy bảo trì
            // BlocProvider.of<BaoTriBloc>(context).add(BaoTriStart());
            // call again event regis token notify add by quanvo
            BlocProvider.of<CoreNotificationBloc>(context)
                .add(ReInitToken(context: context));

            authBloc.add(UpdateUser(state.user));

            ///Pop về page Root
            Navigator.popUntil(context, ModalRoute.withName('/'));
            // Future.delayed(Duration(seconds: 2), () {

            // });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // giới thiệu
            Container(child: Text('${widget.number}', style: style22_semibold)),
            SizedBox(height: paddingM),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(bottom: paddingL),
                child: Text(tr('otp_1'), style: style15)),
            // end giới thiệu

            //form
            BlocBuilder(
                bloc: widget.bloc,
                builder: (BuildContext context, FormSMSState state) {
                  if ((state is WaitingFormState && state.loading == true) ||
                      state is NavigatorSmsCodeState) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 5),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(height: 20)
                      ],
                    );
                  }
                  return Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: paddingL),
                      Container(
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                  child: TextField(
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                focusNode: widget.focusSMSText,
                                controller: widget.smsTextController,
                                style: style13.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    hintText: tr('otp_2'),
                                    focusedBorder: new OutlineInputBorder(
                                      borderSide: borderSide,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: borderSide)),
                              )),
                            )
                          ],
                        ),
                      ),
                      this.widgetThongBaoLoi(),
                      SizedBox(height: paddingXS),
                      buttonDangNhap(),
                      SizedBox(height: paddingL),
                      guiLaiMaSmsButton(),
                      SizedBox(height: paddingL),
                      FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Container(
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.fromLTRB(0, paddingL, 0, paddingL),
                            child: Text(
                              tr('otp_5'),
                              style: style15,
                              textAlign: TextAlign.center,
                            ),
                          ))
                    ],
                  ));
                })

            // end form
          ],
        ));
  }

  buttonDangNhap() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60),
      child: ButtonMidas(
        onPressed: () {
          final dataL =
              (BlocProvider.of<QuocgiaBloc>(context).state as DanhSachQuocgia);
          widget.bloc.add(LoginEvent(
              quocGiaName: dataL.confirm.tenQG,
              sms: widget.smsTextController.text,
              number: widget.numberApi,
              quocGiaId: dataL.confirm.quocGiaId));
        },
        child: Text(
          tr('otp_3'),
          style:
              style17.copyWith(color: colorWhite, fontWeight: FontWeight.bold),
        ),
      ),
    );
//  FlatButton(
//                           padding: EdgeInsets.symmetric(
//                               horizontal:
//                                   MediaQuery.of(context).size.width / 4),
//                           onPressed: () {
//                             final dataL = (BlocProvider.of<QuocgiaBloc>(context)
//                                 .state as DanhSachQuocgia);
//                             widget.bloc.add(LoginEvent(
//                                 sms: widget.smsTextController.text,
//                                 number: widget.numberApi,
//                                 quocGiaId: dataL.confirm.quocGiaId));
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(5)),
//                               color: colorViolet,
//                             ),
//                             alignment: Alignment.center,
//                             padding: EdgeInsets.symmetric(vertical: paddingL),
//                             child: Text(
//                               tr('otp_3'),
//                               style: style17.copyWith(
//                                   color: colorWhite,
//                                   fontWeight: FontWeight.bold),
//                               textAlign: TextAlign.center,
//                             ),
//                           )),
  }

  /* 
  text thông báo lỗi
   */
  widgetThongBaoLoi() {
    return BlocBuilder(
        bloc: widget.bloc,
        builder: (BuildContext context, FormSMSState state) {
          if (state is MessageSMSState) {
            if (state.code == 400 || state.code == 201) {
              return Opacity(
                  opacity: 0.8,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        paddingL, paddingM, paddingM, paddingM),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      state.errorCode != null
                          ? '${tr(state.message)} - [Error: ${state.errorCode}]'
                          : tr(state.message),
                      style: style13.copyWith(color: Colors.red[600]),
                    ),
                    margin: EdgeInsets.only(top: paddingM),
                  ));
            }
          }
          return Container();
        });
  }

  /* 
  nút nhấn gửi lại SMS
  */
  FlatButton guiLaiMaSmsButton() {
    return this._start == 0
        ? FlatButton(
            onPressed: () {
              this.startTimer();
              widget.bloc.add(SendSMSAgain(number: widget.number));
            },
            child: Container(
              alignment: Alignment.center,
              // padding: EdgeInsets.fromLTRB(0, paddingL, 0, paddingL),
              child: Text(
                tr('otp_4'),
                style: style15.copyWith(color: colorBlue),
                textAlign: TextAlign.center,
              ),
            ))
        : FlatButton(
            onPressed: () {},
            child: Opacity(
              opacity: 0.5,
              child: Container(
                // padding: EdgeInsets.fromLTRB(0, paddingL, 0, paddingL),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.only(left: 50),
                            alignment: Alignment.center,
                            child: Text(
                              tr('otp_4'),
                              style: style15.copyWith(color: colorBlue),
                              textAlign: TextAlign.center,
                            ))),
                    Container(
                        width: 40,
                        alignment: Alignment.centerRight,
                        child: Text(
                          '(${this._start})',
                          style: style15.copyWith(color: colorBlue),
                          textAlign: TextAlign.right,
                        ))
                  ],
                ),
              ),
            ),
          );
  }
}
