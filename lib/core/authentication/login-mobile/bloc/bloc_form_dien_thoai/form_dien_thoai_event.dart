import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FormDienThoaiEvent extends Equatable {
  const FormDienThoaiEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

/* 
  kiem tra dữ liệu của form
 */
class SendNumber extends FormDienThoaiEvent {
  final String number;
  final String iconLang;
  final String codeLang;
  final bool is_call_api;

  SendNumber({this.number, this.iconLang, this.is_call_api, this.codeLang});
  @override
  String toString() {
    return 'Check data form';
  }
}

class WaitingFormDienThoai extends FormDienThoaiEvent {
  final loading;

  WaitingFormDienThoai({this.loading});

  @override
  String toString() {
    return 'WaitingForm';
  }
}

/* 
chuyển trang khi thành công
 */
class NavigatorSmsCode extends FormDienThoaiEvent {
  final String number;

  NavigatorSmsCode({this.number});

  @override
  String toString() => 'NavigatorSmsCode';
}
