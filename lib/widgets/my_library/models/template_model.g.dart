// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemplateModel _$TemplateModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['template', 'key', 'title']);
  return TemplateModel(
    template: json['template'] as String,
    key: json['key'] as String,
    title: json['title'] as String,
  )..listSanPham = (json['san_pham'] as List)
      ?.map((e) =>
          e == null ? null : SanPhamModel.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$TemplateModelToJson(TemplateModel instance) =>
    <String, dynamic>{
      'template': instance.template,
      'key': instance.key,
      'title': instance.title,
      'san_pham': instance.listSanPham?.map((e) => e?.toJson())?.toList(),
    };

// **************************************************************************
// JsonLiteralGenerator
// **************************************************************************

final _$glossaryDataJsonLiteral = {
  'result': [
    {
      'template': '1',
      'title': 'home_3',
      'key': 'key_search',
      'san_pham': [
        {
          'don_gia': '558000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '604',
          'ma_san_pham': 'VNCAR(H)190705',
          'ten_san_pham': 'Agan Oil Serum',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/a5a579fb8326335cbe8586053142e4eb.jpg'
        },
        {
          'don_gia': '447000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '615',
          'ma_san_pham': 'VNCAR(H)1907020',
          'ten_san_pham': 'CR BondPlex Shampoo 500ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/4bbd660766676cde16cb7ac5c980783c.jpg'
        },
        {
          'don_gia': '676000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '617',
          'ma_san_pham': 'VNCAR(H)190708',
          'ten_san_pham': 'anti - Yellow Shampoo 830 ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/e7b7bd0d5c92b13abb56a3b179f43843.jpg'
        },
        {
          'don_gia': '1248000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '603',
          'ma_san_pham': 'VNCAR(H)190703',
          'ten_san_pham': 'Severe Damaged Treatment Cream 1000ml (hủ)',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/4d4fcd8a4b36daaa21acea99b8bbe754.jpg'
        },
        {
          'don_gia': '632000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '629',
          'ma_san_pham': 'VNCAR(H)190709',
          'ten_san_pham': 'anti- Hair Fall Shampoo 830ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/05d20c867e6d262eee78d9c58f96c4e1.jpg'
        },
        {
          'don_gia': '382000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '616',
          'ma_san_pham': 'VNCAR(H)1907021',
          'ten_san_pham': 'Micro Keratin Infusion 500ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/6a5b603c1fd4f1fdb0094961aecbf5d3.jpg'
        },
        {
          'don_gia': '424000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '610',
          'ma_san_pham': 'VNCAR(H)1907015',
          'ten_san_pham':
              'CR Natural Volum Perm #2 Neutralizer Layer Liquid 1000ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/51d584edf9c3fdbc272105df733dca9d.jpg'
        },
        {
          'don_gia': '347000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '612',
          'ma_san_pham': 'VNCAR(H)1907017',
          'ten_san_pham': 'CR Keratin Organic Neutalizer 1000ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/d4e9d76f4ed094d5a316077b659dfeef.jpg'
        }
      ]
    },
    {
      'template': '2',
      'key': 'key_search',
      'title': 'home_3',
      'san_pham': [
        {
          'don_gia': '558000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '604',
          'ma_san_pham': 'VNCAR(H)190705',
          'ten_san_pham': 'Agan Oil Serum',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/a5a579fb8326335cbe8586053142e4eb.jpg'
        },
        {
          'don_gia': '447000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '615',
          'ma_san_pham': 'VNCAR(H)1907020',
          'ten_san_pham': 'CR BondPlex Shampoo 500ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/4bbd660766676cde16cb7ac5c980783c.jpg'
        },
        {
          'don_gia': '676000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '617',
          'ma_san_pham': 'VNCAR(H)190708',
          'ten_san_pham': 'anti - Yellow Shampoo 830 ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/e7b7bd0d5c92b13abb56a3b179f43843.jpg'
        },
        {
          'don_gia': '1248000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '603',
          'ma_san_pham': 'VNCAR(H)190703',
          'ten_san_pham': 'Severe Damaged Treatment Cream 1000ml (hủ)',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/4d4fcd8a4b36daaa21acea99b8bbe754.jpg'
        },
        {
          'don_gia': '632000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '629',
          'ma_san_pham': 'VNCAR(H)190709',
          'ten_san_pham': 'anti- Hair Fall Shampoo 830ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/05d20c867e6d262eee78d9c58f96c4e1.jpg'
        },
        {
          'don_gia': '382000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '616',
          'ma_san_pham': 'VNCAR(H)1907021',
          'ten_san_pham': 'Micro Keratin Infusion 500ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/6a5b603c1fd4f1fdb0094961aecbf5d3.jpg'
        },
        {
          'don_gia': '424000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '610',
          'ma_san_pham': 'VNCAR(H)1907015',
          'ten_san_pham':
              'CR Natural Volum Perm #2 Neutralizer Layer Liquid 1000ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/51d584edf9c3fdbc272105df733dca9d.jpg'
        },
        {
          'don_gia': '347000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '612',
          'ma_san_pham': 'VNCAR(H)1907017',
          'ten_san_pham': 'CR Keratin Organic Neutalizer 1000ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/d4e9d76f4ed094d5a316077b659dfeef.jpg'
        }
      ]
    },
    {
      'template': '1',
      'title': 'home_3',
      'key': 'key_search',
      'san_pham': [
        {
          'don_gia': '558000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '604',
          'ma_san_pham': 'VNCAR(H)190705',
          'ten_san_pham': 'Agan Oil Serum',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/a5a579fb8326335cbe8586053142e4eb.jpg'
        },
        {
          'don_gia': '447000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '615',
          'ma_san_pham': 'VNCAR(H)1907020',
          'ten_san_pham': 'CR BondPlex Shampoo 500ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/4bbd660766676cde16cb7ac5c980783c.jpg'
        },
        {
          'don_gia': '676000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '617',
          'ma_san_pham': 'VNCAR(H)190708',
          'ten_san_pham': 'anti - Yellow Shampoo 830 ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/e7b7bd0d5c92b13abb56a3b179f43843.jpg'
        },
        {
          'don_gia': '1248000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '603',
          'ma_san_pham': 'VNCAR(H)190703',
          'ten_san_pham': 'Severe Damaged Treatment Cream 1000ml (hủ)',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/4d4fcd8a4b36daaa21acea99b8bbe754.jpg'
        },
        {
          'don_gia': '632000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '629',
          'ma_san_pham': 'VNCAR(H)190709',
          'ten_san_pham': 'anti- Hair Fall Shampoo 830ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/05d20c867e6d262eee78d9c58f96c4e1.jpg'
        },
        {
          'don_gia': '382000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '616',
          'ma_san_pham': 'VNCAR(H)1907021',
          'ten_san_pham': 'Micro Keratin Infusion 500ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/6a5b603c1fd4f1fdb0094961aecbf5d3.jpg'
        },
        {
          'don_gia': '424000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '610',
          'ma_san_pham': 'VNCAR(H)1907015',
          'ten_san_pham':
              'CR Natural Volum Perm #2 Neutralizer Layer Liquid 1000ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/51d584edf9c3fdbc272105df733dca9d.jpg'
        },
        {
          'don_gia': '347000',
          'khuyen_mai': false,
          'gia_khuyen_mai': 0,
          'phan_tram': 0,
          'san_pham_id': '612',
          'ma_san_pham': 'VNCAR(H)1907017',
          'ten_san_pham': 'CR Keratin Organic Neutalizer 1000ml',
          'mo_ta': null,
          'hinh_dai_dien':
              'public/file/sanpham/d4e9d76f4ed094d5a316077b659dfeef.jpg'
        }
      ]
    }
  ]
};