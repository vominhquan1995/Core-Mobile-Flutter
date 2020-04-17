part of 'sanphamgoiy_bloc.dart';

abstract class SanphamgoiyState extends Equatable {
  const SanphamgoiyState();
  @override
  List<Object> get props => [];
}

class SanphamgoiyInitial extends SanphamgoiyState {}

class SanPhamGoiYLoaded extends SanphamgoiyState {
  final List<SanPhamModel> list;
  final bool hasReachedMax;
  SanPhamGoiYLoaded({this.list, this.hasReachedMax});

  @override
  // TODO: implement props
  List<Object> get props => [list, hasReachedMax];
}

class SanPhamGoiYEmpty extends SanphamgoiyState {}

class SanPhamGoiYError extends SanphamgoiyState {
  final e;
  SanPhamGoiYError({this.e});
  @override
  // TODO: implement props
  List<Object> get props => [e];
}
