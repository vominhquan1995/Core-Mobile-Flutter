import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:flutter/material.dart';

class EmptyData extends StatefulWidget {
  final String title;
  final String noiDung;
  final bool isButton;
  final String textButtom;
  final Function onTap;
  final String image;

  const EmptyData(
      {Key key,
      this.title,
      this.noiDung,
      @required this.isButton,
      this.textButtom,
      @required this.onTap,
      this.image})
      : super(key: key);
  @override
  _EmptyDataState createState() => _EmptyDataState();
}

class _EmptyDataState extends State<EmptyData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(
            left: paddingL,
            right: paddingL,
            bottom: paddingXXS,
            top: paddingXXS),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                width: 250,
                child: Image.asset(
                  widget.image ?? 'assets/search-empty.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: paddingL),
              child: Text(
                widget.title ?? "",
                style: TextStyle(fontSize: 31, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: paddingXXS),
              child: Text(
                widget.noiDung ?? '',
                style: style15.copyWith(height: lineHeight4),
                textAlign: TextAlign.center,
              ),
            ),
            widget.isButton
                ? InkWell(
                    onTap: () {
                      widget.onTap();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(blurRadius)),
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/background_appbar.jpg'),
                              fit: BoxFit.cover)),
                      // margin: EdgeInsets.only(top: paddingXXS),
                      padding: EdgeInsets.only(
                          left: paddingXS,
                          right: paddingXS,
                          top: paddingL,
                          bottom: paddingL),
                      child: Text(
                        widget.textButtom ?? '',
                        style: style15_semibold.copyWith(color: Colors.white),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
