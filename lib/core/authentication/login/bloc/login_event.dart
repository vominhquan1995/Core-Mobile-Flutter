import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed({
    @required this.username,
    @required this.password,
  }) : super();

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';

  @override
  // TODO: implement props
  List<Object> get props => [username, password];
}
