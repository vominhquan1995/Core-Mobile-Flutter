import 'package:Core/core/connection-status/index.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/core/page-core/bloc/bloc.dart';
import 'package:Core/utils/theme.dart';
import 'package:Core/widgets/search_results/widget/app_bar_custom_simple.dart';
import 'package:Core/widgets/upgrade_account/bloc/upgrade_account_bloc.dart';
import 'package:Core/widgets/upgrade_account/bloc_address/address_bloc.dart';
import 'package:Core/widgets/upgrade_account/bloc_upload_image/bloc.dart';
import 'package:Core/widgets/upgrade_account/service/address_service.dart';
import 'package:Core/widgets/upgrade_account/service/image_service.dart';
import 'package:Core/widgets/upgrade_account/service/upgrade_service.dart';
import 'package:Core/widgets/upgrade_account/widgets/form_create_request.dart';
import 'package:Core/widgets/upgrade_account/widgets/form_update_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpgradeAccount extends StatefulWidget {
  UpgradeAccount({Key key}) : super(key: key);
  @override
  _UpgradeAccountState createState() => _UpgradeAccountState();
}

class _UpgradeAccountState extends State<UpgradeAccount> {
  UpgradeAccountBloc bloc;
  UploadImageBloc blocImage;
  AddressBloc blocAdd;
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    bloc = UpgradeAccountBloc(
        service:
            UpgradeAccountService(BlocProvider.of<ErrorhandleBloc>(context)));
    blocAdd = AddressBloc(
        service: AddressService(BlocProvider.of<ErrorhandleBloc>(context)));
    blocImage = UploadImageBloc(
        service: ImageService(BlocProvider.of<ErrorhandleBloc>(context)));
    bloc.add(CheckRequestAccount());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
    blocAdd.close();
    blocImage.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bloc,
        builder: (_, UpgradeAccountState state) {
          if (state is LoadingData) {
            return Scaffold(
              appBar: new AppBarCustomSimple(title: tr('upgrade_salon_1')),
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is NotExitsRequest) {
            return FormCreateRequest(
                bloc: bloc, blocAdd: blocAdd, blocImage: blocImage);
          }
          if (state is ExitsRequest) {
            // return FormInfoRequest(data: state.data);
            return FormUpdateRequest(
                bloc: bloc,
                blocAdd: blocAdd,
                blocImage: blocImage,
                data: state.data);
          }
          if (state is UserIsSalon) {
            return Scaffold(
                appBar: new AppBarCustomSimple(title: tr('upgrade_salon_1')),
                body: Center(
                    child: Text(
                  tr('upgrade_salon_40'),
                  style: style17_semibold,
                )));
          }
          if (state is ErrorNetwork) {
            return Scaffold(
                appBar: new AppBarCustomSimple(title: tr('upgrade_salon_1')),
                body: buildErrorNetwork(state));
          }
          return Scaffold(
            appBar: new AppBarCustomSimple(title: tr('upgrade_salon_1')),
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }

  Center buildErrorNetwork(ErrorNetwork state) {
    return Center(
        child: Connection(
      errorType: state.e,
      onPressed: () => setState(() {
        bloc.add(CheckRequestAccount());
      }),
    ));
  }
}
