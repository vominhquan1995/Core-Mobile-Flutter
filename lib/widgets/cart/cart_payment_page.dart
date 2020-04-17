import 'package:Core/core/cart/model/cart_model.dart';
import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/core/config_json/models/config_json.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/core/connection-status/index.dart';
import 'package:Core/widgets/cart/cart_confirm_page.dart';
import 'package:Core/widgets/cart/service/cart_service.dart';
import 'package:Core/widgets/cart/widgets/expandable_item.dart';
import 'package:Core/core/google_analytics/index.dart';
import 'package:Core/core/function/snackbar.dart';
import 'package:Core/widgets/shared/image-custom/image-custom.dart';
import 'package:Core/widgets/shared/text_html/text_html.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:Core/widgets/cart/payment_bloc/bloc.dart';

class CartPaymentPage extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<CartPaymentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PaymentBloc bloc;
  ExpandableController controller;
  String currencyF;
  @override
  void initState() {
    // TODO: implement initState

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
    // addBloc = AddressBloc(service: AddressService());
    bloc = PaymentBloc(
        service: CartService(BlocProvider.of<ErrorhandleBloc>(context)));
    var cfBloc = BlocProvider.of<ConfigjsonBloc>(context).state;
    currencyF = cfBloc.currency != null ? cfBloc.currency.format : "#,###.####";
    controller = ExpandableController();
    // addBloc.add(InitData());
    bloc.add(GetCartInfo());
    super.initState();
    GoogleAnalytics.trackScreen(notification_list_page);
  }

  /// Thay đổi trạng thái mạng
  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      bloc.add(GetCartInfo());
      showSnackBarUpdateDataKey(_scaffoldKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorGrey_1,
        appBar: AppBar(
          flexibleSpace: Image(
            image: AssetImage('assets/images/background_appbar.jpg'),
            fit: BoxFit.cover,
            alignment: AlignmentDirectional.center,
          ),
          title: Text(
            tr("cart_payment_1"),
            style: style20_semibold.copyWith(color: colorWhite),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: paddingL),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SvgPicture.asset('assets/images/Tracking.svg'),
                  SvgPicture.asset('assets/images/surface1.svg'),
                  SvgPicture.asset(
                    'assets/images/cart-confirm.svg',
                    color: colorGrey_1.withOpacity(0.55),
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(50),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: paddingXXS),
            child: BlocBuilder<PaymentBloc, PaymentState>(
              bloc: bloc,
              builder: (BuildContext _, PaymentState pstate) {
                if (pstate is LoadedPaymentState) {
                  controller.expanded =
                      pstate.info.withmidaswallet == 1 ? true : false;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: Builder(builder: (_) {
                          return Container(
                              child: Column(children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: paddingXS, horizontal: paddingL),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    var b = pstate.info.withmidaswallet;
                                    pstate.info.withmidaswallet =
                                        (b == 1 ? 0 : 1);
                                    controller.expanded =
                                        (b == 1 ? true : false);
                                  });
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      pstate.info.withmidaswallet == 1
                                          ? Container(
                                              child: SvgPicture.asset(
                                                  'assets/images/check_blue.svg'),
                                            )
                                          : Container(
                                              child: SvgPicture.asset(
                                                  'assets/images/check_white.svg'),
                                            ),
                                      Expanded(
                                          child: Container(
                                        margin: EdgeInsets.only(left: paddingL),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                tr("cart_payment_2"),
                                                style: style17_semibold,
                                              ),
                                            ),
                                            pstate.info.withmidaswallet == 1
                                                ? ExpandableItem(
                                                    info: pstate.info,
                                                    total: pstate.total,
                                                    controller: controller,
                                                    currency: currencyF,
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ))
                                    ]),
                              ),
                            ),
                          ]));
                        }),
                      ),
                      SizedBox(height: paddingM),
                      if (pstate.info.withmidaswallet == 1 &&
                          pstate.info.tienhoahong >= pstate.total)
                        Column()
                      else
                        Container(
                            color: Colors.white,
                            child: BlocBuilder<ConfigjsonBloc, ConfigJson>(
                              builder: (BuildContext _, state) {
                                List<Widget> children = [
                                  Text(tr("cart_payment_6"),
                                      style: style15_semibold),
                                  SizedBox(height: paddingL),
                                ];

                                if (state is ConfigJson &&
                                    state.dataPayment != null) {
                                  final list = state.dataPayment;
                                  for (var item in list) {
                                    children.addAll([
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(0),
                                            child: Radio(
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                value: item.value,
                                                groupValue:
                                                    pstate.info.loaithanhtoan,
                                                onChanged: (value) {
                                                  setState(() {
                                                    pstate.info.loaithanhtoan =
                                                        item.value;
                                                  });
                                                }),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: paddingS,
                                                  left: paddingL,
                                                  right: paddingL),
                                              height: 30,
                                              width: 50,
                                              child: SvgPicture.asset(
                                                item.image,
                                                fit: BoxFit.cover,
                                              )
                                              // HinhAnh(
                                              //   image: item.image,
                                              //   fit: BoxFit.cover,
                                              // ),
                                              ),
                                          Expanded(
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                    bottom: paddingM),
                                                margin: EdgeInsets.only(
                                                    top: paddingS,
                                                    left: paddingL,
                                                    right: paddingS),
                                                child: DefaultTextStyle(
                                                    style: style15,
                                                    child: HtmlText(
                                                        data:
                                                            item.description))),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(bottom: borderSide)),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: paddingM,
                                            vertical: paddingM),
                                      )
                                    ]);
                                  }
                                }

                                return Padding(
                                  padding: EdgeInsets.all(paddingL),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: children,
                                  ),
                                );
                              },
                            ))
                    ],
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: paddingM),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<PaymentBloc, PaymentState>(
                bloc: bloc,
                builder: (BuildContext _, PaymentState state) {
                  if (state is LoadedPaymentState) {
                    return InkWell(
                      onTap: () => moveNext(state),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: paddingL),
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.only(top: paddingM, bottom: paddingM),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(blurRadius)),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/background_appbar.jpg'),
                                fit: BoxFit.cover)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              tr("cart_payment_8"),
                              textAlign: TextAlign.center,
                              style: style20.copyWith(color: Colors.white),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: paddingS),
                              child: SvgPicture.asset(
                                'assets/images/next.svg',
                                fit: BoxFit.cover,
                                color: Colors.white,
                                height: 25,
                                width: 50,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return SizedBox(height: paddingL);
                },
              ),
            ],
          ),
        ));
  }

  void moveNext(state) async {
    final ConfigJson cf = BlocProvider.of<ConfigjsonBloc>(context).state;
    final data = cf.dataPayment ?? [];
    final found = data.where((f) => f.value == state.info.loaithanhtoan);
    if (!(state.info.withmidaswallet == 1 &&
        state.info.tienhoahong >= state.total)) {
      if (found.length == 0) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(tr("cart_payment_7")),
          duration: Duration(seconds: 1),
        ));
        return;
      }
      await CartService(BlocProvider.of<ErrorhandleBloc>(context))
          .updatePaymentInfo(CartInfoModel(
        loaithanhtoan: state.info.loaithanhtoan,
        withmidaswallet: state.info.withmidaswallet,
        tienhoahong: state.info.tienhoahong,
      ));

      return openConfirmPage();
    } else {
      await CartService(BlocProvider.of<ErrorhandleBloc>(context))
          .updatePaymentInfo(CartInfoModel(
        loaithanhtoan: state.info.loaithanhtoan,
        withmidaswallet: state.info.withmidaswallet,
        tienhoahong: state.info.tienhoahong,
      ));
      return openConfirmPage();
    }
  }

  openConfirmPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WidgetsCore(widget: CartConfirmPage())),
    );
  }
}
