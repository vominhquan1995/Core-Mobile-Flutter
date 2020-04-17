import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/core/config_json/models/config_json.dart';
import 'package:Core/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Core/widgets/qua_tang_xac_thuc/bloc/qua_tang_xac_thuc_bloc.dart';
import 'package:Core/widgets/qua_tang_xac_thuc/bloc/qua_tang_xac_thuc_event.dart';
import 'package:Core/widgets/qua_tang_xac_thuc/service/qua_tang_xac_thuc_service.dart';
import 'package:Core/widgets/qua_tang_xac_thuc/widget/nhap_ma_xac_thuc.dart';
import 'package:Core/widgets/qua_tang_xac_thuc/widget/qua_tang_xac_thuc_success.dart';
import 'package:Core/widgets/qua_tang_xac_thuc/widget/waiting_xac_thuc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/qua_tang_xac_thuc_state.dart';

typedef void OnSuccess();

class QuaTangXacThuc extends StatefulWidget {
  final OnSuccess onSuccess;

  const QuaTangXacThuc({Key key, this.onSuccess}) : super(key: key);

  @override
  _QuaTangXacThucState createState() => _QuaTangXacThucState();
}

class _QuaTangXacThucState extends State<QuaTangXacThuc> {
  QuaTangXacThucBloc _bloc;
  QuaTangXacThucService _service;
  ConfigJson dataConfig;
  TextEditingController _maXacThucTextController;
  FocusNode _focusMaXacThucText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _maXacThucTextController = new TextEditingController(text: '');

    this._service = new QuaTangXacThucService(BlocProvider.of<ErrorhandleBloc>(context));
    this._bloc = new QuaTangXacThucBloc(service: this._service);

    /* 
    khởi tạo dữ liệu
     */
    this._bloc.add(InputMaPin(maPin: null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: this._bloc,
      listener: (BuildContext context, QuaTangXacThucState state) {
        if (state is XacThucSuccess) {
          widget.onSuccess();
        }
        if (state is FormXacThucState && state.error != null) {
          this._maXacThucTextController.text = state.maPin;
        }
      },
      child: SingleChildScrollView(
        child: Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          child: BlocBuilder(
            bloc: this._bloc,
            builder: (BuildContext context, QuaTangXacThucState state) {
              if (state is FormXacThucState) {
                return NhapMaXacThuc(
                    focusMaXacThucText: this._focusMaXacThucText,
                    maXacThucTextController: this._maXacThucTextController,
                    bloc: this._bloc);
              }

              if (state is XacThucSuccess) {
                return QuaTangXacThucSuccess();
              }

              if (state is WaitingForm) {
                return WaitingXacThuc();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
