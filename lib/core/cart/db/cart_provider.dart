import 'dart:math';

import 'package:Midas/core/database/dbhelper.dart';
import 'package:Midas/core/cart/model/cart_model.dart';

const TAG = 'CART_PROVIDER: ';

class CartProvider {
  static const String CART_TABLE_NAME = "cart";
  static const String INFO_TABLE_NAME = "cart_info";
  Future<List<CartItemModel>> getAllCartItems() async {
    try {
      var res = await DBHelper.dbHelper.getDatabase().query(CART_TABLE_NAME);
      return res.isEmpty ? [] : res;
    } catch (e) {
      return null;
    }
  }

  Future<List<CartItemModel>> getCart() async {
    try {
      var res = await DBHelper.dbHelper.getDatabase().query(CART_TABLE_NAME);

      final dataCart = res
          .map((f) => CartItemModel(
              uid: f["uid"],
              sanphamid: f["sanphamid"],
              tensanpham: f["tensanpham"],
              masanpham: f["masanpham"],
              hinhdaidien: f["hinhdaidien"],
              dongia: f["dongia"],
              soluong: int.parse(f["soluong"].toString()),
              listtinhchatids: (f["listtinhchatids"] as String)
                  .split('-')
                  .where((e) => e.trim() != "")
                  .map((e) => int.parse(e.toString()))
                  .toList()))
          .toList();
      return dataCart;
    } catch (e) {
      return [];
    }
  }

  Future<CartItemModel> getItem(uid) async {
    try {
      var res = await DBHelper.dbHelper
          .getDatabase()
          .query(CART_TABLE_NAME, where: 'uid = ?', whereArgs: [uid], limit: 1);

      final item = res
          .map((f) => CartItemModel(
              uid: f["uid"],
              sanphamid: f["sanphamid"],
              soluong: int.parse(f["soluong"].toString()),
              listtinhchatids: (f["listtinhchatids"] as String)
                  .split('-')
                  .map((f) => int.parse(f.toString()))
                  .toList()))
          .first;
      // .toList();
      return item;
    } catch (e) {
      return null;
    }
  }

