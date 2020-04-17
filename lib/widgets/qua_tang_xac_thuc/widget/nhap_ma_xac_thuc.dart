import 'package:Midas/core/config_json/bloc/configjson_bloc.dart';
import 'package:Midas/core/config_json/models/config_json.dart';
import 'package:Midas/core/custom_translate/easy_localization_delegate.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/theme.dart';
import 'package:Midas/widgets/qua_tang_xac_thuc/bloc/qua_tang_xac_thuc_bloc.dart';
import 'package:Midas/widgets/qua_tang_xac_thuc/bloc/qua_tang_xac_thuc_event.dart';
import 'package:Midas/widgets/qua_tang_xac_thuc/bloc/qua_tang_xac_thuc_state.dart';
import 'package:Midas/widgets/shared/text_html/text_html.dart';
import 'package:Midas/widgets/upgrade_account/widgets/qr_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class NhapMaXacThuc extends StatefulWidget {
  final QuaTangXacThucBloc bloc;
  final TextEditingController maXacThucTextController;
  final FocusNode focusMaXacThucText;
  const NhapMaXacThuc(
      {Key key,
      this.bloc,
      this.maXacThucTextController,
      this.focusMaXacThucText})
      : super(key: key);

  @override
  _NhapMaXacThucState createState() => _NhapMaXacThucState();
}

class _NhapMaXacThucState extends State<NhapMaXacThuc> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(paddingL, 0, paddingL, paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: paddingXXS),
            child: Image(image: AssetImage('assets/gift.png')),
            alignment: Alignment.center,
          ),
          Container(
            padding: EdgeInsets.only(top: paddingL, bottom: paddingXXS),
            child: Center(
              child: Text(
                tr('gift_1'),
                style: style20.copyWith(
                    color: colorBlue, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          BlocBuilder<ConfigjsonBloc, ConfigJson>(
              builder: (BuildContext context, ConfigJson state) {
            return Container(
              child: DefaultTextStyle(
                  style: style15,
                  child: HtmlText(
                      data: tr('gift_2', args: [state?.dataQT?.text]))),
            );
          }),
          formNhapMaPin(context),
          Container(
            padding: EdgeInsets.only(top: paddingL, bottom: paddingL),
            alignment: Alignment.topLeft,
            child: new Text(
              tr('gift_5'),
              style: style13.copyWith(color: colorGrey_4),
            ),
          ),
          textBaoLoi(),
          Container(
            child: Row(
              children: <Widget>[
                quaylai(context),
                SizedBox(
                  width: 10,
                ),
                buildButtonXacThuc()
              ],
            ),
          )
        ],
      ),
    );
  }

/* 
form nhập mã pin
 */
  Widget formNhapMaPin(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: paddingL),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: TextField(
                  onChanged: (value) {
                    widget.bloc.add(InputMaPin(maPin: value));
                  },
                  focusNode: widget.focusMaXacThucText,
                  controller: widget.maXacThucTextController,
                  style: style15.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: tr('gift_3'),
                      focusedBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: borderSide,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: borderSide)),
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QrScan(
                                onScanSuccess: (qrcode) {
                                  widget.maXacThucTextController.text = qrcode;
                                  widget.bloc.add(InputMaPin(maPin: qrcode));
                                },
                              )));
                },
                child: Container(
                    padding: EdgeInsets.only(left: paddingS),
                    child: SvgPicture.asset('assets/icon/qr.svg')))
          ],
        ));
  }

/* 
nút quay lại
 */
  Widget quaylai(BuildContext context) {
    return Expanded(
        flex: 3,
        child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Opacity(
                opacity: 0.6,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: colorGrey_1,
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      vertical: paddingL, horizontal: paddingL),
                  child: Text(
                    tr('gift_6'),
                    style: style17.copyWith(color: colorBlack),
                    textAlign: TextAlign.center,
                  ),
                ))));
  }

/* 
thông báo lỗi
 */
  Widget textBaoLoi() {
    return Container(
      padding: EdgeInsets.only(bottom: paddingXS),
      child: BlocBuilder(
          bloc: widget.bloc,
          builder: (BuildContext context, QuaTangXacThucState state) {
            if (state is WaitingForm) {
              return Container();
            }
            if (state is FormXacThucState && state.error != null) {
              return new Text(
                tr(state.error),
                style: style15.copyWith(
                  color: Colors.red,
                ),
                textAlign: TextAlign.left,
              );
            }
            return Container();
          }),
    );
  }

/* 
btn xác th
 */
  Widget buildButtonXacThuc() {
    return Expanded(
        flex: 3,
        child: BlocBuilder(
            bloc: widget.bloc,
            builder: (BuildContext context, QuaTangXacThucState state) {
              if (state is FormXacThucState) {
                return Opacity(
                  opacity: state.maPin == null || state.maPin.trim().length == 0
                      ? 0.5
                      : 1,
                  child: InkWell(
                    onTap: state.maPin == null || state.maPin.trim().length == 0
                        ? null
                        : () {
                            widget.bloc.add(SubmitXacThuc());
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: colorViolet,
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          vertical: paddingL, horizontal: paddingS),
                      child: Text(
                        tr('gift_7'),
                        style: style15.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }
              return Opacity(
                opacity: 0.5,
                child: InkWell(
                  onTap: null,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: colorViolet,
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        vertical: paddingL, horizontal: paddingS),
                    child: Text(
                      tr('gift_7'),
                      style: style15.copyWith(
                          color: colorWhite, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }));
  }

}
