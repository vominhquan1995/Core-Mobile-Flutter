import 'package:Midas/utils/index.dart';
import 'package:flutter/material.dart';

class AppBarCustomSimple extends StatelessWidget with PreferredSizeWidget {
  final String title;
  AppBarCustomSimple({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      flexibleSpace: Image(
        image: AssetImage('assets/images/background_appbar.jpg'),
        fit: BoxFit.cover,
        alignment: AlignmentDirectional.center,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        title,
        style: style15_semibold.copyWith(color: colorWhite),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
