import 'dart:io';

import 'package:device_id/device_id.dart';
import 'package:Core/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Core/core/page-core/service_custom.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/setting_notification/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingNotificationService extends ServiceCustom {
  SettingNotificationService(ErrorhandleBloc bloc) : super(bloc);

  Future<SettingNotificationModel> getConfig() async {
    final response =
        await dioE.post("/notifications/get-config-user-device", data: {
      "platform": Platform.isIOS ? 'ios' : 'android',
      "diuu": await DeviceId.getID,
      "app_id": Variables.appId
    });
    if (response.statusCode == 200) {
      SettingNotificationModel model = new SettingNotificationModel();
      model.state = response.data['state'];
      // model.is_new = response.data['is_new'];
      model.list_config_page =
          model.mapDataListConfigPage(response.data['config_page']);
      print(model);
      return model;
    } else {
      print("Lỗi khi lấy cấu hình thông báo");
      throw Exception(response);
    }
  }

  Future<bool> updateConfig(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await dioE.post("/notifications/update-config-user-device", data: {
      "platform": Platform.isIOS ? 'ios' : 'android',
      "diuu": await DeviceId.getID,
      "app_id": Variables.appId,
      "state": state,
      "token": prefs.getString('token_device')
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
//      throw Exception(response);
    }
  }

  Future<bool> updateStatePage(int page_id, bool state) async {
    final response = await dioE.post("/notifications/toggle-switch", data: {
      "diuu": await DeviceId.getID,
      "app_id": Variables.appId,
      "state": state,
      "page_id": page_id
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
