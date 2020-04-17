import 'package:flutter/material.dart';

class ShowUp extends StatelessWidget {
  final Widget child;

  ShowUp({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      child: child,
      builder: (BuildContext context, Offset offset, Widget child) {
        return Opacity(
          opacity: 1 - (offset - Offset.zero).distance,
          child: FractionalTranslation(
            translation: offset,
            child: child,
          ),
        );
      },
      duration: Duration(milliseconds: 500),
      tween: Tween<Offset>(begin: Offset(0.0, 0.5), end: Offset.zero),
      curve: Curves.decelerate,
    );
  }
}
