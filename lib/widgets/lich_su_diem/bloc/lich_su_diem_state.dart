part of 'lich_su_diem_bloc.dart';

@immutable
abstract class LichSuDiemState {}

class LichSuDiemInitial extends LichSuDiemState {}

class InitialLichSuDiemState extends LichSuDiemState {
  @override
  String toString() => 'InitialLichSuDiem';
}

class ErrorLichSuDiemState extends LichSuDiemState {
  final e;
  ErrorLichSuDiemState({this.e});
  @override
  String toString() => 'ErrorLichSuDiemState';

  @override
  // TODO: implement props
  List<Object> get props => [e];
}

class EmptyLichSuDiem extends LichSuDiemState {
  @override
  String toString() => 'EmptyLichSuDiem';
}

class LoadedLichSuDiem extends LichSuDiemState {
  final List<LichSuDiemModel> listDiem;
  final bool hasReachedMax;

  LoadedLichSuDiem({this.listDiem, this.hasReachedMax});

  LoadedLichSuDiem copyWith(
      {List<LichSuDiemModel> listDiem, bool hasReachedMax}) {
    return LoadedLichSuDiem(
      listDiem: listDiem ?? this.listDiem,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [listDiem, hasReachedMax];
}
