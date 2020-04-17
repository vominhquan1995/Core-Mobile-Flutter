import 'package:Core/core/cart/model/cart_model.dart';
import 'package:equatable/equatable.dart';

abstract class InfoState {
  const InfoState();
  @override
  List<Object> get props => [];
}

class InitialInfoState extends InfoState {}

class LoadedInfoState extends InfoState {
  final CartInfoModel info;
  LoadedInfoState({this.info});

  @override
  List<Object> get props => [info];
}

class ErrorInfoState extends InfoState {
  final e;
  ErrorInfoState({this.e});
  @override
  String toString() => '$runtimeType $e';
  @override
  List<Object> get props => [e];
}
