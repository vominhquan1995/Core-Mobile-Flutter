import 'package:Midas/core/config_json/bloc/configjson_bloc.dart';
import 'package:Midas/core/config_json/models/config_json.dart';
import 'package:Midas/core/page-core/widget_custom.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/quan_ly_don_hang/model/don_hang_model_2.dart';
import 'package:Midas/widgets/search/service/service_search.dart';
import 'package:Midas/widgets/search_results/search_results.dart';
import 'package:flutter/material.dart';
import 'package:Midas/core/connection-status/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/app_bar_danh_muc.dart';
import 'widget/danh_muc_horizontal.dart';

class DanhMucPage extends StatefulWidget {
  final DonHangModel data;

  const DanhMucPage({Key key, this.data}) : super(key: key);
  @override
  _DanhMucPage createState() => _DanhMucPage();
}

class _DanhMucPage extends State<DanhMucPage> {
  // QuanLyDonHangBloc bloc;
  final SearchService service = SearchService();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bloc = QuanLyDonHangBloc(service: QuanLyDonHangService());
    // bloc.add(GetData());
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      // bloc.add(GetData());
    }
  }

  redirectPageResult(String name, String value) {
    //TODO: ADD BY QUAN
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WidgetsCore(
                widget: WidgetsCore(
                    widget: SearchResults(keySearch: name, value: value)))));
    // _updateHistory(name);
  }

  void _updateHistory(String item) {
    service.updateHistory(item);
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorGrey_1,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Image(
            image: AssetImage('assets/images/background_appbar.jpg'),
            fit: BoxFit.cover,
            alignment: AlignmentDirectional.center,
          ),
          title: AppbarDanhMuc(isPageResult: true),
          titleSpacing: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: paddingXXS),
              color: Colors.white,
              child: BlocBuilder<ConfigjsonBloc, ConfigJson>(
                builder: (BuildContext context, ConfigJson state) {
                  if (state.dataDm != null) {
                    return state.dataDm.length < 0
                        ? CongDungHorizontalShimmer()
                        : ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.dataDm.length ?? 0,
                            itemBuilder: (context, i) {
                              return Container(
                                padding: EdgeInsets.all(paddingL),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        state?.dataDm[i].titleHeader,
                                        style: style17_semibold.copyWith(
                                            color: colorViolet),
                                      ),
                                    ),
                                    Container(
                                      // margin: EdgeInsets.only(
                                      //     bottom: state.dataDm[i].loai == 2
                                      //         ? 0
                                      //         : 0),
                                      child: Wrap(
                                          children: state.dataDm[i].loai == 1
                                              ? state.dataDm[i].traCuu
                                                  .map(
                                                    (TraCuu item) =>
                                                        ThuongHieuHorizontal(
                                                            linkImage:
                                                                item.linkImage,
                                                            onTap: () {
                                                              //TODO
                                                              redirectPageResult(
                                                                  item.key,
                                                                  item.value);
                                                            }),
                                                  )
                                                  .toList()
                                              : state.dataDm[i].traCuu
                                                  .map(
                                                    (item) =>
                                                        CongDungHorizontal(
                                                      linkImage: item.linkImage,
                                                      name: item.name,
                                                      onTap: () {
                                                        redirectPageResult(
                                                            item.key,
                                                            item.value);
                                                      },
                                                    ),
                                                  )
                                                  .toList()),
                                    ),
                                  ],
                                ),
                              );
                            });
                  }
                  return Container();
                },
              ),
            ),
          ),
        ));
  }
}
