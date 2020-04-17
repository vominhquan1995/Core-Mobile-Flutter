import 'package:Core/core/authentication/bloc/bloc.dart';
import 'package:Core/core/cart/cart_badge.dart';
import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/core/config_json/models/config_json.dart';
import 'package:Core/core/connection-status/index.dart';
import 'package:Core/core/function/snackbar.dart';
import 'package:Core/core/page-core/bloc/bloc.dart';
import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/my_library/bloc_banner/banner_bloc.dart';
import 'package:Core/widgets/my_library/bloc_sanpham_goiy/sanphamgoiy_bloc.dart';
import 'package:Core/widgets/my_library/bloc_template/templatesanpham_bloc.dart';
import 'package:Core/widgets/my_library/models/danhmuc_model.dart';
import 'package:Core/widgets/my_library/models/sanpham_model.dart';
import 'package:Core/widgets/my_library/president_header.dart';
import 'package:Core/widgets/my_library/service/library_service.dart';
import 'package:Core/widgets/my_library/widgets/banner_pageview.dart';
import 'package:Core/widgets/my_library/widgets/danhmuc_horizontal.dart';
import 'package:Core/widgets/my_library/widgets/sanpham_grid.dart';
import 'package:Core/widgets/my_library/widgets/sanpham_horizontal.dart';
import 'package:Core/widgets/my_library/widgets/scrollToTop.dart';
import 'package:Core/widgets/my_library/xemthem.dart';
import 'package:Core/widgets/search/widget/search_box_button.dart';
import 'package:Core/widgets/shared/showup/showup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const TOPRATE = 'top_rated';

const FEATURED = 'featured_products';

