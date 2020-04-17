// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigJson _$ConfigJsonFromJson(Map<String, dynamic> json) {
  return ConfigJson(
    dataDmtc: (json['data-dmtc'] as List)
        ?.map((e) =>
            e == null ? null : DataDmtc.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    dataDm: (json['data-dm'] as List)
        ?.map((e) =>
            e == null ? null : DataDm.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    search: (json['search'] as List)
        ?.map((e) =>
            e == null ? null : Search.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    filter: (json['filter'] as List)
        ?.map((e) =>
            e == null ? null : Filter.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    hotline: json['hotline'] == null
        ? null
        : Hotline.fromJson(json['hotline'] as Map<String, dynamic>),
    dataQT: json['data-qt'] == null
        ? null
        : DataQT.fromJson(json['data-qt'] as Map<String, dynamic>),
    dataLoginOptions: (json['data-login-options'] as List)
        ?.map((e) => e == null
            ? null
            : DataQuocGiaLogin.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    dataBank: (json['data-bank'] as List)?.map((e) => e as String)?.toList(),
    dataRutHoaHongMin: json['data-rut-hoa-hong-min'] == null
        ? null
        : DataRuTHHMin.fromJson(
            json['data-rut-hoa-hong-min'] as Map<String, dynamic>),
  )
    ..dataPayment = (json['data_payment'] as List)
        ?.map((e) =>
            e == null ? null : DataPayment.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..currency = json['currency'] == null
        ? null
        : Currency.fromJson(json['currency'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ConfigJsonToJson(ConfigJson instance) =>
    <String, dynamic>{
      'data-dmtc': instance.dataDmtc?.map((e) => e?.toJson())?.toList(),
      'data-dm': instance.dataDm?.map((e) => e?.toJson())?.toList(),
      'search': instance.search?.map((e) => e?.toJson())?.toList(),
      'filter': instance.filter?.map((e) => e?.toJson())?.toList(),
      'hotline': instance.hotline?.toJson(),
      'data-qt': instance.dataQT?.toJson(),
      'data-login-options':
          instance.dataLoginOptions?.map((e) => e?.toJson())?.toList(),
      'data-bank': instance.dataBank,
      'data_payment': instance.dataPayment?.map((e) => e?.toJson())?.toList(),
      'currency': instance.currency?.toJson(),
      'data-rut-hoa-hong-min': instance.dataRutHoaHongMin?.toJson(),
    };

DataDmtc _$DataDmtcFromJson(Map<String, dynamic> json) {
  return DataDmtc(
    name: json['name'] as String ?? '',
    urlImage: json['url-image'] as String ?? '',
    key: json['key'] as String ?? '',
    value: json['value'] as String ?? '',
  );
}

Map<String, dynamic> _$DataDmtcToJson(DataDmtc instance) => <String, dynamic>{
      'name': instance.name,
      'url-image': instance.urlImage,
      'key': instance.key,
      'value': instance.value,
    };

DataDm _$DataDmFromJson(Map<String, dynamic> json) {
  return DataDm(
    titleHeader: json['title_header'] as String ?? '',
    loai: json['loai'] as int,
    traCuu: (json['tra_cuu'] as List)
        ?.map((e) =>
            e == null ? null : TraCuu.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataDmToJson(DataDm instance) => <String, dynamic>{
      'title_header': instance.titleHeader,
      'loai': instance.loai,
      'tra_cuu': instance.traCuu?.map((e) => e?.toJson())?.toList(),
    };

TraCuu _$TraCuuFromJson(Map<String, dynamic> json) {
  return TraCuu(
    name: json['name'] as String ?? '',
    linkImage: json['link_image'] as String ?? '',
    key: json['key'] as String ?? '',
    value: json['value'] as String ?? '',
  );
}

Map<String, dynamic> _$TraCuuToJson(TraCuu instance) => <String, dynamic>{
      'name': instance.name,
      'link_image': instance.linkImage,
      'key': instance.key,
      'value': instance.value,
    };

Search _$SearchFromJson(Map<String, dynamic> json) {
  return Search(
    name: json['name'] as String ?? '',
    key: json['key'] as String ?? '',
  );
}

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'name': instance.name,
      'key': instance.key,
    };

Hotline _$HotlineFromJson(Map<String, dynamic> json) {
  return Hotline(
    value: json['value'] as String ?? '',
  );
}

Map<String, dynamic> _$HotlineToJson(Hotline instance) => <String, dynamic>{
      'value': instance.value,
    };

Filter _$FilterFromJson(Map<String, dynamic> json) {
  return Filter(
    titleHeader: json['title_header'] as String ?? '',
    traCuu: (json['tra_cuu'] as List)
            ?.map((e) =>
                e == null ? null : TraCuu.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        '',
  );
}

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'title_header': instance.titleHeader,
      'tra_cuu': instance.traCuu?.map((e) => e?.toJson())?.toList(),
    };

DataQT _$DataQTFromJson(Map<String, dynamic> json) {
  return DataQT(
    value: json['value'] as String ?? '',
    text: json['text'] as String ?? '',
  );
}

Map<String, dynamic> _$DataQTToJson(DataQT instance) => <String, dynamic>{
      'value': instance.value,
      'text': instance.text,
    };

DataQuocGiaLogin _$DataQuocGiaLoginFromJson(Map<String, dynamic> json) {
  return DataQuocGiaLogin(
    icon: json['icon'] as String ?? '',
    code: json['code'] as String ?? '',
    tenQuocGia: json['ten_quoc_gia'] as String ?? '',
  );
}

Map<String, dynamic> _$DataQuocGiaLoginToJson(DataQuocGiaLogin instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'code': instance.code,
      'ten_quoc_gia': instance.tenQuocGia,
    };

DataPayment _$DataPaymentFromJson(Map<String, dynamic> json) {
  return DataPayment(
    value: json['value'] as int ?? '',
    description: json['description'] as String ?? '',
    descriptionht: json['descriptionht'] as String ?? '',
    image: json['image'] as String ?? '',
  );
}

Map<String, dynamic> _$DataPaymentToJson(DataPayment instance) =>
    <String, dynamic>{
      'value': instance.value,
      'image': instance.image,
      'description': instance.description,
      'descriptionht': instance.descriptionht,
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) {
  return Currency(
    format: json['format'] as String ?? '#,###.####',
  );
}

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'format': instance.format,
    };

DataRuTHHMin _$DataRuTHHMinFromJson(Map<String, dynamic> json) {
  return DataRuTHHMin(
    value: json['value'] as String ?? '',
    text: json['text'] as String ?? '',
  );
}

Map<String, dynamic> _$DataRuTHHMinToJson(DataRuTHHMin instance) =>
    <String, dynamic>{
      'value': instance.value,
      'text': instance.text,
    };
