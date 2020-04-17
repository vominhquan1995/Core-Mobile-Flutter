// import 'package:Core/utils/theme.dart';
// import 'package:Core/widgets/shared/text_html/text_html.dart';
// import 'package:flutter/material.dart';

// class ItemTienMat extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(top: paddingL, bottom: paddingM),
//               child: Text(
//                 'Vui lòng chuẩn bị số tiền cần thanh toán',
//                 style: style15,
//               ),
//             ),
//             Container(
//               child: Text(
//                 '1,789,000đ',
//                 style: style22_semibold.copyWith(color: colorBlueV2),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: paddingL, bottom: paddingXS),
//               child: Text(
//                 'Chúng tôi sẽ giao hàng trong thời gian sớm nhất',
//                 style: style15,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ItemMaDonHang extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(paddingL),
//       color: Colors.white,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Container(
//             child: Text(
//               'Mã đơn hàng: 123123',
//               style: style15_semibold,
//             ),
//           ),
//           InkWell(
//             onTap: () {},
//             child: Container(
//               child: Text(
//                 'Xem lại đơn hàng',
//                 style: style15.copyWith(color: colorBlueV2),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ItemThanhToanNganHang extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Container(
//               alignment: AlignmentDirectional.center,
//               padding: EdgeInsets.all(paddingL),
//               color: Colors.white,
//               child: Text(
//                 'Để thanh toán, Quý khách chuyển tiền vào tài khoản sau:',
//                 style: style15,
//               )),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: paddingL),
//             color: Colors.white,
//             child: DefaultTextStyle(
//               style: style15.copyWith(height: lineHeight3),
//               softWrap: true,
//               textAlign: TextAlign.center,
//               child: HtmlText(
//                 data:
//                     """<p>Tên tài khoản: <b>Lâm Tú Linh</b></p> \n <p>Số tài khoản: <b>00000000000</b></p> \n <p>Ngân hàng: <b>Vietcombank</b></p>""",
//               ),
//             ),
//           ),
//           Container(
//             color: Colors.white,
//             padding: EdgeInsets.only(
//                 bottom: paddingM, left: paddingL + paddingS, right: paddingL),
//             child: Row(
//               children: <Widget>[
//                 Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         child: Text('Nội dung:', style: style15),
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(top: paddingM),
//                         child: Text('Số tiền:', style: style15),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                     child: Container(
//                   margin: EdgeInsets.only(left: paddingS),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         padding: EdgeInsets.symmetric(vertical: paddingS),
//                         child: Text(
//                           '[Số điện thoại] - [Mã đơn hàng]',
//                           style: style15_black,
//                         ),
//                       ),
//                       Container(
//                         child: Text(
//                           '1,784,999đ',
//                           style: style22_semibold.copyWith(color: colorBlueV2),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
