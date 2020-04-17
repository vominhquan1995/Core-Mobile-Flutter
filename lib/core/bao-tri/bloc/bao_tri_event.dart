import 'package:equatable/equatable.dart';

abstract class BaoTriEvent extends Equatable {
  const BaoTriEvent([props]);
}

class BaoTriStart extends BaoTriEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CoBaoTri extends BaoTriEvent {
  final String message;

  CoBaoTri(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class KhongBaoTri extends BaoTriEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RestartBaoTri extends BaoTriEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
