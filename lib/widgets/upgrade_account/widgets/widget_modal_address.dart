import 'package:Midas/utils/index.dart';
import 'package:flutter/material.dart';

class SearchModalAddress extends StatelessWidget {
  const SearchModalAddress({
    Key key,
    this.hintText,
    @required this.ctr,
    @required this.onChange,
  }) : super(key: key);
  final TextEditingController ctr;
  final String hintText;
  final Function(String key) onChange;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
          controller: ctr,
          style: style17_semibold,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: colorGrey_2,
            ),
            hintText: hintText,
            hintStyle: style15_lightgrey,
            border: InputBorder.none,
          ),
          onSubmitted: (String key) {
            onChange(key);
          },
          onChanged: (String key) {
            Future.delayed(const Duration(milliseconds: 500), () {
              onChange(key);
            });
          }),
    );
  }
}

class ListSelectAddress extends StatelessWidget {
  final List<dynamic> list;
  final Function(int index) onTap;
  const ListSelectAddress({
    Key key,
    @required this.list,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Material(
              child: InkWell(
            onTap: () {
              onTap(index);
            },
            child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: paddingL, vertical: paddingL),
                child: Text(
                  list[index].fullName,
                  style: style17,
                  textAlign: TextAlign.left,
                )),
          ));
        });
  }
}
