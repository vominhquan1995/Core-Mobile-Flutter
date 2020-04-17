import 'package:Core/core/authentication/login-mobile/index.dart';
import 'package:flutter/material.dart';
import 'package:Core/core/authentication/phone_auth/index.dart';
import 'package:Core/core/connection-status/index.dart';
import 'package:Core/core/data-status/index.dart';
import 'package:Core/core/function/snackbar.dart';
import 'package:Core/utils/index.dart';

import 'bloc/bloc_form_sms/index.dart';

class LoginSms extends StatefulWidget {
  final PhoneAuth phoneAuth;
  final String number;
  final String numberApi;
  final WaitingFormDT waitingFormDT;

  const LoginSms(
      {Key key,
      this.phoneAuth,
      this.number,
      this.numberApi,
      this.waitingFormDT})
      : super(key: key);
  @override
  _LoginSmsState createState() => _LoginSmsState();
}

class _LoginSmsState extends State<LoginSms> {
  TextEditingController _smsTextController;
  FocusNode _focusSMSText;
  FormSMSBloc _bloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  /* 
  biến nghe kết nối internet
   */
  bool is_error_connection = false;

  @override
  void initState() {
    super.initState();

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);

    this._smsTextController = new TextEditingController(text: '');
    this._focusSMSText = new FocusNode();
    this._bloc = new FormSMSBloc(service: widget.phoneAuth);
  }

  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection) {
      this.setState(() {
        this.is_error_connection = false;
      });
      showSnackBarUpdateDataKey(_scaffoldKey);
    } else {
      this.setState(() {
        this.is_error_connection = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorWhite,
        body: SingleChildScrollView(
            child: !this.is_error_connection
                ? (Container(
                    padding: EdgeInsets.only(top: paddingXS),
                    alignment: Alignment.topLeft,
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // form
                          Container(
                            padding: EdgeInsets.only(
                                left: paddingL,
                                right: paddingL,
                                top: paddingXS),
                            child: FormNhapSms(
                              numberApi: widget.numberApi,
                              bloc: this._bloc,
                              focusSMSText: _focusSMSText,
                              smsTextController: _smsTextController,
                              login: (sms) {
                                // Navigator.pushAndRemoveUntil(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => HomeScreen()),
                                //   (Route<dynamic> route) => false,
                                // );
                              },
                              number: widget.number,
                            ),
                          ),
                          // end form
                        ])))
                : (Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height / 4),
                      Center(
                          child: DataStatusWidget(
                        style: DataStatus.disconnect,
                        onPress: null,
                      )),
                    ],
                  ))));
  }
}
