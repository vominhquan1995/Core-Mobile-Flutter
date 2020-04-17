import 'dart:async';
import 'dart:io';

import 'package:Core/widgets/thanh_vien_f2_f3/db/news_provider.dart';
import 'package:Core/widgets/thanh_vien_f2_f3/model/index.dart';
import 'package:Core/widgets/thanh_vien_f2_f3/model/thanh_vien.m.dart';
import 'package:Core/widgets/thanh_vien_f2_f3/service/thanh_vien_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'thanh_vien_event.dart';
part 'thanh_vien_state.dart';

class ThanhVienBloc extends Bloc<ThanhVienEvent, ThanhVienState> {
  ThanhVienService service;
  ThanhVienDB _db = ThanhVienDB();

  ThanhVienBloc({@required this.service});

  @override
  ThanhVienState get initialState => ThanhVienInitial();

  @override
  Stream<ThanhVienState> mapEventToState(
    ThanhVienEvent event,
  ) async* {
    if (event is GetData) {
      try {
        final data = await this.service.listPhanCap();
        List<PhanCapModel> phan_cap_1 = mapListDonHang(data['phan_cap_lv1']);
        if (phan_cap_1.length > 0) {
          // Lấy số lượng thành viên thêm vào db sqlite
          var f2 = phan_cap_1.length.toString();
          var f3 = data['phan_cap_lv2'].toString();

          try {
            await _db.clearAll();

            await _db.insert(phan_cap_1);
          } catch (e) {
            print(e);
          }

          //Lưu số lượng thành viên F2, F3 vào máy
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('thanhVien');
          await prefs.setStringList('thanhVien', [f2, f3]);

          yield LoadedThanhVien(
              thanh_vien: phan_cap_1,
              slF2: phan_cap_1.length.toString(),
              slF3: data['phan_cap_lv2'].toString());
        } else {
          yield EmptyThanhVien();
        }
      } catch (e) {
        if (e?.error is SocketException) {
          /// Get data local
          // add(GetDataNewsLocal(e: e, danhMuc: event.danhMuc ?? null));
          return;
        }
        yield EmptyThanhVien();
      }
    }

    if (event is SearchEvent) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var list = prefs.getStringList('thanhVien');
      try {
        final data = await ThanhVienDB.search(event.body);
        if (data.length > 0) {
          yield SearchThanhVien(
              thanh_vien: data,
              slF2: list[0].toString(),
              slF3: list[1].toString());
        } else {
          yield EmptySearchThanhVien(
              slF2: list[0].toString(), slF3: list[1].toString());
        }
      } catch (e) {
        if (e?.error is SocketException) {
          return;
        }
        yield EmptySearchThanhVien(
            slF2: list[0].toString(), slF3: list[1].toString());
      }
    }
  }
}

List<PhanCapModel> mapListDonHang(List list) {
  return list.map((f) => PhanCapModel.fromJson(f)).toList();
}
