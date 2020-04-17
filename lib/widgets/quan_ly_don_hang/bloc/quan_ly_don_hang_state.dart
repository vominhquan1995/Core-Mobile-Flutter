part of 'quan_ly_don_hang_bloc.dart';

@immutable
abstract class QuanLyDonHangState {}

class QuanLyDonHangInitial extends QuanLyDonHangState {}

class InitialQuanLyDonHangState extends QuanLyDonHangState {
  @override
  String toString() => 'InitialQuanLyDonHang';
}

class ErrorQuanLyDonHangState extends QuanLyDonHangState {
  final e;
  ErrorQuanLyDonHangState({this.e});
  @override
  String toString() => 'ErrorQuanLyDonHangState';

  @override
  // TODO: implement props
  List<Object> get props => [e];
}

class EmptyQuanLyDonHang extends QuanLyDonHangState {
  @override
  String toString() => 'EmptyQuanLyDonHang';
}
class LoadingState extends QuanLyDonHangState {
  @override
  String toString() => 'LoadingState';
}

class LoadedQuanLyDonHang extends QuanLyDonHangState {
  final List<DonHangModel> donhang;
  final bool hasReachedMax;
  final String dm;

  LoadedQuanLyDonHang({this.donhang, this.hasReachedMax, this.dm});

  LoadedQuanLyDonHang copyWith(
      {List<DonHangModel> donhang, bool hasReachedMax, String dm}) {
    return LoadedQuanLyDonHang(
        donhang: donhang ?? this.donhang,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        dm: dm ?? this.dm);
  }

  @override
  // TODO: implement props
  List<Object> get props => [donhang, hasReachedMax, dm];
}

class LoadedOneQuanLyDonHang extends QuanLyDonHangState {
  final DonHangModel donhang;

  LoadedOneQuanLyDonHang({this.donhang});

  LoadedOneQuanLyDonHang copyWith({DonHangModel donhang}) {
    return LoadedOneQuanLyDonHang(donhang: donhang ?? this.donhang);
  }

  @override
  // TODO: implement props
  List<Object> get props => [donhang];
}
