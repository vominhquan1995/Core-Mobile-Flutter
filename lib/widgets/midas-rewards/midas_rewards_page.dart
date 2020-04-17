import 'package:Midas/core/authentication/bloc/bloc.dart';
import 'package:Midas/core/connection-status/index.dart';
import 'package:Midas/core/custom_translate/easy_localization.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/core/page-core/bloc/bloc.dart';

import 'package:Midas/core/page-core/widget_custom.dart';
import 'package:Midas/utils/theme.dart';
import 'package:Midas/widgets/lich_su_diem/lich_su_diem_list_page.dart';
import 'package:Midas/widgets/lich_su_rut_diem/lich_su_rut_diem_list_page.dart';
import 'package:Midas/widgets/midas-rewards/model/huong_dang_model.dart';
import 'package:Midas/widgets/midas-rewards/service/thong_tin_diem_service.dart';
import 'package:Midas/widgets/midas-rewards/widget/widget/list_huong_dan.dart';
import 'package:Midas/widgets/tra_cuu/models/news_model.dart';
import 'package:Midas/widgets/tra_cuu/news_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/midas_rewards_bloc.dart';
import 'bloc_huong_dan/bloc/huong_dan_bloc.dart';
import 'midas_rewards_variable.dart';
import 'rut_diem_midas_rewards.dart';

class MidasRewardsPage extends StatefulWidget {
  @override
  _MidasRewardsPageState createState() => _MidasRewardsPageState();
}

class _MidasRewardsPageState extends State<MidasRewardsPage> {
  MidasRewardsBloc bloc;
  HuongDanBloc bloc_HD;
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String language = '';

  @override
  void initState() {
    // TODO: implement initState

    bloc = MidasRewardsBloc(
        service:
            ThongTinDiemService(BlocProvider.of<ErrorhandleBloc>(context)));
    bloc_HD = HuongDanBloc(
      service: HuongDanService(
        BlocProvider.of<ErrorhandleBloc>(context),
      ),
    );
    bloc.add(GetDataHMidasRewards());
    bloc_HD.add(GetDanhSachHuongDan(language: language));

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // language = EasyLocalizationProvider.of(context).data.locale.languageCode;
    language = Localization.locate.languageCode;

    bloc_HD.add(GetDanhSachHuongDan(language: language));
  }

  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      bloc.add(GetDataHMidasRewards());
      bloc_HD.add(GetDanhSachHuongDan(language: language));
    }
  }

  goToPage(page) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => WidgetsCore(widget: page)));
  }

  onPressItem(HuongDan huongDan) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewsDetail(
          id: huongDan.id,
          data: News(linkseo: huongDan.linkSeo),
        ),
      ),
    );
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
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            diemSudung(),
            Container(
              color: colorGrey_1,
              height: paddingM,
            ),
            huongDan(),
          ],
        ),
      ),
    );
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
        tr('midas_rewards_1'),
        style: style15_semibold.copyWith(color: colorWhite),
      ),
    );
  }

  Widget diemSudung() {
    final user = (BlocProvider.of<AuthenticationBloc>(context).state
            as AuthenticationAuthenticated)
        .user;
    final listMenu = user.menuID;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(paddingL),
      child: BlocBuilder<MidasRewardsBloc, MidasRewardsState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is LoadedMidasRewards) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: paddingL),
                  child: Text(
                    tr('midas_rewards_2'),
                    style: style15,
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: RichText(
                          text: TextSpan(
                            style: style15,
                            children: [
                              TextSpan(
                                  text: state.data.tienHoaHong,
                                  style:
                                      style34_black.copyWith(color: colorRed)),
                              WidgetSpan(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: 2, left: paddingM),
                                  child: Text(
                                    tr('midas_rewards_3'),
                                    style: style13.copyWith(color: colorRed),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ButtonMidas(
                      //   onPressed: () => goToPage(RutDiemPage()),
                      //   child: Text(
                      //     tr('midas_rewards_6'),
                      //     style: style13.copyWith(color: colorWhite),
                      //   ),
                      // )
                      listMenu.indexOf(BUTTON_RUT_DIEM) != -1
                          ? InkWell(
                              onTap: () {
                                goToPage(RutDiemPage());
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    paddingL, paddingL, paddingL, paddingL),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/background_appbar.jpg'),
                                        fit: BoxFit.cover,
                                        alignment: AlignmentDirectional.center),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(blurRadius))),
                                child: Text(
                                  tr('midas_rewards_6'),
                                  style: style13.copyWith(color: colorWhite),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    goToPage(LichSuDiemList());
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: paddingL),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            tr('midas_rewards_4'),
                            style: style13.copyWith(color: colorGrey_4),
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.chevron_right,
                            color: colorGrey_2,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                listMenu.indexOf(BUTTON_LICH_SU_YEU_CAU) != -1
                    ? InkWell(
                        onTap: () {
                          goToPage(LichSuRutDiemList());
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: paddingL),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  tr('midas_rewards_5'),
                                  style: style13.copyWith(color: colorGrey_4),
                                ),
                              ),
                              Container(
                                child: Icon(Icons.chevron_right,
                                    color: colorGrey_2),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container()
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
          return SizedBox(
              height: 100, child: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }

  Widget huongDan() {
    return BlocBuilder<HuongDanBloc, HuongDanState>(
      bloc: bloc_HD,
      builder: (BuildContext _, HuongDanState state) {
        if (state is LoadedHuongDanState) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(0, paddingL, 0, paddingXXS),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext _, int index) {
                    return ListItemHuongDan(
                      titleHeader: state.list.titleHeader,
                      list: state.list.list,
                      onPress: onPressItem,
                    );
                  },
                  itemCount: 1,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: paddingL);
                  },
                )
              ],
            ),
          );
        }

        if (state is ErrorHuongDanState) {
          return Connection(
            errorType: state.e,
            onPressed: () {
              bloc_HD.add(GetDanhSachHuongDan(language: language));
            },
          );
        }
        return SizedBox(
            height: 100, child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
