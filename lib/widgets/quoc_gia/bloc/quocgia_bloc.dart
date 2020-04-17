import 'dart:async';

import 'package:Midas/widgets/quoc_gia/db/quocgia_db.dart';
import 'package:Midas/widgets/quoc_gia/models/quocgia_model.dart';
import 'package:Midas/widgets/quoc_gia/service/quocgia_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quocgia_event.dart';
part 'quocgia_state.dart';

class QuocgiaBloc extends Bloc<QuocgiaEvent, QuocgiaState> {
  final IBaseQuocGiaService service;
  final QuocGiaDB db = QuocGiaDB();

  QuocgiaBloc(this.service);

  @override
  QuocgiaState get initialState => QuocgiaInitial();

  @override
  Stream<QuocgiaState> mapEventToState(
    QuocgiaEvent event,
  ) async* {
    // TODO: Add Logic

    if (event is CheckQuocGia) {
      final qg = await db.select();
      yield DanhSachQuocgia(list: [], confirm: qg);
    }

    if (event is GetQuocGia) {
      try {
        final list = await service.getDanhSachQG();
        yield list.isNotEmpty ? DanhSachQuocgia(list: list) : EmptyQuocGia();
      } catch (e) {
        yield EmptyQuocGia();
      }
    }

    if (event is SelectQuocGia && state is DanhSachQuocgia) {
      yield DanhSachQuocgia(
        list: (state as DanhSachQuocgia).list,
        selected: event.quocGia,
      );
    }

    if (event is ConfirmQuocGia) {
      final save = await db.insert(event.quocGia);
      yield DanhSachQuocgia(list: [], confirm: event.quocGia);
    }

    if (event is LoadingQuocGiaEvent) {
      yield LoadingQuocGiaState();
    }
  }
}
