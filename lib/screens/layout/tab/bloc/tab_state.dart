import 'package:Core/screens/home.dart';
import 'package:Core/screens/layout/tab/models/tab_page.dart';
import 'package:Core/screens/layout/tab/models/tab_selector.dart';
import 'package:Core/screens/thongbao_screen.dart';
import 'package:Core/screens/thongtin_canhan_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_svg/flutter_svg.dart';

// TODO
/// Hướng dẫn cấu hình
/// [AppTab]: đặt tên tab cho dễ gọi, tên index trùng với [tabSelector] để map
/// [tabSelector]: cấu hình các danh sách menu index trùng với [AppTab]
///
///

abstract class TabState extends Equatable {
  final AppTab tab = AppTab.DANHMUC;

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class UpdateTabPage extends TabState {
  final AppTab tab;
  UpdateTabPage({this.tab});

  @override
  // TODO: implement props
  List<Object> get props => [tab];
}

class JumbToTabPage extends TabState {
  final AppTab tab;
  JumbToTabPage({this.tab});

  @override
  // TODO: implement props
  List<Object> get props => [tab];
}

enum AppTab { LIBRARY, DANHMUC, THONGBAO, TAIKHOAN }

final List<TabSelectorModel> tabSelector = [
  TabSelectorModel(
    tab: AppTab.LIBRARY,
    tabPage: TabPage(
        page: HomePage(),
        icon: SvgPicture.asset('assets/tabs/home_white.svg'),
        iconActive: SvgPicture.asset('assets/tabs/home.svg'),
        id: "1",
        text: 'tab_1'),
  ),
  TabSelectorModel(
    tab: AppTab.THONGBAO,
    tabPage: TabPage(
        page: ThongBaoScreen(),
        icon: SvgPicture.asset('assets/tabs/notify_white.svg'),
        iconActive: SvgPicture.asset('assets/tabs/notify.svg'),
        id: "2",
        text: 'tab_3'),
  ),
  TabSelectorModel(
    tab: AppTab.TAIKHOAN,
    tabPage: TabPage(
        page: ThongTinCaNhanScreen(),
        icon: SvgPicture.asset(
          'assets/tabs/user_white.svg',
        ),
        iconActive: SvgPicture.asset('assets/tabs/user.svg'),
        id: "4",
        text: 'tab_4'),
  ),
];
