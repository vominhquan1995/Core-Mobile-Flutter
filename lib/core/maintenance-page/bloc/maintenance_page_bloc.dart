import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:Core/core/maintenance-page/db/maintenance_provider.dart';
import 'package:Core/core/maintenance-page/maintenance_model.dart';
import 'package:Core/core/maintenance-page/maintenance_service.dart';
import 'package:Core/utils/index.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './index.dart';

class MaintenancePageBloc
    extends Bloc<MaintenancePageEvent, MaintenancePageState> {
  MaintenanceService service = MaintenanceService();
  MaintenanceProvider maintenanceProvider = MaintenanceProvider();

  ///Key_store
  String key_store = 'Bao-tri-page';

  ///Key quyet dinh update du lieu
  String key_update = 'Bao-tri-update';

  /// Version Maintenance
  String key_version = 'Bao-tri-version';

  @override
  MaintenancePageState get initialState => InitialMaintenancePageState();

  @override
  Stream<MaintenancePageState> mapEventToState(
    MaintenancePageEvent event,
  ) async* {
    // TODO: Add Logic

    if (event is StartBaoTriPage) {
      yield InitialMaintenancePageState();
    }

    if (event is KiemTraBaoTriPage) {
      final bt = await maintenanceProvider.select();
      if (bt != null) {
        _changeState(bt.tinhTrang, bt.html);
      } else {
        add(KhongBaoTriPage());
      }
    }

    if (event is CoBaoTriPage) {
      yield GetMaintenancePageState(data: event.data);
    }

    if (event is KhongBaoTriPage) {
      Map<String, dynamic> map = Map<String, dynamic>();
      getListPageBaoTri().forEach((key) => map.addAll({
            key: {"mode": false, "html": ''}
          }));

      yield GetMaintenancePageState(data: map);
    }
  }

  _showBaoTriPage(String timeUpdate) async {
    /// Kiểm tra key phiên bản
    String _keyVersionBaoTri = await _getVersionBaoTri();
    if (_keyVersionBaoTri != null) {
      /// Kiểm tra trùng nhau giữa 2 version
      if (_keyVersionBaoTri != Variables.getVersion) {
        _updateJsonBaoTri(timeUpdate);
      } else {
        ///Get key update
        String _key = await _getKeyUpdate();
        if (timeUpdate != _key) {
          _updateJsonBaoTri(timeUpdate);
        } else {
          _readJsonDb(timeUpdate);
        }
      }
    } else {
      _capNhatVersionBaoTri();
      _updateJsonBaoTri(timeUpdate);
    }
  }

  _changeState(bool tt, String dataChange) {
    if (tt) {
      print('Maintenance: Có bảo trì một số page');

      /// Maintenance: Có bảo trì một số page
      _showBaoTriPage(dataChange.toString());
      // add(CoBaoTriPage(update: dataChange.toString()));
    } else {
      print('Maintenance: Không bảo trì page nào');

      /// Maintenance: Không bảo trì page nào

      add(KhongBaoTriPage());
    }
  }

  _updateJsonBaoTri(String timeUpdate) async {
    // Gồm 2 data lấy api + local
    // 1 trong 2 emit data trả về view
    //
    Observable<Map<String, dynamic>>.merge([
      service.maintenance().then((onValue) async {
        await maintenanceProvider.insertObject(onValue);
        return onValue as Map<String, dynamic>;
      }).asStream(),
      _layDataTrongDB().asStream(),
    ]).listen((onData) async {
      /// Data null khi mới cài đặt app. Phải đợi lấy data từ Firebase
      if (onData != null) {
        await _capNhatTrongDB(time_update: timeUpdate);
        add(CoBaoTriPage(data: onData));
      }
    }).onError((handleError) async {
      print('Maintenance: Lỗi $handleError');
      final data = await _layDataTrongDB();

      ///Lấy trong database xem coi có không có

      if (data != null) {
        /// nếu có thì đưa data
        add(CoBaoTriPage(data: data));
      } else {
        /// Không có bỏ qua
        add(KhongBaoTriPage());
      }
    });
  }

  _readJsonDb(String timeUpdate) async {
    ///Trùng key
    print('Maintenance: Key giống nhau');
    print('Maintenance: Không cập nhật trong database');

    // TODO: Lưu local html
    final data = await _layDataTrongDB();

    if (data != null) {
      add(CoBaoTriPage(data: data));
    } else {
      /// Nếu trong db ko có thì check trên api rồi cập nhật db
      try {
        Map data = await this.service.maintenance();
        print('Maintenance: Cập nhật trong database');
        await _capNhatTrongDB(time_update: timeUpdate);
        await maintenanceProvider.insertObject(data);

        add(CoBaoTriPage(data: data));
      } catch (e) {
        /// Nếu api không được thị chịu
        print('Error api Maintenance $e');
        add(KhongBaoTriPage());
      }
    }
  }

  Future<Map<String, dynamic>> _layDataTrongDB() async {
    return await maintenanceProvider.selectBaoTriPage();
  }

  _capNhatTrongDB({String time_update}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key_update, time_update);
  }

  Future<String> _getKeyUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key_update);
  }

  Future<String> _getVersionBaoTri() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key_version);
  }

  _capNhatVersionBaoTri() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key_version, Variables.getVersion);
  }
}
