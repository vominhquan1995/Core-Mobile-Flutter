import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MaintenancePageEvent extends Equatable {
  const MaintenancePageEvent();
}

class KiemTraBaoTriPage extends MaintenancePageEvent {
  final String dataChange;
  final bool tinhtrang;

  KiemTraBaoTriPage({this.dataChange, this.tinhtrang});

  @override
  String toString() => 'MaintenanceStart';

  @override
  // TODO: implement props
  List<Object> get props => [dataChange, tinhtrang];
}

class CoBaoTriPage extends MaintenancePageEvent {
  final dynamic data;
  CoBaoTriPage({this.data});
  @override
  String toString() => 'CoBaoTriPage';

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class StartBaoTriPage extends MaintenancePageEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class KhongBaoTriPage extends MaintenancePageEvent {
  @override
  String toString() => 'KhongBaoTriPage';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
