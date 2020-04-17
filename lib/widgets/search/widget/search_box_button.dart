import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBoxButton extends StatelessWidget {
  const SearchBoxButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      highlightColor: Colors.grey,
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(blurRadius)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: paddingL),
                    child: Icon(
                      Icons.search,
                      size: 25,
                      color: colorGrey_2,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(paddingM),
                      child: Text(
                        tr('home_2'),
                        style: style13_lightgrey,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
