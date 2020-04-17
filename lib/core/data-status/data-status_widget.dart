import 'package:Midas/core/translate/public.dart';
import 'package:flutter/material.dart';
import 'package:Midas/utils/index.dart';

class IDataStatus {
  String text;
  dynamic color;
  String note;
  String image;
  num opacity;
  double width;
  IDataStatus(String text, dynamic color, image, note, opacity, width) {
    this.text = text;
    this.color = color;
    this.note = note;
    this.image = image;
    this.opacity = opacity;
    this.width = width;
  }
}

class DataStatus {
  static IDataStatus not_found_data = new IDataStatus('core_8',
      Colors.grey[500], 'assets/images/no_internet.png', null, null, 150.0);
  static IDataStatus update_data = new IDataStatus('core_9', Colors.blue[400],
      'assets/images/no_internet.png', null, null, 150.0);
  static IDataStatus server_error = new IDataStatus('core_10', Colors.red[400],
      'assets/images/no_internet.png', null, null, 150.0);
  static IDataStatus disconnect = new IDataStatus('core_11', Colors.black,
      'assets/images/no_internet.png', 'core_12', null, 150.0);
  static IDataStatus time_out = new IDataStatus('core_13', Colors.grey[500],
      'assets/time_out.gif', 'core_14', null, 220.0);
  static IDataStatus not_permission = new IDataStatus('core_15',
      Colors.grey[500], 'assets/not_permission.gif', null, null, 220.0);

  static IDataStatus not_data(String message) {
    return new IDataStatus('core_16', Colors.grey[500],
        'assets/not_found_data.gif', message, 0.7, 220.0);
  }
}

class DataStatusWidget extends StatelessWidget {
  /// design chữ
  final IDataStatus style;

  /// callback nhấn nút
  final VoidCallback onPress;

  /// text của nút
  final String textButton;

  const DataStatusWidget({Key key, this.style, this.onPress, this.textButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: paddingS),
            // color: Colors.blue,
            child: Opacity(
              opacity: style.opacity == null ? 1.0 : style.opacity,
              child: Image.asset(style.image, width: style.width),
            ),
            // padding: EdgeInsets.only(bottom: paddingL),
          ),
          Center(
              child: Padding(
            padding: EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                Container(
                  // color: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: paddingL),
                  child: Text(tr(this.style.text),
                      textAlign: TextAlign.center,
                      style: style15.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(22, 45, 61, 1))),
                ),
                this.style.note != null
                    ? Container(
                        padding: EdgeInsets.only(
                            top: paddingM, right: paddingL, left: paddingL),
                        child: Text(
                          tr(this.style.note),
                          textAlign: TextAlign.center,
                          style: style13.copyWith(
                              color: Color.fromRGBO(122, 146, 165, 1)),
                        ),
                      )
                    : Container()
              ],
            ),
          )),
          this.onPress != null
              ? Container(
                  padding: EdgeInsets.all(0),
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: onPress,
                    child: Text(
                      textButton ?? tr('core_7'),
                      style: style15.copyWith(
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(59, 154, 236, 1)),
                    ),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
