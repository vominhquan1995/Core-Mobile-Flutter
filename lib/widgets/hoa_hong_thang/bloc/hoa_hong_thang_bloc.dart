import 'dart:async';
import 'dart:io';

import 'package:Midas/widgets/hoa_hong_thang/model/index.dart';
import 'package:Midas/widgets/hoa_hong_thang/service/hoa_hong_thang_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'hoa_hong_thang_event.dart';
part 'hoa_hong_thang_state.dart';

class HoaHongThangBloc extends Bloc<HoaHongThangEvent, HoaHongThangState> {
  HoaHongThangService service;
  int _count = 0;

  HoaHongThangBloc({@required this.service});

  @override
  HoaHongThangState get initialState => InitialHoaHongThangState();

  @override
  Stream<HoaHongThangState> mapEventToState(HoaHongThangEvent event) async* {
    // TODO: implement mapEventToState

    if (event is GetData) {
      try {
        ///Cái này đang đúng(Lấy ngày đầu tháng và cuối tháng của tháng hiện tại)
        var date = new DateTime.now();
        var start = new DateTime(date.year, date.month);
        var end = new DateTime(date.year, date.month + 1, 0);
        var formatter = new DateFormat('yyyy-MM-dd');
        String tu_ngay = formatter.format(start);
        String toi_ngay = formatter.format(end);
        ///=======================================

        // String tu_ngay = '2019-01-01';
        // String toi_ngay = '2020-05-31';

        final data = await this.service.listHoaHongThang(
            tu_ngay: tu_ngay, toi_ngay: toi_ngay, loai_khach_hang: 1);
        if (data.length > 0) {
          yield LoadedHoaHongThang(
              listHoaHong: data, hasReachedMax: data.isEmpty);
        } else {
          yield EmptyHoaHongThang();
        }
      } catch (e) {
        print(e);
        if (e?.error is SocketException) {
          return;
        }
        yield ErrorHoaHongThangState(e: e);
      }
    }

    // Lấy thêm Dữ liệu từ page x
    if (event is GetMoreData && !_hasReachedMax(state)) {
      try {
        _count += 7;

        ///Cái này đang đúng(Lấy ngày đầu tháng và cuối tháng của tháng hiện tại)
        var date = new DateTime.now();
        var start = new DateTime(date.year, date.month);
        var end = new DateTime(date.year, date.month + 1, 0);
        var formatter = new DateFormat('yyyy/MM/dd');
        String tu_ngay = formatter.format(start);
        String toi_ngay = formatter.format(end);
        ///=======================================

        // String tu_ngay = '2019-01-01';
        // String toi_ngay = '2020-05-31';
        final data = await this.service.listHoaHongThang(
            offset: _count,
            toi_ngay: toi_ngay,
            tu_ngay: tu_ngay,
            loai_khach_hang: 1);
        yield data.isEmpty
            ? (state as LoadedHoaHongThang).copyWith(hasReachedMax: true)
            : LoadedHoaHongThang(
                listHoaHong: (state as LoadedHoaHongThang).listHoaHong + data,
                hasReachedMax: false);
      } catch (e) {
        yield (state as LoadedHoaHongThang).listHoaHong.isNotEmpty
            ? (state as LoadedHoaHongThang).copyWith(
                listHoaHong: (state as LoadedHoaHongThang).listHoaHong,
                hasReachedMax: true,
              )
            : ErrorHoaHongThangState(e: e);
      }
    }
  }

  bool _hasReachedMax(HoaHongThangState state) =>
      state is LoadedHoaHongThang && state.hasReachedMax;
}
