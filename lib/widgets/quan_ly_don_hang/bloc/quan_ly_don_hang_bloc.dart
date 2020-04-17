import 'dart:async';
import 'dart:io';

import 'package:Midas/widgets/quan_ly_don_hang/model/don_hang_model_2.dart';
import 'package:Midas/widgets/quan_ly_don_hang/service/quan_ly_don_hang_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'quan_ly_don_hang_event.dart';
part 'quan_ly_don_hang_state.dart';

class QuanLyDonHangBloc extends Bloc<QuanLyDonHangEvent, QuanLyDonHangState> {
  QuanLyDonHangService service;

  QuanLyDonHangBloc({@required this.service});

  @override
  QuanLyDonHangState get initialState => InitialQuanLyDonHangState();

  @override
  Stream<QuanLyDonHangState> mapEventToState(QuanLyDonHangEvent event) async* {
    // TODO: implement mapEventToState

    if (event is GetData) {
      try {
        final data = await this.service.listDonHang();
        if (data.length > 0) {
          yield LoadedQuanLyDonHang(donhang: data, hasReachedMax: data.isEmpty);
        } else {
          yield EmptyQuanLyDonHang();
        }
      } catch (e) {
        if (e?.error is SocketException) {
          /// Get data local
          // add(GetDataNewsLocal(e: e, danhMuc: event.danhMuc ?? null));
          return;
        }
        yield ErrorQuanLyDonHangState(e: e);
      }
    }
    if (event is GetOneData) {
      try {
         yield LoadingState();
        final data = await this.service.getOne(id: event.id);
        yield LoadedOneQuanLyDonHang(donhang: data);
      } catch (e) {
        if (e?.error is SocketException) {
          /// Get data local
          // add(GetDataNewsLocal(e: e, danhMuc: event.danhMuc ?? null));
          return;
        }
        yield ErrorQuanLyDonHangState(e: e);
      }
    }

    /// Lấy thêm Dữ liệu từ page x
    if (event is GetMoreData && !_hasReachedMax(state)) {
      try {
        final data = await this.service.listDonHang(
              id: (state as LoadedQuanLyDonHang).donhang.last.giaoDichId,
              upperbound: false,
            );
        yield data.isEmpty
            ? (state as LoadedQuanLyDonHang).copyWith(hasReachedMax: true)
            : LoadedQuanLyDonHang(
                donhang: (state as LoadedQuanLyDonHang).donhang + data,
                hasReachedMax: false);
      } catch (e) {
        yield (state as LoadedQuanLyDonHang).donhang.isNotEmpty
            ? (state as LoadedQuanLyDonHang).copyWith(
                donhang: (state as LoadedQuanLyDonHang).donhang,
                hasReachedMax: true,
              )
            : ErrorQuanLyDonHangState(e: e);
      }
    }
  }

  bool _hasReachedMax(QuanLyDonHangState state) =>
      state is LoadedQuanLyDonHang && state.hasReachedMax;
}
