import 'package:equatable/equatable.dart';
import 'package:Core/widgets/notification/model/notification_model.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
  @override
  List<Object> get props => [];
}

class InitialNotificationState extends NotificationState {}

class LoadedNotificationState extends NotificationState {
  final List<NotificationModel> list;
  final String lastId;
  final bool hasReachedMax;
  LoadedNotificationState({this.list, this.lastId, this.hasReachedMax});

  LoadedNotificationState copyWith(
      {List<NotificationModel> list, String lastId, bool hasReachedMax}) {
    return LoadedNotificationState(
        list: list ?? this.list,
        lastId: lastId ?? this.lastId,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [list, lastId, hasReachedMax];
}

class ErrorNotificationState extends NotificationState {
  final e;
  ErrorNotificationState({this.e});
  @override
  String toString() => '$runtimeType $e';
  @override
  List<Object> get props => [e];
}

class EmptyNotificationState extends NotificationState {
  @override
  List<Object> get props => [];
}
