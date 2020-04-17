import 'package:Midas/core/authentication/bloc/bloc.dart';
import 'package:Midas/core/authentication/bloc/bloc.dart';
import 'package:Midas/core/cart/model/cart_model.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Midas/core/page-core/widget_custom.dart';
import 'package:Midas/widgets/cart/service/cart_service.dart';
import 'package:Midas/widgets/cart/widgets/widget_form.dart';
import 'package:Midas/widgets/shared/user_need_login/user_need_login.dart';
import 'package:Midas/widgets/upgrade_account/bloc_address/address_bloc.dart';
import 'package:Midas/widgets/upgrade_account/model/address_model.dart';
import 'package:Midas/widgets/upgrade_account/service/address_service.dart';
import 'package:Midas/widgets/upgrade_account/widgets/select_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Midas/core/connection-status/index.dart';
import 'package:Midas/core/function/snackbar.dart';
import 'package:Midas/core/google_analytics/index.dart';
import 'package:Midas/utils/theme.dart';
import 'package:flutter_svg/svg.dart';
import 'cart_payment_page.dart';
import 'info_bloc/bloc.dart';

// import 'notification_detail_page.dart';

class CartInfoPage extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<CartInfoPage> {
  ScrollController _scrollController = new ScrollController();

  TextEditingController _tenController = new TextEditingController();
  TextEditingController _sdtController = new TextEditingController();
  TextEditingController _diachiController = new TextEditingController();
  TextEditingController _tinhtpController = new TextEditingController();
  TextEditingController _ghichuController = new TextEditingController();

  Province provinceSelected;
  District districtSelected;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  InfoBloc bloc;
  AddressBloc addBloc;

