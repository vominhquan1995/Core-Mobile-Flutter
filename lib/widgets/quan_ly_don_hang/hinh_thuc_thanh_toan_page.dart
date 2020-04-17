import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/quan_ly_don_hang/widget/expandable_item.dart';
import 'package:Midas/widgets/quan_ly_don_hang/widget/hinhthuc_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HinhThucThanhToan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGrey_1,
      appBar: AppBar(
        flexibleSpace: Image(
          image: AssetImage('assets/images/background_appbar.jpg'),
          fit: BoxFit.cover,
          alignment: AlignmentDirectional.center,
        ),
        title: Text(
          'Hình thức thanh toán',
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
                SvgPicture.asset('assets/images/cart-confirm.svg'),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(50),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(color: Colors.white, child: ExpandableItem()),
          SizedBox(height: paddingL),
          Container(
            color: Colors.white,
            child: HinhThuc(),
          )
        ],
      ),
    );
  }
}
