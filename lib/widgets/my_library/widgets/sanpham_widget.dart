import 'package:Core/core/translate/public.dart';
import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/detail_product/detail_product.dart';
import 'package:Core/widgets/my_library/models/sanpham_model.dart';
import 'package:Core/widgets/shared/image-custom/image-custom.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SanPhamWidget extends StatelessWidget {
  final SanPhamModel sanPhamModel;

  SanPhamWidget({this.sanPhamModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => WidgetsCore(
                widget: DetailProduct(sanPhamId: sanPhamModel.id))));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  HinhAnh(
                    fit: BoxFit.cover,
                    image: sanPhamModel.image,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Wrap(
                      children: sanPhamModel.policy
                          .map(
                            (f) => SizedBox(
                              height: 32,
                              child: Image.network(
                                f.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                    Text(
                      sanPhamModel.tenSanPham,
                      maxLines: 2,
                      style: style13,
                    ),
                  ] +
                  buildContent(context, sanPhamModel),
            ),
          )
        ],
      ),
    );
  }

  buildContent(BuildContext context, SanPhamModel data) {
    List<Widget> items = [];
    switch (data.typeDisplay) {
      case TYPE_DISPLAY_PRICE.TYPE_1:
        items.addAll([
          //row 1 => last price
          SizedBox(height: paddingS),
          Text(data.donGia, style: style15_black),
          //row 2 => out off
          SizedBox(height: paddingS),
          Text(
            tr('product_details_2').toUpperCase(),
            maxLines: 1,
            style: style13.copyWith(color: Colors.redAccent),
          ),
        ]);

        break;
      case TYPE_DISPLAY_PRICE.TYPE_2:
        //row 1 => last price

        items.addAll([
          SizedBox(height: paddingS),
          Text(data.donGiaSale, style: style15_black),
          SizedBox(height: paddingS),
          Text('(-${data.phanTram}%)',
              style: style13_semibold.copyWith(color: Colors.red)),
          SizedBox(height: paddingS),
          Text(
            data.donGia,
            style: style13_lightgrey.copyWith(
              decoration: TextDecoration.lineThrough,
            ),
          )
        ]);

        break;
      case TYPE_DISPLAY_PRICE.TYPE_3:
        items.addAll([
          SizedBox(height: paddingS),
          Text(data.donGia, style: style15_black),
          SizedBox(height: style13.fontSize)
        ]);
        break;
      default:
    }
    return items;
  }
}

class SanPhamWidgetShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(10), child: _buildShimmer(100)),
        SizedBox(height: paddingM),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildShimmer(14),
              SizedBox(height: paddingM),
              _buildShimmer(14),
              SizedBox(height: paddingM),
              _buildShimmer(14)
            ],
          ),
        )
      ],
    );
  }

  _buildShimmer(double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        width: double.infinity,
        height: height,
        color: Colors.white,
      ),
    );
  }
}
