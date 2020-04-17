import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/my_library/models/sanpham_model.dart';
import 'package:Midas/widgets/my_library/widgets/sanpham_widget.dart';
import 'package:flutter/material.dart';

class SanPhamGrid extends StatelessWidget {
  final String title;
  final String keyWord;
  final List<SanPhamModel> list;

  final Function onPressed;
  SanPhamGrid(
      {@required this.title,
      @required this.list,
      @required this.onPressed,
      this.keyWord});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tr(title),
          style: style17_semibold.copyWith(color: colorViolet),
        ),
        SizedBox(height: paddingM),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: paddingL,
            crossAxisSpacing: paddingL,
            childAspectRatio: 0.58,
            // childAspectRatio: 0.5,
          ),
          itemBuilder: (BuildContext context, int index) {
            return SanPhamWidget(sanPhamModel: list[index]);
          },
        ),
      ],
    );
  }
}
