part of 'quocgia_bloc.dart';

abstract class QuocgiaState extends Equatable {
  @override
  List<Object> get props => [];
}

class QuocgiaInitial extends QuocgiaState {}

class DanhSachQuocgia extends QuocgiaState {
  final List<QuocGiaModel> list;
  final QuocGiaModel selected;
  final QuocGiaModel confirm;

  DanhSachQuocgia({this.list, this.selected, this.confirm});

  @override
  String toString() => '$runtimeType $list select: $selected confirm: $confirm';

  @override
  // TODO: implement props
  List<Object> get props => [list, selected, confirm];
}

class EmptyQuocGia extends QuocgiaState {}

class LoadingQuocGiaState extends QuocgiaState {}
