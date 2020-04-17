import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:Midas/core/menu/bloc/index.dart';

@immutable
abstract class MenuState extends Equatable {
  const MenuState([List props = const []]);
}

class InitialMenuState extends MenuState {
  @override
  String toString() => 'initMenu';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class GetDanhSachMenuState extends MenuState {
  List<String> menuList;
  MENU_ROLE menu_role;
  GetDanhSachMenuState({this.menuList = const [], this.menu_role});
  @override
  String toString() => 'GetMenu';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RemoveMenuState extends MenuState {
  @override
  String toString() => 'RemoveMenu';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
