part of 'sanpham_bloc.dart';

abstract class SanPhamEvent extends Equatable {
  const SanPhamEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetDanhSachPham extends SanPhamEvent {
  final String key;
  GetDanhSachPham({@required this.key});

  @override
  // TODO: implement props
  List<Object> get props => [key];

  @override
  String toString() => '$runtimeType $key';
}

class GetMoreDanhSachPham extends SanPhamEvent {
  final String key;
  GetMoreDanhSachPham({@required this.key});

  @override
  // TODO: implement props
  List<Object> get props => [key];

  @override
  String toString() => '$runtimeType $key';
}

class RefreshDanhSachPham extends SanPhamEvent {
  final String key;
  RefreshDanhSachPham({@required this.key});

  @override
  // TODO: implement props
  List<Object> get props => [key];

  @override
  String toString() => '$runtimeType $key';
}
