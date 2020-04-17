import 'package:Midas/core/connection-status/index.dart';
import 'package:Midas/core/translate/public.dart';

import 'package:Midas/core/data-status/index.dart';
import 'package:Midas/core/function/snackbar.dart';
import 'package:Midas/core/page-core/bloc/bloc.dart';
import 'package:Midas/utils/theme.dart';
import 'package:Midas/widgets/quan_ly_don_hang/widget/item_don_hang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/quan_ly_don_hang_bloc.dart';
import 'service/quan_ly_don_hang_service.dart';
import 'widget/empty_data.dart';
import 'widget/item_news.dart';

class QuanLyDonHangList extends StatefulWidget {
  @override
  _QuanLyDonHangListState createState() => _QuanLyDonHangListState();
}

class _QuanLyDonHangListState extends State<QuanLyDonHangList> {
  QuanLyDonHangBloc bloc;
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState

    // bloc = BlocProvider.of<QuanLyDonHangBloc>(context);
    bloc = QuanLyDonHangBloc(
        service:
            QuanLyDonHangService(BlocProvider.of<ErrorhandleBloc>(context)));
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
      ),
    );
  }

  Widget buildList() {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: listNews(),
      //  CustomScrollView(
      //   controller: _scrollController,
      //   slivers: <Widget>[
      //     // appBar(),

      //   ],
      // ),
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
        tr('order_management_1'),
        style: style15_semibold.copyWith(color: colorWhite),
      ),
    );
  }

  Widget listNews() {
    return BlocBuilder<QuanLyDonHangBloc, QuanLyDonHangState>(
      bloc: bloc,
      builder: (BuildContext context, QuanLyDonHangState state) {
        if (state is LoadedQuanLyDonHang) {
          return ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: state.donhang.length ?? 0,
              itemBuilder: (context, i) {
                return i >= state.donhang.length
                    ? NewsItemShimmer()
                    : Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            bottom:
                                state.donhang.length == i + 1 ? paddingXXS : 0),
                        margin: EdgeInsets.only(
                            bottom:
                                state.donhang.length == i + 1 ? paddingXXS : 0),
                        child: ItemDonHang(
                          data: state.donhang[i],
                        ),
                      );
              });
        }

        if (state is EmptyQuanLyDonHang) {
          return EmptyData(
            isButton: true,
            onTap: () {
              returnHome();
            },
            title: tr('order_management_19'),
            noiDung: tr('order_management_20'),
            textButtom: tr('order_management_21'),
          );
        }

        if (state is ErrorQuanLyDonHangState) {
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

  returnHome() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  Future<Null> _handleRefresh() async {
    bloc.add(GetData());
    showSnackBarUpdateDataKey(_scaffoldKey);
    return null;
  }
}
