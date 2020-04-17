import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MaintenancePageState extends Equatable {
  const MaintenancePageState();
}

class InitialMaintenancePageState extends MaintenancePageState {
  @override
  String toString() => 'InitialMaintenancePageState';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class GetMaintenancePageState extends MaintenancePageState {
  final data;
  GetMaintenancePageState({this.data});
  @override
  String toString() => 'GetMaintenancePageState';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ErrorMaintenancePageState extends MaintenancePageState {
  @override
  String toString() => 'ErrorMaintenancePageState';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
