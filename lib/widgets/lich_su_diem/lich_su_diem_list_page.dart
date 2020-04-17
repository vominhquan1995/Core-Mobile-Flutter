import 'package:Midas/core/connection-status/index.dart';
import 'package:Midas/core/translate/public.dart';

import 'package:Midas/core/data-status/index.dart';
import 'package:Midas/core/function/snackbar.dart';
import 'package:Midas/core/page-core/bloc/bloc.dart';
import 'package:Midas/utils/theme.dart';
import 'package:Midas/widgets/quan_ly_don_hang/widget/empty_data.dart';
import 'package:Midas/widgets/quan_ly_don_hang/widget/item_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/lich_su_diem_bloc.dart';
import 'service/lich_su_diem_service.dart';
import 'widget/widget/item_lich_su_diem.dart';

class LichSuDiemList extends StatefulWidget {
  @override
  _LichSuDiemListState createState() => _LichSuDiemListState();
}

class _LichSuDiemListState extends State<LichSuDiemList> {
  LichSuDiemBloc bloc;
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState

    // bloc = BlocProvider.of<LichSuDiemBloc>(context);
    bloc = LichSuDiemBloc(
        service: LichSuDiemService(BlocProvider.of<ErrorhandleBloc>(context)));
    bloc.add(GetData());
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent * 2 / 3)) {
        bloc.add(GetMoreData());
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
      child: listNews(),
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
        tr('log_point_1'),
        style: style15_semibold.copyWith(color: colorWhite),
      ),
    );
  }

  Widget listNews() {
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, LichSuDiemState state) {
        if (state is LoadedLichSuDiem) {
          return ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: state.listDiem.length ?? 0,
              itemBuilder: (context, i) {
                return i >= state.listDiem.length
                    ? NewsItemShimmer()
                    : Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            bottom: state.listDiem.length == i + 1
                                ? paddingXXS
                                : 0),
                        margin: EdgeInsets.only(
                            bottom: state.listDiem.length == i + 1
                                ? paddingXXS
                                : 0),
                        child: ItemLichSuDiem(
                          data: state.listDiem[i],
                        ),
                      );
              });
        }

        if (state is EmptyLichSuDiem) {
          return EmptyData(
            isButton: false,
            onTap: () {},
            title: tr('log_point_3'),
            noiDung: tr('log_point_4'),
          );
        }

        if (state is ErrorLichSuDiemState) {
          return Connection(
            errorType: state.e,
            onPressed: () => setState(() {
              bloc.add(GetData());
            }),
          );
        }
        return NewsItemShimmer();
      },
    );
  }

  Future<Null> _handleRefresh() async {
    bloc.add(GetData());
    showSnackBarUpdateDataKey(_scaffoldKey);
    return null;
  }
}
