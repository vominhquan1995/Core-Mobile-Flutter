import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
@immutable
abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object> get props => [];
}

class GetDataNotification extends NotificationEvent {}

class RefreshNotification extends NotificationEvent {}

class GetMoreNotification extends NotificationEvent {}
