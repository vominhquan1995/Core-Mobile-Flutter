import 'dart:async';
import 'dart:math';
import 'package:Midas/core/cart/model/cart_model.dart';
import 'package:Midas/widgets/cart/cart_bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:Midas/widgets/cart/service/cart_service.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartService service;
  CartBloc({@required this.service});

  // @override
  // Stream<CartState> transformEvents(
  //   Stream<CartEvent> events,
  //   Stream<CartState> Function(CartEvent event) next,
  // ) {
  //   return super.transformEvents(
  //     (events as Observable<CartEvent>).debounceTime(
  //       Duration(milliseconds: 500),
  //     ),
  //     next,
  //   );
  // }

  @override
  CartState get initialState => InitialCartState();

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    // TODO: Add Logic
    ///
    if (event is GetDataCart) {
      try {
        //first page last nofifi id is 0
        var list;
        if (event.isPrivate) {
          list = await service.getCartItemPrivate();
        } else {
          list = await service.getCartItem();
        }
        var total = list.isEmpty
            ? 0
            : list
                .map((f) => f.dongia * f.soluong)
                .reduce((value, elem) => value + elem);
        yield list.isEmpty
            ? EmptyCartState()
            : LoadedCartState(list: list, total: total);
      } catch (e) {
        yield ErrorCartState(e: e);
      }
    }

    if (event is UpdateQuantity && state is LoadedCartState) {
      try {
        //first page last nofifi id is 0
        final List<CartItemModel> data = (state as LoadedCartState).list;
        final dataU = data.where((f) => f.uid == event.item.uid).toList();
        if (dataU.isNotEmpty) {
          await service.updateQuantityCart(dataU[0], event.increase);
          final l = data.map((f) {
            return f.uid == event.item.uid
                ? CartItemModel(
                    uid: dataU[0].uid,
                    dongia: dataU[0].dongia,
                    dongiagoc: dataU[0].dongiagoc,
                    percent: dataU[0].percent,
                    sanphamid: dataU[0].sanphamid,
                    masanpham: dataU[0].masanpham,
                    tensanpham: dataU[0].tensanpham,
                    mota: dataU[0].mota,
                    hinhdaidien: dataU[0].hinhdaidien,
                    soluong:
                        max(dataU[0].soluong + (event.increase ? 1 : -1), 1),
                    iskhuyenmai: dataU[0].iskhuyenmai,
                  )
                : f;
          }).toList();

          final total = l.isEmpty
              ? 0
              : l
                  .map((f) => f.dongia * f.soluong)
                  .reduce((value, elem) => value + elem);
          yield LoadedCartState(list: l, total: total);
          // yield EmptyCartState();
        }
      } catch (e) {
        yield ErrorCartState(e: e);
      }
    }
    if (event is RemoveItem && state is LoadedCartState) {
      try {
        //first page last nofifi id is 0
        final List<CartItemModel> data = (state as LoadedCartState).list;
        final dataU = data.where((f) => f.uid == event.item.uid).toList();
        if (dataU.isNotEmpty) {
          await service.removeItem(dataU[0]);
          data.removeWhere((f) => f.uid == event.item.uid);
          print(data);
          print(data.isEmpty);
          final total = data.isEmpty
              ? 0
              : data
                  .map((f) => f.dongia * f.soluong)
                  .reduce((value, elem) => value + elem);
          yield data.isEmpty
              ? EmptyCartState()
              : LoadedCartState(list: data, total: total);
          // yield EmptyCartState();
        }
      } catch (e) {
        yield ErrorCartState(e: e);
      }
    }
    // if (event is GetCartInfo) {
    //   try {
    //     //first page last nofifi id is 0
    //     var info = await service.getInfo();
    //     yield info ? EmptyCartState() : LoadedCartState(info: info);
    //   } catch (e) {
    //     yield ErrorCartState(e: e);
    //   }
    // }
  }
}
