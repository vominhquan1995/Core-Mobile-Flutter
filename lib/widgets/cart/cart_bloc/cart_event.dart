import 'package:Core/core/cart/model/cart_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CartEvent {
  const CartEvent();
  @override
  List<Object> get props => [];
}

class GetDataCart extends CartEvent {
  final List<CartItemModel> items;
  final bool isPrivate;
  GetDataCart({this.items, this.isPrivate});
  @override
  String toString() => '$runtimeType';
  @override
  List<Object> get props => [items, this.isPrivate];
}

class UpdateQuantity extends CartEvent {
  final CartItemModel item;
  final bool increase;
  UpdateQuantity({this.item, this.increase});
  @override
  String toString() => '$runtimeType';
  @override
  List<Object> get props => [item, increase];
}

class RemoveItem extends CartEvent {
  final CartItemModel item;
  RemoveItem({this.item});
  @override
  String toString() => '$runtimeType';
  @override
  List<Object> get props => [item];
}
