import 'dart:async';

import 'package:Midas/widgets/detail_product/service/service_detail_product.dart';
import 'package:Midas/widgets/my_library/models/sanpham_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  final DetailProductService service;
  DetailProductBloc({@required this.service});
  @override
  DetailProductState get initialState => DetailProductInitial();

  @override
  Stream<DetailProductState> mapEventToState(
    DetailProductEvent event,
  ) async* {
    if (event is GetData) {
      SanPhamModel detail;
      if (event.isPrivate) {
        detail = await service.getDataDetailPrivate(event.sanPhamId);
      } else {
        detail = await service.getDataDetail(event.sanPhamId);
      }
      yield LoadedData(detail: detail);
    }
  }
}
