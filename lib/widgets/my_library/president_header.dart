import 'dart:math';

import 'package:Midas/utils/index.dart';
import 'package:flutter/material.dart';

class MyDynamicHeader extends SliverPersistentHeaderDelegate {
  Widget child;
  double height = 75;
  MyDynamicHeader({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Opacity(
            opacity: min(shrinkOffset / (height / 3), 1),
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: paddingS),
            child: SafeArea(child: child),
          )
        ],
      ),
    );
    // return SizedBox.expand(
    //   child: Stack(
    //     fit: StackFit.expand,
    //     alignment: Alignment.center,
    //     children: <Widget>[SafeArea(child: child)],
    //   ),
    // );

    // return Container(
    //   height: height,
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //       image: AssetImage('assets/images/background.jpg'),
    //       fit: BoxFit.cover,
    //       alignment: Alignment.topCenter,
    //     ),
    //   ),
    //   child: SafeArea(child: child),
    // );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;
}
