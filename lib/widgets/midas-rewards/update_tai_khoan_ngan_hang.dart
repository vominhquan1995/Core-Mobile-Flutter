import 'package:Midas/core/config_json/bloc/configjson_bloc.dart';
import 'package:Midas/core/config_json/models/config_json.dart';
import 'package:Midas/core/connection-status/index.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/core/page-core/bloc/bloc.dart';
import 'package:Midas/core/page-core/widget_custom.dart';
import 'package:Midas/utils/theme.dart';
import 'package:Midas/widgets/midas-rewards/model/thong_tin_diem_model.dart';
import 'package:Midas/widgets/midas-rewards/widget/widget/drop_down_search.dart';
import 'package:Midas/widgets/shared/text_html/text_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/midas_rewards_bloc.dart';
import 'service/thong_tin_diem_service.dart';

class UpdateNganHang extends StatefulWidget {
  final ThongTinDiemModel data;

  const UpdateNganHang({Key key, this.data}) : super(key: key);
  @override
  _UpdateNganHangState createState() => _UpdateNganHangState();
}

class _UpdateNganHangState extends State<UpdateNganHang> {
  MidasRewardsBloc bloc;
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _controllerTenNH;
  TextEditingController _controllerHoTen;
  TextEditingController _controllerTK;

  List<DropdownMenuItem> items = [];
  String selectedValue;
  bool isTap = false;

