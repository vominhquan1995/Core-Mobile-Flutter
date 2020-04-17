part of 'upgrade_account_bloc.dart';

abstract class UpgradeAccountState extends Equatable {
  const UpgradeAccountState();
}

class UpgradeAccountInitial extends UpgradeAccountState {
  @override
  List<Object> get props => [];
}

class ExitsRequest extends UpgradeAccountState {
  final RequestUpgrade data;
  ExitsRequest({this.data});
  @override
  List<Object> get props => [data];
}

class NotExitsRequest extends UpgradeAccountState {
  @override
  List<Object> get props => [];
}

class UserIsSalon extends UpgradeAccountState {
  @override
  List<Object> get props => [];
}

class ErrorNetwork extends UpgradeAccountState {
  final dynamic e;
  ErrorNetwork({this.e});
  @override
  List<Object> get props => [];
}

class LoadingData extends UpgradeAccountState {
  @override
  List<Object> get props => [];
}
