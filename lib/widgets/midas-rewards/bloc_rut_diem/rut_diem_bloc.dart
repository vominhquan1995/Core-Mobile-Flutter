import 'dart:async';
import 'dart:io';

import 'package:Core/widgets/midas-rewards/service/thong_tin_diem_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rut_diem_event.dart';
part 'rut_diem_state.dart';

class RutDiemBloc extends Bloc<RutDiemEvent, RutDiemState> {
  ThongTinDiemService service;

  RutDiemBloc({@required this.service});

  @override
  RutDiemState get initialState => RutDiemInitial();

  @override
  Stream<RutDiemState> mapEventToState(
    RutDiemEvent event,
  ) async* {
    if (event is TaoYeuCauEvent) {
      try {
        if (event.so_tien_rut != '') {
          if (int.parse(event.so_tien_rut) < event.rutHoaHongMin) {
            yield ErrorTaoYeuCauRutDiemState(e: '403');
          } else {
            final data = await this
                .service
                .taoYeuCauRutDiem(so_tien_rut: event.so_tien_rut);

            if (data == 200) {
              yield DoneTaoYeuCauRutDiemState();
            } else if (data == 401) {
              yield ErrorTaoYeuCauRutDiemState(e: '401');
            }
          }
        } else {
          yield ErrorTaoYeuCauRutDiemState(e: '402');
        }
      } catch (e) {
        if (e?.error is SocketException) {
          return;
        }
        yield ErrorTaoYeuCauRutDiemState(e: e);
      }
    }
  }
}
