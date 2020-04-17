import 'package:Core/core/cart/bloc/index.dart';
import 'package:Core/core/cart/model/cart_model.dart';
import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/cart/cart_complete_tien_mat.dart';
import 'package:Core/widgets/cart/cart_complete_ngan_hang.dart';
import 'package:Core/widgets/cart/cart_complete_vi_midas.dart';
import 'package:Core/widgets/cart/service/cart_service.dart';
import 'package:Core/widgets/cart/widgets/confirm_items_detail-don-hang.dart';
import 'package:Core/widgets/my_library/my_library.dart';
import 'package:flutter/material.dart';
import 'package:Core/core/connection-status/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

enum ConfirmAction { CANCEL, OK }

class CartConfirmPage extends StatefulWidget {
  const CartConfirmPage({Key key}) : super(key: key);
  @override
  _CartConfirmPageState createState() => _CartConfirmPageState();
}

class _CartConfirmPageState extends State<CartConfirmPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loading = false;
  String currencyF;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);

    var cfBloc = BlocProvider.of<ConfigjsonBloc>(context).state;
    currencyF = cfBloc.currency != null ? cfBloc.currency.format : "#,###.####";
  }

  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // this._blocQuocGia.dispose();
    // _blocFormDienThoai.close();
  }

  Future<List<CartItemModel>> getCart() async {
    return CartService(BlocProvider.of<ErrorhandleBloc>(context))
        .getCartItemWithoutAPI();
  }

  Future<CartInfoModel> getInfo() async {
    return CartService(BlocProvider.of<ErrorhandleBloc>(context)).getInfo();
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
          tr("cart_confirm_1"),
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
                  color: Colors.white,
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(50),
        ),
      ),
      body: SafeArea(
        child: listNews(),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            left: paddingL, right: paddingL, top: paddingL, bottom: paddingM),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FutureBuilder<List<CartItemModel>>(
              future: getCart(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<CartItemModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox();
                } else {
                  if (snapshot.hasError)
                    return SizedBox();
                  else {
                    var total = snapshot.data
                        .map((f) => f.dongia * f.soluong)
                        .reduce((value, elem) => value + elem);
                    return Row(
                      children: <Widget>[
                        Text(
                          tr("cart_confirm_8"),
                          style: style15,
                        ),
                        Text(
                          "${NumberFormat(currencyF).format(total)}",
                          style: style22_semibold.copyWith(color: colorRed),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    );
                  }
                }
              },
            ),
            //build buttom confirm
            buildButtonConfirm()
          ],
        ),
      ),
    );
  }

  Widget buildButtonConfirm() {
    if (loading) {
      return LinearProgressIndicator();
    }
    return InkWell(
      onTap: () {
        return confirm(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: paddingL),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: paddingM, bottom: paddingM),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(blurRadius)),
            image: DecorationImage(
                image: AssetImage('assets/images/background_appbar.jpg'),
                fit: BoxFit.cover)),
        child: Text(
          tr("cart_confirm_9"),
          textAlign: TextAlign.center,
          style: style20.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget listNews() {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        FutureBuilder<List<CartItemModel>>(
          future: getCart(), // function where you call your api
          builder: (BuildContext context,
              AsyncSnapshot<List<CartItemModel>> snapshot) {
            // AsyncSnapshot<Your object type>
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox();
              // return Center(child: Text('Please wait its loading...'));
            } else {
              if (snapshot.hasError)
                return SizedBox();
              else
                return ItemListSanPham(
                  currency: currencyF,
                  sanPham: snapshot.data ?? [],
                  // tienTe: snapshot.data.donViTienTe.kyHieuTienTe,
                );
            }
          },
        ),
        FutureBuilder<CartInfoModel>(
          future: getInfo(), // function where you call your api
          builder:
              (BuildContext context, AsyncSnapshot<CartInfoModel> snapshot) {
            // AsyncSnapshot<Your object type>
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox();
              // return Center(child: Text('Please wait its loading...'));
            } else {
              if (snapshot.hasError)
                return SizedBox();
              else
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ItemDiaChiNhan(data: snapshot.data),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: ItemHinhThucThanhToan(
                          data: snapshot.data,
                        )),
                  ],
                );
            }
          },
        ),
        if (loading) Center(child: CircularProgressIndicator()),
      ],
    );
  }

  void confirm(BuildContext context) async {
    //waiting
    setState(() {
      loading = true;
    });
    final ConfirmAction action = await _dialogConfirm(context);
    if (action == ConfirmAction.OK) {
      //waiting
      setState(() {
        loading = false;
      });
      // return openCompletePage(4);
      var result = await CartService(BlocProvider.of<ErrorhandleBloc>(context))
          .createTransaction();
      BlocProvider.of<CoreCartBloc>(context).add(ClearCart());
      return openCompletePage(result);
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  Future<ConfirmAction> _dialogConfirm(BuildContext context) {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(tr("cart_confirm_10")),
          content: new Text(""),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(tr("cart_confirm_11")),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            new FlatButton(
              child: new Text(tr("cart_confirm_12")),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.OK);
              },
            ),
          ],
        );
      },
    );
  }

  openCompletePage(CartResultModel result) {
    var page;
    switch (result.loaithanhtoan) {
      case 1:
        page = WidgetsCore(widget: CartCompleteViMidas(result: result));
        break;
      case 3:
        page = WidgetsCore(widget: CartCompleteNganHang(result: result));
        break;
      case 4:
        page = WidgetsCore(widget: CartCompleteTienMat(result: result));
        break;
      default:
        page = WidgetsCore(widget: MyLibrary());
    }
    Navigator.pushAndRemoveUntil(
        context,
        // PageRouteBuilder(
        //   pageBuilder: (context, animation, secondaryAnimation) => page,
        //   transitionsBuilder: (BuildContext context,
        //       Animation<double> animation,
        //       Animation<double> secondaryAnimation,
        //       Widget child) {
        //     return new SlideTransition(
        //       position: new Tween<Offset>(
        //         begin: const Offset(1.0, 0.0),
        //         end: Offset.zero,
        //       ).animate(animation),
        //       child: child,
        //     );
        //   },
        // ),
        MaterialPageRoute(builder: (context) => page),
        ModalRoute.withName('/')
        // MaterialPageRoute(builder: (context) => CartInfoPage()),
        );
  }
}
