import 'dart:async';
import 'package:Core/widgets/notification/bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:Core/widgets/notification/service/notification_service.dart';
import 'package:rxdart/rxdart.dart';

const PER_PAGE = 10;

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationService service;
  NotificationBloc({@required this.service});

  @override
  Stream<NotificationState> transformEvents(
    Stream<NotificationEvent> events,
    Stream<NotificationState> Function(NotificationEvent event) next,
  ) {
    return super.transformEvents(
      (events as Observable<NotificationEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  NotificationState get initialState => InitialNotificationState();

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    // TODO: Add Logic
    ///
    if (event is GetDataNotification) {
      try {
        //first page last nofifi id is 0
        var list = await service.getListNotification(0, PER_PAGE);
        yield list.isEmpty
            ? EmptyNotificationState()
            : LoadedNotificationState(
                list: list,
                lastId: list.last.notifiid,
                hasReachedMax: list.length < PER_PAGE);
      } catch (e) {
        yield ErrorNotificationState(e: e);
      }
    }

    ///
    if (event is RefreshNotification) {
      try {
        //first page last nofifi id is 0
        var list = await service.getListNotification(0, PER_PAGE);
        yield list.isEmpty
            ? EmptyNotificationState()
            : LoadedNotificationState(
                list: list,
                lastId: list.last.notifiid,
                hasReachedMax: list.length < PER_PAGE);
      } catch (e) {
        // currentState is LoadedNotificationState
        yield state is LoadedNotificationState
            ? (state as LoadedNotificationState).copyWith(
                list: (state as LoadedNotificationState).list,
                lastId: (state as LoadedNotificationState).lastId,
                hasReachedMax:
                    (state as LoadedNotificationState).list.length < PER_PAGE)
            : ErrorNotificationState(e: e);
      }
    }

    ///
    if (event is GetMoreNotification && state is LoadedNotificationState) {
      try {
        int lastiId = int.parse((state as LoadedNotificationState).lastId);
        var list = await service.getListNotification(lastiId, PER_PAGE);

        if (list.isEmpty) {
          yield (state as LoadedNotificationState)
              .copyWith(hasReachedMax: true);
        } else {
          yield (state as LoadedNotificationState).copyWith(
              list: (state as LoadedNotificationState).list + list,
              lastId: list.last.notifiid,
              hasReachedMax: list.length < PER_PAGE);
        }
      } catch (e) {
        yield (state as LoadedNotificationState).copyWith(hasReachedMax: true);
      }
    }
  }
}
