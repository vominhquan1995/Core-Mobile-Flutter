import 'dart:async';
import 'package:Midas/widgets/tra_cuu/service/tracuu_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class TracuuBloc extends Bloc<TracuuEvent, TracuuState> {
  IBaseTraCuuService service;

  TracuuBloc({@required this.service});

  @override
  TracuuState get initialState => InitialTracuuState();

  @override
  Stream<TracuuState> mapEventToState(
    TracuuEvent event,
  ) async* {
    // TODO: Add Logic

    if (event is GetDanhSachTraCuu) {
      try {
        final list = await service.getDanhSachTraCuu(event.language);

        yield LoadedTracuuState(list: list);
      } catch (e) {
        yield ErrorTracuuState(e: e);
      }
    }
  }
}
