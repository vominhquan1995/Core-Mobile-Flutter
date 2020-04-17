import 'package:Core/core/cart/model/cart_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartState {
  const CartState();
  @override
  List<Object> get props => [];
}

class InitialCartState extends CartState {}

class LoadedCartState extends CartState {
  final List<CartItemModel> list;
  final num total;
  LoadedCartState({this.list, this.total});

  @override
  List<Object> get props => [list, total];
}

class ErrorCartState extends CartState {
  final e;
  ErrorCartState({this.e});
  @override
  String toString() => '$runtimeType $e';
  @override
  List<Object> get props => [e];
}

class EmptyCartState extends CartState {
  @override
  List<Object> get props => [];
}
