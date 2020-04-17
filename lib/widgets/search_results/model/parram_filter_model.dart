enum TYPE_SEARCH {KEY,LOAI_SP,DONG_SP,NGANH_HANG,THUONG_HIEU,CATEGORY}
class ParamFilter {
  String locate;
  String search;
  List<String> loaiSanPham;
  List<String> dongSanPham;
  List<String> nganhHang;
  List<String> thuongHieu;
  String category;

  ParamFilter(
      {this.locate,
      this.search,
      this.category,
      this.loaiSanPham = const [],
      this.dongSanPham = const [],
      this.nganhHang = const [],
      this.thuongHieu = const []});
  ParamFilter.fromJson(Map<String, dynamic> json) {
    locate = json['locate'];
    search = json['search'];
    category = json['category'];
    loaiSanPham = json['loai_san_pham'];
    dongSanPham = json['dong_san_pham'];
    nganhHang = json['nganh_hang'];
    thuongHieu = json['thuong_hieu'];
  }
  Map<String, dynamic> toJson() {
    try {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['locate'] = this.locate;
      data['search'] = this.search;
      data['category'] = this.category;
      data['loai_san_pham'] = this.loaiSanPham;
      data['dong_san_pham'] = this.dongSanPham;
      data['nganh_hang'] = this.nganhHang;
      data['thuong_hieu'] = this.thuongHieu;
      data.removeWhere((key, value) => value == null || value.length == 0);
      return data;
    } catch (e) {
      print(e);
    }
  }

  setValueFilter(String key, String value) {
    switch (key) {
      case 'loai_san_pham':
        {
          loaiSanPham.add(value);
          break;
        }
      case 'dong_san_pham':
        {
          dongSanPham.add(value);
          break;
        }
      case 'nganh_hang':
        {
          nganhHang.add(value);
          break;
        }
      case 'thuong_hieu':
        {
          thuongHieu.add(value);
          break;
        }
      default:
        break;
    }
  }

  clearFilter() {
    loaiSanPham = [];
    dongSanPham = [];
    nganhHang = [];
    thuongHieu = [];
  }
}
