import 'package:Core/core/authentication/bloc/bloc.dart';
import 'package:Core/core/connection-status/index.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Core/utils/theme.dart';
import 'package:Core/widgets/my_library/widgets/sanpham_widget.dart';
import 'package:Core/widgets/quoc_gia/bloc/quocgia_bloc.dart';
import 'package:Core/widgets/search/search.dart';
import 'package:Core/widgets/search/widget/search_box_static.dart';
import 'package:Core/widgets/search_results/service/service_search_results.dart';
import 'package:Core/widgets/search_results/widget/app_bar_custom.dart';
import 'package:Core/widgets/search_results/widget/filter_drawer.dart';
import 'package:Core/widgets/shared/buttonMidas/button_midas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/search_results_bloc.dart';
import 'model/parram_filter_model.dart';

class SearchResults extends StatefulWidget {
  final String keySearch;
  final String value;
  SearchResults({
    Key key,
    @required this.keySearch,
    @required this.value,
  }) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  String textSearch = '';
  SearchResultsBloc bloc;
  List<FilterItem> data = [];
  final globalKey = GlobalKey<ScaffoldState>();
  ParamFilter _paramFilter = ParamFilter();
  ScrollController _scrollController = new ScrollController();
  bool isLogin;
  @override
  void initState() {
    bloc = new SearchResultsBloc(
        service:
            SearchResultsService(BlocProvider.of<ErrorhandleBloc>(context)));
    //get data lang
    final dataL =
        (BlocProvider.of<QuocgiaBloc>(context).state as DanhSachQuocgia);
    _paramFilter.locate = dataL.confirm.codeC;
    //init data filter
    initFilter();
    isLogin = BlocProvider.of<AuthenticationBloc>(context).state
        is AuthenticationAuthenticated;
    bloc.add(SearchData(filter: _paramFilter, isPrivate: isLogin));
    //add event load more
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent * 2 / 3)) {
        bloc.add(LoadMoreData(filter: _paramFilter, isPrivate: isLogin));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    bloc.close();
  }

  void initFilter() {
    switch (widget.keySearch) {
      case 'loai_san_pham':
        {
          data.add(FilterItem(key: 'loai_san_pham', value: widget.value));
          _paramFilter.loaiSanPham = [widget.value];
          break;
        }
      case 'dong_san_pham':
        {
          data.add(FilterItem(key: 'dong_san_pham', value: widget.value));
          _paramFilter.dongSanPham = [widget.value];
          break;
        }
      case 'nganh_hang':
        {
          data.add(FilterItem(key: 'nganh_hang', value: widget.value));
          _paramFilter.nganhHang = [widget.value];
          break;
        }
      case 'thuong_hieu':
        {
          data.add(FilterItem(key: 'thuong_hieu', value: widget.value));
          _paramFilter.thuongHieu = [widget.value];
          break;
        }
      default:
        //search by key
        textSearch = widget.value ?? '';
        _paramFilter.search = widget.value;
        break;
    }
  }

  void onClickSearch() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(),
      ),
    );
  }

  _submitFilter(List<FilterItem> _data) {
    //save data selected
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          data = _data;
        }));
    //reset filter
    _paramFilter.clearFilter();
    //build param filter
    _data.forEach((FilterItem item) {
      _paramFilter.setValueFilter(item.key, item.value);
    });
    //recall service
    bloc.add(SearchData(filter: _paramFilter, isPrivate: isLogin));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorGrey_1,
        key: globalKey,
        appBar: new AppBarCustomSearchResult(keySearch: textSearch),
        endDrawer: FilterDrawer(
            selected: data,
            onSubmitFilter: (data) {
              _submitFilter(data);
            }),
        body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: HeaderFilterCustom(numberFilter: data.length),
            ),
            SliverToBoxAdapter(child: SizedBox(height: paddingS)),
            BlocBuilder(
                bloc: bloc,
                builder: (BuildContext context, SearchResultsState state) {
                  if (state is EmptyData) {
                    return SliverToBoxAdapter(
                        child: Container(
                      color: Colors.transparent,
                      child: SearchNotFound(),
                    ));
                  }
                  if (state is LoadedData) {
                    return SliverFillRemaining(
                        child: ListView(
                      controller: _scrollController,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: paddingL, right: paddingL, top: paddingXS),
                          color: Colors.white,
                          child: GridView.builder(
                              // controller: _scrollController,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.list.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: paddingL,
                                crossAxisSpacing: paddingL,
                                childAspectRatio: 0.58,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: SanPhamWidget(
                                      sanPhamModel: state.list[index]),
                                );
                              }),
                        ),
                        Container(
                          color: Colors.transparent,
                          height: paddingXXS,
                        )
                      ],
                    ));
                  }
                  if (state is LoadDataError) {
                    return SliverFillRemaining(
                      child: Connection(
                        errorType: state.e,
                        onPressed: () => setState(() {
                          bloc.add(SearchData(
                              filter: _paramFilter, isPrivate: isLogin));
                        }),
                      ),
                    );
                  }
                  return SliverFillRemaining(
                      child: Container(
                    color: Colors.white,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ));
                }),
          ],
        ));
  }
}

