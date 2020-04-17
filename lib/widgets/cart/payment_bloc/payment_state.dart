import 'package:Midas/core/cart/model/cart_model.dart';
import 'package:equatable/equatable.dart';

abstract class PaymentState {
  const PaymentState();
  @override
  List<Object> get props => [];
}

class InitialPaymentState extends PaymentState {}

class LoadedPaymentState extends PaymentState {
  final CartInfoModel info;
  final num total;
  LoadedPaymentState({this.info, this.total});

  @override
  List<Object> get props => [info, total];
}

class ErrorPaymentState extends PaymentState {
  final e;
  ErrorPaymentState({this.e});
  @override
  String toString() => '$runtimeType $e';
  @override
  List<Object> get props => [e];
}
