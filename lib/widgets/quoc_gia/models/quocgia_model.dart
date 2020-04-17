import 'package:Midas/widgets/quoc_gia/db/quocgia_db.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quocgia_model.g.dart';

const String TABLE_QUOCGIA =
    "CREATE TABLE IF NOT EXISTS ${QuocGiaDB.TABLE_NAME} (" +
        "quoc_gia_id TEXT," +
        "quoc_gia_name TEXT," +
        "ma_vung TEXT," +
        "ti_gia_tien_te TEXT," +
        "ky_hieu_tien_te TEXT," +
        "current_status TEXT," +
        "link_flag TEXT," +
        "link_web TEXT," +
        "locale TEXT )";

@JsonSerializable(explicitToJson: true)
class QuocGiaModel extends Equatable {
  @JsonKey(name: 'quoc_gia_id')
  final String quocGiaId;

  @JsonKey(name: 'quoc_gia_name', defaultValue: '')
  final String tenQG;

  @JsonKey(name: 'ma_vung', defaultValue: '')
  final String maVung;

  @JsonKey(name: 'ti_gia_tien_te', defaultValue: '')
  final String tiGiaTienTe;

  @JsonKey(name: 'ky_hieu_tien_te', defaultValue: '')
  final String kyHieuTienTe;

  @JsonKey(name: 'current_status', defaultValue: 'deactive')
  final String status;

  @JsonKey(name: 'locale', defaultValue: 'en_US')
  final String locale;

  @JsonKey(ignore: true)
  String codeL;

  @JsonKey(ignore: true)
  String codeC;

  @JsonKey(name: 'link_flag', defaultValue: '')
  final String flag;

  @JsonKey(name: 'link_web', defaultValue: '')
  final String linkWeb;

  QuocGiaModel({
    this.quocGiaId,
    this.tiGiaTienTe,
    this.kyHieuTienTe,
    this.maVung,
    this.tenQG,
    this.status,
    this.locale,
    this.flag,
    this.linkWeb,
  }) {
    var listString = locale.split('_');

    this.codeL = listString[0];
    this.codeC = listString[1];
  }

  factory QuocGiaModel.fromJson(Map<String, dynamic> json) =>
      _$QuocGiaModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuocGiaModelToJson(this);

  @override
  // TODO: implement props
  List<Object> get props => [maVung];

  @override
  String toString() => '$runtimeType $maVung';

  checkDataEmpty() =>
      quocGiaId != null &&
      tiGiaTienTe != '' &&
      kyHieuTienTe != '' &&
      maVung != '' &&
      tenQG != '' &&
      status != '' &&
      locale != '' &&
      flag != '' &&
      linkWeb != '';
}

@JsonLiteral('data.json')
Map get dataQuocGiaJson => _$dataQuocGiaJsonJsonLiteral;
