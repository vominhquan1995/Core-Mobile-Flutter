import 'dart:async';

import 'package:Core/core/authentication/login-mobile/bloc/bloc_form_dien_thoai/bloc_quoc_gia_bloc.dart';
import 'package:Core/core/authentication/login-mobile/bloc/bloc_form_dien_thoai/index.dart';
import 'package:Core/core/authentication/login-mobile/index.dart';
import 'package:Core/core/config_json/models/config_json.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/shared/buttonMidas/button_midas.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/theme.dart';

typedef void SendSms(String number, String codeContry);

class FormNhapSoDienThoai extends StatefulWidget {
  final QuocGiaBloc quocGiaBloc;
  final TextEditingController phoneTextController;
  final FocusNode focusPhoneText;
  final FormDienThoaiBloc dienThoaiBloc;
  final DataQuocGiaLogin activeCountry;
  final List<DataQuocGiaLogin> quocGias;
  /* 
  thành công qua bước sms
   */
  final SendSms sendSms;
  FormNhapSoDienThoai(
      {this.phoneTextController,
      this.focusPhoneText,
      this.sendSms,
      this.dienThoaiBloc,
      this.quocGiaBloc,
      this.activeCountry,
      this.quocGias});

  @override
  _FormNhapSoDienThoaiState createState() => _FormNhapSoDienThoaiState();
}

class _FormNhapSoDienThoaiState extends State<FormNhapSoDienThoai> {
  dynamic _activeCountry;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.activeCountry != null) {
      widget.dienThoaiBloc.add(SendNumber(
          number: '',
          codeLang: widget.activeCountry.code,
          iconLang: widget.activeCountry.icon,
          is_call_api: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: widget.dienThoaiBloc,
        listener: (BuildContext context, FormDienThoaiState state) {
          if (state is NavigatorSmsCodeState) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              widget.sendSms(state.number, this._activeCountry['code']);
            });
            widget.dienThoaiBloc.add(WaitingFormDienThoai(loading: true));

            Future.delayed(Duration(milliseconds: 600)).then((onValue) {
              widget.dienThoaiBloc.add(SendNumber(
                  number: widget.phoneTextController.text ?? '',
                  codeLang: this._activeCountry['code'],
                  iconLang: this._activeCountry['icon'],
                  is_call_api: false));
            });
          }
          return;
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // giới thiệu
                Center(
                  child: Text(
                    tr('login_1'),
                    style: style20_semibold.copyWith(color: colorViolet),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(
                    paddingL,
                    paddingL,
                    paddingL,
                    paddingXXS,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: style15.copyWith(color: colorGrey_3),
                      children: <TextSpan>[
                        TextSpan(text: tr('login_2')),
                      ],
                    ),
                  ),
                ),
                // end giới thiệu

                // form
                BlocBuilder(
                    bloc: widget.dienThoaiBloc,
                    builder: (BuildContext context, FormDienThoaiState state) {
                      if ((state is WaitingFormState &&
                              state.loading == true) ||
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
                      } else {
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                height: 50,
                                child: Row(
                                  children: <Widget>[
                                    quocGiaSelect(),
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            focusNode: widget.focusPhoneText,
                                            controller:
                                                widget.phoneTextController,
                                            style: style15.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(10.0),
                                                hintText: tr('login_13'),
                                                focusedBorder:
                                                    new OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(0)),
                                                  borderSide: borderSide,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    0)),
                                                        borderSide:
                                                            borderSide)),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              widgetThongBaoLoi(),
                              SizedBox(height: paddingXS),
                              buttonTiepTuc()
                            ],
                          ),
                        );
                      }
                    }),
                // end form
              ],
            ),
          ),
        ));
  }

  /* 
  dropdown chọn quốc gia
  */
  quocGiaSelect() {
    return BlocBuilder(
        bloc: widget.dienThoaiBloc,
        builder: (BuildContext context, FormDienThoaiState state) {
          if (state is SendNumberState) {
            return FlatButton(
                onPressed: () => showChonQuocGia(widget.quocGias),
                padding: EdgeInsets.all(0),
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: paddingM),
                    height: MediaQuery.of(context).size.height - paddingXS,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: borderSide.width,
                            style: borderSide.style,
                            color: borderSide.color)),
                    width: 95,
                    child: Row(children: <Widget>[
                      CachedNetworkImage(
                        width: 40,
                        imageUrl: state.iconLang,
                        placeholder: (context, url) => new Container(
                          color: colorBlue,
                        ),
                        errorWidget: (context, url, error) => new Container(
                          color: colorBlue,
                        ),
                      ),
                      Expanded(
                          child: new Padding(
                              padding: EdgeInsets.only(left: paddingS),
                              child: new Text(
                                state.codeLang,
                                style: style13.copyWith(
                                    fontWeight: FontWeight.normal),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              )))
                    ])));
          }
          return Container(
            width: 85,
            height: 40,
            color: Colors.blue,
          );
        });
  }

