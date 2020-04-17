import 'package:Midas/widgets/upgrade_account/widgets/widget_modal_address.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/upgrade_account/model/address_model.dart';
import 'package:Midas/widgets/upgrade_account/widgets/widget_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Midas/widgets/upgrade_account/bloc_address/address_bloc.dart';

class SelectAddress {
  Province provinceSelected;
  District districtSelected;
  // Ward wardSelected;
  TextEditingController ctr = TextEditingController();
  Function(Province province, District district, Ward ward) onSubmit;
  Future<Widget> onPick(BuildContext context, AddressBloc bloc,
      Function(Province province, District district, Ward ward) onSelected) {
    //set event callback
    onSubmit = onSelected;
    bloc.add(InitData());
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return MaterialApp(
          home: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: paddingL, horizontal: paddingL),
            child: new Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.white,
                child: BlocBuilder(
                    bloc: bloc,
                    builder: (_, AddressState state) {
                      if (state is LoadingDataAddress) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is LoadedData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            HeaderModalAddress(
                              onClose: () {
                                Navigator.of(context).pop();
                              },
                              title: tr('upgrade_salon_25'),
                            ),
                            SearchModalAddress(
                              onChange: (String key) {
                                bloc.add(SearchDataProvince(key: key));
                              },
                              hintText: tr('upgrade_salon_26'),
                              ctr: ctr,
                            ),
                            Expanded(
                                child: ListSelectAddress(
                                    list: state.data.provinces,
                                    onTap: (index) {
                                      selectedProvince(
                                          state.data.provinces[index]);
                                      bloc.add(LoadDataDistrict(
                                          idProvince:
                                              state.data.provinces[index].id));
                                    }))
                          ],
                        );
                      }
                      if (state is LoadedDataDistrict) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            HeaderModalAddress(
                              onClose: () {
                                //context of modal
                                Navigator.of(context).pop();
                              },
                              title: tr('upgrade_salon_27'),
                            ),
                            SearchModalAddress(
                              onChange: (String key) {
                                bloc.add(SearchDataDistrict(
                                    key: key, idProvince: provinceSelected.id));
                              },
                              hintText: tr('upgrade_salon_28'),
                              ctr: ctr,
                            ),
                            Expanded(
                                child: ListSelectAddress(
                                    list: state.data.districts,
                                    onTap: (index) {
                                      selectedDistrict(
                                          state.data.districts[index]);
                                      Navigator.of(context).pop();
                                      // bloc.add(LoadDataWard(
                                      //     idDistrict:
                                      //         state.data.districts[index].id));
                                    }))
                          ],
                        );
                      }
                      // if (state is LoadedDataWard) {
                      //   return Column(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: <Widget>[
                      //       HeaderModalAddress(
                      //         onClose: () {
                      //           //context of modal
                      //           Navigator.of(context).pop();
                      //         },
                      //         title: tr('upgrade_salon_41'),
                      //       ),
                      //       SearchModalAddress(
                      //         onChange: (String key) {
                      //           bloc.add(SearchDataWard(
                      //               key: key, idDistrict: districtSelected.id));
                      //         },
                      //         hintText: tr('upgrade_salon_42'),
                      //         ctr: ctr,
                      //       ),
                      //       Expanded(
                      //           child: ListSelectAddress(
                      //               list: state.data.wards,
                      //               onTap: (index) {
                      //                 selectedWard(state.data.wards[index]);
                      //                 Navigator.of(context).pop();
                      //               }))
                      //     ],
                      //   );
                      // }
                      return Center(child: CircularProgressIndicator());
                    })),
          ),
        );
      },
    );
  }

  selectedProvince(Province item) {
    provinceSelected = item;
    ctr.clear();
  }

  selectedDistrict(District item) {
    districtSelected = item;
    onSubmit(provinceSelected, districtSelected, null);
    ctr.clear();
  }

  // selectedWard(Ward item) {
  //   wardSelected = item;
  //   onSubmit(provinceSelected, districtSelected, wardSelected);
  //   ctr.clear();
  // }
}