  @override
  void initState() {
    // TODO: implement initState

    bloc = MidasRewardsBloc(
        service:
            ThongTinDiemService(BlocProvider.of<ErrorhandleBloc>(context)));
    widget.data.tenNganHang != ''
        ? selectedValue = widget.data.tenNganHang
        : selectedValue = null;
    _controllerHoTen = new TextEditingController(
        text: widget.data.tenNguoiNhan.toUpperCase() ?? '');
    _controllerTK =
        new TextEditingController(text: widget.data.taiKhoanNganHang ?? '');

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
    super.initState();
  }

  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      // bloc.add(GetData());
    }
  }

  goToPage(page) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => WidgetsCore(widget: page)));
  }

  updateThongTin() {
    if (isTap) {
      return;
    }
    setState(() {
      isTap = true;
    });
    bloc.add(UpdateThongTin(
        tai_khoan_ngan_hang: _controllerTK.text,
        ten_nguoi_nhan: _controllerHoTen.text,
        ten_ngan_hang: selectedValue ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MidasRewardsBloc, MidasRewardsState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is DoneUpdateMidasRewards) {
            BlocProvider.of<MidasRewardsBloc>(context)
                .add(GetDataHMidasRewards());
            isTap = false;
            Navigator.pop(context);
          }
          if (state is ErrorUpdateMidasRewards) {
            isTap = false;
          }
          if (state is ValidateStateUpdateMidasRewards) {
            isTap = false;
          }
        },
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: colorGrey_1,
            appBar: appBar(),
            body: SafeArea(
              child: buildList(),
            )));
  }

  Widget buildList() {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            color: colorGrey_1,
            child: Column(
              children: <Widget>[
                thongTinNganHang(),
                Container(
                  color: colorGrey_1,
                  height: paddingL,
                ),
              ],
            ),
          ),
        ));
  }

  Widget appBar() {
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
        tr('banking_14'),
        // 'Tài khoản ngân hàng',
        style: style15_semibold.copyWith(color: colorWhite),
      ),
    );
  }

  Widget validate(String text) {
    return Container(
      child: Text(
        text,
        style: style13.copyWith(color: colorRed),
      ),
    );
  }

  Widget thongTinNganHang() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: paddingL),
            child: DefaultTextStyle(
              style: style15,
              softWrap: true,
              textAlign: TextAlign.center,
              child: HtmlText(
                data: tr('banking_1'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: paddingL),
            child: RichText(
              text: TextSpan(
                style: style15,
                children: [
                  TextSpan(text: tr('banking_2'), style: style13),
                  TextSpan(
                      text: ' (*)', style: style13.copyWith(color: colorRed)),
                ],
              ),
            ),
          ),
          BlocBuilder<ConfigjsonBloc, ConfigJson>(
            builder: (BuildContext _, state) {
              return SearchableDropdown(
                items: state.dataBank.map((item) {
                  return DropdownMenuItem<String>(
                      child: Text(item), value: item);
                }).toList(),
                isExpanded: true,
                value: selectedValue,
                style: style15_semibold,
                hint: Text(
                  tr('banking_6'),
                  style: style13_lightgrey,
                ),
                searchHint: Text(
                  tr('banking_7'),
                  style: TextStyle(fontSize: 20),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              );
            },
          ),
          BlocBuilder<MidasRewardsBloc, MidasRewardsState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is ValidateStateUpdateMidasRewards) {
                return state.e == '1'
                    ? Container(
                        child: Text(
                          tr('banking_10'),
                          style: style13.copyWith(color: colorRed),
                        ),
                      )
                    : Container();
              }
              return Container();
            },
          ),
          Container(
            margin: EdgeInsets.only(top: paddingL),
            child: RichText(
              text: TextSpan(
                style: style15,
                children: [
                  TextSpan(text: tr('banking_3'), style: style13),
                  TextSpan(
                      text: ' (*)', style: style13.copyWith(color: colorRed)),
                ],
              ),
            ),
          ),
          Container(
            child: TextField(
              // focusNode: focusMaXacThucText,
              controller: _controllerTK,
              style: style15_semibold,
              decoration: InputDecoration(
                hintText: tr('banking_8'),
                hintStyle: style13_lightgrey,
              ),
            ),
          ),
          BlocBuilder<MidasRewardsBloc, MidasRewardsState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is ValidateStateUpdateMidasRewards) {
                return state.e == '2'
                    ? Container(
                        margin: EdgeInsets.only(top: paddingM),
                        child: Text(
                          tr('banking_11'),
                          style: style13.copyWith(color: colorRed),
                        ),
                      )
                    : Container();
              }
              return Container();
            },
          ),
          Container(
            margin: EdgeInsets.only(top: paddingL),
            child: RichText(
              text: TextSpan(
                style: style15,
                children: [
                  TextSpan(text: tr('banking_4'), style: style13),
                  TextSpan(
                      text: ' (*)', style: style13.copyWith(color: colorRed)),
                ],
              ),
            ),
          ),
          Container(
            child: TextField(
              controller: _controllerHoTen,
              style: style15_semibold,
              decoration: InputDecoration(
                hintText: tr('banking_9'),
                hintStyle: style13_lightgrey,
              ),
            ),
          ),
          BlocBuilder<MidasRewardsBloc, MidasRewardsState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is ValidateStateUpdateMidasRewards) {
                return state.e == '3'
                    ? Container(
                        margin: EdgeInsets.only(top: paddingM),
                        child: Text(
                          tr('banking_12'),
                          style: style13.copyWith(color: colorRed),
                        ),
                      )
                    : Container();
              }
              return Container();
            },
          ),
          Container(
            height: paddingXS,
          ),
          Opacity(
            opacity: isTap ? 0.5 : 1,
            child: Container(
              margin: EdgeInsets.only(top: paddingXXS, bottom: paddingXXS),
              child: InkWell(
                onTap: () {
                  updateThongTin();
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: paddingM + 3),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/background_appbar.jpg'),
                            fit: BoxFit.cover,
                            alignment: AlignmentDirectional.center),
                        borderRadius:
                            BorderRadius.all(Radius.circular(blurRadius))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          tr('banking_5'),
                          style: style20.copyWith(color: colorWhite),
                          textAlign: TextAlign.center,
                        ),
                        isTap
                            ? Container(
                                margin: EdgeInsets.only(left: paddingL),
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(),
                              )
                            : Container()
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