class MyLibrary extends StatefulWidget {
  @override
  _MyLibraryState createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {
  BannerBloc bannerBloc;

  TemplateSanPhamBloc templateSanPhamBloc;

  SanphamGoiYBloc sanphamGoiYBloc;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState

    bannerBloc = BannerBloc(
        service: LibraryService(BlocProvider.of<ErrorhandleBloc>(context)));

    templateSanPhamBloc = TemplateSanPhamBloc(
        BlocProvider.of<AuthenticationBloc>(context),
        service: LibraryService(BlocProvider.of<ErrorhandleBloc>(context)));

    sanphamGoiYBloc = SanphamGoiYBloc(
        BlocProvider.of<AuthenticationBloc>(context),
        service: LibraryService(BlocProvider.of<ErrorhandleBloc>(context)));

    bannerBloc.add(GetBanner());
    templateSanPhamBloc.add(GetTemplateSanPham());
    super.initState();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent * 2 / 3)) {
        ///Nếu khác trạng thái đã có data
        if (sanphamGoiYBloc.state is! SanPhamGoiYLoaded) {
          sanphamGoiYBloc.add(GetDanhSachPhamGoiY());
          return;
        }
        sanphamGoiYBloc.add(GetMoreDanhSachPhamGoiY());
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bannerBloc.close();
    templateSanPhamBloc.close();
    sanphamGoiYBloc.close();
    super.dispose();
  }

  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      bannerBloc.add(GetBanner());
      templateSanPhamBloc.add(GetTemplateSanPham());
      showSnackBarUpdateDataKey(_scaffoldKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: templateSanPhamBloc,
          listener: (BuildContext _, state) {
            if (state is TemplateSanPhamLoaded) {
              // sanphamGoiYBloc.add(GetDanhSachPhamGoiY());
            }
          },
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (BuildContext _, state) {
            if (state is AuthenticationAuthenticated ||
                state is AuthenticationUnauthenticated) {
              templateSanPhamBloc.add(GetTemplateSanPham());
              sanphamGoiYBloc.add(GetDanhSachPhamGoiY());
            }
          },
        ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorGrey_2,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _buildBackground(),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  _buildBackground() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 250,
          child: ArcBannerImage('assets/images/background.jpg'),
        )
      ],
    );
  }

  _buildContent() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        ///
        ///
        SliverAppBar(
          pinned: true,
          title: _buildSearchBar(),
          elevation: 0.0,
          flexibleSpace: Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),

        ///
        SliverToBoxAdapter(child: SizedBox(height: paddingS)),

        ///
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: paddingL),
          sliver: SliverToBoxAdapter(child: _buildBanner()),
        ),

        ///
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingL),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(height: paddingL),
                _buildDanhMuc(),
                _buildTemplate(),
                Divider(color: borderSide.color),
                SizedBox(height: paddingXS),
                _buildGoiYHomNay(),
              ],
            ),
          ),
        ),

        ///
        SliverToBoxAdapter(
          child: SizedBox(
            height: paddingXXS * 3,
            child: _buildScrollToTop(),
          ),
        )
      ],
    );
  }

  _buildTemplate() {
    return BlocBuilder(
      bloc: templateSanPhamBloc,
      builder: (BuildContext context, TemplateSanPhamState state) {
        Widget w = Column(
          key: UniqueKey(),
          children: <Widget>[
            Divider(key: UniqueKey(), color: borderSide.color),
            SizedBox(key: UniqueKey(), height: paddingM),
            Container(
              height: 250,
              key: UniqueKey(),
              child: SanPhamHorizontalShimmer(),
            ),
          ],
        );

        if (state is TemplateSanPhamLoaded) {
          List<Widget> listW = [];

          for (var item in state.listTemplate) {
            switch (item.template) {
              case "1":
                listW.addAll([
                  Divider(color: borderSide.color),
                  SizedBox(key: UniqueKey(), height: paddingXS),
                  _buildListHorizontal(
                    text: item.title,
                    list: item.listSanPham.toList(),
                  ),
                ]);
                break;
              case "2":
                listW.addAll([
                  Divider(color: borderSide.color),
                  SizedBox(key: UniqueKey(), height: paddingXS),
                  _buildGrid(
                      text: item.title,
                      list: item.listSanPham.toList(),
                      keyWord: item.key)
                ]);
                break;
              default:
                listW.addAll([Container(key: UniqueKey())]);
            }
          }

          w = Column(
              key: UniqueKey(),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: listW);
        }

        if (state is TemplateSanPhamError) {
          w = Connection(
            errorType: state.e,
            onPressed: () => templateSanPhamBloc.add(GetTemplateSanPham()),
          );
        }

        return AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: w,
        );
      },
    );
  }

  _buildDanhMuc() {
    return BlocBuilder<ConfigjsonBloc, ConfigJson>(
      builder: (BuildContext context, state) {
        if (state.dataDmtc != null) {
          return Container(
            height: 130,
            child: DanhMucHorizontal(
              listDM: state.dataDmtc
                  .map(
                    (f) => DanhMucModel(
                        id: f.key,
                        image: f.urlImage,
                        name: f.name,
                        key: f.key,
                        value: f.value),
                  )
                  .toList(),
            ),
          );
        }

        return Container();
      },
    );
  }

  _buildSearchBar() {
    return Row(
      children: <Widget>[
        Expanded(child: SearchBoxButton()),
        CartBadge(
          color: colorWhite,
        )
      ],
    );
  }

  _buildBanner() {
    final height = MediaQuery.of(context).size.width * 3 / 7;

    return Container(
      width: double.infinity,
      // height: ScreenUtil().setHeight(160),
      height: height,
      color: colorGrey_1,
      child: BlocBuilder(
        bloc: bannerBloc,
        builder: (BuildContext context, state) {
          if (state is BannerLoaded) {
            return BannerPageView(list: state.list);
          }

          if (state is BannerError) {
            return BannerErrorPageView();
          }

          if (state is BannerEmpty) {
            return BannerErrorPageView();
          }

          return BannerShimmer();
        },
      ),
    );
  }

  _buildGrid({
    String text,
    List<SanPhamModel> list,
    @required String keyWord,
  }) {
    return SanPhamGrid(
      title: text,
      list: list,
      keyWord: keyWord,
      onPressed: () => _goToXemThem(keyWord),
    );
  }

  _goToXemThem(String keyWord) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WidgetsCore(
          widget: XemThemPage(
            keyword: keyWord,
          ),
        ),
      ),
    );
  }

  _buildListHorizontal({String text, List<SanPhamModel> list}) {
    return SanPhamHorizontal(
      titile: text,
      list: list.toList(),
    );
  }

  _buildGoiYHomNay() {
    return BlocBuilder(
        bloc: sanphamGoiYBloc,
        builder: (BuildContext context, state) {
          if (state is SanPhamGoiYLoaded) {
            return ShowUp(
              child: _buildGrid(
                list: state.list,
                text: 'home_6',
                keyWord: null,
              ),
            );
          }

          return SizedBox(height: paddingXXS * 2);
        });
  }

  _buildScrollToTop() {
    return BlocBuilder(
        bloc: sanphamGoiYBloc,
        builder: (BuildContext context, state) {
          if (state is SanPhamGoiYLoaded) {
            return Center(
              child: ScrollToTop(
                onPressed: () {
                  _scrollController.animateTo(0.0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
              ),
            );
          }

          return Container();
        });
  }
}

class ArcBannerImage extends StatelessWidget {
  ArcBannerImage(this.imageUrl);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ArcClipper(),
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
