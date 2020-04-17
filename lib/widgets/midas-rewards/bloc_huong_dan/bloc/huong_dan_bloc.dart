import 'dart:async';

import 'package:Core/widgets/midas-rewards/model/huong_dang_model.dart';
import 'package:Core/widgets/midas-rewards/service/thong_tin_diem_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'huong_dan_event.dart';
part 'huong_dan_state.dart';

class HuongDanBloc extends Bloc<HuongDanEvent, HuongDanState> {
  IBaseHuongDanService service;

  HuongDanBloc({@required this.service});
  @override
  HuongDanState get initialState => HuongDanInitial();

  @override
  Stream<HuongDanState> mapEventToState(
    HuongDanEvent event,
  ) async* {
    if (event is GetDanhSachHuongDan) {
      try {
        final list = await service.getDanhSachHuongDan(event.language);

        yield LoadedHuongDanState(list: list);
      } catch (e) {
        print(e);
        yield ErrorHuongDanState(e: e);
      }
    }
  }
}
