part of 'thongtincanhan_bloc.dart';

abstract class ThongTinCaNhanState extends Equatable {
  const ThongTinCaNhanState();

  @override
  List<Object> get props => [];
}

class ThongtincanhanInitial extends ThongTinCaNhanState {}

class ThongtincanhanLoaded extends ThongTinCaNhanState {
  final Profile profile;
  final updateError;

  ThongtincanhanLoaded({this.profile, this.updateError = false});

  @override
  // TODO: implement props
  List<Object> get props => [profile];
}
