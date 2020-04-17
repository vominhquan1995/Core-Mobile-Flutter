// import 'package:Midas/utils/index.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'widget/item_hoan_thanh_thanh_toan.dart';

// class HoanThanhThanhToanMT extends StatefulWidget {
//   @override
//   HoanThanhThanhToanMTState createState() => HoanThanhThanhToanMTState();
// }

// class HoanThanhThanhToanMTState extends State<HoanThanhThanhToanMT> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorGrey_1,
//       appBar: PreferredSize(
//           child: AppBar(
//             backgroundColor: colorBlueV2,
//             // title: ,
//             centerTitle: true,
//             bottom: PreferredSize(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.max,
//                   children: <Widget>[
//                     SvgPicture.asset(
//                       'assets/images/cart-confirm.svg',
//                       width: 60,
//                       height: 60,
//                       color: Colors.white,
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(bottom: paddingM, top: paddingL),
//                       child: Text(
//                         'Cảm ơn Nguyen Van Ngoc!',
//                         style: style15.copyWith(color: colorWhite),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(bottom: paddingXXS),
//                       child: Text(
//                         'Đặt hàng thành công',
//                         style: style20_semibold.copyWith(color: colorWhite),
//                       ),
//                     )
//                   ],
//                 ),
//                 preferredSize: Size.fromHeight(200)),
//           ),
//           preferredSize: Size.fromHeight(200)),
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             /**
//              * 3 cái này dùng cho thanh toán băng tiền mặt 
//              */
//             ItemTienMat(),
//             Container(
//               height: paddingM,
//             ),
//             ItemMaDonHang(),

//             /**
//              *  2 cái dưới  Dùng cho trang thanh toán bằng tk ngân hàng 
//              */
//             // Container(
//             //   height: paddingM,
//             // ),
//             // ItemThanhToanNganHang(),
//           ],
//         ),
//       )),
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.symmetric(vertical: paddingM),
//         color: Colors.white,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             InkWell(
//               onTap: () {},
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: paddingL),
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.only(top: paddingM, bottom: paddingM),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(blurRadius)),
//                     image: DecorationImage(
//                         image:
//                             AssetImage('assets/images/background_appbar.jpg'),
//                         fit: BoxFit.cover)),
//                 child: Text(
//                   'Quay về trang chủ',
//                   textAlign: TextAlign.center,
//                   style: style20.copyWith(color: Colors.white),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
