part of 'hoa_hong_ca_nhan_bloc.dart';

@immutable
abstract class HoaHongCaNhanState {}

class HoaHongCaNhanInitial extends HoaHongCaNhanState {}

class InitialHoaHongCaNhanState extends HoaHongCaNhanState {
  @override
  String toString() => 'InitialHoaHongCaNhan';
}

class ErrorHoaHongCaNhanState extends HoaHongCaNhanState {
  final e;
  ErrorHoaHongCaNhanState({this.e});
  @override
  String toString() => 'ErrorHoaHongCaNhanState';

  @override
  // TODO: implement props
  List<Object> get props => [e];
}

class EmptyHoaHongCaNhan extends HoaHongCaNhanState {
  @override
  String toString() => 'EmptyHoaHongCaNhan';
}

class LoadedHoaHongCaNhan extends HoaHongCaNhanState {
  final String tongHoaHong;

  LoadedHoaHongCaNhan({this.tongHoaHong});

  LoadedHoaHongCaNhan copyWith({String tongHoaHong}) {
    return LoadedHoaHongCaNhan(
      tongHoaHong: tongHoaHong ?? this.tongHoaHong,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [tongHoaHong];
}
