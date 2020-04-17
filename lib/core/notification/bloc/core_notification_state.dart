import 'package:Core/core/notification/index.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CoreNotificationState extends Equatable {
  CoreNotificationState();
}

class InitialCoreNotificationState extends CoreNotificationState {
  @override
  String toString() => 'InitialCoreNotificationState';
  @override
  List<Object> get props => [];
}

class InitSuccessState extends CoreNotificationState {
  @override
  String toString() => 'IniSuccessState';
  @override
  List<Object> get props => [];
}

class InitFailState extends CoreNotificationState {
  @override
  String toString() => 'InitFailState';
  @override
  List<Object> get props => [];
}

class RegisTokenSuccessState extends CoreNotificationState {
  @override
  String toString() => 'RegisTokenSuccessState';
  @override
  List<Object> get props => [];
}

class RedirectPageState extends CoreNotificationState {
  final ItemNotification data;
  RedirectPageState({this.data});
  @override
  String toString() => 'RedirectPageState';
  @override
  List<Object> get props => [data];
}
