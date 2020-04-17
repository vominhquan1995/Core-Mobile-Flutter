import 'dart:async';

import 'package:Midas/widgets/my_library/models/banner_model.dart';
import 'package:Midas/widgets/my_library/service/library_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  IBaseLibraryService service;

  BannerBloc({@required this.service});

  @override
  BannerState get initialState => BannerInitial();

  @override
  Stream<BannerState> mapEventToState(
    BannerEvent event,
  ) async* {
    // TODO: Add Logic

    if (event is GetBanner) {
      try {
        final banners = await service.getBanner();

        yield banners.isNotEmpty ? BannerLoaded(list: banners) : BannerEmpty();
      } catch (e) {
        yield BannerError(e);
      }
    }
  }
}
