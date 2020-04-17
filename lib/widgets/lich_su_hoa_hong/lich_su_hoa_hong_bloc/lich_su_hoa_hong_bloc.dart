import 'dart:async';
import 'dart:io';

import 'package:Midas/widgets/lich_su_hoa_hong/model/index.dart';
import 'package:Midas/widgets/lich_su_hoa_hong/service/lich_su_hoa_hong_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'lich_su_hoa_hong_event.dart';
part 'lich_su_hoa_hong_state.dart';

class LichSuHoaHongBloc extends Bloc<LichSuHoaHongEvent, LichSuHoaHongState> {
  LichSuHoaHongService service;
  int _count = 0;

  LichSuHoaHongBloc({@required this.service});

  @override
  LichSuHoaHongState get initialState => InitialLichSuHoaHongState();

  @override
  Stream<LichSuHoaHongState> mapEventToState(LichSuHoaHongEvent event) async* {
    // TODO: implement mapEventToState

    if (event is GetData) {
      try {
        yield LoadingLichSuHoaHong();
        _count = 0;
        var date = new DateTime.now();
        var start;
        var end;
        var formatter;
        String tu_ngay;
        String toi_ngay;
        if (event.toi_ngay == null || event.tu_ngay == null) {
          date = new DateTime.now();
          start = new DateTime(date.year, date.month - 1);
          end = new DateTime(date.year, date.month, 0);
          formatter = new DateFormat('yyyy-MM-dd');
          tu_ngay = formatter.format(start);
          toi_ngay = formatter.format(end);
        } else {
          tu_ngay = event.tu_ngay;
          toi_ngay = event.toi_ngay;
        }

        final data = await this
            .service
            .listLichSuHoaHong(tu_ngay: tu_ngay, toi_ngay: toi_ngay);
        if (data.length > 0) {
          yield LoadedLichSuHoaHong(
              listHoaHong: data, hasReachedMax: data.isEmpty);
        } else {
          yield EmptyLichSuHoaHong();
        }
      } catch (e) {
          _count = 0;
        print(e);
        if (e?.error is SocketException) {
          return;
        }
        yield ErrorLichSuHoaHongState(e: e);
      }
    }

    // Lấy thêm Dữ liệu từ page x
    if (event is GetMoreData && !_hasReachedMax(state)) {
      try {
        _count += 6;
        ///Cái này đang đúng(Lấy ngày đầu tháng và cuối tháng của tháng hiện tại)
        var date = new DateTime.now();
        var start;
        var end;
        var formatter;
        String tu_ngay;
        String toi_ngay;
        if (event.toi_ngay == null || event.tu_ngay == null) {
          date = new DateTime.now();
          start = new DateTime(date.year, date.month - 1);
          end = new DateTime(date.year, date.month, 0);
          formatter = new DateFormat('yyyy-MM-dd');
          tu_ngay = formatter.format(start);
          toi_ngay = formatter.format(end);
        } else {
          tu_ngay = event.tu_ngay;
          toi_ngay = event.toi_ngay;
        }

        // String tu_ngay = '2019-01-01';
        // String toi_ngay = '2020-05-31';
        final data = await this.service.listLichSuHoaHong(
            offset: _count, toi_ngay: toi_ngay, tu_ngay: tu_ngay);
        yield data.isEmpty
            ? (state as LoadedLichSuHoaHong).copyWith(hasReachedMax: true)
            : LoadedLichSuHoaHong(
                listHoaHong: (state as LoadedLichSuHoaHong).listHoaHong + data,
                hasReachedMax: false);
      } catch (e) {
        yield (state as LoadedLichSuHoaHong).listHoaHong.isNotEmpty
            ? (state as LoadedLichSuHoaHong).copyWith(
                listHoaHong: (state as LoadedLichSuHoaHong).listHoaHong,
                hasReachedMax: true,
              )
            : ErrorLichSuHoaHongState(e: e);
      }
    }
  }

  bool _hasReachedMax(LichSuHoaHongState state) =>
      state is LoadedLichSuHoaHong && state.hasReachedMax;
}
