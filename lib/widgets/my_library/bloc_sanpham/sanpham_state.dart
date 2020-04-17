part of 'sanpham_bloc.dart';

abstract class SanPhamState extends Equatable {
  const SanPhamState();
  @override
  List<Object> get props => [];
}

class SanPhamInitial extends SanPhamState {}

class SanPhamLoaded extends SanPhamState {
  final List<SanPhamModel> list;
  final bool hasReachedMax;
  SanPhamLoaded({this.list, this.hasReachedMax});

  @override
  // TODO: implement props
  List<Object> get props => [list, hasReachedMax];
}

class SanPhamEmpty extends SanPhamState {}

class SanPhamError extends SanPhamState {
  final e;
  SanPhamError({this.e});
  @override
  // TODO: implement props
  List<Object> get props => [e];
}
