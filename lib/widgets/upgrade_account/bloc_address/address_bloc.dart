import 'dart:async';

import 'package:Midas/widgets/search/bloc/search_bloc_bloc.dart';
import 'package:Midas/widgets/upgrade_account/model/address_model.dart';
import 'package:Midas/widgets/upgrade_account/service/address_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  DataAddress dataCache;
  AddressService service;
  AddressBloc({this.service});
  @override
  AddressState get initialState => AddressInitial();

  @override
  Stream<AddressState> mapEventToState(
    AddressEvent event,
  ) async* {
    if (event is InitData) {
      yield LoadingDataAddress();
      DataAddress data = await service.getDataAddress();
      //save data for one session
      dataCache = data;
      data.provinces.sort((Province a, Province b) => a.name.compareTo(b.name));
      yield LoadedData(data: data);
    }
    if (event is SearchDataProvince) {
      yield LoadedData(
          data: DataAddress(
              provinces: dataCache.provinces
                  .where((f) => f.fullName
                      .toLowerCase()
                      .contains(event.key.toLowerCase()))
                  .toList()
                    ..sort(
                        (Province a, Province b) => a.name.compareTo(b.name)),
              districts: (state as LoadedData).data.districts));
    }
    if (event is LoadDataDistrict) {
      print(event.idProvince);
      yield LoadedDataDistrict(
          data: DataAddress(
              provinces: dataCache.provinces,
              districts: dataCache.districts
                  .where((f) => f.idParent == event.idProvince)
                  .toList()
                    ..sort(
                        (District a, District b) => a.name.compareTo(b.name))));
    }
    if (event is SearchDataDistrict) {
      yield LoadedDataDistrict(
          data: DataAddress(
              provinces: dataCache.provinces,
              districts: dataCache.districts
                  .where((f) =>
                      f.idParent == event.idProvince &&
                      f.fullName
                          .toLowerCase()
                          .contains(event.key.toLowerCase()))
                  .toList()
                    ..sort(
                        (District a, District b) => a.name.compareTo(b.name))));
    }
    if (event is LoadDataWard) {
      yield LoadedDataWard(
          data: DataAddress(
              wards: dataCache.wards
                  .where((f) => f.idParent == event.idDistrict)
                  .toList()
                    ..sort((Ward a, Ward b) => a.name.compareTo(b.name))));
    }
    if (event is SearchDataWard) {
      yield LoadedDataWard(
          data: DataAddress(
              wards: dataCache.wards
                  .where((f) =>
                      f.idParent == event.idDistrict &&
                      f.fullName
                          .toLowerCase()
                          .contains(event.key.toLowerCase()))
                  .toList()
                    ..sort((Ward a, Ward b) => a.name.compareTo(b.name))));
    }
  }
}
