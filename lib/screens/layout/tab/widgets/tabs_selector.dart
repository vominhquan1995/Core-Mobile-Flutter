import 'package:Core/core/translate/public.dart';
import 'package:Core/screens/layout/tab/bloc/bloc.dart';
import 'package:Core/utils/index.dart';
import 'package:flutter/material.dart';

import '../custom_bottom_navigation.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNav(
      indicatorWeight: 2,
      indicatorColor: Color.fromRGBO(0, 98, 205, 1),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      iconStyle: IconStyle(size: 30, onSelectSize: 30),
      index: AppTab.values.indexOf(activeTab),
      labelStyle: LabelStyle(
        textStyle: style10_lightgrey,
        onSelectTextStyle: style10.copyWith(color: colorBlue),
      ),
      items: tabSelector
          .map((f) => BottomNavItem(
                f.tabPage.icon,
                f.tabPage.iconActive,
                label: tr(f.tabPage.text),
                key: f.tab.toString(),
              ))
          .toList(),
    );
  }
}
