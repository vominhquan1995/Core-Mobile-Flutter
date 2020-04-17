import 'package:flutter/material.dart';

class NoConnection extends AnimatedWidget {
  NoConnection(
      {Key key, @required this.connected, AnimationController controller})
      : super(key: key, listenable: controller);
  final bool connected;
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: CircleAvatar(
          backgroundColor:
              connected ? Colors.blue : Colors.grey.withOpacity(.5),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            child: connected
                ? Icon(Icons.wifi, size: 26, color: Colors.white)
                : Icon(Icons.signal_wifi_off, size: 26, color: Colors.white),
          )),
      opacity: listenable,
    );
  }
}
