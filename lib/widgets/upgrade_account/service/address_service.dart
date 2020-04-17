import 'package:Core/core/page-core/bloc/bloc.dart';
import 'package:Core/core/page-core/service_custom.dart';
import 'package:Core/widgets/upgrade_account/model/address_model.dart';

class AddressService extends ServiceCustom {
  AddressService(ErrorhandleBloc bloc) : super(bloc);
  Future<DataAddress> getDataAddress() async {
    try {
      final response = await dioE.get('/cauhinhchung/get-data-address');
      final data = response.data;
      var province = (data['tinh'] as Map<String, dynamic>).values;
      province = province.map((f) => Province.fromJson(f)).toList();
      var district = (data['quan-huyen'] as Map<String, dynamic>).values;
      district = district.map((f) => District.fromJson(f)).toList();
      var wards = (data['xa-phuong'] as Map<String, dynamic>).values;
      wards = wards.map((f) => Ward.fromJson(f)).toList();
      return DataAddress(
          provinces: province, districts: district, wards: wards);
    } catch (e) {
      return DataAddress(provinces: [], districts: []);
    }
  }
}
