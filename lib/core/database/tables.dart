import 'package:Midas/core/authentication/models/profile_model.dart';
import 'package:Midas/core/bao-tri/models/baotri.dart';
import 'package:Midas/core/cart/model/cart_model.dart';
import 'package:Midas/core/config_json/db/config_json_provider.dart';
import 'package:Midas/core/notification/index.dart';
import 'package:Midas/widgets/quoc_gia/models/quocgia_model.dart';
import 'package:Midas/widgets/thanh_vien_f2_f3/model/index.dart';

class Tables {
  static String CRATE_TABLE_USER = TABLE_USER;

  static String CRATE_TABLE_BAOTRI = TABLE_BAOTRI;

  static String CREATE_TABLE_QUOCGIA = TABLE_QUOCGIA;

  static String CREATE_TABLE_CART = TABLE_CART;

  static String CREATE_TABLE_CART_INFO = TABLE_CART_INFO;

  static String CREATE_TABLE_THANHVIEN = TABLE_THANHVIEN;

  static String CREATE_TABLE_DATAJSON = TABLE_DATAJSON;


  static String CREATE_TABLE_NOTIFI =
      "CREATE TABLE IF NOT EXISTS ${NotificationCore.TABLE_NAME} (" +
          "key		  TEXT," +
          "value		TEXT" +
          ");";
}
