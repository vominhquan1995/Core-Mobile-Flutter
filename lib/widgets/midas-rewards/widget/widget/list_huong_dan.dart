import 'package:Core/utils/index.dart';
import 'package:Core/widgets/midas-rewards/model/huong_dang_model.dart';
import 'package:Core/widgets/midas-rewards/widget/widget/item_in_list.dart';
import 'package:flutter/material.dart';


typedef OnPressItem = Function(HuongDan huongDan);

class ListItemHuongDan extends StatelessWidget {
  final String titleHeader;
  final List<HuongDan> list;
  final OnPressItem onPress;

  const ListItemHuongDan(
      {Key key, this.titleHeader = '', this.list, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(titleHeader, style: style17_semibold),
          Flexible(
            child: ListView.separated(
              padding: EdgeInsets.only(top: paddingL),
              itemCount: list.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext _, int index) {
                return ItemInList(
                    huongDan: list[index],
                    onPress: list[index].id != null
                        ? () => onPress(list[index])
                        : null);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: paddingM);
              },
            ),
          )
        ],
      ),
    );
  }
}
