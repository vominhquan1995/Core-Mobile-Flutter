import 'dart:async';
import 'package:Core/core/cart/service/cart_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'index.dart';

class CoreCartBloc extends Bloc<CoreCartEvent, CoreCartState> {
  CoreCartService service;
  CoreCartBloc({@required this.service});
  @override
  CoreCartState get initialState => InitialCoreCartState();
  @override
  Stream<CoreCartState> mapEventToState(
    CoreCartEvent event,
  ) async* {
    if (event is InitCartBadge) {
      final cart = await service.getCart();
      yield InitCartBadgeSuccessState(count: cart.length ?? 0);
    }
    if (event is AddToCart || event is RemoveCartItem || event is ClearCart) {
      final cart = await service.getCart();
      yield InitCartBadgeSuccessState(count: cart.length ?? 0);
    }
    // if (event is RedirectPage) {
    //   yield RedirectPageState(data: event.data);
    // }
  }
}
