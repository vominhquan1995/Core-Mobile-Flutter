import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Core/core/authentication/bloc/bloc.dart';
import 'package:Core/core/authentication/login/widgets/loginFailure/login_failure.dart';
import 'package:Core/core/bao-tri/bloc/bloc.dart';
import 'package:Core/widgets/shared/collapsible/collapsible.dart';
import 'package:Core/core/google_analytics/index.dart';
import '../authentication_service.dart';
import 'widgets/logo/index.dart';
import 'widgets/formDangNhap/index.dart';

import './bloc/index.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AuthenticationService _authenticationService = AuthenticationService();

  FocusNode _focusNodeText1 = new FocusNode();
  FocusNode _focusNodeText2 = new FocusNode();
  bool hasForcus = false;

  @override
  void initState() {
    super.initState();
    GoogleAnalytics.trackScreen(login_page);

    this._loginBloc =
        LoginBloc(authenticationService: this._authenticationService);

    _focusNodeText1.addListener(_focusNodeListener1);
    _focusNodeText2.addListener(_focusNodeListener2);
  }

  Future<Null> _focusNodeListener1() async {
    setState(() {
      hasForcus = _focusNodeText1.hasFocus;
    });
  }

  Future<Null> _focusNodeListener2() async {
    setState(() {
      hasForcus = _focusNodeText2.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginState state) {
        if (state is LoginSucess) {
          BlocProvider.of<AuthenticationBloc>(context).saveUser(state.user);
          BlocProvider.of<BaoTriBloc>(context).add(BaoTriStart());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state) {
          double _heightLogo = MediaQuery.of(context).size.height / 3;
          double _heightFormError = 60;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              key: this._scaffoldKey,
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height +
                      ((hasForcus && (state is LoginFailure)) ? 120 : 0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Logo(height: _heightLogo),
                      Collapsible(
                        isCollapsed: !(state is LoginFailure),
                        child: LoginFailureWidget(
                          message: (state is LoginFailure) ? state.error : "",
                          linkRedirect:
                              (state is LoginFailure) ? state.linkRedirect : "",
                          linkRedirectName: (state is LoginFailure)
                              ? state.linkRedirectName
                              : "",
                          height: _heightFormError,
                        ),
                      ),
                      FormDangNhap(
                        loginBloc: this._loginBloc,
                        focusNodeText1: _focusNodeText1,
                        focusNodeText2: _focusNodeText2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget background({Widget widget}) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/bg.png'),
        ),
      ),
      child: widget,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNodeText1.removeListener(_focusNodeListener1);
    _focusNodeText2.removeListener(_focusNodeListener2);
    this._loginBloc.close();
  }
}
