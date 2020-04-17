import 'package:Midas/core/translate/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Midas/core/authentication/bloc/bloc.dart';
import 'package:Midas/core/data-status/index.dart';
import 'package:Midas/utils/theme.dart';

import 'bloc/bloc.dart';

class WidgetsCore extends StatefulWidget {
  final Widget widget;
  final PageCustomError delegate;
  WidgetsCore({Key key, this.widget, PageCustomError delegate})
      : delegate = delegate ?? DefaultCustomError(),
        super(key: key);

  @override
  _WidgetsCoreState createState() => _WidgetsCoreState();
}

class _WidgetsCoreState extends State<WidgetsCore> {
  ErrorhandleBloc bloc = ErrorhandleBloc();

  Widget widgetKhongCoQuyen(ErrorhandleState state) {
    if (state is KhongCoToken) {
      return widget.delegate.customPhienLamViecHetHan() ??
          widget.delegate.widgetHetHanDefault(logout);
    }

    if (state is KhongCoQuyen) {
      return widget.delegate.customKhongCoQuyen() ??
          widget.delegate.widgetNotPermission;
    }

    return Container();
  }

  logout() {
    final authenBloc = BlocProvider.of<AuthenticationBloc>(context);
    Navigator.of(context).pop();

    if (authenBloc.state is AuthenticationAuthenticated) {
      authenBloc?.add(LoggedOut());
    }
  }

  Widget page(ErrorhandleState state) {
    if (state is KhongCoToken) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: widgetKhongCoQuyen(state),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.delegate.buildsAppBar(context) ??
          widget.delegate.appBarDefault,
      body: widgetKhongCoQuyen(state),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener(
        bloc: bloc,
        listener: (BuildContext context, ErrorhandleState state) {
          if (state is KhongCoToken) {
            _showMaterialDialog();
          }
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, ErrorhandleState state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: (state is InitialErrorhandleState || state is KhongCoToken)
                  ? widget.widget
                  : page(state),
            );
          },
        ),
      ),
    );
  }

  void _showMaterialDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(tr('core_1')),
            content: Text(tr('core_2')),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  logout();
                },
                child: Text(
                  tr('core_3'),
                  style: style15.copyWith(color: colorBlue),
                ),
              )
            ],
          );
        });
  }
}

class DefaultCustomError extends PageCustomError {
  @override
  Widget customKhongCoQuyen() {
    // TODO: implement customKhongCoQuyen
    return widgetNotPermission;
  }

  @override
  Widget customPhienLamViecHetHan() {
    // TODO: implement customPhienLamViecHetHan
    return null;
  }

  @override
  PreferredSizeWidget buildsAppBar(BuildContext context) {
    // TODO: implement buildsAppBar
    return null;
  }

  @override
  Widget buildsBody(BuildContext context) {
    // TODO: implement buildsBody
    return null;
  }
}

abstract class PageCustomError {
  Widget widgetHetHanDefault(fn) => HetHanDefault(onPress: fn);

  Widget get widgetNotPermission =>
      DataStatusWidget(style: DataStatus.not_permission);

  PreferredSizeWidget get appBarDefault => AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.blue),
      );

  /// Custom
  Widget customKhongCoQuyen();

  /// Custom
  Widget customPhienLamViecHetHan();

  /// AppBar
  PreferredSizeWidget buildsAppBar(BuildContext context);

  /// Body
  Widget buildsBody(BuildContext context);
}

class HetHanDefault extends StatelessWidget {
  final VoidCallback onPress;
  HetHanDefault({this.onPress});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Phiên làm việc hết hạn',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: paddingM),
          Text(
            'Vui lòng đăng nhập lại',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          SizedBox(height: paddingM),
          RaisedButton(
            color: Colors.blue,
            onPressed: onPress,
            child: Text(
              'Đăng nhập lại',
              style: style13.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
