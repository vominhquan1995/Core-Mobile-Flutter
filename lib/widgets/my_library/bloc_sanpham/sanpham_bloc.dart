import 'dart:async';

import 'package:Midas/widgets/my_library/models/sanpham_model.dart';
import 'package:Midas/widgets/my_library/service/library_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

part 'sanpham_event.dart';
part 'sanpham_state.dart';

class SanPhamBloc extends Bloc<SanPhamEvent, SanPhamState> {
  IBaseLibraryService service;

  int _count = 0;

  SanPhamBloc({@required this.service});

  @override
  Stream<SanPhamState> transformEvents(
    Stream<SanPhamEvent> events,
    Stream<SanPhamState> Function(SanPhamEvent event) next,
  ) {
    return super.transformEvents(
      (events as Observable<SanPhamEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  SanPhamState get initialState => SanPhamInitial();

  @override
  Stream<SanPhamState> mapEventToState(
    SanPhamEvent event,
  ) async* {
    // TODO: Add Logic

    if (event is GetDanhSachPham) {
      try {
        final data = await service.getSanPham(event.key);

        yield data.isEmpty
            ? SanPhamEmpty()
            : SanPhamLoaded(list: data, hasReachedMax: false);
      } catch (e) {
        yield SanPhamError(e: e);
      }
    }

    if (event is GetMoreDanhSachPham && !_hasReachedMax(state)) {
      try {
        _count += 15;

        ///
        final data = await service.getSanPham(event.key, offset: _count);

        ///
        yield SanPhamLoaded(
          list: (state as SanPhamLoaded).list + data,
          hasReachedMax: data.isEmpty,
        );
      } catch (e) {
        ///
        if (state is SanPhamLoaded) {
          yield SanPhamLoaded(
            list: (state as SanPhamLoaded).list,
            hasReachedMax: true,
          );
          return;
        }

        ///
        yield SanPhamError();
      }
    }

    if (event is RefreshDanhSachPham) {
      try {
        _count = 0;
        final data = await service.getSanPham(event.key);

        yield data.isEmpty
            ? SanPhamEmpty()
            : SanPhamLoaded(list: data, hasReachedMax: false);
      } catch (e) {
        if (state is SanPhamLoaded) {
          yield SanPhamLoaded(
            list: (state as SanPhamLoaded).list,
            hasReachedMax: true,
          );
          return;
        }

        yield SanPhamError();
      }
    }
  }

  bool _hasReachedMax(SanPhamState state) =>
      state is SanPhamLoaded && state.hasReachedMax;
}
