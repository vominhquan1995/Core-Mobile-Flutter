part of 'lich_su_rut_diem_bloc.dart';

@immutable
abstract class LichSuRutDiemState {}

class LichSuDiemInitial extends LichSuRutDiemState {}

class LichSuRutDiemInitial extends LichSuRutDiemState {
  @override
  String toString() => 'InitialLichSuDiem';
}

class ErrorLichSuRutDiemState extends LichSuRutDiemState {
  final e;
  ErrorLichSuRutDiemState({this.e});
  @override
  String toString() => 'ErrorLichSuRutDiemState';

  @override
  // TODO: implement props
  List<Object> get props => [e];
}

class EmptyLichSuDiem extends LichSuRutDiemState {
  @override
  String toString() => 'EmptyLichSuDiem';
}

class LoadedLichSuRutDiem extends LichSuRutDiemState {
  final List<LichSuRutDiemModel> listDiem;
  final bool hasReachedMax;

  LoadedLichSuRutDiem({this.listDiem, this.hasReachedMax});

  LoadedLichSuRutDiem copyWith(
      {List<LichSuRutDiemModel> listDiem, bool hasReachedMax}) {
    return LoadedLichSuRutDiem(
      listDiem: listDiem ?? this.listDiem,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [listDiem, hasReachedMax];
}
