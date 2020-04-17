import 'dart:async';

import 'package:Midas/widgets/ngon_ngu/service/ngon_ngu_service.dart';
import 'package:Midas/widgets/quoc_gia/models/quocgia_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'ngonngu_event.dart';
part 'ngonngu_state.dart';

class NgonnguBloc extends Bloc<NgonnguEvent, NgonnguState> {
  IBaseNgonNguService service;

  NgonnguBloc({@required this.service});

  @override
  NgonnguState get initialState => NgonnguInitial();

  @override
  Stream<NgonnguState> mapEventToState(
    NgonnguEvent event,
  ) async* {
    // TODO: Add Logic

    if (event is GetDSNgonNgu) {
      try {
        final data = await service.getDanhSachNgonNgu(language: event.language);
        yield NgonNguLoaded(list: data);
      } catch (e) {
        yield NgonNguLoaded(list: []);
      }
    }

    if (event is SelectNgonNgu && state is NgonNguLoaded) {
      yield NgonNguLoaded(
        list: (state as NgonNguLoaded).list,
        selected: event.selected,
      );
    }
  }
}
