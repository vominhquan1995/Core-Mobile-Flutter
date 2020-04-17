// import 'package:Midas/core/translate/public.dart';
// import 'package:Midas/utils/index.dart';
// import 'package:Midas/widgets/lich_su_diem/model/index.dart';
// import 'package:flutter/material.dart';

// class ItemLichSuDiem extends StatelessWidget {
//   final LichSuDiemModel data;

//   const ItemLichSuDiem({Key key, this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Color tongTienColor =
//         data.loaiGiaoDich == 1 ? colorBlueV2 : colorOrange;
//     String tongTienText =
//         data.loaiGiaoDich == 1 ? '+ ${data.soTien}' : '- ${data.soTien}';
//     String noiDungGiaoDichText =
//         data.noiDungGiaoDich == '' ? tr('log_point_2') : data.noiDungGiaoDich;
//     TextStyle noiDungGiaoDichStyle =
//         data.noiDungGiaoDich == '' ? style15_lightgrey : style15;
//     return Container(
//       decoration: BoxDecoration(
//           border: Border(
//         bottom: borderSide,
//       )),
//       padding: EdgeInsets.only(bottom: paddingL, top: paddingXS),
//       margin: EdgeInsets.only(left: paddingL, right: paddingL),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.only(bottom: paddingM),
//             child: Text(
//               noiDungGiaoDichText,
//               style: noiDungGiaoDichStyle,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Container(
//                   child: Text('${data.timeCreate}', style: style13_lightgrey),
//                 ),
//                 Container(
//                   child: Text(tongTienText,
//                       style: style17_semibold.copyWith(color: tongTienColor)),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
