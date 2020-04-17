part of 'hoa_hong_thang_bloc.dart';


@immutable
abstract class HoaHongThangEvent extends Equatable {
  const HoaHongThangEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetData extends HoaHongThangEvent {
  @override
  String toString() {
    // TODO: implement toString
    return 'Get Data Đơn hàng';
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetMoreData extends HoaHongThangEvent {
  final int offset;

  GetMoreData({this.offset});
  @override
  String toString() {
    // TODO: implement toString
    return 'GetMore Data ';
  }
}