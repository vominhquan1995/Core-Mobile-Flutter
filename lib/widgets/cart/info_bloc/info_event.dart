import 'package:Core/core/cart/model/cart_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class InfoEvent {
  const InfoEvent();
  @override
  List<Object> get props => [];
}

class GetCartInfo extends InfoEvent {
  GetCartInfo();
  @override
  List<Object> get props => [];
}

class SubmitCartInfo extends InfoEvent {
  final CartInfoModel info;
  SubmitCartInfo({this.info});
  @override
  List<Object> get props => [info];
}
