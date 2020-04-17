import 'package:Midas/core/cart/db/cart_provider.dart';
import 'package:Midas/core/cart/model/cart_model.dart';
import 'package:Midas/core/page-core/service_custom.dart';

class CoreCartService extends ServiceCustom {
  CoreCartService() : super(null);

  var dbHelper = CartProvider();
  Future<bool> addToCart(CartItemModel item) async {
    try {
      return await dbHelper.addToCart(item);
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeItem(CartItemModel item) async {
    try {
      return await dbHelper.removeItem(item);
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearCart() async {
    try {
      return await dbHelper.clearCart();
    } catch (e) {
      return false;
    }
  }

  Future<int> count() async {
    try {
      return await dbHelper.count();
    } catch (e) {
      return 0;
    }
  }

  Future<bool> updateQuantityCart(CartItemModel item, bool increase) async {
    try {
      return await dbHelper.updateQuantityCart(item, increase);
    } catch (e) {
      return false;
    }
  }

  Future<List<CartItemModel>> getCart() async {
    try {
      return await dbHelper.getCart();
    } catch (e) {
      return [];
    }
  }

  Future<bool> updateCartItems(List<CartItemModel> items) async {
    try {
      return await dbHelper.updateCartItems(items);
    } catch (e) {
      return false;
    }
  }

  Future<CartInfoModel> getCartInfo() async {
    try {
      return await dbHelper.getCartInfo();
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateCartInfo(CartInfoModel info) async {
    try {
      return await dbHelper.updateCartInfo(info);
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatePaymentInfo(CartInfoModel info) async {
    try {
      return await dbHelper.updatePaymentInfo(info);
    } catch (e) {
      return false;
    }
  }
}
