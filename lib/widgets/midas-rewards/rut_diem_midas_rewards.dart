import 'package:Midas/core/config_json/bloc/configjson_bloc.dart';
import 'package:Midas/core/config_json/models/config_json.dart';
import 'package:Midas/core/connection-status/index.dart';
import 'package:Midas/core/translate/public.dart';

import 'package:Midas/core/function/snackbar.dart';
import 'package:Midas/core/page-core/bloc/bloc.dart';
import 'package:Midas/core/page-core/widget_custom.dart';
import 'package:Midas/utils/theme.dart';
import 'package:Midas/widgets/shared/text_html/text_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bloc/midas_rewards_bloc.dart';
import 'bloc_rut_diem/rut_diem_bloc.dart';
import 'service/thong_tin_diem_service.dart';
import 'update_tai_khoan_ngan_hang.dart';
import 'widget/widget/update_success.dart';

class RutDiemPage extends StatefulWidget {
  @override
  _RutDiemPageState createState() => _RutDiemPageState();
}

class _RutDiemPageState extends State<RutDiemPage> {
  MidasRewardsBloc bloc;
  RutDiemBloc bloc_rut_diem;
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _controller = TextEditingController();
  bool isTap = false;

  @override
  void initState() {
    // TODO: implement initState

    bloc = MidasRewardsBloc(
        service:
            ThongTinDiemService(BlocProvider.of<ErrorhandleBloc>(context)));
    bloc_rut_diem = RutDiemBloc(
        service:
            ThongTinDiemService(BlocProvider.of<ErrorhandleBloc>(context)));
    bloc.add(GetDataHMidasRewards());
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent * 2 / 3)) {
        // bloc.add(GetMoreData());
      }
    });

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
    super.initState();
  }

  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      bloc.add(GetDataHMidasRewards());
    }
  }

  goToPageUpdate(page) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => BlocProvider.value(
              value: bloc,
              child: WidgetsCore(widget: page),
            )));
  }

  showModalSuccess() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext _) {
          return UpdateSucces();
        }).then((onValue) {
      setState(() {
        isTap = false;
      });
      _controller.clear();
    });
  }

  taoYeuCau() {
    if (isTap) {
      return;
    }
    setState(() {
      isTap = true;
    });
    final configJson = BlocProvider.of<ConfigjsonBloc>(context).state;
    bloc_rut_diem.add(TaoYeuCauEvent(
        so_tien_rut: _controller.text.toString(),
        rutHoaHongMin: num.parse(configJson?.dataRutHoaHongMin?.value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorGrey_1,
        appBar: appBar(),
        body: SafeArea(
          child: buildList(),
        ));
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
              child: BlocListener<MidasRewardsBloc, MidasRewardsState>(
                  bloc: bloc,
                  listener: (context, state) {
                    // if (state is DoneUpdateMidasRewards) {
                    //   bloc.add(GetDataHMidasRewards());
                    // }
                  },
                  child: BlocBuilder<MidasRewardsBloc, MidasRewardsState>(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state is LoadedMidasRewards) {
                        return Column(
                          children: <Widget>[
                            state.data.tenNganHang == '' &&
                                    state.data.tenNguoiNhan == '' &&
                                    state.data.taiKhoanNganHang == ''
                                ? khongCoThongTin(state.data)
                                : coThongTin(state.data),
                            Container(
                              color: colorGrey_1,
                              height: paddingM,
                            ),
                            state.data.tenNganHang == '' &&
                                    state.data.tenNguoiNhan == '' &&
                                    state.data.taiKhoanNganHang == ''
                                ? guiYeuCau(state.data, false)
                                : guiYeuCau(state.data, true),
                          ],
                        );
                      }
                      if (state is ErrorMidasRewardsState) {
                        return Connection(
                          errorType: state.e,
                          onPressed: () => setState(() {
                            bloc.add(GetDataHMidasRewards());
                          }),
                        );
                      }
                      return Center(
                        child: Container(
                          padding: EdgeInsets.all(paddingL),
                          margin: EdgeInsets.only(top: paddingXXS),
                          child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                            Color.fromRGBO(90, 39, 131, 1),
                          )),
                        ),
                      );
                    },
                  ))),
        ));

    ;
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
        tr('withdrawal_1'),
        style: style15_semibold.copyWith(color: colorWhite),
      ),
    );
  }

  Widget khongCoThongTin(data) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: paddingL),
            child: DefaultTextStyle(
              style: style15,
              softWrap: true,
              textAlign: TextAlign.center,
              child: HtmlText(
                data: tr('withdrawal_2'),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              goToPageUpdate(UpdateNganHang(
                data: data,
              ));
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: paddingM, bottom: paddingM),
                padding: EdgeInsets.symmetric(
                    vertical: paddingL, horizontal: paddingXXS),
                color: colorGrey_1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: SvgPicture.asset(
                        'assets/images/add-card.svg',
                        height: 60,
                        width: 60,
                      ),
                    ),
                    Container(
                      child: Text(
                        tr('withdrawal_3'),
                        style: style15,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget coThongTin(data) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: paddingM),
            child: DefaultTextStyle(
              style: style15,
              softWrap: true,
              textAlign: TextAlign.center,
              child: HtmlText(
                data: tr('withdrawal_2'),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: paddingL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          tr('withdrawal_9') + ':',
                          style: style15.copyWith(color: colorGrey_3),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: paddingM),
                        child: Text(tr('withdrawal_10') + ':',
                            style: style15.copyWith(color: colorGrey_3)),
                      ),
                      Container(
                        child: Text(tr('withdrawal_11') + ':',
                            style: style15.copyWith(color: colorGrey_3)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: paddingL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          data.taiKhoanNganHang,
                          style: style15_semibold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: paddingM),
                        child: Text(data.tenNguoiNhan.toUpperCase(),
                            style: style15_semibold),
                      ),
                      Container(
                        child: Text(
                          data.tenNganHang,
                          style: style15_semibold,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              goToPageUpdate(UpdateNganHang(
                data: data,
              ));
            },
            child: Container(
              margin: EdgeInsets.only(top: paddingM, bottom: paddingXXS),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      tr('withdrawal_12'),
                      //  AppLocalizations.of(context)
                      //     .tr('commission_5'),
                      style: style15.copyWith(color: colorBlue),
                    ),
                  ),
                  Container(
                    child: Icon(Icons.chevron_right, color: colorBlue),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget guiYeuCau(data, coThongTin) {
    return BlocListener<RutDiemBloc, RutDiemState>(
        bloc: bloc_rut_diem,
        listener: (context, state) {
          if (state is DoneTaoYeuCauRutDiemState) {
            showModalSuccess();
          }
          if (state is ErrorTaoYeuCauRutDiemState) {
            setState(() {
              isTap = false;
            });
          }
        },
        child: Container(
          color: Colors.white,
          padding:
              EdgeInsets.fromLTRB(paddingL, paddingXS, paddingL, paddingXXS),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: paddingM),
                child: RichText(
                  text: TextSpan(
                    style: style15,
                    children: [
                      WidgetSpan(
                          child: Container(
                        margin:
                            EdgeInsets.only(bottom: paddingM, right: paddingM),
                        child: Text(
                          tr('withdrawal_4') + ': ',
                          style: style15,
                        ),
                      )),
                      WidgetSpan(
                          child: Container(
                        margin: EdgeInsets.only(bottom: 2),
                        child: Text(
                          data.tienHoaHong,
                          style: style34_black.copyWith(color: colorRed),
                        ),
                      )),
                      WidgetSpan(
                          child: Container(
                        margin:
                            EdgeInsets.only(bottom: paddingM, left: paddingM),
                        child: Text(
                          tr('withdrawal_5'),
                          style: style13.copyWith(color: colorRed),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: paddingL),
                child: TextField(
                  enableInteractiveSelection: false,
                  readOnly: !coThongTin,
                  keyboardType: TextInputType.number,
                  // focusNode: focusMaXacThucText,
                  controller: _controller,
                  style: style15,
                  decoration: InputDecoration(
                      fillColor: !coThongTin ? colorGrey_1 : null,
                      filled: !coThongTin,
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: tr('withdrawal_6'),
                      hintStyle: style15_lightgrey,
                      focusedBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: borderSide,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: borderSide)),
                ),
              ),
              BlocBuilder<ConfigjsonBloc, ConfigJson>(
                builder: (BuildContext context, ConfigJson state) {
                  return Container(
                    margin: EdgeInsets.only(top: paddingM),
                    child: Text(
                      tr('withdrawal_7', args: [state.dataRutHoaHongMin.text]),
                      style: style13.copyWith(
                          color: colorGrey_4, fontStyle: FontStyle.italic),
                    ),
                  );
                },
              ),
              BlocBuilder<RutDiemBloc, RutDiemState>(
                bloc: bloc_rut_diem,
                builder: (context, state) {
                  if (state is ErrorTaoYeuCauRutDiemState) {
                    return Container(
                      margin: EdgeInsets.only(top: paddingM),
                      child: BlocBuilder<ConfigjsonBloc, ConfigJson>(
                        builder: (BuildContext context, ConfigJson s) {
                          return Container(
                            margin: EdgeInsets.only(top: paddingM),
                            child: Text(
                              state.e == '401'
                                  ? tr('withdrawal_17')
                                  : state.e == '402'
                                      ? tr('withdrawal_18')
                                      : tr('withdrawal_19',
                                          args: [s.dataRutHoaHongMin.text]),
                              style: style13.copyWith(color: colorRed),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
              InkWell(
                onTap: () {
                  coThongTin ? taoYeuCau() : null;
                },
                child: Opacity(
                  opacity: !coThongTin ? 0.5 : isTap ? 0.5 : 1,
                  child: Container(
                      margin: EdgeInsets.only(top: paddingXXS),
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
                            tr('withdrawal_8'),
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
            ],
          ),
        ));
  }

  Future<Null> _handleRefresh() async {
    // bloc.add(GetData());
    showSnackBarUpdateDataKey(_scaffoldKey);
    return null;
  }
}
