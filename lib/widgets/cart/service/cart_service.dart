import 'package:Midas/core/cart/model/cart_model.dart';
import 'package:Midas/core/cart/service/cart_service.dart';
import 'package:Midas/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Midas/core/page-core/service_custom.dart';
import 'package:Midas/widgets/upgrade_account/model/address_model.dart';

class CartService extends ServiceCustom {
  var core = CoreCartService();
  CartService(ErrorhandleBloc bloc) : super(bloc);

  Future<List<CartItemModel>> getCartItem() async {
    var cart = await core.getCart();
    var c = cart
        .map((elem) => {
              "san_pham_id": elem.sanphamid,
              "list_tinh_chat_id": elem.listtinhchatids,
              "so_luong": elem.soluong
            })
        .toList();
    final response =
        await dioE.post("/cart/get-cart-items", data: {"san_pham": c});
    if (response.statusCode == 200) {
      List list = response.data['result'] as List;
      var l = list
          .map((f) => CartItemModel(
              uid: f['uid'].toString(),
              sanphamid: f['san_pham_id'].toString(),
              masanpham: f['ma_san_pham'].toString(),
              tensanpham: f['ten_san_pham'].toString(),
              mota: f['mo_ta'].toString(),
              percent: num.parse(f['percent'].toString()),
              dongia: num.parse(f['don_gia'].toString()),
              dongiagoc: num.parse(f['don_gia_goc'].toString()),
              soluong: f['so_luong'],
              hinhdaidien: f['hinh_dai_dien'].toString(),
              iskhuyenmai:
                  num.parse(f['percent'].toString()) > 0 ? true : false,
              listtinhchatids: (f['list_tinh_chat_id'] as List)
                  .map((e) => int.parse(e.toString()))
                  .toList(),
              listtinhchatname: (f['list_tinh_chat_name'] as List)
                  .map((e) => e.toString())
                  .toList()))
          .toList();
      await core.updateCartItems(l);
      return l;
    } else {
      throw Exception(response);
    }
  }

  //clone by quan
  Future<List<CartItemModel>> getCartItemPrivate() async {
    var cart = await core.getCart();
    var c = cart
        .map((elem) => {
              "san_pham_id": elem.sanphamid,
              "list_tinh_chat_id": elem.listtinhchatids,
              "so_luong": elem.soluong
            })
        .toList();
    final response =
        await dioE.post("/cart/get-cart-items-private", data: {"san_pham": c});
    if (response.statusCode == 200) {
      List list = response.data['result'] as List;
      var l = list
          .map((f) => CartItemModel(
              uid: f['uid'].toString(),
              sanphamid: f['san_pham_id'].toString(),
              masanpham: f['ma_san_pham'].toString(),
              tensanpham: f['ten_san_pham'].toString(),
              mota: f['mo_ta'].toString(),
              percent: num.parse(f['percent'].toString()),
              dongia: num.parse(f['don_gia'].toString()),
              dongiagoc: num.parse(f['don_gia_goc'].toString()),
              soluong: f['so_luong'],
              hinhdaidien: f['hinh_dai_dien'].toString(),
              iskhuyenmai:
                  num.parse(f['percent'].toString()) > 0 ? true : false,
              listtinhchatids: (f['list_tinh_chat_id'] as List)
                  .map((e) => int.parse(e.toString()))
                  .toList(),
              listtinhchatname: (f['list_tinh_chat_name'] as List)
                  .map((e) => e.toString())
                  .toList()))
          .toList();
      await core.updateCartItems(l);
      return l;
    } else {
      throw Exception(response);
    }
  }

  Future<List<CartItemModel>> getCartItemWithoutAPI() async {
    var cart = await core.getCart();
    return cart;
  }

  Future<num> getCartTotal() async {
    var cart = await core.getCart();
    var c = cart
        .map((f) => f.dongia * f.soluong)
        .reduce((value, elem) => value + elem);
    return c;
  }

