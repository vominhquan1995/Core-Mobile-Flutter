import 'package:Midas/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppBarBackSimple extends StatelessWidget with PreferredSizeWidget {
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      leading: new IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: colorGrey_4,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      backgroundColor: colorWhite,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
