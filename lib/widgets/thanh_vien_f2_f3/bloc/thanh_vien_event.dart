part of 'thanh_vien_bloc.dart';

@immutable
abstract class ThanhVienEvent extends Equatable {
  const ThanhVienEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetData extends ThanhVienEvent {
  @override
  String toString() {
    // TODO: implement toString
    return 'Get Data Đơn hàng';
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetMoreData extends ThanhVienEvent {
  @override
  String toString() {
    // TODO: implement toString
    return 'GetMore Data ';
  }
}

class SearchEvent extends ThanhVienEvent {
  final String body;

  SearchEvent(this.body);
  @override
  String toString() {
    // TODO: implement toString
    return 'Search Data ';
  }
}
