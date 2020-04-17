import 'package:Core/core/translate/public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Core/core/connection-status/connectionStatusSingleton.dart';

void showSnackBarUpdateDataKey(GlobalKey<ScaffoldState> _scaffoldKey) {
  final snackBar = SnackBar(
    content: Text(tr('core_21')),
    duration: Duration(seconds: 2),
  );

  /// Find the Scaffold in the widget tree and use it to show a SnackBar.
  _scaffoldKey?.currentState?.removeCurrentSnackBar();
  _scaffoldKey?.currentState?.showSnackBar(snackBar);
}

void showSnackBarUpdatedDataKey(GlobalKey<ScaffoldState> _scaffoldKey) {
  final snackBar = SnackBar(
    content: ConnectionStatusSingleton.getInstance().hasConnection
        ? Text(tr('core_21'))
        : Text(tr('core_22')),
    duration: Duration(seconds: 2),
  );
  _scaffoldKey?.currentState?.removeCurrentSnackBar();
  _scaffoldKey?.currentState?.showSnackBar(snackBar);
}
