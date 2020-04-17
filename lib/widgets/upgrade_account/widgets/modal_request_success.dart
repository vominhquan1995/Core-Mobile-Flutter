import 'package:Midas/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Midas/core/translate/public.dart';
class ModalRequestSuccess extends StatelessWidget {
  const ModalRequestSuccess({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 5 / 3,
                  child: Image.asset(
                    'assets/images/success.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      paddingL, paddingXS, paddingL, paddingL),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        tr('upgrade_salon_14'),
                        textAlign: TextAlign.center,
                        style: style20_semibold.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: paddingM),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: tr('upgrade_salon_15'),
                          style: style15,
                        ),
                      ),
                      SizedBox(height: paddingXS),
                      OutlineButton(
                          child: new Center(
                            child: Text(
                              tr('upgrade_salon_17'),
                              style: style17_semibold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          borderSide: BorderSide(color: colorPurple, width: 2),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5))),
                      SizedBox(height: paddingL),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
