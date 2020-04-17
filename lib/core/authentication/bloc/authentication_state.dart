import 'package:Midas/core/authentication/models/profile_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final Profile user;
  AuthenticationAuthenticated(this.user);
  @override
  String toString() => 'AuthenticationAuthenticated $user';

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';
}

class MaintenanceApp extends AuthenticationState {
  final String message;
  MaintenanceApp(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class UpgradeVersionApp extends AuthenticationState {}

class UserLoggedIn extends AuthenticationState {}

class QuocGiaNotFound extends AuthenticationState {}

class ConfigJsonNotFound extends AuthenticationState {}
