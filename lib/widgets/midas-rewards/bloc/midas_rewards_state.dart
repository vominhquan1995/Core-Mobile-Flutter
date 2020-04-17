part of 'midas_rewards_bloc.dart';

@immutable
abstract class MidasRewardsState {}

class MidasRewardsInitial extends MidasRewardsState {}

class InitialMidasRewardsState extends MidasRewardsState {
  @override
  String toString() => 'InitialMidasRewards';
}

class ErrorMidasRewardsState extends MidasRewardsState {
  final e;
  ErrorMidasRewardsState({this.e});
  @override
  String toString() => 'ErrorMidasRewardsState';

  @override
  // TODO: implement props
  List<Object> get props => [e];
}

class EmptyMidasRewards extends MidasRewardsState {
  @override
  String toString() => 'EmptyMidasRewards';
}

class LoadedMidasRewards extends MidasRewardsState {
  final ThongTinDiemModel data;

  LoadedMidasRewards({this.data});

  LoadedMidasRewards copyWith({ThongTinDiemModel data}) {
    return LoadedMidasRewards(
      data: data ?? this.data,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class DoneUpdateMidasRewards extends MidasRewardsState {
  @override
  String toString() => 'DoneMidasRewards';
}

class ErrorUpdateMidasRewards extends MidasRewardsState {
  final e;
  ErrorUpdateMidasRewards({this.e});
  @override
  String toString() => 'Error Update MidasRewards';
}

class ValidateStateUpdateMidasRewards extends MidasRewardsState {
  final e;
  ValidateStateUpdateMidasRewards({this.e});
  @override
  String toString() => 'ValidateState Update MidasRewards';
}
