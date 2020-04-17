part of 'upgrade_account_bloc.dart';

abstract class UpgradeAccountEvent extends Equatable {
  const UpgradeAccountEvent();
}

class CheckRequestAccount extends UpgradeAccountEvent {
  CheckRequestAccount();
  @override
  List<Object> get props => [];
}

class LoadingRequest extends UpgradeAccountEvent {
  LoadingRequest();
  @override
  List<Object> get props => [];
}
