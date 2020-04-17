import 'package:Core/core/connection-status/index.dart';
import 'package:Core/core/translate/public.dart';

import 'package:Core/core/data-status/index.dart';
import 'package:Core/core/function/snackbar.dart';
import 'package:Core/core/page-core/bloc/bloc.dart';
import 'package:Core/utils/theme.dart';
import 'package:Core/widgets/quan_ly_don_hang/widget/empty_data.dart';
import 'package:Core/widgets/quan_ly_don_hang/widget/item_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/hoa_hong_thang_bloc.dart';
import 'service/hoa_hong_thang_service.dart';
import 'widget/widget/item_hoa_hong_thang.dart';

class HoaHongThangList extends StatefulWidget {
  @override
  _HoaHongThangListState createState() => _HoaHongThangListState();
}

class _HoaHongThangListState extends State<HoaHongThangList> {
  HoaHongThangBloc bloc;
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var currenMonth;
  var date = new DateTime.now();

  @override
  void initState() {
    // TODO: implement initState

    // bloc = BlocProvider.of<HoaHongThangBloc>(context);
    bloc = HoaHongThangBloc(
        service:
            HoaHongThangService(BlocProvider.of<ErrorhandleBloc>(context)));
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

    var month = new DateTime(date.year, date.month);
    currenMonth = month.month.toString();
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
        tr('commission_9', args: [currenMonth]),
        style: style15_semibold.copyWith(color: colorWhite),
      ),
      // centerTitle: true,
    );
  }

  Widget listNews() {
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, HoaHongThangState state) {
        if (state is LoadedHoaHongThang) {
          return ListView.builder(
              controller: _scrollController,
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
                        child: ItemHoaHongThang(
                          data: state.listHoaHong[i],
                        ),
                      );
              });
        }

        if (state is EmptyHoaHongThang) {
         return EmptyData(
            isButton: false,
            onTap: () {},
            title: tr('commission_12'),
            noiDung: tr('commission_13'),
          );
        }

        if (state is ErrorHoaHongThangState) {
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
