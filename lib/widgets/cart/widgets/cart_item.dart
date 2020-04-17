import 'package:Core/core/cart/bloc/core_cart_bloc.dart';
import 'package:Core/core/cart/bloc/core_cart_event.dart';
import 'package:Core/core/cart/model/cart_model.dart';
import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/core/config_json/models/config_json.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/shared/border-dash/index.dart';
import 'package:Core/widgets/shared/image-custom/image-custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'package:Core/widgets/cart/cart_bloc/bloc.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartItem;
  final CartBloc bloc;
  final String currency;

  CartItem({this.cartItem, this.bloc, this.currency});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
          padding:
              EdgeInsets.only(left: paddingL, bottom: paddingL, top: paddingXS),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 80,
                  width: 100,
                  child: HinhAnh(
                    image: cartItem.hinhdaidien,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  child: Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: paddingM + 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            cartItem.masanpham ?? '',
                            style: style13_lightgrey.copyWith(
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: paddingM),
                          child: Text(
                            cartItem.tensanpham ?? '',
                            style: style15,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: paddingM),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: cartItem.iskhuyenmai
                                ? <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                            NumberFormat(currency)
                                                .format(cartItem.dongia ?? 0),
                                            style: style17_black),
                                        SizedBox(width: paddingL),
                                        Text(('(-${cartItem.percent}%)'),
                                            style: style17_semibold.copyWith(
                                                color: Colors.red))
                                      ],
                                    ),
                                    SizedBox(height: paddingS),
                                    Text(
                                      NumberFormat(currency)
                                          .format(cartItem.dongiagoc ?? 0),
                                      style: style13_lightgrey.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    )
                                  ]
                                : <Widget>[
                                   Text(
                                      NumberFormat(currency)
                                          .format(cartItem.dongia ?? 0),
                                      style: style17_semibold,
                                    )
                                  ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: paddingL),
                          child: Row(children: <Widget>[
                            InkWell(
                              onTap: () {
                                bloc.add(UpdateQuantity(
                                    item: cartItem, increase: false));
                              },
                              child: Container(
                                padding: EdgeInsets.all(paddingS),
                                color: colorGrey_2,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              color: colorGrey_1,
                              padding: EdgeInsets.symmetric(
                                  horizontal: paddingL, vertical: paddingS + 1),
                              child: Text(
                                cartItem.soluong.toString() ?? '0',
                                style: style17_semibold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                bloc.add(UpdateQuantity(
                                    item: cartItem, increase: true));
                              },
                              child: Container(
                                padding: EdgeInsets.all(paddingS),
                                color: colorGrey_2,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),
                  )),
                ),
                InkWell(
                  onTap: () {
                    bloc.add(RemoveItem(item: cartItem));
                    BlocProvider.of<CoreCartBloc>(context)
                        .add(RemoveCartItem());
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: paddingS, bottom: paddingL, right: paddingL),
                    child: Icon(
                      Icons.close,
                      color: colorGrey_4,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class CartItemShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title,
          SizedBox(height: paddingM),
          subtitle,
          SizedBox(height: paddingS),
          MySeparator(color: colorGrey_2)
        ],
      ),
    );
  }

  final title = Shimmer.fromColors(
    baseColor: Colors.grey[300],
    highlightColor: Colors.grey[100],
    child: Container(
      width: double.infinity,
      height: 10.0,
      color: Colors.white,
    ),
  );

  final subtitle = Shimmer.fromColors(
    baseColor: Colors.grey[300],
    highlightColor: Colors.grey[100],
    child: Container(
      width: 150,
      height: 10.0,
      color: Colors.white,
    ),
  );
}
