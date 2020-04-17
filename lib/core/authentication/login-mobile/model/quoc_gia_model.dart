import 'package:equatable/equatable.dart';
class QuocGia extends Equatable {
  String ten_quoc_gia;
  String icon;
  String ma_vung;
  String code;

  QuocGia(params) {
    this.ten_quoc_gia = params['ten_quoc_gia'];
    this.icon = params['icon'];
    this.ma_vung = params['ma_vung'];
    this.code = params['code'];
  }

  @override
  // TODO: implement props
  List<Object> get props => null;
}

QuocGiafromJson(parsedJson) {
  List<QuocGia> temp = [];
  for (int i = 0; i < parsedJson.length; i++) {
    QuocGia result = QuocGia(parsedJson[i]);
    temp.add(result);
  }
  return temp;
}

/* 
cột local
 */
const String columnTenQuocGia = 'ten_quoc_gia';
const String columnFlag = 'icon';
const String columnMaVung = 'ma_vung';
const String columnCode = 'code';