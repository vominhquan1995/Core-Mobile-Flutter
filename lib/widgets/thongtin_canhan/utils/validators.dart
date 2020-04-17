import 'dart:async';

class Validators {
  static final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email == null || email.trim().length == 0) {
      sink.addError('Phải nhập Email');
      return;
    }
    String s =
        r'(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))';
    RegExp exp = new RegExp(s);
    if (!exp.hasMatch(email)) {
      sink.addError('Không đúng định dạng');
      return;
    }
    sink.add(email);
  });
}
