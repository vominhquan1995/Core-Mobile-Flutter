import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  @override
  TabState get initialState => UpdateTabPage(tab: AppTab.LIBRARY);

  @override
  Stream<TabState> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield UpdateTabPage(tab: event.tab);
    }

    if (event is JumbTab) {
      yield JumbToTabPage(tab: event.tab);
    }
  }
}
