part of 'info_salon_bloc.dart';

@immutable
abstract class InfoSalonEvent {}

class GetDataInfo extends InfoSalonEvent {
  GetDataInfo();
  @override
  List<Object> get props => [];
}
