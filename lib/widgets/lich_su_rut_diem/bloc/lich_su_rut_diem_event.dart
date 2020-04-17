part of 'lich_su_rut_diem_bloc.dart';


@immutable
abstract class LichSuRutDiemEvent extends Equatable {
  const LichSuRutDiemEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetData extends LichSuRutDiemEvent {
  @override
  String toString() {
    // TODO: implement toString
    return 'Get Data Đơn hàng';
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetMoreData extends LichSuRutDiemEvent {
  final int offset;

  GetMoreData({this.offset});
  @override
  String toString() {
    // TODO: implement toString
    return 'GetMore Data ';
  }
}
