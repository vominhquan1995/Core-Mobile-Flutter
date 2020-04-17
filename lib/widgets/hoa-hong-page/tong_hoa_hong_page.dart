import 'package:Core/core/connection-status/index.dart';
import 'package:Core/core/translate/public.dart';

import 'package:Core/core/function/snackbar.dart';
import 'package:Core/core/page-core/bloc/bloc.dart';
import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/utils/theme.dart';
import 'package:Core/widgets/hoa-hong-page/bloc/hoa_hong_ca_nhan_bloc.dart';
import 'package:Core/widgets/hoa_hong_thang/hoa_hong_thang_list_page.dart';
import 'package:Core/widgets/lich_su_hoa_hong/lich_su_hoa_hong_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'service/tong_hoa_hong_service.dart';

class HoaHongPage extends StatefulWidget {
  @override
  _HoaHongPageState createState() => _HoaHongPageState();
}

class _HoaHongPageState extends State<HoaHongPage> {
  HoaHongCaNhanBloc bloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var currenMonth;
  var date = new DateTime.now();
  @override
  void initState() {
    // TODO: implement initState

    bloc = HoaHongCaNhanBloc(service: HoaHongCaNhanService(BlocProvider.of<ErrorhandleBloc>(context)));
    bloc.add(GetDataHoaHong());

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
    var month = new DateTime(date.year, date.month);
    currenMonth = month.month.toString();
    super.initState();
  }

  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      bloc.add(GetDataHoaHong());
    }
  }

  goToPage(page) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => WidgetsCore(widget: page)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorGrey_1,
        appBar: appBar(),
        body: SafeArea(
          child: listNews(),
        ));
  }

  Widget appBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: colorBlack, //change your color here
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Text(
        tr('commission_1'),
        style: style15_semibold.copyWith(color: colorBlack),
      ),
      // centerTitle: true,
    );
  }

  Widget listNews() {
    return Column(
      children: <Widget>[
        BlocBuilder<HoaHongCaNhanBloc, HoaHongCaNhanState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is LoadedHoaHongCaNhan) {
              return Container(
                  padding: EdgeInsets.all(paddingL),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/background_appbar.jpg'),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          // 'Hoa hồng có thể nhận được trong tháng ' +
                          //     currenMonth,

                          tr('commission_2', args: [currenMonth]),
                          style: style15.copyWith(color: colorWhite),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: paddingL),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                state.tongHoaHong,
                                style: style34_black.copyWith(color: colorRed),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: paddingL, left: paddingM),
                              child: Text(
                                tr('commission_3'),
                                style: style13.copyWith(color: colorRed),
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          goToPage(HoaHongThangList());
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: paddingL),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  // 'Chi tiết hoa hồng tạm tính tháng ' +
                                  //     currenMonth,

                                  tr('commission_4', args: [currenMonth]),
                                  style: style13.copyWith(color: colorWhite),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.chevron_right,
                                  color: colorWhite,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          goToPage(LichSuHoaHongList());
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: paddingL),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  // 'Lịch sử hoa hồng kiếm được',

                                  tr('commission_5'),
                                  style: style13.copyWith(color: colorWhite),
                                ),
                              ),
                              Container(
                                child: Icon(Icons.chevron_right,
                                    color: colorWhite),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ));
            }
            if (state is ErrorHoaHongCaNhanState) {
              return Connection(
                errorType: state.e,
                onPressed: () => setState(() {
                  bloc.add(GetDataHoaHong());
                }),
              );
            }

            return Center(
              child: Container(
                margin: EdgeInsets.only(top: paddingXXS),
                child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(90, 39, 131, 1),
                )),
              ),
            );
          },
        ),
      ],
    );
  }
  Future<Null> _handleRefresh() async {
    bloc.add(GetDataHoaHong());
    showSnackBarUpdateDataKey(_scaffoldKey);
    return null;
  }
}
