import 'package:Core/core/translate/public.dart';
import 'package:Core/utils/index.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: paddingM,
        horizontal: paddingM,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: borderSide.color),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.search, size: 24, color: colorGrey_2),
          SizedBox(width: paddingS),
          Expanded(
            child: Text(tr('home_2'),
                style: style13_lightgrey),
          )
        ],
      ),
    );
  }
}
