import 'dart:async';
import 'dart:io';

import 'package:Midas/widgets/hoa-hong-page/model/hoa_hong_ca_nhan_model.dart';
import 'package:Midas/widgets/hoa-hong-page/service/tong_hoa_hong_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'hoa_hong_ca_nhan_event.dart';
part 'hoa_hong_ca_nhan_state.dart';

class HoaHongCaNhanBloc extends Bloc<HoaHongCaNhanEvent, HoaHongCaNhanState> {
  HoaHongCaNhanService service;

  HoaHongCaNhanBloc({@required this.service});

  @override
  HoaHongCaNhanState get initialState => HoaHongCaNhanInitial();

  @override
  Stream<HoaHongCaNhanState> mapEventToState(
    HoaHongCaNhanEvent event,
  ) async* {
    if (event is GetDataHoaHong) {
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
        final data = await this
            .service
            .hoaHOngCaNhan(tu_ngay: tu_ngay, toi_ngay: toi_ngay);

        yield LoadedHoaHongCaNhan(tongHoaHong: data);
      } catch (e) {
        print(e);
        if (e?.error is SocketException) {
          return;
        }
        yield ErrorHoaHongCaNhanState(e: e);
      }
    }
  }
}
