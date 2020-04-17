import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BlocUploadImageState extends Equatable {
  const BlocUploadImageState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitialBlocUploadImageState extends BlocUploadImageState {}

class SuccessUploadImageState extends BlocUploadImageState {
  final String image;
  SuccessUploadImageState(this.image);
  @override
  String toString() => 'SuccessUploadImageState $image';

  @override
  // TODO: implement props
  List<Object> get props => [image];
}

class ErrorBlocUploadImageState extends BlocUploadImageState {
  @override
  String toString() => 'ErrorBlocUploadImageState';
}

class WaittingBlocUploadImageState extends BlocUploadImageState {
  @override
  String toString() => 'WaittingBlocUploadImageState';
}
