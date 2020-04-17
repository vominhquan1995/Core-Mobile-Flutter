import 'dart:async';

import 'package:Core/core/authentication/bloc/bloc.dart';
import 'package:Core/widgets/my_library/models/template_model.dart';
import 'package:Core/widgets/my_library/service/library_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'templatesanpham_event.dart';
part 'templatesanpham_state.dart';

class TemplateSanPhamBloc
    extends Bloc<TemplateSanPhamEvent, TemplateSanPhamState> {
  IBaseLibraryService service;
  AuthenticationBloc authenticationBloc;

  TemplateSanPhamBloc(this.authenticationBloc, {@required this.service});

  @override
  TemplateSanPhamState get initialState => TemplateSanPhamInitial();

  @override
  Stream<TemplateSanPhamState> mapEventToState(
    TemplateSanPhamEvent event,
  ) async* {
    // TODO: Add Logic

    if (event is GetTemplateSanPham) {
      try {
        if (authenticationBloc.state is AuthenticationAuthenticated) {
          final list = await service.getTemplatePrivate();

          yield TemplateSanPhamLoaded(listTemplate: list);
          return;
        }

        if (authenticationBloc.state is AuthenticationUnauthenticated) {
          final list = await service.getTemplate();

          yield TemplateSanPhamLoaded(listTemplate: list);
          return;
        }

        yield TemplateSanPhamLoaded(listTemplate: []);
      } catch (e) {
        yield TemplateSanPhamError(e: e);
      }
    }
  }
}
