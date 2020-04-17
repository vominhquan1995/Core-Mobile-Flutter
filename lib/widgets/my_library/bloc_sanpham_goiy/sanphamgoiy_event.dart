part of 'sanphamgoiy_bloc.dart';

abstract class SanphamgoiyEvent extends Equatable {
  const SanphamgoiyEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetDanhSachPhamGoiY extends SanphamgoiyEvent {}

class GetMoreDanhSachPhamGoiY extends SanphamgoiyEvent {}
