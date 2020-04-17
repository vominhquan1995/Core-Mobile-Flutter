import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Core/core/authentication/bloc/bloc.dart';
import 'package:Core/utils/index.dart';

import '../../bloc/index.dart';

class FormDangNhap extends StatefulWidget {
  final LoginBloc loginBloc;
  FocusNode focusNodeText1;
  FocusNode focusNodeText2;

  FormDangNhap(
      {Key key,
      @required this.loginBloc,
      this.focusNodeText1,
      this.focusNodeText2})
      : super(key: key);

  @override
  FormDangNhapState createState() {
    return FormDangNhapState();
  }
}

class FormDangNhapState extends State<FormDangNhap> {
  final _userNameController = TextEditingController(text: "0988989888");
  // TextEditingController();
  final _passwordController = TextEditingController(text: "123123");
  // TextEditingController();

  double _heigtInput = 40.0;
  bool eye = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.0),
      child: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('TÀI KHOẢN'),
            tenDangNhapField(),
            SizedBox(height: paddingL),
            Text('MẬT KHẨU'),
            passwordField(),
            SizedBox(height: 38.0),
            ButtonDangNhap(
              callback: _onLoginButtonPressed,
              loginBloc: widget.loginBloc,
            )
          ],
        ),
      ),
    );
  }

  void _onLoginButtonPressed() {
    widget.loginBloc.add(LoginButtonPressed(
        username: this._userNameController.text,
        password: this._passwordController.text));
  }

  Widget tenDangNhapField() {
    return Container(
        height: _heigtInput,
        child: TextField(
          focusNode: widget.focusNodeText1,
          controller: this._userNameController,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    borderSide.copyWith(width: 1.0, color: Colors.blueAccent),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: borderSide.copyWith(width: 1.0),
              ),
              hintStyle: TextStyle(color: Colors.grey[400]),
              // labelText: 'Tài khoản',
              hintText: 'Mã sinh viên hoặc CB GV-NV',
              hasFloatingPlaceholder: false),
        ));
  }

  Widget passwordField() {
    return Container(
        height: _heigtInput,
        child: TextField(
          focusNode: widget.focusNodeText2,
          controller: this._passwordController,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    borderSide.copyWith(width: 1.0, color: Colors.blueAccent),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: borderSide.copyWith(width: 1.0),
              ),
              suffixIcon: IconButton(
                onPressed: seepassword,
                icon: Icon(
                  Icons.remove_red_eye,
                ),
                color: eye ? Colors.blueAccent : Colors.grey[400],
              ),
              hintStyle: TextStyle(color: Colors.grey[400]),
              hintText: 'Mật khẩu',
              hasFloatingPlaceholder: false),
          obscureText: !eye,
        ));
  }

  void seepassword() {
    setState(() {
      eye = !eye;
    });
  }
}

class ButtonDangNhap extends StatelessWidget {
  final callback;
  final LoginBloc loginBloc;
  ButtonDangNhap({@required this.callback, @required this.loginBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      builder: (BuildContext context, AuthenticationState stateAuthen) {
        return BlocBuilder(
          bloc: loginBloc,
          builder: (BuildContext context, LoginState state) {
            return SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: callback,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    state is LoginLoading ||
                            (!(stateAuthen is AuthenticationAuthenticated) &&
                                state is LoginSucess)
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
                color: state is LoginLoading ||
                        (!(stateAuthen is AuthenticationAuthenticated) &&
                            state is LoginSucess)
                    ? Colors.blueAccent[100]
                    : Colors.blueAccent[400],
              ),
            );
          },
        );
      },
    );
  }
}

class ButtonQuenMatKhau extends StatelessWidget {
  final callback;

  ButtonQuenMatKhau({@required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: FlatButton(
            onPressed: callback,
            child: Text(
              'Quên mật khẩu?',
              style: TextStyle(color: Colors.grey),
            ),
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
