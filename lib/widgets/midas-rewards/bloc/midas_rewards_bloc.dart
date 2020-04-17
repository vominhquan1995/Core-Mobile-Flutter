import 'dart:async';
import 'dart:io';

import 'package:Core/widgets/midas-rewards/model/thong_tin_diem_model.dart';
import 'package:Core/widgets/midas-rewards/service/thong_tin_diem_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'midas_rewards_event.dart';
part 'midas_rewards_state.dart';

class MidasRewardsBloc extends Bloc<MidasRewardsEvent, MidasRewardsState> {
  ThongTinDiemService service;

  MidasRewardsBloc({@required this.service});
  @override
  MidasRewardsState get initialState => MidasRewardsInitial();

  @override
  Stream<MidasRewardsState> mapEventToState(
    MidasRewardsEvent event,
  ) async* {
    if (event is GetDataHMidasRewards) {
      try {
        final data = await this.service.getThongTinDiem();

        yield LoadedMidasRewards(data: data);
      } catch (e) {
        print(e);
        if (e?.error is SocketException) {
          return;
        }
        yield ErrorMidasRewardsState(e: e);
      }
    }
    if (event is UpdateThongTin) {
      try {
        print(event.ten_ngan_hang);
        if (event.ten_ngan_hang == "") {
          yield ValidateStateUpdateMidasRewards(e: '1');
        } else if (event.tai_khoan_ngan_hang == '') {
          yield ValidateStateUpdateMidasRewards(e: '2');
        } else if (event.ten_nguoi_nhan == '') {
          yield ValidateStateUpdateMidasRewards(e: '3');
        } else {
          final data = await this.service.updateThongTin(
              ten_nguoi_nhan: event.ten_nguoi_nhan,
              ten_ngan_hang: event.ten_ngan_hang,
              tai_khoan_ngan_hang: event.tai_khoan_ngan_hang);

          yield DoneUpdateMidasRewards();
        }
      } catch (e) {
        print(e);
        if (e?.error is SocketException) {
          return;
        }
        yield ErrorUpdateMidasRewards(e: e);
      }
    }
  }
}