  @override
  void initState() {
    // TODO: implement initState

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
    addBloc = AddressBloc(
        service: AddressService(BlocProvider.of<ErrorhandleBloc>(context)));
    // addBloc = BlocProvider.of<AddressBloc>(context);
    bloc = InfoBloc(
        service: CartService(BlocProvider.of<ErrorhandleBloc>(context)));
    if (BlocProvider.of<AuthenticationBloc>(context).state
        is AuthenticationAuthenticated) {
      addBloc.add(InitData());
      bloc.add(GetCartInfo());
    }
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
  void dispose() async {
    // TODO: implement dispose
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (BuildContext _, state) {
            if (state is AuthenticationAuthenticated) {
              //login success
              addBloc.add(InitData());
              bloc.add(GetCartInfo());
            }
          },
        ),
      ],
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: colorGrey_1,
          appBar: AppBar(
            flexibleSpace: Image(
              image: AssetImage('assets/images/background_appbar.jpg'),
              fit: BoxFit.cover,
              alignment: AlignmentDirectional.center,
            ),
            title: Text(
              tr("cart_info_1"),
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
                    SvgPicture.asset(
                      'assets/images/surface1.svg',
                      color: colorGrey_1.withOpacity(0.55),
                    ),
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
          body: buildBody(),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: paddingM),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BlocBuilder<InfoBloc, InfoState>(
                  bloc: bloc,
                  builder: (BuildContext _, InfoState state) {
                    if (state is LoadedInfoState) {
                      return InkWell(
                        onTap: () {
                          var valid = _formKey.currentState.validate();
                          if (valid) {
                            return moveNext();
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: paddingL),
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
                                tr("cart_info_11"),
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
          )),
    );
  }

  buildBody() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationAuthenticated) {
          return bodyContentCart();
        }
        if (state is AuthenticationUnauthenticated) {
          return UserNeedLogin();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  bodyContentCart() {
    return BlocBuilder<InfoBloc, InfoState>(
      bloc: bloc,
      builder: (BuildContext _, InfoState state) {
        if (state is LoadedInfoState) {
          _tenController.text = state.info.ten;
          _sdtController.text = state.info.sodienthoai;
          _diachiController.text = state.info.diachi;
          _tinhtpController.text =
              state.info.tinhname + ' - ' + state.info.quanname;
          _ghichuController.text = state.info.ghichu;
          provinceSelected =
              Province(id: state.info.tinhid, fullName: state.info.tinhname);
          districtSelected =
              District(id: state.info.quanid, fullName: state.info.quanname);
          return SingleChildScrollView(
              child: GestureDetector(
            onTap: () {
              // call this method here to hide soft keyboard
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            child: Container(
              margin: EdgeInsets.only(bottom: paddingXXS),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(paddingL),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: paddingM),
                              child: RichText(
                                text: TextSpan(
                                  style: style15,
                                  children: [
                                    TextSpan(
                                        text: tr("cart_info_2"),
                                        style: style13),
                                    TextSpan(
                                        text: ' (*)',
                                        style:
                                            style13.copyWith(color: colorRed)),
                                  ],
                                ),
                              ),
                            ),
                            TextFormField(
                              style: style15_semibold,
                              decoration: InputDecoration(
                                labelStyle: style13,
                                // hintText: "Nhập tên người nhận",
                                hintText: "",
                                hintStyle: style13_lightgrey,
                              ),
                              controller: _tenController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return tr("cart_info_8");
                                }
                                return null;
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(top: paddingXS),
                              child: RichText(
                                text: TextSpan(
                                  style: style15,
                                  children: [
                                    TextSpan(
                                        text: tr("cart_info_3"),
                                        style: style13),
                                    TextSpan(
                                        text: ' (*)',
                                        style:
                                            style13.copyWith(color: colorRed)),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                style: style15_semibold,
                                decoration: InputDecoration(
                                  labelStyle: style13,
                                  // hintText: "Nhập số điện thoại",
                                  hintText: "",
                                  hintStyle: style13_lightgrey,
                                ),
                                controller: _sdtController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return tr("cart_info_9");
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: paddingXS),
                              child: RichText(
                                text: TextSpan(
                                  style: style15,
                                  children: [
                                    TextSpan(
                                        text: tr("cart_info_4"),
                                        style: style13),
                                    TextSpan(
                                        text: ' (*)',
                                        style:
                                            style13.copyWith(color: colorRed)),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              // padding: EdgeInsets.only(top: paddingL),
                              child: TextFormField(
                                style: style15_semibold,
                                decoration: InputDecoration(
                                  labelStyle: style13,
                                  // hintText: "Nhập địa chỉ nhận hàng",
                                  hintText: "",
                                  hintStyle: style13_lightgrey,
                                ),
                                controller: _diachiController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return tr("cart_info_10");
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: paddingXS),
                              child: RowForm(
                                  title: tr("cart_info_5"),
                                  child: ButtonSelectAddress(
                                      onTap: () {
                                        // selectAddress(addBloc);
                                        SelectAddress().onPick(context, addBloc,
                                            (Province province,
                                                District district, Ward ward) {
                                          provinceSelected = province;
                                          districtSelected = district;
                                          // wardSelected = ward;
                                          _tinhtpController.text =
                                              '${provinceSelected.fullName} - ${districtSelected.fullName}';
                                        });
                                      },
                                      ctr: _tinhtpController)),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onPanDown: (_) {
                          // FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(top: paddingM),
                            padding: EdgeInsets.all(paddingL),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: paddingM),
                                  child: Text(
                                    tr("cart_info_6"),
                                    style: style13,
                                  ),
                                ),
                                TextFormField(
                                  maxLines: 3,
                                  controller: _ghichuController,
                                  style: style15_semibold,
                                  decoration: InputDecoration(
                                    labelStyle: style13,
                                    hintText: tr("cart_info_7"),
                                    hintStyle: style13_lightgrey,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: borderSide,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: borderSide,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  )),
            ),
          ));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  selectedProvince(Province item) {
    provinceSelected = item;
    _tinhtpController.text = '';
  }

  selectedDistrict(District item) {
    districtSelected = item;
    _tinhtpController.text =
        '${provinceSelected.fullName} - ${districtSelected.fullName} ';
  }

  moveNext() async {
    // bloc.add(GetCartInfo());
    await CartService(BlocProvider.of<ErrorhandleBloc>(context))
        .updateInfo(CartInfoModel(
      phuongid: "",
      phuongname: "",
      ten: _tenController.text,
      diachi: _diachiController.text,
      sodienthoai: _sdtController.text,
      tinhid: provinceSelected.id,
      tinhname: provinceSelected.fullName,
      quanid: districtSelected.id,
      quanname: districtSelected.fullName,
      ghichu: _ghichuController.text,
    ));
    bloc.add(GetCartInfo());
    return openPaymentPage();
  }

  openPaymentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WidgetsCore(widget: CartPaymentPage())),
    );
  }
}
