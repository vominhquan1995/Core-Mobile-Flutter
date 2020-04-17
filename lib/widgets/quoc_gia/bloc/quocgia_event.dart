part of 'quocgia_bloc.dart';

abstract class QuocgiaEvent extends Equatable {
  const QuocgiaEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetQuocGia extends QuocgiaEvent {}

class SelectQuocGia extends QuocgiaEvent {
  final QuocGiaModel quocGia;

  SelectQuocGia({this.quocGia});

  @override
  // TODO: implement props
  List<Object> get props => [quocGia];
}

class ConfirmQuocGia extends QuocgiaEvent {
  final QuocGiaModel quocGia;

  ConfirmQuocGia({this.quocGia});

  @override
  // TODO: implement props
  List<Object> get props => [quocGia];
}

class CheckQuocGia extends QuocgiaEvent {}

class LoadingQuocGiaEvent extends QuocgiaEvent {}
