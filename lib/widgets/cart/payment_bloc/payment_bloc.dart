import 'dart:async';
import 'package:Core/widgets/cart/payment_bloc/payment_event.dart';
import 'package:Core/widgets/cart/payment_bloc/payment_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:Core/widgets/cart/service/cart_service.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  CartService service;
  PaymentBloc({@required this.service});

  @override
  PaymentState get initialState => InitialPaymentState();

  @override
  Stream<PaymentState> mapEventToState(
    PaymentEvent event,
  ) async* {
    // TODO: Add Logic
    ///
    if (event is GetCartInfo) {
      try {
        //first page last nofifi id is 0
        var list = await service.getCartItemWithoutAPI();
        var total = list
            .map((f) => f.dongia * f.soluong)
            .reduce((value, elem) => value + elem);
        var info = await service.getPaymentInfo();
        yield info == null
            ? ErrorPaymentState()
            : LoadedPaymentState(info: info, total: total);
      } catch (e) {
        yield ErrorPaymentState(e: e);
      }
    }
  }
}
