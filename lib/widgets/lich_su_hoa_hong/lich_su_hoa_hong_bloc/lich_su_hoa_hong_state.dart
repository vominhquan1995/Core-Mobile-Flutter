part of 'lich_su_hoa_hong_bloc.dart';

@immutable
abstract class LichSuHoaHongState {}

class LichSuHoaHongInitial extends LichSuHoaHongState {}

class InitialLichSuHoaHongState extends LichSuHoaHongState {
  @override
  String toString() => 'InitialLichSuHoaHong';
}

class ErrorLichSuHoaHongState extends LichSuHoaHongState {
  final e;
  ErrorLichSuHoaHongState({this.e});
  @override
  String toString() => 'ErrorLichSuHoaHongState';

  @override
  // TODO: implement props
  List<Object> get props => [e];
}

class EmptyLichSuHoaHong extends LichSuHoaHongState {
  @override
  String toString() => 'EmptyLichSuHoaHong';
}
class LoadingLichSuHoaHong extends LichSuHoaHongState {
  @override
  String toString() => 'EmptyLichSuHoaHong';
}

class LoadedLichSuHoaHong extends LichSuHoaHongState {
  final List<HoaHongModel> listHoaHong;
  final bool hasReachedMax;

  LoadedLichSuHoaHong({this.listHoaHong, this.hasReachedMax});

  LoadedLichSuHoaHong copyWith(
      {List<HoaHongModel> listHoaHong, bool hasReachedMax}) {
    return LoadedLichSuHoaHong(
      listHoaHong: listHoaHong ?? this.listHoaHong,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [listHoaHong, hasReachedMax];
}
