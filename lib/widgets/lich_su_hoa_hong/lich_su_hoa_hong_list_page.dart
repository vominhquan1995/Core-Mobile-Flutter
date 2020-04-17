import 'package:Core/core/connection-status/index.dart';
import 'package:Core/core/translate/public.dart';

import 'package:Core/core/data-status/index.dart';
import 'package:Core/core/function/snackbar.dart';
import 'package:Core/core/page-core/bloc/bloc.dart';
import 'package:Core/utils/theme.dart';
import 'package:Core/widgets/lich_su_hoa_hong/lich_su_hoa_hong_bloc/lich_su_hoa_hong_bloc.dart';
import 'package:Core/widgets/lich_su_hoa_hong/service/lich_su_hoa_hong_service.dart';
import 'package:Core/widgets/quan_ly_don_hang/widget/empty_data.dart';
import 'package:Core/widgets/quan_ly_don_hang/widget/item_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/widget/item_hoa_hong_thang.dart';
import 'widget/widget/month_picker.dart';

class LichSuHoaHongList extends StatefulWidget {
  @override
  _LichSuHoaHongListState createState() => _LichSuHoaHongListState();
}

class _LichSuHoaHongListState extends State<LichSuHoaHongList> {
  LichSuHoaHongBloc bloc;
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var tu_ngay;
  var toi_ngay;

  @override
  void initState() {
    // TODO: implement initState

    // bloc = BlocProvider.of<LichSuHoaHongBloc>(context);
    bloc = LichSuHoaHongBloc(
        service:
            LichSuHoaHongService(BlocProvider.of<ErrorhandleBloc>(context)));
    bloc.add(GetData());
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent * 2 / 3)) {
        bloc.add(GetMoreData(tu_ngay: tu_ngay, toi_ngay: toi_ngay));
      }
    });

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
    super.initState();
  }

  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      bloc.add(GetData());
    }
  }

  changeMonth({tu_ngay, toi_ngay}) {
    bloc.add(GetData(tu_ngay: tu_ngay, toi_ngay: toi_ngay));
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
    return RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
              color: Colors.white,
              child: MonthPickerHor(
                onChange: (time) {
                  tu_ngay = time['tu_ngay'];
                  toi_ngay = time['toi_ngay'];
                  changeMonth(
                      tu_ngay: time['tu_ngay'], toi_ngay: time['toi_ngay']);
                },
              ),
            ),
            listNews(),
          ],
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
        tr('commission_10'),
        style: style15_semibold.copyWith(color: colorWhite),
      ),
      // centerTitle: true,
    );
  }

  Widget listNews() {
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, LichSuHoaHongState state) {
        if (state is LoadedLichSuHoaHong) {
          return ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.listHoaHong.length ?? 0,
              itemBuilder: (context, i) {
                return i >= state.listHoaHong.length
                    ? NewsItemShimmer()
                    : Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            bottom: state.listHoaHong.length == i + 1
                                ? paddingXXS
                                : 0),
                        margin: EdgeInsets.only(
                            bottom: state.listHoaHong.length == i + 1
                                ? paddingXXS
                                : 0),
                        child: ItemHoaHong(
                          data: state.listHoaHong[i],
                        ),
                      );
              });
        }

        if (state is EmptyLichSuHoaHong) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: EmptyData(
              isButton: false,
              onTap: () {},
              title: tr('commission_12'),
              noiDung: tr('commission_13'),
            ),
          );
        }

        if (state is ErrorLichSuHoaHongState) {
          return Connection(
            errorType: state.e,
            onPressed: () => setState(() {
              bloc.add(GetData());
            }),
          );
        }

        return Container(
          padding: EdgeInsets.only(top: paddingL),
          child: NewsItemShimmer(),
        );
      },
    );
  }

  Future<Null> _handleRefresh() async {
    bloc.add(GetData());
    showSnackBarUpdateDataKey(_scaffoldKey);
    return null;
  }
}
