import 'dart:async';
import 'dart:io';

import 'package:Core/widgets/lich_su_rut_diem/model/lich_su_rut_diem_model.dart';
import 'package:Core/widgets/lich_su_rut_diem/service/lich_su_rut_diem_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'lich_su_rut_diem_event.dart';
part 'lich_su_rut_diem_state.dart';

// class LichSuRutDiemBloc extends Bloc<LichSuRutDiemEvent, LichSuRutDiemState> {
//   @override
//   LichSuRutDiemState get initialState => LichSuRutDiemInitial();

//   @override
//   Stream<LichSuRutDiemState> mapEventToState(
//     LichSuRutDiemEvent event,
//   ) async* {
//     // TODO: Add Logic
//   }
// }

class LichSuRutDiemBloc extends Bloc<LichSuRutDiemEvent, LichSuRutDiemState> {
  LichSuRutDiemService service;
  int _count = 0;

  LichSuRutDiemBloc({@required this.service});

  @override
  LichSuRutDiemState get initialState => LichSuRutDiemInitial();

  @override
  Stream<LichSuRutDiemState> mapEventToState(LichSuRutDiemEvent event) async* {
    // TODO: implement mapEventToState

    if (event is GetData) {
      try {
        final data = await this.service.listLichSuRutDiem();
        if (data.length > 0) {
          yield LoadedLichSuRutDiem(
              listDiem: data, hasReachedMax: data.isEmpty);
        } else {
          yield EmptyLichSuDiem();
        }
      } catch (e) {
        if (e?.error is SocketException) {
          return;
        }
        yield ErrorLichSuRutDiemState(e: e);
      }
    }

    // Lấy thêm Dữ liệu từ page x
    if (event is GetMoreData && !_hasReachedMax(state)) {
      try {
        _count += 10;
        final data = await this.service.listLichSuRutDiem(offset: _count);
        yield data.isEmpty
            ? (state as LoadedLichSuRutDiem).copyWith(hasReachedMax: true)
            : LoadedLichSuRutDiem(
                listDiem: (state as LoadedLichSuRutDiem).listDiem + data,
                hasReachedMax: false);
      } catch (e) {
        yield (state as LoadedLichSuRutDiem).listDiem.isNotEmpty
            ? (state as LoadedLichSuRutDiem).copyWith(
                listDiem: (state as LoadedLichSuRutDiem).listDiem,
                hasReachedMax: true,
              )
            : ErrorLichSuRutDiemState(e: e);
      }
    }
  }

  bool _hasReachedMax(LichSuRutDiemState state) =>
      state is LoadedLichSuRutDiem && state.hasReachedMax;
}
