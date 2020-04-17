import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:Core/core/authentication/models/profile_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  @override
  String toString() => 'LoginInitial';
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

class LoginSucess extends LoginState {
  final Profile user;
  LoginSucess(this.user);
  @override
  String toString() => 'LoginSucess';
}

class LoginFailure extends LoginState {
  final String error;
  final String linkRedirect;
  final String linkRedirectName;
  LoginFailure(
      {@required this.error, this.linkRedirect, this.linkRedirectName});

  @override
  String toString() => 'LoginFailure { error: $error }';

  @override
  // TODO: implement props
  List<Object> get props => [error, linkRedirect, linkRedirectName];
}
