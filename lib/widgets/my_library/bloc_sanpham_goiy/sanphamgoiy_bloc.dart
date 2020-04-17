import 'dart:async';

import 'package:Core/core/authentication/bloc/bloc.dart';
import 'package:Core/widgets/my_library/models/sanpham_model.dart';
import 'package:Core/widgets/my_library/service/library_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'sanphamgoiy_event.dart';
part 'sanphamgoiy_state.dart';

class SanphamGoiYBloc extends Bloc<SanphamgoiyEvent, SanphamgoiyState> {
  IBaseLibraryService service;

  AuthenticationBloc authenticationBloc;

  int _page = 1;

  SanphamGoiYBloc(this.authenticationBloc, {@required this.service});

  @override
  Stream<SanphamgoiyState> transformEvents(
    Stream<SanphamgoiyEvent> events,
    Stream<SanphamgoiyState> Function(SanphamgoiyEvent event) next,
  ) {
    return super.transformEvents(
      (events as Observable<SanphamgoiyEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  SanphamgoiyState get initialState => SanphamgoiyInitial();

  @override
  Stream<SanphamgoiyState> mapEventToState(
    SanphamgoiyEvent event,
  ) async* {
    // TODO: Add Logic

    if (event is GetDanhSachPhamGoiY) {
      try {
        if (authenticationBloc.state is AuthenticationAuthenticated) {
          final data = await service.getSanPhamGoiYPrivate();

          yield data.isEmpty
              ? SanPhamGoiYEmpty()
              : SanPhamGoiYLoaded(list: data, hasReachedMax: false);
          return;
        }

        if (authenticationBloc.state is AuthenticationUnauthenticated) {
          final data = await service.getSanPhamGoiY();

          yield data.isEmpty
              ? SanPhamGoiYEmpty()
              : SanPhamGoiYLoaded(list: data, hasReachedMax: false);
          return;
        }

        yield SanPhamGoiYEmpty();
      } catch (e) {
        yield SanPhamGoiYError(e: e);
      }
    }

    if (event is GetMoreDanhSachPhamGoiY && !_hasReachedMax(state)) {
      try {
        _page += 1;

        if (authenticationBloc.state is AuthenticationAuthenticated) {
          ///
          final data = await service.getSanPhamGoiYPrivate(page: _page);

          ///
          yield SanPhamGoiYLoaded(
            list: (state as SanPhamGoiYLoaded).list + data,
            hasReachedMax: data.isEmpty,
          );
          return;
        }

        if (authenticationBloc.state is AuthenticationUnauthenticated) {
          ///
          final data = await service.getSanPhamGoiY(page: _page);

          ///
          yield SanPhamGoiYLoaded(
            list: (state as SanPhamGoiYLoaded).list + data,
            hasReachedMax: data.isEmpty,
          );
          return;
        }
      } catch (e) {
        ///
        if (state is SanPhamGoiYLoaded) {
          yield SanPhamGoiYLoaded(
            list: (state as SanPhamGoiYLoaded).list,
            hasReachedMax: true,
          );
          return;
        }

        ///
        yield SanPhamGoiYError();
      }
    }
  }

  bool _hasReachedMax(SanphamgoiyState state) =>
      state is SanPhamGoiYLoaded && state.hasReachedMax;
}
