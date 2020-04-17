import 'dart:async';

import 'package:Midas/core/translate/public.dart';
import 'package:flutter/material.dart';
import 'package:Midas/core/connection-status/index.dart';

class ShowOverlay {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ShowOverlay _singleton = new ShowOverlay._internal();

  StreamSubscription streamSubscription;

  bool _isShowOverlay = false;

  ShowOverlay._internal() {
    initialize();
  }

  bool get isOverlay => _isShowOverlay;

  static ShowOverlay getInstance() => _singleton;

  void initialize() {
    streamSubscription?.cancel();
  }

  showOverlay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    streamSubscription?.cancel();
    _isShowOverlay = false;
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            width: MediaQuery.of(context).size.width,
            top: 16,
            child: ConnectionWidget()));

    overlayState.insert(overlayEntry);
    if (!ConnectionStatusSingleton.getInstance().hasConnection) {
      showMaterialDialog(context);
    }

    streamSubscription = ConnectionStatusSingleton.getInstance()
        .connectionChange
        .listen((onData) {
      if (onData) {
      } else {
        showMaterialDialog(context);
        _isShowOverlay = true;
      }
    });
  }

  void showMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(tr('core_4')),
            content: Text(tr('core_5')),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(tr('core_6')),
              )
            ],
          );
        });
  }
}
