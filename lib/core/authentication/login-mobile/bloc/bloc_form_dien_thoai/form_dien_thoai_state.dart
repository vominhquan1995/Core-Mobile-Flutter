import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/* 
 trạng thái của bloc (dùng currentState cho bloc xử lý)
 */
@immutable
abstract class FormDienThoaiState extends Equatable {
  const FormDienThoaiState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitialFormDienThoaiState extends FormDienThoaiState {}

/* 
check data form
 */
class SendNumberState extends FormDienThoaiState {
  final code;
  final message;
  final iconLang;
  final codeLang;
  // dùng supper để đè lên
  SendNumberState({this.code, this.message, this.iconLang, this.codeLang})
      : super();

  SendNumberState copyWith({codeNew, messageNew, iconNew, codeLangNew}) {
    return SendNumberState(
        code: codeNew,
        message: messageNew,
        iconLang: iconNew,
        codeLang: codeLangNew);
  }

  @override
  String toString() => 'ValidFormDienThoaiState';
}

/* 
disable button
 */
class WaitingFormState extends FormDienThoaiState {
  final loading;

  WaitingFormState({this.loading}) : super();
  WaitingFormState copyWith({loadingNew}) {
    return WaitingFormState(loading: loadingNew || this.loading);
  }

  @override
  String toString() => 'WaitingFormState';
}

/* 
chuyển trang khi thành công
 */
class NavigatorSmsCodeState extends FormDienThoaiState {
  final String number;
  NavigatorSmsCodeState({this.number}) : super();
  @override
  String toString() => 'NavigatorSmsCodeState';
}
