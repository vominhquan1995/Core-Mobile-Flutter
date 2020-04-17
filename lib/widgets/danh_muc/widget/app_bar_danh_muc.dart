import 'package:Core/core/cart/cart_badge.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/search/search.dart';
import 'package:Core/widgets/search/widget/search_box_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppbarDanhMuc extends StatefulWidget {
  AppbarDanhMuc({Key key, this.value, this.isPageResult}) : super(key: key);
  String value;
  bool isPageResult;
  @override
  _AppbarDanhMucState createState() => _AppbarDanhMucState();
}

class _AppbarDanhMucState extends State<AppbarDanhMuc> {
  @override
  void initState() {
    super.initState();
  }

  void onClickSearch() {
    if (widget.isPageResult) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchPage(),
        ),
      );
    } else {
      Navigator.of(context).pop(context);
    }
  }

  // onTap: onClickSearch,
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingL),
      child: Row(
        children: <Widget>[
          Expanded(child: SearchBoxButton()),
          CartBadge(
            color: colorWhite,
          )
        ],
      ),
    );
  }
}
