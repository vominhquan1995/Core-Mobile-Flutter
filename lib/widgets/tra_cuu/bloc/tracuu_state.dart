import 'package:Midas/widgets/tra_cuu/models/tracuu_model.dart';
import 'package:equatable/equatable.dart';

abstract class TracuuState extends Equatable {
  const TracuuState();
  @override
  List<Object> get props => [];
}

class InitialTracuuState extends TracuuState {}

class LoadedTracuuState extends TracuuState {
  final List<TraCuuHeader> list;

  LoadedTracuuState({this.list});

  @override
  // TODO: implement props
  List<Object> get props => [list];
}

class ErrorTracuuState extends TracuuState {
  final e;
  ErrorTracuuState({this.e});

  @override
  // TODO: implement props
  List<Object> get props => [e];
}
