import 'package:Midas/widgets/quoc_gia/models/quocgia_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../models/profile_model.dart';

/* 
 trạng thái của bloc (dùng currentState cho bloc xử lý)
 */
@immutable
abstract class FormSMSState extends Equatable {
  const FormSMSState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitialFormSMSState extends FormSMSState {
  @override
  String toString() {
    // TODO: implement toString
    return 'Preload list van ban';
  }
}

/* 
check data form
 */
class CheckValidFormSMSState extends FormSMSState {
  final code;
  final message;
  // dùng supper để đè lên
  CheckValidFormSMSState({this.code, this.message}) : super();

  CheckValidFormSMSState copyWith({
    codeOld,
    messageOld,
  }) {
    return CheckValidFormSMSState(
      code: codeOld,
      message: messageOld,
    );
  }

  @override
  String toString() => 'ValidFormSMSState';
}

/* 
disable button
 */
class DisableButtonFormSMSState extends FormSMSState {
  @override
  String toString() => 'DisableButton';
}

/* 
chuyển trang khi thành công
 */
class NavigatorSmsCodeState extends FormSMSState {
  final Profile user;
  final QuocGiaModel quocGia;
  NavigatorSmsCodeState({this.quocGia, this.user}) : super();

  NavigatorSmsCodeState copyWith({userNew, quocGiaNew}) {
    return NavigatorSmsCodeState(user: userNew, quocGia: quocGiaNew);
  }

  @override
  String toString() => 'NavigatorSmsCodeState';
}

class MessageSMSState extends FormSMSState {
  final code;
  final message;
  final errorCode;
  // dùng supper để đè lên
  MessageSMSState({this.errorCode, this.code, this.message}) : super();

  MessageSMSState copyWith({codeOld, messageOld, errorCodeOld}) {
    return MessageSMSState(
        code: codeOld, message: messageOld, errorCode: errorCodeOld);
  }

  @override
  String toString() => 'MessageSMSState';
}

class WaitingFormState extends FormSMSState {
  final loading;

  WaitingFormState({this.loading}) : super();
  WaitingFormState copyWith({loadingNew}) {
    return WaitingFormState(loading: loadingNew || this.loading);
  }

  @override
  String toString() => 'WaitingFormState';
}
