part of 'banner_bloc.dart';

abstract class BannerState extends Equatable {
  @override
  List<Object> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoaded extends BannerState {
  final List<BannerModel> list;

  BannerLoaded({this.list});

  @override
  // TODO: implement props
  List<Object> get props => [list];
}

class BannerEmpty extends BannerState {}

class BannerError extends BannerState {
  final e;
  BannerError(this.e);
  @override
  // TODO: implement props
  List<Object> get props => [e];
}
