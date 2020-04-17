part of 'huong_dan_bloc.dart';

@immutable
abstract class HuongDanState {}

class HuongDanInitial extends HuongDanState {}

class InitialHuongDanState extends HuongDanState {}

class LoadedHuongDanState extends HuongDanState {
  final HuongDanHeader list;

  LoadedHuongDanState({this.list});

  @override
  // TODO: implement props
  List<Object> get props => [list];
}

class ErrorHuongDanState extends HuongDanState {
  final e;
  ErrorHuongDanState({this.e});

  @override
  // TODO: implement props
  List<Object> get props => [e];
}