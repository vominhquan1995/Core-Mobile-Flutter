part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();
}

class AddressInitial extends AddressState {
  @override
  List<Object> get props => [];
}

class LoadedData extends AddressState {
  LoadedData({this.data});
  final DataAddress data;
  @override
  List<Object> get props => [data];
}

class LoadedDataProvince extends AddressState {
  LoadedDataProvince({this.data});
  final DataAddress data;
  @override
  List<Object> get props => [data];
}

class LoadedDataDistrict extends AddressState {
  LoadedDataDistrict({this.data});
  final DataAddress data;
  @override
  List<Object> get props => [data];
}
class LoadedDataWard extends AddressState {
  LoadedDataWard({this.data});
  final DataAddress data;
  @override
  List<Object> get props => [data];
}

class LoadingDataAddress extends AddressState {
  LoadingDataAddress();
  @override
  List<Object> get props => [];
}
