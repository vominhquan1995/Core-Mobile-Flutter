part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();
}

class InitData extends AddressEvent {
  @override
  List<Object> get props => [];
}

class LoadDataDistrict extends AddressEvent {
  final String idProvince;
  LoadDataDistrict({this.idProvince});
  @override
  List<Object> get props => [idProvince];
}

class LoadDataWard extends AddressEvent {
  final String idDistrict;
  LoadDataWard({this.idDistrict});
  @override
  List<Object> get props => [idDistrict];
}

class SearchDataProvince extends AddressEvent {
  final String key;
  SearchDataProvince({this.key});
  @override
  List<Object> get props => [key];
}

class SearchDataDistrict extends AddressEvent {
  final String key;
  final String idProvince;
  SearchDataDistrict({this.key, this.idProvince});
  @override
  List<Object> get props => [key];
}

class SearchDataWard extends AddressEvent {
  final String key;
  final String idDistrict;
  SearchDataWard({this.key, this.idDistrict});
  @override
  List<Object> get props => [key];
}
