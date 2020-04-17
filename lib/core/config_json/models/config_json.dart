import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'config_json.g.dart';

@JsonSerializable(explicitToJson: true)
class ConfigJson extends Equatable {
  @JsonKey(name: 'data-dmtc')
  List<DataDmtc> dataDmtc;

  @JsonKey(name: 'data-dm')
  List<DataDm> dataDm;

  @JsonKey(name: 'search')
  List<Search> search;

  @JsonKey(name: 'filter')
  List<Filter> filter;

  @JsonKey(name: 'hotline')
  Hotline hotline;

  @JsonKey(name: 'data-qt')
  DataQT dataQT;

  @JsonKey(name: 'data-login-options')
  List<DataQuocGiaLogin> dataLoginOptions;

  @JsonKey(name: 'data-bank')
  List<String> dataBank;

  @JsonKey(name: 'data_payment')
  List<DataPayment> dataPayment;

  @JsonKey(name: 'currency')
  Currency currency;

  @JsonKey(name: 'data-rut-hoa-hong-min')
  DataRuTHHMin dataRutHoaHongMin;

  @override
  // TODO: implement props
  List<Object> get props => [
        dataDmtc,
        dataDm,
        search,
        filter,
        hotline,
        dataQT,
        dataLoginOptions,
        dataBank,
        dataRutHoaHongMin
      ];

  @override
  String toString() => '$runtimeType ${toJson()}';

  ConfigJson(
      {this.dataDmtc,
      this.dataDm,
      this.search,
      this.filter,
      this.hotline,
      this.dataQT,
      this.dataLoginOptions,
      this.dataBank,
      this.dataRutHoaHongMin});

  factory ConfigJson.fromJson(Map<String, dynamic> json) =>
      _$ConfigJsonFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigJsonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DataDmtc {
  @JsonKey(name: 'name', defaultValue: '')
  String name;

  @JsonKey(name: 'url-image', defaultValue: '')
  String urlImage;

  @JsonKey(name: 'key', defaultValue: '')
  String key;

  @JsonKey(name: 'value', defaultValue: '')
  String value;

  DataDmtc({
    this.name,
    this.urlImage,
    this.key,
    this.value,
  });

  factory DataDmtc.fromJson(Map<String, dynamic> json) =>
      _$DataDmtcFromJson(json);

  Map<String, dynamic> toJson() => _$DataDmtcToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DataDm {
  @JsonKey(name: 'title_header', defaultValue: '')
  String titleHeader;

  @JsonKey(name: 'loai')
  int loai;

  @JsonKey(name: 'tra_cuu')
  List<TraCuu> traCuu;

  DataDm({this.titleHeader, this.loai, this.traCuu});

  factory DataDm.fromJson(Map<String, dynamic> json) => _$DataDmFromJson(json);

  Map<String, dynamic> toJson() => _$DataDmToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TraCuu {
  @JsonKey(name: 'name', defaultValue: '')
  String name;
  @JsonKey(name: 'link_image', defaultValue: '')
  String linkImage;
  @JsonKey(name: 'key', defaultValue: '')
  String key;
  @JsonKey(name: 'value', defaultValue: '')
  String value;

  TraCuu({this.name, this.linkImage, this.key, this.value});

  factory TraCuu.fromJson(Map<String, dynamic> json) => _$TraCuuFromJson(json);

  Map<String, dynamic> toJson() => _$TraCuuToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Search {
  @JsonKey(name: 'name', defaultValue: '')
  String name;

  @JsonKey(name: 'key', defaultValue: '')
  String key;

  Search({this.name, this.key});

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
  Map<String, dynamic> toJson() => _$SearchToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Hotline {
  @JsonKey(name: 'value', defaultValue: '')
  String value;

  Hotline({this.value});

  factory Hotline.fromJson(Map<String, dynamic> json) =>
      _$HotlineFromJson(json);
  Map<String, dynamic> toJson() => _$HotlineToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Filter {
  @JsonKey(name: 'title_header', defaultValue: '')
  String titleHeader;

  @JsonKey(name: 'tra_cuu', defaultValue: '')
  List<TraCuu> traCuu;

  Filter({this.titleHeader, this.traCuu});

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);
  Map<String, dynamic> toJson() => _$FilterToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DataQT {
  @JsonKey(name: 'value', defaultValue: '')
  String value;

  @JsonKey(name: 'text', defaultValue: '')
  String text;

  DataQT({this.value, this.text});

  factory DataQT.fromJson(Map<String, dynamic> json) => _$DataQTFromJson(json);
  Map<String, dynamic> toJson() => _$DataQTToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DataQuocGiaLogin {
  @JsonKey(name: 'icon', defaultValue: '')
  String icon;
  @JsonKey(name: 'code', defaultValue: '')
  String code;
  @JsonKey(name: 'ten_quoc_gia', defaultValue: '')
  String tenQuocGia;

  DataQuocGiaLogin({this.icon, this.code, this.tenQuocGia});

  factory DataQuocGiaLogin.fromJson(Map<String, dynamic> json) =>
      _$DataQuocGiaLoginFromJson(json);
  Map<String, dynamic> toJson() => _$DataQuocGiaLoginToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DataPayment {
  @JsonKey(name: 'value', defaultValue: '')
  int value;
  @JsonKey(name: 'image', defaultValue: '')
  String image;
  @JsonKey(name: 'description', defaultValue: '')
  String description;
  @JsonKey(name: 'descriptionht', defaultValue: '')
  String descriptionht;

  DataPayment({
    this.value,
    this.description,
    this.descriptionht,
    this.image,
  });

  factory DataPayment.fromJson(Map<String, dynamic> json) =>
      _$DataPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$DataPaymentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Currency {
  @JsonKey(name: 'format', defaultValue: '#,###.####')
  String format;

  Currency({
    this.format,
  });

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DataRuTHHMin {
  @JsonKey(name: 'value', defaultValue: '')
  String value;

  @JsonKey(name: 'text', defaultValue: '')
  String text;

  DataRuTHHMin({this.value, this.text});

  factory DataRuTHHMin.fromJson(Map<String, dynamic> json) =>
      _$DataRuTHHMinFromJson(json);
  Map<String, dynamic> toJson() => _$DataRuTHHMinToJson(this);
}

