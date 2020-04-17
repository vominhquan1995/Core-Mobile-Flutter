part of 'info_salon_bloc.dart';

@immutable
abstract class InfoSalonState {}

class InfoSalonInitial extends InfoSalonState {}

class LoadingDataSalon extends InfoSalonState {
  @override
  List<Object> get props => [];
}

class LoadedDataSalon extends InfoSalonState {
  RequestUpgrade data;
  LoadedDataSalon({this.data});
  @override
  List<Object> get props => [data];
}

class UserNotSaLon extends InfoSalonState {
  @override
  List<Object> get props => [];
}

class ErrorNetwork extends InfoSalonState {
  final dynamic e;
  ErrorNetwork({this.e});
  @override
  List<Object> get props => [];
}
