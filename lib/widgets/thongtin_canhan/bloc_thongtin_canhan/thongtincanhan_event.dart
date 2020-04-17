part of 'thongtincanhan_bloc.dart';

abstract class ThongTinCaNhanEvent extends Equatable {
  const ThongTinCaNhanEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetThongTinCaNhan extends ThongTinCaNhanEvent {}

class UpdateThongTinCaNhan extends ThongTinCaNhanEvent {
  final Profile profile;

  UpdateThongTinCaNhan({this.profile});

  @override
  // TODO: implement props
  List<Object> get props => [profile];
}
