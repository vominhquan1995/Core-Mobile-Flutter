import 'package:Core/core/translate/public.dart';
import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/cart/cart_list_page.dart';
import 'package:Core/widgets/my_library/models/sanpham_model.dart';
import 'package:Core/widgets/shared/image-custom/image-custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'body_content_detail.dart';
import 'button_custom.dart';

class ModalAddProductSuccess extends StatelessWidget {
  final SanPhamModel detail;
  const ModalAddProductSuccess({Key key, @required this.detail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: paddingM),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Icon(Icons.check_circle_outline, color: colorBlue),
                ),
                Expanded(
                  flex: 8,
                  child: Text(
                    tr('product_details_5'),
                    style: style15.copyWith(color: colorBlue),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: IconButton(
                      alignment: Alignment.topRight,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: colorBlack,
                      ),
                    ))
              ],
            ),
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                    flex: 3,
                    child: Container(
                      color: colorWhite,
                      padding: EdgeInsets.symmetric(
                          horizontal: paddingM, vertical: paddingM),
                      child: HinhAnh(
                        fit: BoxFit.cover,
                        image: (detail.image),
                      ),
                    )),
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TitleCodeProduct(title: detail.maSanPham),
                      TitleProduct(title: detail.tenSanPham),
                      SizedBox(height: paddingL),
                      // PriceItem(data: detail.donGia),
                      PriceItem(
                        lastPrice: detail.donGia,
                        salePrice: detail.donGiaSale,
                        percent: detail.phanTram,
                        type: detail.typeDisplay,
                      ),
                    ],
                  ),
                )
              ],
            )),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingL),
              child: RaisedButton(
                onPressed: () {
                  goToCart(context);
                },
                padding: EdgeInsets.symmetric(vertical: paddingL),
                color: colorRed,
                child: Text(
                  tr('product_details_6'),
                  style: style17.copyWith(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: paddingL),
            // Container(
            //   height: 50,
            //   margin:
            //       EdgeInsets.symmetric(horizontal: paddingXS, vertical: paddingM),
            //   child: FlatButton(
            //       padding: EdgeInsets.all(paddingM),
            //       color: colorOrange,
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //       child: Text(
            //         'Xem giỏ hàng',
            //         style: style20_lightgrey.copyWith(color: colorWhite),
            //       )),
            // )
          ],
        ),
      ),
    );
  }

  goToCart(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => WidgetsCore(widget: CartListPage())),
    );
  }
}