  Future<CartInfoModel> getInfo() async {
    var info = await core.getCartInfo();
    if (info != null) return info;

    final response = await dioE.get("/cart/get-cart-info");
    if (response.statusCode == 200) {
      var result = response.data['result'];
      var info = CartInfoModel(
        ten: result["ho_ten"] ?? result["ho_ten"].toString(),
        sodienthoai:
            result["so_dien_thoai"] ?? result["so_dien_thoai"].toString(),
        diachi: result["dia_chi"] ?? result["dia_chi"].toString(),
        tinhid: result["tinh_id"] ?? result["tinh_id"].toString(),
        quanid: result["quan_id"] ?? result["quan_id"].toString(),
        phuongid: result["phuong_id"] ?? result["phuong_id"].toString(),
        tinhname: result["tinh_name"] ?? result["tinh_name"].toString(),
        quanname: result["quan_name"] ?? result["quan_name"].toString(),
        phuongname: result["phuong_name"] ?? result["phuong_name"].toString(),
      );
      await core.updateCartInfo(info);
      return info;
    } else {
      throw Exception(response);
    }
  }

  Future<CartInfoModel> getPaymentInfo() async {
    final response = await dioE.get("/cart/get-cart-info");
    if (response.statusCode == 200) {
      var result = response.data['result'];
      var info = await core.getCartInfo();
      info.tienhoahong = num.parse(result["tien_hoa_hong"].toString()) ?? 0;
      return info;
    } else {
      throw Exception(response);
    }
  }

  Future<bool> updateInfo(CartInfoModel info) async {
    final f = await core.updateCartInfo(info);
    if (f) {
      dioE.post("/cart/update-cart-info", data: {
        "ho_ten": info.ten,
        "so_dien_thoai": info.sodienthoai,
        "dia_chi": info.diachi,
        "tinh_id": info.tinhid,
        "quan_id": info.quanid,
        "phuong_id": info.phuongid,
        "tinh_name": info.tinhname,
        "quan_name": info.quanname,
        "phuong_name": info.phuongname,
        "ghi_chu": info.ghichu
      });
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePaymentInfo(CartInfoModel info) async {
    return await core.updatePaymentInfo(info);
  }

  Future<DataAddress> getDataAddress() async {
    try {
      final response = await dioE.get('/cauhinhchung/get-data-address');
      final data = response.data;
      var province = (data['tinh'] as Map<String, dynamic>).values;
      province = province.map((f) => Province.fromJson(f)).toList();
      var district = (data['quan-huyen'] as Map<String, dynamic>).values;
      district = district.map((f) => District.fromJson(f)).toList();
      return DataAddress(provinces: province, districts: district);
    } catch (e) {
      return DataAddress(provinces: [], districts: []);
    }
  }

  Future<bool> updateQuantityCart(CartItemModel item, bool increase) async {
    try {
      return await core.updateQuantityCart(item, increase);
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeItem(CartItemModel item) async {
    try {
      return await core.removeItem(item);
    } catch (e) {
      return false;
    }
  }

  Future<CartResultModel> createTransaction() async {
    var cart = await core.getCart();
    var info = await core.getCartInfo();
    var c = cart
        .map((elem) => {
              "san_pham_id": elem.sanphamid,
              "list_tinh_chat_id": elem.listtinhchatids,
              "so_luong": elem.soluong
            })
        .toList();
    final response = await dioE.post("/cart/create-transaction", data: {
      "product": c,
      "ho_ten": info.ten,
      "so_dien_thoai": info.sodienthoai,
      "ghi_chu": info.ghichu,
      "dia_chi": info.diachi,
      "tinh_id": info.tinhid,
      "quan_id": info.quanid,
      "phuong_id": info.phuongid,
      "tinh_name": info.tinhname,
      "quan_name": info.quanname,
      "phuong_name": info.phuongname,
      "with_midas_wallet": info.withmidaswallet,
      "loai_thanh_toan": info.loaithanhtoan
    });
    if (response.statusCode == 200) {
      var result = response.data['result'];
      var r = CartResultModel(
        id: result["id"] ?? result["id"].toString(),
        madonhang: result["ma_giao_dich"] ?? result["ma_giao_dich"].toString(),
        ten: result["ho_ten"] ?? result["ho_ten"].toString(),
        sodienthoai:
            result["so_dien_thoai"] ?? result["so_dien_thoai"].toString(),
        tongtien: result["tong_tien"] ?? result["tong_tien"],
        tinhtrang: result["tinh_trang"] ?? result["tinh_trang"],
        loaithanhtoan: result["loai_thanh_toan"] ?? result["loai_thanh_toan"],
      );
      await core.clearCart();
      return r;
    } else {
      throw Exception(response);
    }
  }
}
