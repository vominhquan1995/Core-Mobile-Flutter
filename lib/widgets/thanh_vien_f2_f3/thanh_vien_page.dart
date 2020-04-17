import 'package:Midas/core/connection-status/index.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/core/data-status/index.dart';
import 'package:Midas/core/function/snackbar.dart';
import 'package:Midas/utils/theme.dart';
import 'package:Midas/widgets/quan_ly_don_hang/widget/empty_data.dart';
import 'package:Midas/widgets/thanh_vien_f2_f3/widget/widget/app_bar.dart';
import 'package:Midas/widgets/thanh_vien_f2_f3/widget/widget/item_news.dart';
import 'package:Midas/widgets/thanh_vien_f2_f3/widget/widget/item_thanh_vien.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/thanh_vien_bloc.dart';
import 'service/thanh_vien_service.dart';
import 'widget/widget/empty_page.dart';

class ThanhVienPage extends StatefulWidget {
  @override
  _ThanhVienPageState createState() => _ThanhVienPageState();
}

class _ThanhVienPageState extends State<ThanhVienPage> {
  ThanhVienBloc bloc;
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final myController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    bloc = ThanhVienBloc(service: ThanhVienService());
    bloc.add(GetData());
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      bloc.add(GetData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThanhVienBloc, ThanhVienState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is EmptyThanhVien) {
          return Scaffold(
            appBar: AppBar(
              brightness: Brightness.dark,
              flexibleSpace: Image(
                image: AssetImage('assets/images/background_appbar.jpg'),
                fit: BoxFit.cover,
                alignment: AlignmentDirectional.center,
              ),
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              elevation: 0.0,
              title: Text(
                tr('member_1'),
                style: style15_semibold.copyWith(color: colorWhite),
              ),
              // centerTitle: true,
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: EmptyPage(),
            ),
          );
        }
        if (state is ErrorThanhVienState) {
          return Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Connection(
                errorType: state.e,
                onPressed: () {
                  bloc.add(GetData());
                },
              ),
            ),
          );
        }
        return Scaffold(
            key: _scaffoldKey,
            backgroundColor: colorGrey_1,
            appBar: appBar(),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: listNews(),
              ),
            ));
      },
    );
  }

  Widget appBar() {
    // return AppBarThanhVien(f2: '1', f3: '1');
    return PreferredSize(
        child: BlocBuilder<ThanhVienBloc, ThanhVienState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is LoadedThanhVien) {
              return AppBarThanhVien(f2: state.slF2, f3: state.slF3);
            }
            if (state is SearchThanhVien) {
              return AppBarThanhVien(f2: state.slF2, f3: state.slF3);
            }
            if (state is EmptySearchThanhVien) {
              return AppBarThanhVien(f2: state.slF2, f3: state.slF3);
            }
            if (state is ErrorThanhVienState) {
              return AppBarThanhVien(f2: '-', f3: '-');
            }
            return AppBarThanhVien(f2: '-', f3: '-');
          },
        ),
        preferredSize: Size.fromHeight(130));
  }

  Widget listNews() {
    return Container(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: paddingL,
                  right: paddingL,
                  top: paddingL,
                  bottom: paddingM),
              child: TextField(
                controller: myController,
                onChanged: (content) {
                  bloc.add(SearchEvent(content));
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: colorGrey_3, width: 0.0),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: paddingM),
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  fillColor: colorGrey_1,
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  hintText: tr('member_5'),
                ),
              ),
            ),
            BlocBuilder<ThanhVienBloc, ThanhVienState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is LoadedThanhVien && myController.text == '') {
                    return Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: paddingXXS),
                      padding: EdgeInsets.only(
                          left: paddingL, right: paddingL, bottom: paddingXS),
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.thanh_vien.length,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: EdgeInsets.only(
                                  bottom: state.thanh_vien.length == i + 1
                                      ? paddingL
                                      : 0),
                              child: ItemThanhVien(
                                tenShop: state.thanh_vien[i].ten_shop,
                                taiKhoan: state.thanh_vien[i].tai_khoan,
                                diaChi: state.thanh_vien[i].dia_chi_shop,
                              ),
                            );
                          }),
                    );
                  }
                  if (state is SearchThanhVien) {
                    return Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: paddingXXS),
                      padding: EdgeInsets.only(
                          left: paddingL, right: paddingL, bottom: paddingXS),
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.thanh_vien.length,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: EdgeInsets.only(
                                  bottom: state.thanh_vien.length == i + 1
                                      ? paddingL
                                      : 0),
                              child: ItemThanhVien(
                                tenShop: state.thanh_vien[i].ten_shop,
                                taiKhoan: state.thanh_vien[i].tai_khoan,
                                diaChi: state.thanh_vien[i].dia_chi_shop,
                              ),
                            );
                          }),
                    );
                  }

                  if (state is EmptySearchThanhVien) {
                    return EmptyData(
                      isButton: false,
                      onTap: () {},
                      title: tr('member_7'),
                      noiDung: tr('member_8'),
                    );

                    // Container(
                    //   padding: EdgeInsets.only(top: paddingXS),
                    //   child: DataStatusWidget(
                    //     style: DataStatus.not_data(tr('member_7')),
                    //   ),
                    // );
                  }
                  // if (state is EmptySearchThanhVien) {
                  //   return Container(
                  //     height: MediaQuery.of(context).size.height,
                  //     child: EmptyPage(),
                  //   );
                  // }
                  // if (state is EmptyThanhVien) {
                  //   return Container(
                  //     // height: MediaQuery.of(context).size.height/2,
                  //     child: DataStatusWidget(
                  //       style: DataStatus.not_data('Không có dữ liệu'),
                  //     ),
                  //   );
                  // }

                  if (state is ErrorThanhVienState) {
                    return SliverFillRemaining(
                      child: Connection(
                        errorType: state.e,
                        onPressed: () => setState(() {
                          bloc.add(GetData());
                        }),
                      ),
                    );
                  }
                  return Container(
                    child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 15,
                        itemBuilder: (context, i) {
                          return NewsItemShimmer();
                        }),
                  );
                })
          ],
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    bloc.add(GetData());
    showSnackBarUpdateDataKey(_scaffoldKey);
    return null;
  }
}
