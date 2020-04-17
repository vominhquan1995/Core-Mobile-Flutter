import 'package:flutter/material.dart';

class AppBarCustom extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  AppBarCustom({this.child, this.height = 75.0});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg_header.jpg'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: SafeArea(child: child),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;
}
