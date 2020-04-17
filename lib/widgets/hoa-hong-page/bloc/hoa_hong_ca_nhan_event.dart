part of 'hoa_hong_ca_nhan_bloc.dart';

@immutable
abstract class HoaHongCaNhanEvent extends Equatable {
  const HoaHongCaNhanEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetDataHoaHong extends HoaHongCaNhanEvent {
  @override
  String toString() {
    // TODO: implement toString
    return 'Get Data Tổng hoa hồng';
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}
