import 'package:Midas/core/authentication/bloc/bloc.dart';
import 'package:Midas/core/authentication/login-mobile/login_dien_thoai_page.dart';
import 'package:Midas/core/cart/model/cart_model.dart';
import 'package:Midas/core/cart/service/cart_service.dart';
import 'package:Midas/core/config_json/bloc/configjson_bloc.dart';
import 'package:Midas/core/config_json/models/config_json.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/core/data-status/index.dart';
import 'package:Midas/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Midas/core/page-core/widget_custom.dart';
import 'package:Midas/widgets/cart/service/cart_service.dart';
import 'package:Midas/widgets/my_library/my_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Midas/core/connection-status/index.dart';
import 'package:Midas/core/function/snackbar.dart';
import 'package:Midas/core/google_analytics/index.dart';
import 'package:Midas/utils/theme.dart';
import 'package:intl/intl.dart';

import 'cart_bloc/bloc.dart';
// import 'notification_detail_page.dart';
import 'cart_info_page.dart';
import 'widgets/cart_item.dart';

class CartListPage extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<CartListPage> {
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CartBloc blocCart;
  String currencyF;
  bool isLogin;
  @override
  void initState() {
    // TODO: implement initState

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
    blocCart = CartBloc(
        service: CartService(BlocProvider.of<ErrorhandleBloc>(context)));
    isLogin = BlocProvider.of<AuthenticationBloc>(context).state
        is AuthenticationAuthenticated;
    blocCart.add(GetDataCart(isPrivate: isLogin));

    var cfBloc = BlocProvider.of<ConfigjsonBloc>(context).state;
    currencyF = cfBloc.currency != null ? cfBloc.currency.format : "#,###.####";
    // CoreCartService().clearCart();
    // var item1 = new CartItemModel(sanphamid: '404', listtinhchatids: []);
    // var item2 = new CartItemModel(sanphamid: '444', listtinhchatids: [74]);

    // CoreCartService().addToCart(item1).then((result) => {
    //       CoreCartService()
    //           .addToCart(item2)
    //           .then((result) => {blocCart.add(GetDataCart())})
    //     });

    super.initState();
    GoogleAnalytics.trackScreen(notification_list_page);
  }

  /// Thay đổi trạng thái mạng
  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      blocCart.add(GetDataCart(isPrivate: isLogin));
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
          tr("cart_1"),
          style: style20_semibold.copyWith(color: colorWhite),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BlocBuilder<CartBloc, CartState>(
              bloc: blocCart,
              builder: (BuildContext _, CartState state) {
                if (state is LoadedCartState) {
                  return Container(
                      margin: EdgeInsets.only(bottom: paddingXS),
                      child: buildList(state));
                }

                Widget w = Center(child: CircularProgressIndicator());
                if (state is EmptyCartState) {
                  w = Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        // color: Colors.blue,
                        child: Opacity(
                          opacity: 0.7,
                          child: Image.asset("assets/images/cart_empty.png",
                              width: 220),
                        ),
                        // padding: EdgeInsets.only(bottom: paddingL),
                      ),
                      Center(
                          child: Padding(
                        padding: EdgeInsets.all(paddingXXS),
                        child: Column(
                          children: <Widget>[
                            Container(
                              // color: Colors.orange,
                              child: Text(tr("cart_2"),
                                  textAlign: TextAlign.center,
                                  style: style28.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(22, 45, 61, 1))),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: paddingL,
                                  bottom: paddingXXS,
                                  left: paddingXXS,
                                  right: paddingXXS),
                              child: Text(
                                tr("cart_3"),
                                textAlign: TextAlign.center,
                                style: style15.copyWith(
                                    color: Color.fromRGBO(122, 146, 165, 1)),
                              ),
                            ),
                            InkWell(
                                onTap: () => returnHome(),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: paddingL),
                                  padding: EdgeInsets.symmetric(
                                      vertical: paddingL,
                                      horizontal: paddingXXS),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(blurRadius)),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/background_appbar.jpg'),
                                          fit: BoxFit.cover)),
                                  child: Text(
                                    tr("cart_4"),
                                    textAlign: TextAlign.center,
                                    style: style15.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ))
                          ],
                        ),
                      )),
                    ],
                  );
                }

                if (state is ErrorCartState) {
                  w = Connection(
                    errorType: state.e,
                    onPressed: () =>
                        blocCart.add(GetDataCart(isPrivate: isLogin)),
                  );
                }

                return Flexible(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height -
                        (style34_black.fontSize +
                            MediaQuery.of(context).padding.top +
                            paddingXS * 5),
                    child: w,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: paddingM),
        color: Colors.white,
        child: BlocBuilder<CartBloc, CartState>(
          bloc: blocCart,
          builder: (BuildContext _, CartState state) {
            if (state is LoadedCartState) {
              return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: paddingL),
                      margin: EdgeInsets.symmetric(horizontal: paddingL),
                      child: Row(
                        children: <Widget>[
                          Text(
                            tr("cart_5"),
                            style: style15,
                          ),
                          Text(
                            "${NumberFormat(currencyF).format(state.total)}",
                            style: style22_semibold.copyWith(color: colorRed),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    InkWell(
                      onTap: () => openInfoPage(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: paddingL),
                        padding: EdgeInsets.symmetric(
                            vertical: paddingM, horizontal: paddingXXS),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(blurRadius)),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/background_appbar.jpg'),
                                fit: BoxFit.cover)),
                        child: Text(
                          tr("cart_6"),
                          textAlign: TextAlign.center,
                          style: style20.copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  ]);
            }
            return SizedBox(height: paddingL);
          },
        ),
      ),
    );
  }

  Widget buildList(LoadedCartState state) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: paddingL),
      physics: ClampingScrollPhysics(),
      itemCount: state.list.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext ctxt, int index) {
        return index >= state.list.length
            ? CartItemShimmer()
            : CartItem(
                currency: currencyF,
                bloc: blocCart,
                cartItem: state.list[index],
              );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(border: Border(bottom: borderSide)),
          margin: EdgeInsets.symmetric(horizontal: paddingL),
        );
      },
    );
  }

  returnHome() {
    Navigator.popUntil(context, ModalRoute.withName('/')
        // MaterialPageRoute(builder: (context) => CartInfoPage()),
        );
  }

  openInfoPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WidgetsCore(widget: CartInfoPage())),
    );
  }

  openLoginPage() {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              WidgetsCore(widget: LoginDienThoai()),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        )
        // MaterialPageRoute(builder: (context) => CartInfoPage()),
        );
  }
}
