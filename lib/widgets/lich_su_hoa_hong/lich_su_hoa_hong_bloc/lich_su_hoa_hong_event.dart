part of 'lich_su_hoa_hong_bloc.dart';

@immutable
abstract class LichSuHoaHongEvent extends Equatable {
  const LichSuHoaHongEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetData extends LichSuHoaHongEvent {
  final String tu_ngay;
  final String toi_ngay;

  GetData({this.tu_ngay, this.toi_ngay});

  @override
  String toString() {
    // TODO: implement toString
    return 'Get Data Đơn hàng';
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetMoreData extends LichSuHoaHongEvent {
  final int offset;
  final String tu_ngay;
  final String toi_ngay;

  GetMoreData({this.offset, this.tu_ngay, this.toi_ngay});
  @override
  String toString() {
    // TODO: implement toString
    return 'GetMore Data ';
  }
}
