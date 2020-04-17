// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thanh_vien.m.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThongTinCaNhan _$ThongTinCaNhanFromJson(Map<String, dynamic> json) {
  return ThongTinCaNhan(
    diaChiShop: json['dia_chi_shop'] as String ?? '',
    tenShop: json['ten_shop'] as String ?? '',
  );
}

Map<String, dynamic> _$ThongTinCaNhanToJson(ThongTinCaNhan instance) =>
    <String, dynamic>{
      'dia_chi_shop': instance.diaChiShop,
      'ten_shop': instance.tenShop,
    };

PhanCap _$PhanCapFromJson(Map<String, dynamic> json) {
  return PhanCap(
    taiKhoan: json['tai_khoan'] as String ?? '',
    thongTinCaNhan: json['thong_tin_ca_nhan'] == null
        ? null
        : ThongTinCaNhan.fromJson(
            json['thong_tin_ca_nhan'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PhanCapToJson(PhanCap instance) => <String, dynamic>{
      'tai_khoan': instance.taiKhoan,
      'thong_tin_ca_nhan': instance.thongTinCaNhan?.toJson(),
    };

ThanhVienModel _$ThanhVienModelFromJson(Map<String, dynamic> json) {
  return ThanhVienModel(
    phanCapLv1: (json['phan_cap_lv1'] as List)
        ?.map((e) =>
            e == null ? null : PhanCap.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    phanCapLv2: json['phan_cap_lv2'] as int,
  );
}

Map<String, dynamic> _$ThanhVienModelToJson(ThanhVienModel instance) =>
    <String, dynamic>{
      'phan_cap_lv1': instance.phanCapLv1?.map((e) => e?.toJson())?.toList(),
      'phan_cap_lv2': instance.phanCapLv2,
    };

// **************************************************************************
// JsonLiteralGenerator
// **************************************************************************

final _$dataQuocGiaJsonJsonLiteral = {
  'result': {
    'phan_cap_lv1': [
      {
        'tai_khoan': 'VNSK8RIV',
        'thong_tin_ca_nhan': {
          'cmnd': '280750114',
          'email': '',
          'ho_ten': 'Nguyễn Thị Tuyết Nhung',
          'dia_chi': 'Ap 2A xa phuoc hoa . Phu giao binh duong',
          'quan_id': '722',
          'tinh_id': '74',
          'ngay_cap': '02/11/2014',
          'ten_shop': 'Salon tuyet nhung',
          'gioi_tinh': 'nu',
          'ngay_sinh': '13/03/1980',
          'quan_name': 'Huyện Phú Giáo',
          'tinh_name': 'Bình Dương',
          'quoc_gia_id': 'VN',
          'dia_chi_shop': 'Ap 2A xa phuoc hoa . Phu giao binh duong',
          'quoc_gia_name': 'Viet Nam',
          'so_dien_thoai': '0399171000',
          'ten_ngan_hang': '',
          'ho_ten_khong_dau': 'nguyen thi tuyet nhung',
          'don_vi_tien_te_id': '9',
          'don_vi_tien_te_name': 'VIETNAM',
          'tai_khoan_ngan_hang': '1'
        },
        'level_vip': -1
      },
      {
        'tai_khoan': 'VNEAJ9N3',
        'thong_tin_ca_nhan': {
          'cmnd': '079056004407',
          'email': '',
          'ho_ten': 'Lâm Cơ Xưởng (salon hàng Mỹ)',
          'dia_chi': '167, trần thủ độ, p. Phú thạnh, q. Tân phú',
          'quan_id': '',
          'tinh_id': '79',
          'ngay_cap': '16/07/2018',
          'ten_shop': 'Salon hàng Mỹ',
          'gioi_tinh': 'nam',
          'ngay_sinh': '16/09/1956',
          'quan_name': '',
          'tinh_name': 'Hồ Chí Minh',
          'quoc_gia_id': 'VN',
          'dia_chi_shop': '',
          'quoc_gia_name': 'Viet Nam',
          'so_dien_thoai': '0808181728',
          'ten_ngan_hang': '',
          'ho_ten_khong_dau': 'lam co xuong salon hang my',
          'don_vi_tien_te_id': '9',
          'don_vi_tien_te_name': 'VIETNAM',
          'tai_khoan_ngan_hang': '.'
        },
        'level_vip': -1
      },
      {
        'tai_khoan': 'VNCM2M0I',
        'thong_tin_ca_nhan': {
          'cmnd': '080050000190',
          'email': '',
          'ho_ten': 'Nguyễn Hoàng Hùng (salon Ngọc Hà)',
          'dia_chi': '188, Hậu Giang, p6, q6',
          'quan_id': '775',
          'tinh_id': '79',
          'ngay_cap': '02/04/2019',
          'ten_shop': 'Salon Ngọc hà',
          'gioi_tinh': 'nam',
          'ngay_sinh': '28/08/1955',
          'quan_name': 'Quận 6',
          'tinh_name': 'Hồ Chí Minh',
          'quoc_gia_id': 'VN',
          'dia_chi_shop': '188, Hậu Giang, p6, q6',
          'quoc_gia_name': 'Viet Nam',
          'so_dien_thoai': '0942290299',
          'ten_ngan_hang': '',
          'ho_ten_khong_dau': 'nguyen hoang hung salon ngoc ha',
          'don_vi_tien_te_id': '9',
          'don_vi_tien_te_name': 'VIETNAM',
          'tai_khoan_ngan_hang': '.'
        },
        'level_vip': -1
      },
      {
        'tai_khoan': 'VN8R9VIY',
        'thong_tin_ca_nhan': {
          'cmnd': '023754981',
          'email': '',
          'ho_ten': 'Trần Thị Ái Quyên (salon Thanh Thanh)',
          'dia_chi': '157 Bãi Sậy, P4, Q6',
          'quan_id': '775',
          'tinh_id': '79',
          'ngay_cap': '05/03/2015',
          'ten_shop': 'Salon Thanh Thanh',
          'gioi_tinh': 'nu',
          'ngay_sinh': '10/07/1979',
          'quan_name': 'Quận 6',
          'tinh_name': 'Hồ Chí Minh',
          'quoc_gia_id': 'VN',
          'dia_chi_shop': '157 Bãi Sậy, P4, Q6',
          'quoc_gia_name': 'Viet Nam',
          'so_dien_thoai': '0907034688',
          'ten_ngan_hang': '',
          'ho_ten_khong_dau': 'tran thi ai quyen salon thanh thanh',
          'don_vi_tien_te_id': '9',
          'don_vi_tien_te_name': 'VIETNAM',
          'tai_khoan_ngan_hang': '.'
        },
        'level_vip': -1
      },
      {
        'tai_khoan': 'VNGN4AVI',
        'thong_tin_ca_nhan': {
          'cmnd': '300003540',
          'email': '',
          'ho_ten': 'Phạm Ngọc Chứa',
          'dia_chi': '',
          'quan_id': '',
          'tinh_id': '80',
          'ngay_cap': '10/09/2008',
          'ten_shop': 'Salon Ngọc Chứa',
          'gioi_tinh': 'nam',
          'ngay_sinh': '28/10/1962',
          'quan_name': '',
          'tinh_name': 'Long An',
          'quoc_gia_id': 'VN',
          'dia_chi_shop': '26 Lê Cao Đông, P2, TP Tân An, Long An',
          'quoc_gia_name': 'Viet Nam',
          'so_dien_thoai': '0984945606',
          'ten_ngan_hang': '',
          'ho_ten_khong_dau': 'pham ngoc chua',
          'don_vi_tien_te_id': '9',
          'don_vi_tien_te_name': 'VIETNAM',
          'tai_khoan_ngan_hang': '-1'
        },
        'level_vip': -1
      },
      {
        'tai_khoan': 'VNEUML8A',
        'thong_tin_ca_nhan': {
          'cmnd': '025952989',
          'email': '',
          'ho_ten': 'Lê Thị Minh Châu (salon Ngọc Mai)',
          'dia_chi': '',
          'quan_id': '',
          'tinh_id': '',
          'ngay_cap': '02/12/2014',
          'ten_shop': 'Ngọc Mai . ',
          'gioi_tinh': 'nu',
          'ngay_sinh': '25/11/1985',
          'quan_name': '',
          'tinh_name': '',
          'quoc_gia_id': 'VN',
          'dia_chi_shop': '79 Đặng Chất. F2 .Q8, Tp.HCM',
          'quoc_gia_name': 'Viet Nam',
          'so_dien_thoai': '0907.677.782',
          'ten_ngan_hang': 'Sacombank chi nhánh Q8',
          'ho_ten_khong_dau': 'le thi minh chau salon ngoc mai',
          'don_vi_tien_te_id': '9',
          'don_vi_tien_te_name': 'VIETNAM',
          'tai_khoan_ngan_hang': '060086800422'
        },
        'level_vip': -1
      },
      {
        'tai_khoan': 'VN7CFFGJ',
        'thong_tin_ca_nhan': {
          'cmnd': '023447376',
          'email': 'Tudo7283@gmail.com',
          'ho_ten': 'Đỗ Anh Tú',
          'dia_chi': '25B Nguyễn Văn Đậu, P5, Q. Phú Nhuận, Tp. Hồ Chí Minh',
          'quan_id': '',
          'tinh_id': '',
          'ngay_cap': '10/07/2014',
          'ten_shop': 'Salon Anh Tú',
          'gioi_tinh': 'nam',
          'ngay_sinh': '07/02/1983',
          'quan_name': '',
          'tinh_name': '',
          'quoc_gia_id': 'VN',
          'dia_chi_shop':
              '25B Nguyễn Văn Đậu, P5, Q. Phú Nhuận, Tp. Hồ Chí Minh',
          'quoc_gia_name': 'Viet Nam',
          'so_dien_thoai': '0932294383',
          'ten_ngan_hang': '',
          'ho_ten_khong_dau': 'do anh tu',
          'don_vi_tien_te_id': '9',
          'don_vi_tien_te_name': 'VIETNAM',
          'tai_khoan_ngan_hang': '-1'
        },
        'level_vip': -1
      },
      {
        'tai_khoan': 'VNLQU92K',
        'thong_tin_ca_nhan': {
          'cmnd': '092185002684',
          'email': '',
          'ho_ten': 'Nguyễn Hồng Sương',
          'dia_chi': '120/25 Trần Hưng Đạo, p. Phạm Ngũ Lão, Q1',
          'quan_id': '760',
          'tinh_id': '79',
          'ngay_cap': '13/03/2017',
          'ten_shop': 'Thảo Sương',
          'gioi_tinh': 'nu',
          'ngay_sinh': '30/07/1985',
          'quan_name': 'Quận 1',
          'tinh_name': 'Hồ Chí Minh',
          'quoc_gia_id': 'VN',
          'dia_chi_shop': '120/25 Trần Hưng Đạo, p. Phạm Ngũ Lão, Q1',
          'quoc_gia_name': 'Viet Nam',
          'so_dien_thoai': '0903369179',
          'ten_ngan_hang': '',
          'ho_ten_khong_dau': 'nguyen hong suong',
          'don_vi_tien_te_id': '9',
          'don_vi_tien_te_name': 'VIETNAM',
          'tai_khoan_ngan_hang': '-1'
        },
        'level_vip': -1
      },
      {
        'tai_khoan': 'VNGZBEH2',
        'thong_tin_ca_nhan': {
          'cmnd': '245072740',
          'email': '',
          'ho_ten': 'Độ Quốc Thắng',
          'dia_chi': '',
          'quan_id': '',
          'tinh_id': '',
          'ngay_cap': '24/02/2016',
          'ten_shop': 'Salon Thắng Trần',
          'gioi_tinh': 'nam',
          'ngay_sinh': '02/09/1987',
          'quan_name': '',
          'tinh_name': '',
          'quoc_gia_id': 'VN',
          'dia_chi_shop': '173/86 Khuông Việt .P, Phú Trung, Q.Tân Phú, Tp.HCM',
          'quoc_gia_name': 'Viet Nam',
          'so_dien_thoai': '0904126847',
          'ten_ngan_hang': '',
          'ho_ten_khong_dau': 'do quoc thang',
          'don_vi_tien_te_id': '9',
          'don_vi_tien_te_name': 'VIETNAM',
          'tai_khoan_ngan_hang': '123'
        },
        'level_vip': -1
      },
      {
        'tai_khoan': 'VN1KMUYM',
        'thong_tin_ca_nhan': {
          'cmnd': '121468426',
          'email': 'Vanthangtheki21@gmail.com',
          'ho_ten': 'Nguyễn Văn Thắng',
          'dia_chi': '',
          'quan_id': '',
          'tinh_id': '',
          'ngay_cap': '22/12/2012',
          'ten_shop': 'Phong Cách',
          'gioi_tinh': 'nam',
          'ngay_sinh': '04/07/1987',
          'quan_name': '',
          'tinh_name': '',
          'quoc_gia_id': 'VN',
          'dia_chi_shop': '572 Nguyễn Trãi, TX Lái Thiêu, Bình Dương',
          'quoc_gia_name': 'Viet Nam',
          'so_dien_thoai': '0933.535.100',
          'ten_ngan_hang': '',
          'ho_ten_khong_dau': 'nguyen van thang',
          'don_vi_tien_te_id': '9',
          'don_vi_tien_te_name': 'VIETNAM',
          'tai_khoan_ngan_hang': '1234'
        },
        'level_vip': -1
      },
      {
        'tai_khoan': 'VNOOX7K4',
        'thong_tin_ca_nhan': {
          'cmnd': '790142895072',
          'email': '',
          'ho_ten': 'Nguyễn Lê Hùng Dũng (Dũng Thái Lan)',
          'dia_chi': '',
          'quan_id': '783',
          'tinh_id': '79',
          'ngay_cap': '30/05/2014',
          'ten_shop': 'Dũng Thái Lan',
          'gioi_tinh': 'nam',
          'ngay_sinh': '09/10/1970',
          'quan_name': 'Huyện Củ Chi',
          'tinh_name': 'Hồ Chí Minh',
          'quoc_gia_id': 'VN',
          'dia_chi_shop': '359 QL 22 tan thong hoi , Củ Chi, TP.HCM',
          'quoc_gia_name': 'Viet Nam',
          'so_dien_thoai': '0934971196',
          'ten_ngan_hang': '',
          'ho_ten_khong_dau': 'nguyen le hung dung dung thai lan',
          'don_vi_tien_te_id': '9',
          'don_vi_tien_te_name': 'VIETNAM',
          'tai_khoan_ngan_hang': '-1'
        },
        'level_vip': -1
      },
      {
        'tai_khoan': 'VNYT1IYM',
        'thong_tin_ca_nhan': {
          'cmnd': '023447376',
          'email': '',
          'ho_ten': 'Đỗ Anh Tú (Salon Anh Tú)',
          'dia_chi': '261, Nguyễn Thượng Hiền, P.6, Q. Bình Thạnh, TP.HCM',
          'quan_id': '',
          'tinh_id': '79',
          'ngay_cap': '10/07/2014',
          'ten_shop': 'Salon Anh Tú',
          'gioi_tinh': 'nam',
          'ngay_sinh': '07/02/1983',
          'quan_name': '',
          'tinh_name': 'Hồ Chí Minh',
          'quoc_gia_id': 'VN',
          'dia_chi_shop': '',
          'quoc_gia_name': 'Viet Nam',
          'so_dien_thoai': '0932294383',
          'ten_ngan_hang': '',
          'ho_ten_khong_dau': 'do anh tu salon anh tu',
          'don_vi_tien_te_id': '9',
          'don_vi_tien_te_name': 'VIETNAM',
          'tai_khoan_ngan_hang': '.'
        },
        'level_vip': -1
      },
      {
        'tai_khoan': 'VN162WQP',
        'thong_tin_ca_nhan': {
          'cmnd': '025135766',
          'email': '',
          'ho_ten': 'Huỳnh Thị Hồng Hà (salon Thái)',
          'dia_chi': '5/4 Trần Khắc Chân, Hóc Môn',
          'quan_id': '',
          'tinh_id': '79',
          'ngay_cap': '12/12/2012',
          'ten_shop': 'Salon Thái',
          'gioi_tinh': 'nu',
          'ngay_sinh': '24/12/1968',
          'quan_name': '',
          'tinh_name': 'Hồ Chí Minh',
          'quoc_gia_id': 'VN',
          'dia_chi_shop': '5/4 Trần Khắc Chân, Hóc Môn',
          'quoc_gia_name': 'Viet Nam',
          'so_dien_thoai': '0976996700',
          'ten_ngan_hang': '',
          'ho_ten_khong_dau': 'huynh thi hong ha salon thai',
          'don_vi_tien_te_id': '9',
          'don_vi_tien_te_name': 'VIETNAM',
          'tai_khoan_ngan_hang': '.'
        },
        'level_vip': -1
      }
    ],
    'phan_cap_lv2': 1
  }
};
