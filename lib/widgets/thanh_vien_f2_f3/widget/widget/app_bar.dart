import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/theme.dart';
import 'package:flutter/material.dart';

class AppBarThanhVien extends StatefulWidget with PreferredSizeWidget{
  final String f2;
  final String f3;

   AppBarThanhVien({Key key, this.f2, this.f3}) : super(key: key);

  @override
  _AppBarThanhVienState createState() => _AppBarThanhVienState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(130);
}

class _AppBarThanhVienState extends State<AppBarThanhVien> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Image(
        image: AssetImage('assets/images/background_appbar.jpg'),
        fit: BoxFit.cover,
        alignment: AlignmentDirectional.center,
      ),
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      // backgroundColor: Colors.purple,
      elevation: 0.0,
      title: Text(
        tr('member_1'),
        // 'MIDAS Memberrships',
        style: style15_semibold.copyWith(color: colorWhite),
      ),
      // centerTitle: true,
      // floating: true,
      bottom: PreferredSize(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingL),
          child: Container(
            margin: EdgeInsets.only(bottom: paddingL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: RichText(
                    text: TextSpan(
                        text: widget.f2 + ' ',
                        style: style34_black.copyWith(
                            height: lineHeight3, color: colorWhite),
                        children: [
                          TextSpan(
                              text: 'F2',
                              style: style13.copyWith(
                                color: colorWhite,
                              )),
                        ]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(paddingL),
                  child: Text('-',
                      style: style13.copyWith(
                        color: colorWhite,
                      )),
                ),
                Container(
                  child: RichText(
                    text: TextSpan(
                        text: widget.f3 + ' ',
                        style: style34_black.copyWith(
                            height: lineHeight3,
                            color: colorWhite.withOpacity(0.65)),
                        children: [
                          TextSpan(
                              text: 'F3',
                              style: style13.copyWith(
                                color: colorWhite,
                              )),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(75),
      ),
    );
  }
}

class AppBarThanhVien2 extends StatefulWidget {
  @override
  _AppBarThanhVien2State createState() => _AppBarThanhVien2State();
}

class _AppBarThanhVien2State extends State<AppBarThanhVien2> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      flexibleSpace: Image(
        image: AssetImage('assets/images/background_appbar.jpg'),
        fit: BoxFit.cover,
        alignment: AlignmentDirectional.center,
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      elevation: 0.0,
      title: Text(
        tr('member_1'),
        style: style15.copyWith(color: colorWhite),
      ),
      // centerTitle: true,
    );
  }
}
