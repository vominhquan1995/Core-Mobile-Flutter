import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/my_library/models/sanpham_model.dart';
import 'package:Midas/widgets/my_library/widgets/sanpham_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SanPhamHorizontal extends StatelessWidget {
  final String titile;

  final List<SanPhamModel> list;

  SanPhamHorizontal({
    @required this.titile,
    this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(260),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            tr(titile),
            style: style17_semibold.copyWith(color: colorViolet),
          ),
          SizedBox(height: paddingM),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: ScreenUtil().setWidth(100),
                  margin: EdgeInsets.only(right: paddingL),
                  child: SanPhamWidget(sanPhamModel: list[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SanPhamHorizontalShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            width: double.infinity,
            height: 15,
            color: Colors.white,
          ),
        ),
        SizedBox(height: paddingM),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 100,
                margin: EdgeInsets.only(right: paddingL),
                child: SanPhamWidgetShimmer(),
              );
            },
          ),
        ),
      ],
    );
  }
}
