part of 'thanh_vien_bloc.dart';

@immutable
abstract class ThanhVienState {}

class ThanhVienInitial extends ThanhVienState {}

class InitialThanhVienState extends ThanhVienState {
  @override
  String toString() => 'InitialThanhVien';
}

class ErrorThanhVienState extends ThanhVienState {
  final e;
  ErrorThanhVienState({this.e});
  @override
  String toString() => 'ErrorThanhVienState';

  @override
  // TODO: implement props
  List<Object> get props => [e];
}

class EmptyThanhVien extends ThanhVienState {
  final String slF2;
  final String slF3;
  EmptyThanhVien({this.slF2, this.slF3});

  @override
  String toString() => 'EmptyThanhVien';
}

class LoadedThanhVien extends ThanhVienState {
  final List<PhanCapModel> thanh_vien;
  final String slF2;
  final String slF3;

  LoadedThanhVien({this.thanh_vien, this.slF2, this.slF3});

  LoadedThanhVien copyWith(
      {List<PhanCap> thanh_vien, String slF2, String slF3}) {
    return LoadedThanhVien(
        thanh_vien: thanh_vien ?? this.thanh_vien,
        slF2: slF2 ?? this.slF2,
        slF3: slF3 ?? this.slF3);
  }

  @override
  // TODO: implement props
  List<Object> get props => [thanh_vien, slF2, slF3];
}

class SearchThanhVien extends ThanhVienState {
  final List<PhanCapModel> thanh_vien;
 final String slF2;
  final String slF3;
  SearchThanhVien({this.thanh_vien, this.slF2, this.slF3});

  SearchThanhVien copyWith(
      {List<PhanCap> thanh_vien, String slF2, String slF3}) {
    return SearchThanhVien(thanh_vien: thanh_vien ?? this.thanh_vien,
        slF2: slF2 ?? this.slF2,
        slF3: slF3 ?? this.slF3);
  }

  @override
  // TODO: implement props
  List<Object> get props => [thanh_vien, slF2, slF3];
}

class EmptySearchThanhVien extends ThanhVienState {
  final String slF2;
  final String slF3;

  EmptySearchThanhVien({this.slF2, this.slF3});
  @override
  String toString() => 'EmptySearchThanhVien';
}
