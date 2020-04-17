import 'package:Midas/core/cart/model/cart_model.dart';
import 'package:Midas/core/config_json/bloc/configjson_bloc.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/my_library/my_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/item_hoan_thanh_thanh_toan.dart';

class CartCompleteTienMat extends StatefulWidget {
  final CartResultModel result;
  CartCompleteTienMat({Key key, @required this.result}) : super(key: key);
  @override
  CartCompleteTienMatState createState() => CartCompleteTienMatState();
}

class CartCompleteTienMatState extends State<CartCompleteTienMat> {
  String currencyF;
  @override
  void initState() {
    super.initState();
    var cfBloc = BlocProvider.of<ConfigjsonBloc>(context).state;
    currencyF = cfBloc.currency != null ? cfBloc.currency.format : "#,###.####";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGrey_1,
      appBar: PreferredSize(
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: colorBlueV2,
            // title: ,
            centerTitle: true,
            bottom: PreferredSize(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/cart-confirm.svg',
                      width: 60,
                      height: 60,
                      color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: paddingM, top: paddingL),
                      child: Text(
                        '${tr("cart_result_1")} ${widget.result.ten}!',
                        style: style15.copyWith(color: colorWhite),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: paddingXXS),
                      child: Text(
                        tr("cart_result_2"),
                        style: style20_semibold.copyWith(color: colorWhite),
                      ),
                    )
                  ],
                ),
                preferredSize: Size.fromHeight(200)),
          ),
          preferredSize: Size.fromHeight(200)),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /**
             * 3 cái này dùng cho thanh toán băng tiền mặt 
             */
            ItemTienMat(result: widget.result, currency: currencyF),
            Container(
              height: paddingM,
            ),
            ItemMaDonHang(result: widget.result),

            /**
             *  2 cái dưới  Dùng cho trang thanh toán bằng tk ngân hàng 
             */
            // Container(
            //   height: paddingM,
            // ),
            // ItemThanhToanNganHang(),
          ],
        ),
      )),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: paddingM),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () => returnHome(),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: paddingL),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: paddingM, bottom: paddingM),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(blurRadius)),
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/background_appbar.jpg'),
                        fit: BoxFit.cover)),
                child: Text(
                  tr("cart_result_7"),
                  textAlign: TextAlign.center,
                  style: style20.copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  returnHome() {
    Navigator.popUntil(context, ModalRoute.withName('/')
        // MaterialPageRoute(builder: (context) => CartInfoPage()),
        );
  }
}
