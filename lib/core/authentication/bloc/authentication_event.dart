import 'package:Core/core/authentication/models/profile_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}

class Maintenance extends AuthenticationEvent {
  final String message;

  Maintenance(this.message);

  @override
  String toString() => 'Maintenance';

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class YouNeedUpgradeVersionApp extends AuthenticationEvent {
  @override
  String toString() => 'YouNeedUpgradeVersionApp';
}

class YouNotNeedUpgradeVersionApp extends AuthenticationEvent {
  @override
  String toString() => 'YouNotNeedUpgradeVersionApp';
}

class UpdateUser extends AuthenticationEvent {
  final Profile profile;
  UpdateUser(this.profile);
  @override
  String toString() => 'UpdateUser';

  @override
  // TODO: implement props
  List<Object> get props => [profile];
}

class QuocGiaNotFoundInDB extends AuthenticationEvent {}

class ConfigJsonError extends AuthenticationEvent {}