class SearchNotFound extends StatelessWidget {
  const SearchNotFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            SizedBox(height: paddingL),
            Opacity(
              opacity: 0.5,
              child: Image.asset('assets/search-empty.png'),
            ),

            SizedBox(height: paddingL),
            Text(
              tr('search_results_1'),
              style: style22_semibold,
            ),
            SizedBox(height: paddingM),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Text(
                tr('search_results_2'),
                textAlign: TextAlign.center,
                style: style15_lightgrey,
              ),
            ),
            SizedBox(height: paddingXXS),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 4),
              child: ButtonMidas(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ),
                  );
                },
                child: Text(
                  tr('search_results_3'),
                  style: style17_semibold.copyWith(color: colorWhite),
                ),
              ),
            )

            // Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage("assets/bg_header.jpg"),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   margin: EdgeInsets.all(10),
            //   width: MediaQuery.of(context).size.width * 0.6,
            //   height: 50,
            //   child: FlatButton(
            //       onPressed: () {
            //         Navigator.pushReplacement(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => SearchPage(),
            //           ),
            //         );
            //       },
            //       child: Text(
            //         tr('search_results_3'),
            //         style: style17_semibold.copyWith(color: colorWhite),
            //       )),
            // )
          ],
        ));
  }
}

class GroupFilterItem {
  GroupFilterItem({this.idGroup, this.index, this.title, this.filters});
  final int index;
  final String idGroup;
  final String title;
  final List<FilterItem> filters;
}

class FilterItem {
  FilterItem({this.key, this.title, this.value, this.urlImage = ''});
  final String key;
  final String title;
  final String value;
  final String urlImage;
}

class HeaderFilterCustom extends SliverPersistentHeaderDelegate {
  final int numberFilter;
  HeaderFilterCustom({this.numberFilter});
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: Colors.black12,
              )),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.sort,
                    color: Colors.black,
                  ),
                  Text(tr('search_results_4'), style: style15),
                  Text('(${numberFilter})',
                      style: style15.copyWith(color: colorBlue))
                ],
              ),
            ),
          ));

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class AppBarCustomSearchResult extends StatelessWidget
    with PreferredSizeWidget {
  final String keySearch;
  AppBarCustomSearchResult({Key key, @required this.keySearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Image(
        image: AssetImage('assets/images/background_appbar.jpg'),
        fit: BoxFit.cover,
        alignment: AlignmentDirectional.center,
      ),
      backgroundColor: colorBackground,
      elevation: 0.0,
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
      title: SearchBoxStatic(value: keySearch, isPageResult: true),
      actions: <Widget>[new Container()],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
