import 'package:Core/core/connection-status/index.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/core/page-core/bloc/bloc.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/quoc_gia/bloc/quocgia_bloc.dart';
import 'package:Core/widgets/search_results/widget/app_bar_custom_simple.dart';
import 'package:Core/widgets/shared/image-custom/image-custom.dart';
import 'package:Core/widgets/upgrade_account/bloc_info_salon/info_salon_bloc.dart';
import 'package:Core/widgets/upgrade_account/model/request_upgrade_model.dart';
import 'package:Core/widgets/upgrade_account/service/upgrade_service.dart';
import 'package:Core/widgets/upgrade_account/widgets/widget_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class InfoAccountSalon extends StatefulWidget {
  InfoAccountSalon({Key key}) : super(key: key);

  @override
  _InfoAccountSalonState createState() => _InfoAccountSalonState();
}

class _InfoAccountSalonState extends State<InfoAccountSalon> {
  UpgradeAccountService service;
  InfoSalonBloc bloc;
  String pathImage;
  String urlShare;
  TextEditingController txtCode = new TextEditingController();
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtSubAdd = new TextEditingController();
  TextEditingController txtMainAdd = new TextEditingController();
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    service = UpgradeAccountService(BlocProvider.of<ErrorhandleBloc>(context));
    urlShare = (BlocProvider.of<QuocgiaBloc>(context).state as DanhSachQuocgia)
        .confirm
        .linkWeb;
    bloc = InfoSalonBloc(service: service);
    bloc.add(GetDataInfo());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        backgroundColor: colorBackground,
        appBar: new AppBarCustomSimple(title: tr('upgrade_salon_22')),
        body: BlocBuilder(
            bloc: bloc,
            builder: (_, InfoSalonState state) {
              if (state is LoadingDataSalon) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is UserNotSaLon) {
                return Center(
                    child: Text(
                  tr('upgrade_salon_37'),
                  style: style17_semibold,
                ));
              }
              if (state is LoadedDataSalon) {
                return buildContentView(context, state.data);
              }
              if (state is ErrorNetwork) {
                return buildErrorNetwork(state);
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  Container buildErrorNetwork(ErrorNetwork state) {
    return Container(
        color: colorWhite,
        child: Connection(
          errorType: state.e,
          onPressed: () => setState(() {
            bloc.add(GetDataInfo());
          }),
        ));
  }

  CustomScrollView buildContentView(BuildContext context, RequestUpgrade data) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(child: buildContentSocial(data, context)),
        SliverToBoxAdapter(child: SizedBox(height: paddingXS)),
        SliverToBoxAdapter(child: buildContentInfo(data)),
        SliverToBoxAdapter(child: SizedBox(height: paddingXXS)),
      ],
    );
  }

  Container buildContentSocial(RequestUpgrade data, BuildContext context) {
    return Container(
      color: colorWhite,
      child: Column(
        children: <Widget>[
          SizedBox(height: paddingL),
          Container(
            child: Column(
              children: <Widget>[
                Text(tr('upgrade_salon_23'), style: style17),
                Container(
                    padding: EdgeInsets.symmetric(
                        vertical: paddingL, horizontal: paddingL),
                    child: QrImage(
                      data: '${urlShare}m/${data.maCuaToi}',
                      version: QrVersions.auto,
                      size: MediaQuery.of(context).size.width * 0.6,
                      gapless: false,
                    )),
                Text(
                  data.maCuaToi,
                  style: style20_semibold.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: paddingL),
          Container(
              padding: EdgeInsets.symmetric(horizontal: paddingL),
              child: Html(
                  data: tr('upgrade_salon_36'),
                  defaultTextStyle: style15_lightgrey)),
          SizedBox(height: paddingL),
          Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(59, 89, 152, 1),
                borderRadius: BorderRadius.circular(5.0)),
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2),
            height: 50,
            child: FlatButton(
                onPressed: () {
                  Share.share('${urlShare}m/${data.maGioiThieu}');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: paddingL),
                      child: Image.asset('assets/share_fb_icon.png',
                          height: 25, width: 25),
                    ),
                    Text(
                      tr('upgrade_salon_24'),
                      style: style17_lightgrey.copyWith(color: colorWhite),
                    ),
                  ],
                )),
          ),
          SizedBox(height: paddingXS),
        ],
      ),
    );
  }

  Container buildContentInfo(RequestUpgrade data) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: paddingM),
        color: colorWhite,
        child: Column(
          children: <Widget>[
            SizedBox(height: paddingL),
            RowForm(
                isView: true,
                title: tr('upgrade_salon_3'),
                child: TextFiledView(
                    text: data.maGioiThieu, isBorderUnder: false)),
            SizedBox(height: paddingL),
            RowForm(
                isView: true,
                title: tr('upgrade_salon_6'),
                child: Container(
                  height: 200,
                  child: HinhAnh(
                    image: data.hinhAnh,
                    fit: BoxFit.contain,
                  ),
                )),
            SizedBox(height: paddingL),
            RowForm(
                isView: true,
                title: tr('upgrade_salon_9'),
                child: TextFiledView(text: data.tenShop)),
            SizedBox(height: paddingL),
            RowForm(
                isView: true,
                title: tr('upgrade_salon_10'),
                child: TextFiledView(text: data.diaChiShop)),
            SizedBox(height: paddingL),
            RowForm(
              isView: true,
              title: tr('upgrade_salon_11'),
              child: TextFiledView(
                  text:
                      '${data.tinhName} - ${data.quanName} - ${data.phuongName}'),
            ),
            SizedBox(height: paddingXS),
          ],
        ));
  }
}
