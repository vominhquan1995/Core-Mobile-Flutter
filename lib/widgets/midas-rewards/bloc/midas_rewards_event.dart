part of 'midas_rewards_bloc.dart';

@immutable
abstract class MidasRewardsEvent extends Equatable {
  const MidasRewardsEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetDataHMidasRewards extends MidasRewardsEvent {
  @override
  String toString() {
    // TODO: implement toString
    return 'Get Data Tổng hoa hồng';
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UpdateThongTin extends MidasRewardsEvent {
  final String tai_khoan_ngan_hang;
  final String ten_ngan_hang;
  final String ten_nguoi_nhan;

  UpdateThongTin(
      {this.tai_khoan_ngan_hang, this.ten_ngan_hang, this.ten_nguoi_nhan});

  @override
  String toString() {
    // TODO: implement toString
    return 'Update thông tin ngân hàng';
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}


