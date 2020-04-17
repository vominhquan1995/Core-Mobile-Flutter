import 'dart:io';

import 'package:Midas/core/translate/public.dart';
import 'package:device_id/device_id.dart';
import 'package:Midas/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Midas/core/page-core/service_custom.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/notification/model/notification_model.dart';

class NotificationService extends ServiceCustom {
  NotificationService(ErrorhandleBloc bloc) : super(bloc);

  Future<List<NotificationModel>> getListNotification(
      int notifi_id, int per_page) async {
    final response = await dioE.post(
      "/notifications/load-list",
      data: {
        "notifi_id": notifi_id,
        "per_page": per_page,
        "language": Localization.locate.languageCode
      },
    );
    if (response.statusCode == 200) {
      List list = response.data['result'] as List;
      return list
          .map((f) => NotificationModel(
                notifiid: f['notifi_id'].toString(),
                // timesent: f['time_sent'].toString(),

                noidung: f['noi_dung'].toString(),
                noidunghtml: f['noi_dung_html'].toString(),
                tieude: f['tieu_de'].toString(),
                timecreate: f['time_create'].toString(),
                // isview: f['is_view'],
              ))
          .toList();
    } else {
      throw Exception(response);
    }
  }

  Future<bool> registerToken(String token) async {
    final response = await dioP.post("/api/contact/token/register", data: {
      "token_notifi": token,
      "uuid": await DeviceId.getID,
      "device": Platform.isIOS ? 'ios' : 'android',
      "app_id": Variables.appId
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response);
    }
  }

  Future<bool> registerTokenUser(String token, List<int> idTopics) async {
    final response = await dioE.post("/notifications/regis-token-user", data: {
      "app_id": Variables.appId,
      "uuid": await DeviceId.getID,
      "token": token,
      "platform": Platform.isIOS ? 'ios' : 'android',
      "settings": idTopics
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response);
    }
  }
}