/* 
button tiếp tục
 */
  buttonTiepTuc() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingXXS),
      child: ButtonMidas(
        onPressed: () {
          if (this._activeCountry == null) {
            this._activeCountry = {
              'code': widget.activeCountry.code,
              'icon': widget.activeCountry.icon
            };
          }
          widget.dienThoaiBloc.add(WaitingFormDienThoai(loading: true));
          widget.dienThoaiBloc.add(SendNumber(
              codeLang: this._activeCountry['code'],
              iconLang: this._activeCountry['icon'],
              number: widget.phoneTextController.text,
              is_call_api: true));
        },
        child: Text(
          tr('login_3'),
          style:
              style17.copyWith(color: colorWhite, fontWeight: FontWeight.bold),
        ),
      ),
    );

    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 60),
    //   child: RaisedButton(
    //     color: colorViolet,
    //     padding: EdgeInsets.symmetric(vertical: paddingL),
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    //     onPressed: () {
    //       if (this._activeCountry == null) {
    //         this._activeCountry = {
    //           'code': widget.activeCountry.code,
    //           'icon': widget.activeCountry.icon
    //         };
    //       }
    //       widget.dienThoaiBloc.add(WaitingFormDienThoai(loading: true));
    //       widget.dienThoaiBloc.add(SendNumber(
    //           codeLang: this._activeCountry['code'],
    //           iconLang: this._activeCountry['icon'],
    //           number: widget.phoneTextController.text,
    //           is_call_api: true));
    //     },
    //     child: Text(
    //       tr('login_3'),
    //       style:
    //           style17.copyWith(color: colorWhite, fontWeight: FontWeight.bold),
    //     ),
    //   ),
    // );

    // return FlatButton(
    //   padding: EdgeInsets.symmetric(horizontal: 60),
    //   onPressed: () {
    //     if (this._activeCountry == null) {
    //       this._activeCountry = {
    //         'code': widget.activeCountry.code,
    //         'icon': widget.activeCountry.icon
    //       };
    //     }
    //     widget.dienThoaiBloc.add(WaitingFormDienThoai(loading: true));
    //     widget.dienThoaiBloc.add(SendNumber(
    //         codeLang: this._activeCountry['code'],
    //         iconLang: this._activeCountry['icon'],
    //         number: widget.phoneTextController.text,
    //         is_call_api: true));
    //   },
    //   child: Container(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.all(Radius.circular(5)),
    //       color: colorViolet,
    //     ),
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.symmetric(vertical: paddingL),
    //     child: Text(
    //       tr('login_3'),
    //       style:
    //           style17.copyWith(color: colorWhite, fontWeight: FontWeight.bold),
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    // );
  }

  /* 
  text thông báo lỗi
   */
  BlocBuilder<FormDienThoaiBloc, FormDienThoaiState> widgetThongBaoLoi() {
    return BlocBuilder(
        bloc: widget.dienThoaiBloc,
        builder: (BuildContext context, FormDienThoaiState state) {
          if (state is SendNumberState) {
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
                      tr(state.message),
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
  show danh sách + chọn quốc gia
   */
  void showChonQuocGia(List<DataQuocGiaLogin> data) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: data.map((x) {
              return SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, {'code': x.code, 'icon': x.icon});
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(right: paddingM),
                          child: CachedNetworkImage(
                            width: 40,
                            imageUrl: x.icon,
                            placeholder: (context, url) => new Container(
                              color: colorBlue,
                            ),
                            errorWidget: (context, url, error) => new Container(
                              color: colorBlue,
                            ),
                          )),
                      Container(
                        child: Text(
                          x.tenQuocGia,
                          style: style13,
                        ),
                      )
                    ],
                  ));
            }).toList(),
          );
        }).then((onValue) {
      if (onValue != null) {
        this._activeCountry = {
          'code': onValue['code'],
          'icon': onValue['icon']
        };
        widget.dienThoaiBloc.add(SendNumber(
            number: widget.phoneTextController.text ?? '',
            codeLang: onValue['code'],
            iconLang: onValue['icon'],
            is_call_api: false));
      }
    });
  }
}
