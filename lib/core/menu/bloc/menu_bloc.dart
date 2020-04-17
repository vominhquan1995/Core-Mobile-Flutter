import 'dart:async';
import 'package:bloc/bloc.dart';
import './index.dart';

enum MENU_ROLE {
  ROLE_NHAN_VIEN,
  ROLE_SINH_VIEN,
  ROLE_GIANG_VIEN,
  ROLE_PHU_HUYNH,
  ROLE_UNINIT,
}

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  @override
  MenuState get initialState => InitialMenuState();

  @override
  Stream<MenuState> mapEventToState(
    MenuEvent event,
  ) async* {
    // TODO: Add Logic

    if (event is GetMenu) {
      try {
        MENU_ROLE menu_role = MENU_ROLE.ROLE_UNINIT;
        // menu_role = _getRole(event.profile.loai);
        yield GetDanhSachMenuState(
            menuList: event.profile.menuID, menu_role: menu_role);
      } catch (e) {
        print(e);
        yield RemoveMenuState();
      }
    }

    if (event is RemoveMenu) {
      yield RemoveMenuState();
    }
  }

  MENU_ROLE _getRole(String roleString) {
    switch (roleString) {
      case 'S':
        return MENU_ROLE.ROLE_SINH_VIEN;
      case 'N':
        return MENU_ROLE.ROLE_NHAN_VIEN;

      case 'G':
        return MENU_ROLE.ROLE_GIANG_VIEN;
      case 'P':
        return MENU_ROLE.ROLE_PHU_HUYNH;

      default:
        return MENU_ROLE.ROLE_UNINIT;
    }
  }
}
