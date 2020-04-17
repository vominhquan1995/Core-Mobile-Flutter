import 'package:Core/core/cart/cart_badge.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/detail_product/detail_product.dart';
import 'package:Core/widgets/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBoxStatic extends StatefulWidget {
  SearchBoxStatic({Key key, @required this.value, @required this.isPageResult})
      : super(key: key);
  String value;
  bool isPageResult;
  @override
  _SearchBoxStaticState createState() => _SearchBoxStaticState();
}

class _SearchBoxStaticState extends State<SearchBoxStatic> {
  @override
  void initState() {
    super.initState();
  }

  void onClickSearch() {
    if (widget.isPageResult) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SearchPage(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.width * 0.18,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/bg_header.jpg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        // BoxDecoration(
        //     color: Colors.purple,
        //     border: Border.all(
        //       width: 1,
        //       color: Colors.black12,
        //     )),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: InkWell(
                    highlightColor: colorGrey_1,
                    child: Container(
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    })),
            Expanded(
                flex: 6,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  child: InkWell(
                    splashColor: colorGrey_3,
                    onTap: onClickSearch,
                    child: Container(
                        // margin: EdgeInsets.symmetric(horizontal: paddingXS),
                        height: 35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: paddingM),
                                child: Text(
                                  widget.value,
                                  style: style13_semibold,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ],
                        )),
                  ),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingL),
              child: CartBadge(color: colorWhite),
            )
          ],
        ));
  }
}
