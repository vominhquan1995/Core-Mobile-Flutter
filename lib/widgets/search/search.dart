import 'dart:developer';
import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/core/config_json/models/config_json.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/search/service/service_search.dart';
import 'package:Core/widgets/search_results/search_results.dart';
import 'package:Core/widgets/search_results/widget/app_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

const String KEY_SEARCH = 'history_seach';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode searchFocusNode = new FocusNode();
  final TextEditingController searchController = new TextEditingController();
  List<String> history = [];
  final SearchService service = SearchService();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  redirectPageResult(String key) {
    if (searchController.text.length <= 0 && key.length <= 0) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: Colors.red,
        content: new Text(tr('search_5')),
        duration: Duration(milliseconds: 1000),
      ));
    } else {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => WidgetsCore(
                  widget: SearchResults(
                    keySearch: key,
                    value: key,
                  ),
                )),
      );
      _updateHistory(key);
    }
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(colorPurple);
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBarCustomSearch(
          searchController: searchController,
          searchFocusNode: searchFocusNode,
          onClick: (String key) => redirectPageResult(key)),
      body: CustomScrollView(
        slivers: <Widget>[
          BlocBuilder(
              bloc: BlocProvider.of<ConfigjsonBloc>(context),
              builder: (BuildContext context, ConfigJson data) {
                if (data.search != null) {
                  return _buildTopSearch(data.search);
                }
                return SliverToBoxAdapter(child: SizedBox());
              }),
          SliverToBoxAdapter(
              child: FutureBuilder(
            future: _getHistory(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _buildHistory(snapshot.data);
              }
              return ItemShimerHistory(
                numberLine: 4,
              ); // or some other widget
            },
          )),
        ],
      ),
    );
  }

  _buildTopSearch(List<Search> topKey) {
    List<Widget> out = [];
    topKey.forEach((item) {
      out.add(Container(
        margin: const EdgeInsets.only(right: 5),
        child: FlatButton(
          highlightColor: Colors.black38,
          onPressed: () {
            redirectPageResult(item.name);
          },
          child: Text(
            item.name,
            style: style15,
          ),
          color: Colors.black12,
        ),
      ));
    });
    if (out.length > 0) {
      return SliverToBoxAdapter(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(paddingL, paddingM, paddingL, paddingM),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[HeaderHotKey(), Wrap(children: out)],
            ),
          ),
        ],
      ));
    } else {
      return SliverToBoxAdapter(child: SizedBox());
    }
  }

  _buildHistory(List<String> _history) {
    List<Widget> list = [];
    //header
    list.add(HeaderHistory(onClick: _clearHistory));
    _history.forEach((item) {
      list.add(Container(
        height: paddingXXS,
        padding: EdgeInsets.symmetric(vertical: paddingS),
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          onTap: () {
            redirectPageResult(item);
          },
          child: SizedBox(
            child: Container(
              child: Text(
                item,
                style: style15,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ));
    });
    return _history.isEmpty
        ? SizedBox()
        : Container(
            margin: EdgeInsets.all(paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list,
            ),
          );
  }

  void _updateHistory(String item) {
    service.updateHistory(item);
  }

  void _clearHistory() {
    setState(() {
      history = [];
    });
    service.clearHistory();
  }

  Future<List<String>> _getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data = prefs.getStringList(KEY_SEARCH);
    history = data == null ? [] : data.take(10).toList();
    return history;
  }
}

class HeaderHotKey extends StatelessWidget {
  const HeaderHotKey({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      tr('search_2'),
      style: style17_semibold.copyWith(color: colorViolet),
    );
  }
}

class HeaderHistory extends StatelessWidget {
  const HeaderHistory({Key key, this.onClick}) : super(key: key);
  final Function onClick;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: paddingS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            tr('search_3'),
            style: style17_semibold,
          ),
          InkWell(
              onTap: onClick,
              child: Container(
                  padding: EdgeInsets.all(paddingM),
                  child: Text(
                    tr('search_4'),
                    style: style17.copyWith(color: colorBlue),
                    textAlign: TextAlign.right,
                  )))
        ],
      ),
    );
  }
}

class KeyHotShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              color: Colors.white,
            ),
          ),
        )
      ]),
    );
  }
}

class ItemShimerHistory extends StatelessWidget {
  const ItemShimerHistory({Key key, this.numberLine}) : super(key: key);
  final int numberLine;
  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    for (var i = 0; i < numberLine; i++) {
      items.add(Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 13,
            color: Colors.white,
          ),
        ),
      ));
    }
    return Column(children: items);
  }
}

class AppBarCustomSearch extends StatelessWidget with PreferredSizeWidget {
  final Function(String key) onClick;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  AppBarCustomSearch(
      {Key key,
      @required this.searchController,
      @required this.searchFocusNode,
      @required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // flexibleSpace: Image(
      //   image: AssetImage('assets/images/background_appbar.jpg'),
      //   fit: BoxFit.cover,
      //   alignment: AlignmentDirectional.center,
      // ),
      backgroundColor: colorBackground,
      elevation: 0.0,
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
      title: Container(
        decoration: BoxDecoration(
          color: colorWhite,
          border: Border.all(color: colorGrey_3),
        ),
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back, color: colorGrey_4),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Expanded(
              child: TextField(
                autofocus: true,
                controller: searchController,
                focusNode: searchFocusNode,
                decoration: InputDecoration(
                  hintText: tr('search_1'),
                  hintStyle: style13_lightgrey,
                  border: InputBorder.none,
                ),
                onSubmitted: (String key) => onClick(key),
              ),
            ),
            (searchFocusNode != null && searchFocusNode.hasFocus)
                ? Container(
                    width: 50,
                    child: FlatButton(
                        highlightColor: Colors.black38,
                        child: Icon(Icons.cancel, color: colorGrey_2),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          //if use searchController.clear() will error
                          WidgetsBinding.instance.addPostFrameCallback(
                              (_) => searchController.clear());
                        }),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
