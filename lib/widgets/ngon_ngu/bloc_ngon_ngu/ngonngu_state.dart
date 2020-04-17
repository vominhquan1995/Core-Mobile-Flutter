part of 'ngonngu_bloc.dart';

abstract class NgonnguState extends Equatable {
  const NgonnguState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NgonnguInitial extends NgonnguState {}

class NgonNguLoaded extends NgonnguState {
  final List<QuocGiaModel> list;
  final QuocGiaModel selected;

  NgonNguLoaded({
    this.list,
    this.selected,
  });

  @override
  // TODO: implement props
  List<Object> get props => [list, selected];
}
