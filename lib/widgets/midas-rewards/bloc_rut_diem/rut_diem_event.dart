part of 'rut_diem_bloc.dart';

@immutable
abstract class RutDiemEvent {}

class TaoYeuCauEvent extends RutDiemEvent {
  final String so_tien_rut;
  final num rutHoaHongMin;
  TaoYeuCauEvent({this.rutHoaHongMin, this.so_tien_rut});

  @override
  String toString() {
    // TODO: implement toString
    return 'Tạo yêu cầu rút';
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}
