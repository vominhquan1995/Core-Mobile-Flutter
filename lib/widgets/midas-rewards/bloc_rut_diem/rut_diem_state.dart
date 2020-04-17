part of 'rut_diem_bloc.dart';

@immutable
abstract class RutDiemState {}

class RutDiemInitial extends RutDiemState {}

class DoneTaoYeuCauRutDiemState extends RutDiemState {
  @override
  String toString() => 'Done TaoYeuCau RutDiemState';
}

class ErrorTaoYeuCauRutDiemState extends RutDiemState {
  final e;
  ErrorTaoYeuCauRutDiemState({this.e});
  @override
  String toString() => 'Error TaoYeuCau RutDiemState';
}