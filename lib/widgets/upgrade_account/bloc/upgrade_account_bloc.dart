import 'dart:async';

import 'package:Core/widgets/upgrade_account/bloc_address/address_bloc.dart';
import 'package:Core/widgets/upgrade_account/model/request_upgrade_model.dart';
import 'package:Core/widgets/upgrade_account/service/upgrade_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'upgrade_account_event.dart';
part 'upgrade_account_state.dart';

class UpgradeAccountBloc
    extends Bloc<UpgradeAccountEvent, UpgradeAccountState> {
  UpgradeAccountService service;
  UpgradeAccountBloc({this.service});
  @override
  UpgradeAccountState get initialState => UpgradeAccountInitial();

  @override
  Stream<UpgradeAccountState> mapEventToState(
    UpgradeAccountEvent event,
  ) async* {
    if (event is LoadingRequest) {
      yield LoadingData();
    }
    if (event is CheckRequestAccount) {
      yield LoadingData();
      try {
        var data = await service.checkRequestAccount();
        yield ExitsRequest(data: data);
      } catch (e) {
        try {
          int code = int.parse(e.response.data['code'].toString());
          if (code == 101) {
            yield UserIsSalon();
          } else if (code == 102) {
            yield NotExitsRequest();
          } else {
            yield ErrorNetwork(e: e);
          }
        } catch (e) {
          yield ErrorNetwork(e: e);
        }
      }
    }
  }
}
