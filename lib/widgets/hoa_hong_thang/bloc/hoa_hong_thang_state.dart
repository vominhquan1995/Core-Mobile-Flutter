part of 'hoa_hong_thang_bloc.dart';

@immutable
abstract class HoaHongThangState {}

class HoaHongThangInitial extends HoaHongThangState {}

class InitialHoaHongThangState extends HoaHongThangState {
  @override
  String toString() => 'InitialHoaHongThang';
}

class ErrorHoaHongThangState extends HoaHongThangState {
  final e;
  ErrorHoaHongThangState({this.e});
  @override
  String toString() => 'ErrorHoaHongThangState';

  @override
  // TODO: implement props
  List<Object> get props => [e];
}

class EmptyHoaHongThang extends HoaHongThangState {
  @override
  String toString() => 'EmptyHoaHongThang';
}

class LoadedHoaHongThang extends HoaHongThangState {
  final List<HoaHongThangModel> listHoaHong;
  final bool hasReachedMax;

  LoadedHoaHongThang({this.listHoaHong, this.hasReachedMax});

  LoadedHoaHongThang copyWith(
      {List<HoaHongThangModel> listHoaHong, bool hasReachedMax}) {
    return LoadedHoaHongThang(
      listHoaHong: listHoaHong ?? this.listHoaHong,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [listHoaHong, hasReachedMax];
}
