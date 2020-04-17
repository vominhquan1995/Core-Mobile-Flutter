import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:Core/core/authentication/models/profile_model.dart';

@immutable
abstract class MenuEvent extends Equatable {
  const MenuEvent();
}

class SaveListMenu extends MenuEvent {
  final List<String> menuList;

  /// Loại user
  final String loai;
  SaveListMenu({@required this.menuList, this.loai});

  @override
  String toString() => 'Save { List Menu: ${menuList.length} }';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RemoveMenu extends MenuEvent {
  @override
  String toString() => 'Remove Menu';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class GetMenu extends MenuEvent {
  final Profile profile;
  GetMenu({@required this.profile});
  @override
  String toString() => 'Get Menu';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
