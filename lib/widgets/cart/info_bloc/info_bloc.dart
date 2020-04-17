import 'dart:async';
import 'package:Core/widgets/cart/info_bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:Core/widgets/cart/service/cart_service.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  CartService service;
  InfoBloc({@required this.service});

  @override
  InfoState get initialState => InitialInfoState();

  @override
  Stream<InfoState> mapEventToState(
    InfoEvent event,
  ) async* {
    // TODO: Add Logic
    ///
    if (event is GetCartInfo) {
      try {
        //first page last nofifi id is 0
        var info = await service.getInfo();
        yield info == null ? ErrorInfoState() : LoadedInfoState(info: info);
      } catch (e) {
        yield ErrorInfoState(e: e);
      }
    }
    if (event is SubmitCartInfo) {
      try {
        //first page last nofifi id is 0
        var info = await service.getInfo();
        yield info == null ? ErrorInfoState() : LoadedInfoState(info: info);
      } catch (e) {
        yield ErrorInfoState(e: e);
      }
    }
  }
}
