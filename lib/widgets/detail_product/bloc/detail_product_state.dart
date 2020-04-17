part of 'detail_product_bloc.dart';

abstract class DetailProductState extends Equatable {
  const DetailProductState();
}

class DetailProductInitial extends DetailProductState {
  @override
  List<Object> get props => [];
}

class LoadedData extends DetailProductState {
  SanPhamModel detail;
  LoadedData({this.detail});
  @override
  List<Object> get props => [detail];
}
