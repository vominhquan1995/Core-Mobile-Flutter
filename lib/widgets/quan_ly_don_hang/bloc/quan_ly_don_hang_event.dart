part of 'quan_ly_don_hang_bloc.dart';

@immutable
abstract class QuanLyDonHangEvent extends Equatable {
  const QuanLyDonHangEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetData extends QuanLyDonHangEvent {
  @override
  String toString() {
    // TODO: implement toString
    return 'Get Data Đơn hàng';
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}
class GetOneData extends QuanLyDonHangEvent {
  final int id;

  GetOneData({this.id});
  @override
  String toString() {
    // TODO: implement toString
    return 'Get Data Đơn hàng';
  }

}

class GetMoreData extends QuanLyDonHangEvent {
  @override
  String toString() {
    // TODO: implement toString
    return 'GetMore Data ';
  }
}

