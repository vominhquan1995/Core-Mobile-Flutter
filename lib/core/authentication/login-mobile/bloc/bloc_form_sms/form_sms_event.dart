import 'package:Core/widgets/quoc_gia/models/quocgia_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../models/profile_model.dart';

@immutable
abstract class FormSMSEvent extends Equatable {
  const FormSMSEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

/* 
  kiem tra dữ liệu của form
 */
class SendSMSAgain extends FormSMSEvent {
  final String number;

  SendSMSAgain({this.number});
  @override
  String toString() {
    return 'Check data form';
  }
}

class DisableButtonForm extends FormSMSEvent {
  @override
  String toString() {
    return 'DisableButtonForm';
  }
}

/* 
chuyển trang khi thành công
 */
class NavigatorSmsCode extends FormSMSEvent {
  final Profile user;
  final QuocGiaModel quocGia;

  NavigatorSmsCode({this.quocGia, this.user});
  @override
  String toString() => 'NavigatorSmsCode';
}

class LoginEvent extends FormSMSEvent {
  final String sms;
  final String number;
  final String quocGiaId;
  final String quocGiaName;
  LoginEvent({this.quocGiaName, this.quocGiaId, this.sms, this.number});
  @override
  String toString() {
    return 'LoginEvent';
  }
}

class MessageSmsFail extends FormSMSEvent {
  final code;
  final message;
  final errorCode;

  MessageSmsFail({this.errorCode, this.code, this.message});
  @override
  String toString() {
    return 'MessageSmsFail';
  }
}

class WaitingFormSMS extends FormSMSEvent {
  final loading;

  WaitingFormSMS({this.loading});

  @override
  String toString() {
    return 'WaitingForm';
  }
}
