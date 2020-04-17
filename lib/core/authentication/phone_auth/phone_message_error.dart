/* 
Dùng để show lỗi message sang tiếng việt
 */
class PhoneMessageError {
  /* 
    show lỗi dựa theo mã code của Firebase
    code: invalidCredential
    message: 1 đoạn thông báo dài có chứa [TOO_SHORT] -> quá ngắn
                                          [ TOO_LONG ] -> quá dài
                                          [ Invalid format. ] -> sai định dạng format
  
    code: tooManyRequests
    message: thiết bị request quá nhiều lần
   */
  static showErrorMessage(String firebase_code, String firebase_message) {
    var _message = '';
    print(firebase_code);
    switch (firebase_code) {
      case 'invalidCredential':
        _message = showErrorMessageByinvalidCredential(firebase_message);
        break;

      case 'firebaseAuth':
        _message = showErrorMessageByinvalidCredential(firebase_message);
        break;

      case 'tooManyRequests':
        _message = 'login_6';
        break;

      case 'quotaExceeded':
        _message = 'login_6';
        break;

      case 'verifyPhoneNumber':
        if (firebase_message.indexOf('network error') != -1) {
          _message = 'login_7';
        } else {
          _message = 'login_8';
        }
        break;
      default:
        _message = 'login_8';
        break;
    }
    return _message;
  }

/* 
  show lỗi khi có code lỗi trong tin nhắn [hỗ trợ cho hàm showErrorMessage]
  1 đoạn thông báo dài có chứa [ TOO_SHORT ] -> quá ngắn
                               [ TOO_LONG ] -> quá dài
                               [ Invalid format. ] -> sai định dạng format
 */
  static String showErrorMessageByinvalidCredential(String firebaseMessage) {
    var message = firebaseMessage;
    if (firebaseMessage.indexOf('[ TOO_SHORT ]') != -1) {
      message = 'login_9';
    }
    if (firebaseMessage.indexOf('[ TOO_LONG ]') != -1) {
      message = 'login_10';
    }
    if (firebaseMessage.indexOf('[ Invalid format. ]') != -1) {
      message = 'login_11';
    }

    if (firebaseMessage.indexOf(
            '[ App validation failed. Is app running on a physical device? ]') !=
        -1) {
      message = 'login_12';
    }

    return message;
  }
}
