import 'package:Core/core/notification/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CoreNotificationEvent extends Equatable {}

class InitNotification extends CoreNotificationEvent {
  final BuildContext context;
  InitNotification({this.context});
  @override
  String toString() => 'InitNotification';
  @override
  List<Object> get props => [context];
}

class CallRegisToken extends CoreNotificationEvent {
  final BuildContext context;
  CallRegisToken({this.context});
  @override
  String toString() => 'CallRegisToken';
  @override
  List<Object> get props => [context];
}

class ReInitToken extends CoreNotificationEvent {
  final BuildContext context;
  ReInitToken({this.context});
  @override
  String toString() => 'ReInitToken';
  @override
  List<Object> get props => [context];
}

class RedirectPage extends CoreNotificationEvent {
  final ItemNotification data;
  RedirectPage({this.data});
  @override
  String toString() => 'RedirectPage';
  @override
  List<Object> get props => [data];
}
