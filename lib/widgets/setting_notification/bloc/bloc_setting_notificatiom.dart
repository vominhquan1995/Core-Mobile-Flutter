import 'package:Core/core/translate/public.dart';
import 'package:Core/core/notification/badge_helper.dart';
import 'package:Core/utils/notification_util.dart';
import 'package:Core/widgets/setting_notification/index.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingNotificationBloc {
  var dbHelper = BadgeHelper();

  final SettingNotificationService _repository;
  SettingNotificationBloc(this._repository);

  BehaviorSubject<SettingNotificationModel> _settingFetcher =
      BehaviorSubject<SettingNotificationModel>.seeded(
          SettingNotificationModel());
  Observable<SettingNotificationModel> get config => _settingFetcher.stream;
  getConfig() async {
    try {
      _settingFetcher.sink.add(await _repository.getConfig());
    } catch (e) {
      _settingFetcher.sink.addError(e);
    }
  }

  Future<bool> updateConfig(bool state) async {
    try {
      return await _repository.updateConfig(state);
    } on DioError catch (e) {
      if (e.type == DioErrorType.DEFAULT) {
        throw tr('other_4');
      }
      if (e.type == DioErrorType.RESPONSE) {
        if (!(e.response.data is String) &&
            e.response.data['message'] != null) {
          throw e.response.data['message'];
        } else {
//          throw e.response.data;
          throw tr('other_11');
        }
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        throw tr('other_6');
      }
      throw tr('other_11');
    }
  }

  dispose() {
    _settingFetcher.close();
  }

  Future<bool> getStateNotifi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool statenotyfy = false;
    if (prefs.getBool("stateNotifi") != null) {
      statenotyfy = prefs.getBool("stateNotifi");
    }
    return statenotyfy;
  }

  Future<bool> checkErrorRegisNotifi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool flagerror = false;
    if (prefs.getBool("errorNotifi") != null) {
      flagerror = prefs.getBool("errorNotifi");
    }
    return flagerror;
  }

  Future<bool> setStateNotifi(bool state) async {
    //save pref
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //save sqllite
    await this.dbHelper.updateConfigNotifi(NotificationUtil.keyNotifi, state);
    return prefs.setBool("stateNotifi", state);
  }

  Future<bool> setStateTopicNotifi(String key, bool state) async {
    //save sqllie
    await this.dbHelper.updateConfigNotifi(key, state);
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    return prefs.setBool("topic_"+ id.toString(), state);
  }

  Future<bool> updateStateTopic(int page_id, bool state) async {
    try {
      return await _repository.updateStatePage(page_id, state);
    } on DioError catch (e) {
      if (e.type == DioErrorType.DEFAULT) {
        throw tr('other_4');
      }
      if (e.type == DioErrorType.RESPONSE) {
        if (!(e.response.data is String) &&
            e.response.data['message'] != null) {
          throw e.response.data['message'];
        } else {
          throw tr('other_11');
        }
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        throw tr('other_6');
      }
      throw tr('other_11');
    }
  }
}
