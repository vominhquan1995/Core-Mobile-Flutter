import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/shared/buttonMidas/button_midas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonCustomDetail extends StatelessWidget {
  final bool bgImage;
  final String text;
  final Function() onClick;
  const ButtonCustomDetail(
      {Key key,
      @required this.text,
      @required this.onClick,
      this.bgImage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonMidas(
      onPressed: onClick,
      child: Text(
        text,
        style: style17_lightgrey.copyWith(color: colorWhite),
      ),
    );

    // return Container(
    //   decoration: bgImage
    //       ? BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage("assets/bg_header.jpg"),
    //             fit: BoxFit.cover,
    //           ),
    //         )
    //       : BoxDecoration(color: colorOrange),
    //   margin: EdgeInsets.symmetric(horizontal: paddingXS, vertical: paddingM),
    //   height: 50,
    //   child: FlatButton(
    //       onPressed: onClick,
    //       child: Text(
    //         text,
    //         style: style20_lightgrey.copyWith(color: colorWhite),
    //       )),
    // );
  }
}
