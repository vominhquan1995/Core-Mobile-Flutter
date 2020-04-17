import 'package:equatable/equatable.dart';

abstract class ErrorhandleState extends Equatable {
  const ErrorhandleState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitialErrorhandleState extends ErrorhandleState {}

class KhongCoQuyen extends ErrorhandleState {
  @override
  String toString() => 'KhongCoQuyen';
}

class KhongCoToken extends ErrorhandleState {
  @override
  String toString() => 'KhongCoToken';
}
