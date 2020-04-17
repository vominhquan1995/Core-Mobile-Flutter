import 'dart:async';
import 'dart:io';

import 'package:Core/widgets/qua_tang_xac_thuc/bloc/qua_tang_xac_thuc_event.dart';
import 'package:Core/widgets/qua_tang_xac_thuc/bloc/qua_tang_xac_thuc_state.dart';
import 'package:Core/widgets/qua_tang_xac_thuc/service/qua_tang_xac_thuc_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class QuaTangXacThucBloc
    extends Bloc<QuaTangXacThucEvent, QuaTangXacThucState> {
  final QuaTangXacThucService service;

  QuaTangXacThucBloc({@required this.service});

  @override
  QuaTangXacThucState get initialState => InitialQuaTangXacThucState();

  @override
  Stream<QuaTangXacThucState> mapEventToState(
      QuaTangXacThucEvent event) async* {
    // TODO: implement mapEventToState

    /* 
    nhập liệu
    1/ kiểm tra xem giá trị có rỗng không?
    -> có: báo lỗi
    2/ error cho về null
    */
    if (event is InputMaPin) {
      yield FormXacThucState(error: null, maPin: event.maPin);
    }

    /**
     * khi submit
     * 1/ waiting form
     * 2/ gọi api kiểm tra
     *  -> thành công: qua trang success
     *  -> lỗi: hiện lỗi và giá trị vừa nhập
     */
    if (event is SubmitXacThuc) {
      FormXacThucState currentState = (state as FormXacThucState);

      yield WaitingForm();
      try {
        final data = await this
            .service
            .xacThucThanhVien(currentState.maPin);

        if (data['code'] != null && data['code'] == 201) {
          yield currentState.copyWith(errorMessage: data['message']);
        } else {
          yield XacThucSuccess();
        }
      } catch (ex) {
        yield currentState.copyWith(
            errorMessage: 'gift_14');
      }
    }
  }
}
