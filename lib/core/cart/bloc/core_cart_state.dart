import 'package:meta/meta.dart';

@immutable
abstract class CoreCartState {
  CoreCartState();

  List<Object> get props => [];
}

class InitialCoreCartState extends CoreCartState {
  @override
  String toString() => 'InitialCoreCartState';
}

class InitCartBadgeSuccessState extends CoreCartState {
  int count;

  InitCartBadgeSuccessState({@required this.count});

  @override
  String toString() => 'IniSuccessState';

  @override
  // TODO: implement props
  List<Object> get props => [count];
}

class InitCartBadgeFailState extends CoreCartState {
  @override
  String toString() => 'InitFailState';
  @override
  List<Object> get props => [];
}

// class RegisTokenSuccessState extends CoreCartState {
//   @override
//   String toString() => 'RegisTokenSuccessState';
//   @override
//   List<Object> get props => [];
// }

// class RedirectPageState extends CoreCartState {
//   final ItemNotification data;
//   RedirectPageState({this.data});
//   @override
//   String toString() => 'RedirectPageState';
//   @override
//   List<Object> get props => [data];
// }
