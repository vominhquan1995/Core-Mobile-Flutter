import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ErrorhandleEvent extends Equatable {
  const ErrorhandleEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ErrorCustom extends ErrorhandleEvent {
  final dynamic e;

  ErrorCustom(this.e);
  @override
  String toString() => 'ErrorHandle $e';

  @override
  // TODO: implement props
  List<Object> get props => [e];
}

class KhongCoLoi extends ErrorhandleEvent {}
