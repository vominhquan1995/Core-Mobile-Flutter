part of 'huong_dan_bloc.dart';

@immutable
abstract class HuongDanEvent {}

class GetDanhSachHuongDan extends HuongDanEvent {
   final String language;

  GetDanhSachHuongDan({@required this.language});
}
