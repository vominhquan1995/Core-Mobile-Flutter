import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'index.dart';

class PhoneFirebase extends PhoneBase {
  String _verificationId;

  PhoneFirebase() : super();
  /* 
    Gửi code Sms cho mobile
   */
  Future<dynamic> guiSms(String number) {
    var completer = new Completer();
    this.auth.verifyPhoneNumber(
        phoneNumber: number,
        timeout: const Duration(seconds: 5),
        /* 
        gửi code thành công sẽ trả về 1 mã xác thực để đính kèm chung với sms code xác nhận
         */
        codeSent: (String verificationId, [int forceResendingToken]) {
          this._verificationId = verificationId;
          completer.complete(
              {'code': 200, 'message': '', 'result': null});
        },
        verificationCompleted: (AuthCredential phoneAuthCredential) {
          completer.complete({
            'code': 200,
            'message': '',
            'result': phoneAuthCredential
          });
        },
        /* 
        invalidCredential: chứng thực không hợp lệ
        tooManyRequests: request quá nhiều
         */
        verificationFailed: (AuthException authException) {
          completer.completeError({
            'code': 400,
            'message': '',
            'result': PhoneMessageError.showErrorMessage(
                authException.code, authException.message)
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // id xác minh sms kèm theo chung sms code
          this._verificationId = verificationId;
          completer.completeError(
              {'code': 401, 'message': '', 'result': null});
        });
    return completer.future;
  }

  /* 
  xác thực code sms
   */
  Future<dynamic> xacThucBangCodeSms(String smsCode) async {
    try {
      /**
     * gửi mã xác nhận
     */
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      /* 
    nếu thành công thì có user
     */
      final FirebaseUser _user =
          (await super.auth.signInWithCredential(credential));
      if (_user != null) {
        /* 
      mỗi khi user login thì token cũ ko sài dc
      */
        final _idToken = await _user.getIdToken();
        return _idToken;
      } else {
        return null;
      }
    } on PlatformException catch (ex) {
      if (ex.code == 'ERROR_INVALID_VERIFICATION_CODE') {
        return null;
      }
      return -1;
    }
  }

  /* 
  đăng xuất
   */
  sigOut() async {
    await super.auth.signOut();
  }
}
