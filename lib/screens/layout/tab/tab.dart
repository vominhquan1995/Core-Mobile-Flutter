import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'widgets/tabs_selector.dart';

class TabLayout extends StatelessWidget {
  ///Page Controller
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TabBloc, TabState>(
          listener: (BuildContext _, TabState state) {
            if (state is JumbToTabPage) {}

            if (state is UpdateTabPage) {
              if (_pageController == null) {
                getDefaultController(index: AppTab.values.indexOf(state.tab));
              }
              _pageController.jumpToPage(AppTab.values.indexOf(state.tab));
            }
          },
        ),
      ],
      child: BlocBuilder<TabBloc, TabState>(
        condition: (preTab, nextTab) {
          /// Not rebuild when same Tab
          return preTab.tab != nextTab.tab;
        },
        builder: (BuildContext _, TabState state) {
          return Scaffold(
            body: PageView(
              physics: new NeverScrollableScrollPhysics(),
              children: tabSelector.map((f) => f.tabPage.page).toList(),
              controller:
                  getDefaultController(index: AppTab.values.indexOf(state.tab)),
              onPageChanged: (int index) {
                BlocProvider.of<TabBloc>(context)
                    .add(JumbTab(AppTab.values[index]));
              },
            ),
            bottomNavigationBar: TabSelector(
              activeTab: state.tab,
              onTabSelected: (tab) {
                BlocProvider.of<TabBloc>(context).add(UpdateTab(tab));
              },
            ),
          );
        },
      ),
    );
  }

  getDefaultController({int index = 0}) {
    if (_pageController == null) {
      _pageController = PageController(
        initialPage: index,
        keepPage: true,
      );
    }
    return _pageController;
  }
}
