part of 'detail_product_bloc.dart';

abstract class DetailProductEvent extends Equatable {
  const DetailProductEvent();
}

class GetData extends DetailProductEvent {
  String sanPhamId;
  bool isPrivate;
  GetData({this.sanPhamId, this.isPrivate});
  @override
  List<Object> get props => [sanPhamId, isPrivate];
}
