import 'dart:async';

import 'package:Midas/widgets/upgrade_account/model/request_upgrade_model.dart';
import 'package:Midas/widgets/upgrade_account/service/upgrade_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'info_salon_event.dart';
part 'info_salon_state.dart';

class InfoSalonBloc extends Bloc<InfoSalonEvent, InfoSalonState> {
  UpgradeAccountService service;
  InfoSalonBloc({this.service});
  @override
  InfoSalonState get initialState => InfoSalonInitial();

  @override
  Stream<InfoSalonState> mapEventToState(
    InfoSalonEvent event,
  ) async* {
    if (event is GetDataInfo) {
      yield LoadingDataSalon();
      try {
        var data = await service.getInfoSalon();
        yield LoadedDataSalon(data: data);
      } catch (e) {
        yield ErrorNetwork(e: e);
        // try {
        //   int code = int.parse(e.response.data['code'].toString());
        //   if (code == 101) {
        //     yield UserNotSaLon();
        //   } else {
        //     yield ErrorNetwork(e: e);
        //   }
        // } catch (e) {
        //   yield ErrorNetwork(e: e);
        // }
      }
    }
  }
}
