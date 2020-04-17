import 'package:equatable/equatable.dart';
import 'package:Midas/core/bao-tri/db/baotri_provider.dart';

const columnKey = 'key';
const columnHtml = 'html';
const columnTinhTrang = 'tinhtrang';

const String TABLE_BAOTRI =
    "CREATE TABLE IF NOT EXISTS ${BaoTriProvider.TABLE_NAME} ("
            "$columnKey TEXT," +
        "$columnHtml TEXT," +
        "$columnTinhTrang BLOB)";

class BaoTriLocal extends Equatable {
  String key;
  String html;
  bool tinhTrang;
  BaoTriLocal({this.key, this.html, this.tinhTrang});

  @override
  String toString() => '$key, $tinhTrang';

  @override
  // TODO: implement props
  List<Object> get props => [key, html, tinhTrang];
}
