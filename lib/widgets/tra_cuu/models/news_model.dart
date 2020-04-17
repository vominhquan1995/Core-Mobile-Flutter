part 'news.g.dart';

class News {
  String tintucid;
  String mota;
  String noidung;
  String hinhthumbnail;
  String tieude;
  String timecreate;
  String linkseo;
  String timeCreateFormat;
  String danhMuc;
  bool isNew;
  News(
      {this.tintucid,
      this.mota,
      this.noidung,
      this.hinhthumbnail,
      this.tieude,
      this.timecreate,
      this.linkseo,
      this.timeCreateFormat,
      this.danhMuc,
      this.isNew = false});

  factory News.fromJson(Map<String, dynamic> json) => _$FromJson(json);
  Map<String, dynamic> toJson() => _$ToJson(this);
}