  Future<bool> addToCart(CartItemModel item) async {
    try {
      //check exist
      item.listtinhchatids.sort((int a, int b) => a - b);
      var uid = item.listtinhchatids.length > 0
          ? item.sanphamid + '-' + item.listtinhchatids.join('-')
          : item.sanphamid;

      var res = await DBHelper.dbHelper
          .getDatabase()
          .query(CART_TABLE_NAME, where: 'uid = ?', whereArgs: [uid], limit: 1);
      if (res.length == 0) {
        //insert
        Map<String, dynamic> _p = Map();
        _p.addAll({
          "uid": uid,
          "sanphamid": item.sanphamid,
          "listtinhchatids": item.listtinhchatids.join('-'),
          "soluong": 1
        });
        await DBHelper.dbHelper.getDatabase().insert(CART_TABLE_NAME, _p);
      } else {
        Map<String, dynamic> _p = Map();
        _p.addAll({
          "uid": uid,
          "sanphamid": item.sanphamid,
          "listtinhchatids": item.listtinhchatids.join('-'),
          "soluong": res[0]["soluong"] + 1
        });
        await DBHelper.dbHelper
            .getDatabase()
            .update(CART_TABLE_NAME, _p, where: 'uid = ?', whereArgs: [uid]);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCartItems(List<CartItemModel> items) async {
    try {
      //check exist
      await DBHelper.dbHelper.getDatabase().delete(CART_TABLE_NAME);
      var batch = DBHelper.dbHelper.getDatabase().batch();
      items.forEach((f) {
        //insert
        Map<String, dynamic> _p = Map();
        _p.addAll({
          "uid": f.uid,
          "sanphamid": f.sanphamid,
          "tensanpham": f.tensanpham,
          "masanpham": f.masanpham,
          "hinhdaidien": f.hinhdaidien,
          "dongia": f.dongia,
          "listtinhchatids": f.listtinhchatids.join('-'),
          "soluong": f.soluong,
        });
        batch.insert(CART_TABLE_NAME, _p);
      });
      var result = await batch.commit();
      print(result);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateQuantityCart(CartItemModel item, bool increase) async {
    try {
      //check exist
      var res = await DBHelper.dbHelper.getDatabase().query(CART_TABLE_NAME,
          where: 'uid = ?', whereArgs: [item.uid], limit: 1);
      if (res.length == 0 || (!increase && res[0]["soluong"] == 1)) {
        return true;
      } else {
        Map<String, dynamic> _p = Map();
        _p.addAll({
          "uid": item.uid,
          "soluong": (res[0]["soluong"] + (increase ? 1 : -1))
        });
        await DBHelper.dbHelper.getDatabase().update(CART_TABLE_NAME, _p,
            where: 'uid = ?', whereArgs: [item.uid]);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> count() async {
    try {
      var res = await DBHelper.dbHelper.getDatabase().query(CART_TABLE_NAME);
      return res.length;
    } catch (e) {
      return 0;
    }
  }

  Future<bool> removeItem(CartItemModel item) async {
    try {
      await DBHelper.dbHelper
          .getDatabase()
          .delete(CART_TABLE_NAME, where: 'uid = ?', whereArgs: [item.uid]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearCart() async {
    try {
      await DBHelper.dbHelper.getDatabase().delete(CART_TABLE_NAME);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<CartInfoModel> getCartInfo() async {
    try {
      var res = await DBHelper.dbHelper
          .getDatabase()
          .query(INFO_TABLE_NAME, where: 'id = ?', whereArgs: ['1']);
      if (res.length == 0) {
        return null;
      }
      final info = res
          .map((f) => CartInfoModel(
                ten: f["ten"],
                sodienthoai: f["sodienthoai"],
                diachi: f["diachi"],
                ghichu: f["ghichu"],
                tinhid: f["tinhid"],
                quanid: f["quanid"],
                phuongid: f["phuongid"],
                tinhname: f["tinhname"],
                quanname: f["quanname"],
                phuongname: f["phuongname"],
                withmidaswallet: f["withmidaswallet"],
                loaithanhtoan: f["loaithanhtoan"],
              ))
          .first;
      // .toList();
      return info;
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateCartInfo(CartInfoModel info) async {
    try {
      var res = await DBHelper.dbHelper
          .getDatabase()
          .query(INFO_TABLE_NAME, where: 'id = ?', whereArgs: ['1']);
      if (res.length == 0) {
        Map<String, dynamic> _p = Map();
        _p.addAll({
          "id": "1",
          "ten": info.ten,
          "sodienthoai": info.sodienthoai,
          "diachi": info.diachi,
          "tinhid": info.tinhid,
          "ghichu": info.ghichu,
          "quanid": info.quanid,
          "phuongid": info.phuongid,
          "tinhname": info.tinhname,
          "quanname": info.quanname,
          "phuongname": info.phuongname,
        });
        await DBHelper.dbHelper.getDatabase().insert(INFO_TABLE_NAME, _p);
        return true;
      } else {
        Map<String, dynamic> _p = Map();
        _p.addAll({
          "ten": info.ten,
          "sodienthoai": info.sodienthoai,
          "diachi": info.diachi,
          "tinhid": info.tinhid,
          "ghichu": info.ghichu,
          "quanid": info.quanid,
          "phuongid": info.phuongid,
          "tinhname": info.tinhname,
          "quanname": info.quanname,
          "phuongname": info.phuongname,
        });
        await DBHelper.dbHelper
            .getDatabase()
            .update(INFO_TABLE_NAME, _p, where: 'id = ?', whereArgs: ['1']);
      }
      // .toList();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatePaymentInfo(CartInfoModel info) async {
    try {
      // await DBHelper.dbHelper.getDatabase().delete(INFO_TABLE_NAME);
      var res = await DBHelper.dbHelper
          .getDatabase()
          .query(INFO_TABLE_NAME, limit: 1);
      if (res.length == 0) {
        return null;
      } else {
        Map<String, dynamic> _p = Map();
        _p.addAll({
          "withmidaswallet": info.withmidaswallet,
          "loaithanhtoan": info.loaithanhtoan,
          "tienhoahong": info.tienhoahong
        });
        await DBHelper.dbHelper
            .getDatabase()
            .update(INFO_TABLE_NAME, _p, where: 'id = ?', whereArgs: ['1']);
      }
      // .toList();
      return true;
    } catch (e) {
      return false;
    }
  }

  // static Future deleteLastToken() async {
  //   print('${TAG} Delete last token');
  //   try {
  //     Map<String, dynamic> _p = Map();
  //     _p.addAll({
  //       "value": null,
  //     });
  //     await DBHelper.dbHelper.getDatabase().update(CART_TABLE_NAME, _p,
  //         where: 'key = ?', whereArgs: [KEY_TOKEN_LAST]);
  //   } catch (ex) {}
  // }
}
