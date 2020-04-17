import 'package:Midas/core/translate/public.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/upgrade_account/model/request_upgrade_model.dart';
import 'package:Midas/widgets/upgrade_account/widgets/qr_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        hintText: tr('upgrade_salon_38'),
        hintStyle: style15_lightgrey,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: borderSide.color, width: 1.0),
        ),
      ),
    );
  }
}

class TextFiledCustom extends StatelessWidget {
  final TextEditingController txtCtr;
  final FocusNode focus;
  final Function onSubmit;
  TextFiledCustom(
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
        contentPadding: EdgeInsets.symmetric(horizontal: paddingM),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: borderSide.color, width: 1.0),
        ),
      ),
    );
  }
}

class TextFiledView extends StatelessWidget {
  final String text;
  bool isBorderUnder;
  TextFiledView({Key key, this.text, this.isBorderUnder = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      initialValue: text,
      style: style17_semibold,
      maxLines: 1,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 0, horizontal: paddingM),
          border: isBorderUnder
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: borderSide.color, width: 1.0))
              : OutlineInputBorder(
                  borderSide: BorderSide(color: borderSide.color, width: 1.0),
                  borderRadius: BorderRadius.circular(0.0))),
    );
  }
}

class RowForm extends StatelessWidget {
  bool isView;
  final String title;
  final Widget child;
  RowForm(
      {Key key,
      @required this.title,
      @required this.child,
      this.isView = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TitleFormCustom(title: title, isView: isView),
          SizedBox(height: paddingS),
          child
        ],
      ),
    );
  }
}

class TitleFormCustom extends StatelessWidget {
  final String title;
  bool isView;
  TitleFormCustom({
    this.isView = false,
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: title, style: style15),
          !isView
              ? TextSpan(
                  text: ' (*)', style: style15.copyWith(color: Colors.red))
              : TextSpan(),
        ],
      ),
    );
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

class FormCustomQrScan extends StatelessWidget {
  final Function onSubmit;
  FormCustomQrScan({
    Key key,
    this.onSubmit,
    @required this.txtCode,
  }) : super(key: key);

  final TextEditingController txtCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            flex: 8,
            child: TextFormField(
              onFieldSubmitted: onSubmit,
              controller: txtCode,
              validator: (value) {
                if (value.isEmpty) {
                  return tr('upgrade_salon_4');
                }
                return null;
              },
              style: style17_semibold,
              maxLines: 1,
              decoration: InputDecoration(
                  hintStyle: style15.copyWith(color: colorGrey_3),
                  hintText: tr('upgrade_salon_5'),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: paddingS),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: borderSide.color, width: 1.0),
                      borderRadius: BorderRadius.circular(0.0))),
            )),
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QrScan(
                                onScanSuccess: (value) {
                                  txtCode.text = value;
                                },
                              )));
                },
                child: Container(
                    height: 50, child: SvgPicture.asset('assets/icon/qr.svg'))),
          ),
        ),
      ],
    );
  }
}

class HeaderStatusRequest extends StatelessWidget {
  const HeaderStatusRequest({
    Key key,
    @required this.data,
  }) : super(key: key);
  final RequestUpgrade data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buidlItem(data),
      ),
    );
  }

  _buidlItem(RequestUpgrade data) {
    List<Widget> items = [];
    items.add(Text(
      '${tr('upgrade_salon_18')} ${data.timeCreate}',
      style: style15,
    ));
    items.add(SizedBox(height: paddingM));
    items.add(
      RichText(
        text: TextSpan(
          text: tr('upgrade_salon_19'),
          style: style15,
          children: [
            TextSpan(
              style: style15_semibold.copyWith(
                color: data.dataStatus.type == STATUS_REQUEST.TU_CHOI
                    ? colorBlack
                    : data.dataStatus.color,
                decoration: data.dataStatus.type == STATUS_REQUEST.TU_CHOI
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
              text: data.dataStatus.name,
            ),
          ],
        ),
      ),
    );
    if (data.dataStatus.type == STATUS_REQUEST.TU_CHOI) {
      items.add(SizedBox(height: paddingM));
      items.add(
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                style: style15.copyWith(decoration: TextDecoration.underline),
                text: tr('upgrade_salon_39').toLowerCase(),
              ),
              TextSpan(
                style: style15,
                text: data.lyDo,
              ),
            ],
          ),
        ),
      );
    }
    return items;
  }
}
