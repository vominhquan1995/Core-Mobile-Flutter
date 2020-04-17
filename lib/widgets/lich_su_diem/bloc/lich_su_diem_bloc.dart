import 'dart:async';
import 'dart:io';

import 'package:Core/widgets/lich_su_diem/model/index.dart';
import 'package:Core/widgets/lich_su_diem/service/lich_su_diem_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'lich_su_diem_event.dart';
part 'lich_su_diem_state.dart';

class LichSuDiemBloc extends Bloc<LichSuDiemEvent, LichSuDiemState> {
  LichSuDiemService service;
  int _count = 0;

  LichSuDiemBloc({@required this.service});

  @override
  LichSuDiemState get initialState => InitialLichSuDiemState();

  @override
  Stream<LichSuDiemState> mapEventToState(LichSuDiemEvent event) async* {
    // TODO: implement mapEventToState

    if (event is GetData) {
      try {
        final data = await this.service.listLichSuDiem();
        if (data.length > 0) {
          yield LoadedLichSuDiem(listDiem: data, hasReachedMax: data.isEmpty);
        } else {
          yield EmptyLichSuDiem();
        }
      } catch (e) {
        if (e?.error is SocketException) {
          return;
        }
        yield ErrorLichSuDiemState(e: e);
      }
    }

    // Lấy thêm Dữ liệu từ page x
    if (event is GetMoreData && !_hasReachedMax(state)) {
      try {
        _count += 10;
        final data = await this.service.listLichSuDiem(offset: _count);
        yield data.isEmpty
            ? (state as LoadedLichSuDiem).copyWith(hasReachedMax: true)
            : LoadedLichSuDiem(
                listDiem: (state as LoadedLichSuDiem).listDiem + data,
                hasReachedMax: false);
      } catch (e) {
        yield (state as LoadedLichSuDiem).listDiem.isNotEmpty
            ? (state as LoadedLichSuDiem).copyWith(
                listDiem: (state as LoadedLichSuDiem).listDiem,
                hasReachedMax: true,
              )
            : ErrorLichSuDiemState(e: e);
      }
    }
  }

  bool _hasReachedMax(LichSuDiemState state) =>
      state is LoadedLichSuDiem && state.hasReachedMax;
}
