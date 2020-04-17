part of 'lich_su_diem_bloc.dart';

@immutable
abstract class LichSuDiemEvent extends Equatable {
  const LichSuDiemEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetData extends LichSuDiemEvent {
  @override
  String toString() {
    // TODO: implement toString
    return 'Get Data Đơn hàng';
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetMoreData extends LichSuDiemEvent {
  final int offset;

  GetMoreData({this.offset});
  @override
  String toString() {
    // TODO: implement toString
    return 'GetMore Data ';
  }
}
