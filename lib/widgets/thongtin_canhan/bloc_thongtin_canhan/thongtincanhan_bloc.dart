import 'dart:async';

import 'package:Midas/core/authentication/models/profile_model.dart';
import 'package:Midas/widgets/thongtin_canhan/service/thongtin_canhan_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'thongtincanhan_event.dart';
part 'thongtincanhan_state.dart';

class ThongTinCaNhanBloc
    extends Bloc<ThongTinCaNhanEvent, ThongTinCaNhanState> {
  ProfileService service;

  ThongTinCaNhanBloc({@required this.service});

  @override
  ThongTinCaNhanState get initialState => ThongtincanhanInitial();

  @override
  Stream<ThongTinCaNhanState> mapEventToState(
    ThongTinCaNhanEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is GetThongTinCaNhan) {
      try {
        final data = await service.fetchThongTinUser();

        yield ThongtincanhanLoaded(profile: data);
      } catch (e) {}
    }

    if (event is UpdateThongTinCaNhan) {
      try {
        final b = await service.updateHoTenNgaySinh(event.profile);
        if (b) {
          yield ThongtincanhanLoaded(profile: event.profile);
          return;
        }

        if (state is ThongtincanhanLoaded) {
          yield ThongtincanhanLoaded(
            profile: (state as ThongtincanhanLoaded).profile,
            updateError: true,
          );
        }
      } catch (e) {
        if (state is ThongtincanhanLoaded) {
          yield ThongtincanhanLoaded(
            profile: (state as ThongtincanhanLoaded).profile,
            updateError: true,
          );
          return;
        }
      }
    }
  }
}
