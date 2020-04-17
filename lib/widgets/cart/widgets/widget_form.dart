import 'package:Midas/core/translate/public.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/upgrade_account/widgets/qr_scan.dart';
import 'package:flutter/material.dart';

class ButtonSelectAddress extends StatelessWidget {
  final Function onTap;
  const ButtonSelectAddress({
    Key key,
    @required this.onTap,
    @required this.ctr,
  }) : super(key: key);
  final TextEditingController ctr;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style17_semibold,
      onTap: onTap,
      readOnly: true,
      autofocus: false,
      controller: ctr,
      validator: (value) {
        if (value.isEmpty) {
          return tr('upgrade_salon_12');
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.arrow_drop_down, color: colorGrey_2),
        // hintText: tr('search_1'),
        hintText: 'Chọn địa chỉ',
        hintStyle: style15_lightgrey,
        border: InputBorder.none,
      ),
    );
  }
}

class TextFiledCustom extends StatelessWidget {
  final TextEditingController txtCtr;
  final FocusNode focus;
  final Function onSubmit;
  const TextFiledCustom(
      {Key key,
      @required this.txtCtr,
      @required this.focus,
      @required this.onSubmit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onSubmit,
      focusNode: focus,
      controller: txtCtr,
      validator: (value) {
        if (value.isEmpty) {
          return tr('upgrade_salon_12');
        }
        return null;
      },
      style: style17_semibold,
      maxLines: 1,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 0, horizontal: paddingM),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.0))),
    );
  }
}

class RowForm extends StatelessWidget {
  final String title;
  final Widget child;
  const RowForm({Key key, @required this.title, @required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TitleFormCustom(title: title),
          SizedBox(height: paddingM),
          child
        ]);
  }
}

class TitleFormCustom extends StatelessWidget {
  final String title;
  const TitleFormCustom({
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(text: title, style: style15),
      TextSpan(text: '(*)', style: style15.copyWith(color: Colors.red)),
    ]));
  }
}

class HeaderModalAddress extends StatelessWidget {
  final String title;
  final Function onClose;
  const HeaderModalAddress(
      {Key key, @required this.title, @required this.onClose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingL, vertical: paddingL),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(title,
                style: style17.copyWith(decoration: TextDecoration.none)),
          ),
          Expanded(
              flex: 1,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: onClose,
                    child: Icon(Icons.close) // the arrow back icon
                    ),
              ))
        ],
      ),
    );
  }
}
