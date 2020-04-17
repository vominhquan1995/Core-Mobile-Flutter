
import 'package:firebase_auth/firebase_auth.dart';

class PhoneBase {
  final FirebaseAuth auth = FirebaseAuth.instance;
}

class PhoneModel extends PhoneBase {
  String number;
  String userID;
  PhoneModel({number = '', userID = ''});
}
