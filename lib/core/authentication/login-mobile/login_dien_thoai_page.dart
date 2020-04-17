import 'package:Midas/core/authentication/login-mobile/index.dart';
import 'package:Midas/core/authentication/phone_auth/index.dart';
import 'package:Midas/core/config_json/bloc/configjson_bloc.dart';
import 'package:Midas/core/config_json/models/config_json.dart';
import 'package:Midas/core/data-status/data-status_widget.dart';
import 'package:flutter/material.dart';
import 'package:Midas/core/connection-status/index.dart';
import 'package:Midas/core/function/snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/index.dart';
import 'bloc/bloc_form_dien_thoai/bloc_quoc_gia_bloc.dart';
import 'bloc/bloc_form_dien_thoai/index.dart';

class LoginDienThoai extends StatefulWidget {
  @override
  _LoginDienThoaiState createState() => _LoginDienThoaiState();
}

class _LoginDienThoaiState extends State<LoginDienThoai> {
  /* 
  event text nhập số điện thoại
   */
  TextEditingController phoneTextController;
  FocusNode _focusPhoneText;

  /* 
  firebase chứng thực
   */
  PhoneAuth _phoneAuth;

  FormDienThoaiBloc _blocFormDienThoai;
  dynamic activeCountry;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);

    this._phoneAuth = new PhoneAuth();
    _blocFormDienThoai = FormDienThoaiBloc(service: _phoneAuth);
    this.phoneTextController = new TextEditingController(text: '');
    this._focusPhoneText = new FocusNode();
    this.getQuocGia();
  }

  /// Thay đổi trạng thái mạng
  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      showSnackBarUpdateDataKey(_scaffoldKey);
    }
    if (!hasConnection) {}
  }

  getQuocGia() async {
    if (this.activeCountry != null) {
      this._blocFormDienThoai.add(SendNumber(
          number: '',
          codeLang: this.activeCountry.code,
          iconLang: this.activeCountry.icon,
          is_call_api: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double scaleValue = 0.5;
    final Matrix4 transform = Matrix4.identity()
      ..scale(scaleValue, scaleValue, 1.0);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black54),
        ),
        backgroundColor: colorWhite,
        body: SingleChildScrollView(
            child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // hình nền
                      Container(
                        child: Transform(
                          alignment: Alignment.center,
                          transform: transform,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        alignment: Alignment.center,
                      ),
                      // end hình nền

                      // form
                      Container(
                          padding: EdgeInsets.only(
                              left: paddingL, right: paddingL, top: paddingL),
                          child: BlocBuilder<ConfigjsonBloc, ConfigJson>(
                            builder: (BuildContext context, ConfigJson state) {
                              if (state is ConfigJson &&
                                  state.dataLoginOptions != null) {
                                return FormNhapSoDienThoai(
                                  activeCountry: state.dataLoginOptions != null
                                      ? state.dataLoginOptions[0]
                                      : null,
                                  quocGias: state?.dataLoginOptions,
                                  dienThoaiBloc: _blocFormDienThoai,
                                  focusPhoneText: _focusPhoneText,
                                  phoneTextController: phoneTextController,
                                  sendSms: (number, code) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BlocProvider.value(
                                                value: _blocFormDienThoai,
                                                child: LoginSms(
                                                    number: number,
                                                    phoneAuth: _phoneAuth,
                                                    numberApi: number),
                                              )),
                                    );
                                  },
                                );
                              }

                              if (state is ConfigJson &&
                                  state.dataLoginOptions == null) {
                                return DataStatusWidget(
                                    style: DataStatus.update_data);
                              }

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3),
                                  Center(child: CircularProgressIndicator()),
                                ],
                              );
                            },
                          ))

                      // end form
                    ]))));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _blocFormDienThoai.close();
  }
}
