import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/core/config_json/models/config_json.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/search_results/search_results.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDrawer extends StatefulWidget {
  final Function(List<FilterItem> data) onSubmitFilter;
  final List<FilterItem> selected;
  const FilterDrawer(
      {Key key, @required this.selected, @required this.onSubmitFilter})
      : super(key: key);
  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  List<FilterItem> data;
  @override
  void initState() {
    super.initState();
    //build item selected
    data = widget.selected;
  }

  @override
  void dispose() {
    //submit data filter
    widget.onSubmitFilter(data);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
            child: Column(
          children: <Widget>[
            AppBar(
              elevation: 0.0, //shadow
              titleSpacing: 0,
              actions: <Widget>[Container()],
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                            Text(
                              tr('search_results_5'),
                              style: style17,
                            )
                          ],
                        )),
                    GestureDetector(
                      onTap: () {
                        _clearFilter();
                      },
                      child: Text(
                        tr('search_results_6'),
                        style: style15.copyWith(color: colorBlue),
                      ),
                    )
                  ],
                ),
              ),
            ),
            BlocBuilder(
                bloc: BlocProvider.of<ConfigjsonBloc>(context),
                builder: (BuildContext context, ConfigJson data) {
                  if (data.filter != null) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: _buildFilter(context, data.filter),
                      ),
                    );
                  }
                  return SliverToBoxAdapter(child: SizedBox());
                }),
          ],
        )));
  }

  List<Widget> _buildFilter(BuildContext context, List<Filter> dataFilter) {
    List<GroupFilterItem> _filters = convertDataJson(dataFilter);
    List<Widget> content = [];
    _filters.forEach((item) {
      List<Widget> child = [];
      item.filters.forEach((filter) {
        child.add(_buildItemFilter(filter));
      });
      content.add(Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item.title,
              style: style17_semibold.copyWith(color: colorPurple),
              // textAlign: TextAlign.left,
            ),
            Wrap(
              children: child,
            )
          ],
        ),
      ));
    });
    return content;
  }

  List<GroupFilterItem> convertDataJson(List<Filter> list) {
    list = list != null ? list : [];
    List<GroupFilterItem> filters = [];
    list.forEach((itemGrop) {
      List<FilterItem> child = [];
      itemGrop.traCuu.forEach((item) {
        child.add(
            FilterItem(key: item.key, value: item.value, title: item.name));
      });
      filters.add(GroupFilterItem(title: itemGrop.titleHeader, filters: child));
    });
    return filters;
  }

  Widget _buildItemFilter(FilterItem item) {
    if (data.where((x) => x.value == item.value).toList().isNotEmpty) {
      return Container(
        margin: const EdgeInsets.all(1),
        child: FlatButton(
          onPressed: () {
            _selectFilter(item);
          },
          child: Text(
            item.title,
            style: style15.copyWith(color: colorWhite),
          ),
          color: colorPurple,
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(1),
        child: FlatButton(
          onPressed: () {
            _selectFilter(item);
          },
          child: Text(
            item.title,
            style: style15,
          ),
          color: colorGrey_1,
        ),
      );
    }
  }

  void _clearFilter() {
    setState(() => {data = []});
  }

  void _selectFilter(FilterItem item) {
    if (data.where((x) => x.value == item.value).toList().isEmpty) {
      data.add(item);
    } else {
      data.removeWhere((x) => x.value == item.value);
    }
    setState(() => {data = data});
  }
}
