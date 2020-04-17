import 'package:Midas/core/cart/model/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CoreCartEvent extends Equatable {}

class InitCartBadge extends CoreCartEvent {
  final BuildContext context;
  InitCartBadge({this.context});
  @override
  String toString() => 'initCartBadge';
  @override
  List<Object> get props => [context];
}

class AddToCart extends CoreCartEvent {
  final CartItemModel item;
  AddToCart({this.item});
  @override
  String toString() => 'AddToCart';
  @override
  List<Object> get props => [item];
}

class RemoveCartItem extends CoreCartEvent {
  final CartItemModel item;
  RemoveCartItem({this.item});
  @override
  String toString() => 'RemoveCartItem';
  @override
  List<Object> get props => [item];
}

class ClearCart extends CoreCartEvent {
  final CartItemModel item;
  ClearCart({this.item});
  @override
  String toString() => 'ClearCart';
  @override
  List<Object> get props => [item];
}

// class ReInitToken extends CoreCartEvent {
//   final BuildContext context;
//   ReInitToken({this.context});
//   @override
//   String toString() => 'ReInitToken';
//   @override
//   List<Object> get props => [context];
// }

// class RedirectPage extends CoreCartEvent {
//   final ItemCart data;
//   RedirectPage({this.data});
//   @override
//   String toString() => 'RedirectPage';
//   @override
//   List<Object> get props => [data];
// }
