import 'package:Core/core/authentication/models/profile_model.dart';
import 'package:Core/core/bao-tri/models/baotri.dart';
import 'package:Core/core/cart/model/cart_model.dart';
import 'package:Core/core/config_json/db/config_json_provider.dart';
import 'package:Core/core/notification/index.dart';
import 'package:Core/widgets/quoc_gia/models/quocgia_model.dart';

class Tables {
  static String CRATE_TABLE_USER = TABLE_USER;

  static String CRATE_TABLE_BAOTRI = TABLE_BAOTRI;

  static String CREATE_TABLE_QUOCGIA = TABLE_QUOCGIA;

  static String CREATE_TABLE_CART = TABLE_CART;

  static String CREATE_TABLE_CART_INFO = TABLE_CART_INFO;

  static String CREATE_TABLE_DATAJSON = TABLE_DATAJSON;


  static String CREATE_TABLE_NOTIFI =
      "CREATE TABLE IF NOT EXISTS ${NotificationCore.TABLE_NAME} (" +
          "key		  TEXT," +
          "value		TEXT" +
          ");";
}
