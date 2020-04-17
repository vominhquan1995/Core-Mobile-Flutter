import 'package:Core/core/cart/model/cart_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PaymentEvent {
  const PaymentEvent();
  @override
  List<Object> get props => [];
}

class GetCartInfo extends PaymentEvent {
  GetCartInfo();
  @override
  List<Object> get props => [];
}

class SubmitCartInfo extends PaymentEvent {
  final CartInfoModel info;
  final num total;
  SubmitCartInfo({this.info, this.total});
  @override
  List<Object> get props => [info, total];
}
