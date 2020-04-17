import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:Midas/core/notification/core_notification.dart';
import 'index.dart';

class CoreNotificationBloc
    extends Bloc<CoreNotificationEvent, CoreNotificationState>
    with NotificationCore {
  @override
  CoreNotificationState get initialState => InitialCoreNotificationState();
  @override
  Stream<CoreNotificationState> mapEventToState(
    CoreNotificationEvent event,
  ) async* {
    if (event is InitNotification) {
      await configFirebase(event.context);
      var state = await getTokenFirebase(false);
      if (state) {
        yield InitSuccessState();
      } else {
        yield InitFailState();
      }
    }
    if (event is CallRegisToken) {
      regisTokenNotify(event.context);
    }
    if (event is ReInitToken) {
      var state = await getTokenFirebase(true);
      if (state) {
        regisTokenNotify(event.context);
      }
    }
    if (event is RedirectPage) {
      yield RedirectPageState(data: event.data);
    }
  }
}
