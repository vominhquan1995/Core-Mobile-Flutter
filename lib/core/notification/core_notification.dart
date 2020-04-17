import 'package:Core/core/authentication/bloc/bloc.dart';
import 'package:Core/core/notification/bloc/index.dart';
import 'package:Core/screens/layout/tab/bloc/tab_bloc.dart';
import 'package:Core/screens/layout/tab/bloc/tab_event.dart';
import 'package:Core/screens/layout/tab/bloc/tab_state.dart';
import 'package:Core/widgets/notification/model/notification_model.dart';
import 'package:Core/widgets/notification/notification_detail_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:Core/core/authentication/db/authen_provider.dart';
import 'package:Core/core/notification/db/notifi_provider.dart';
import 'package:Core/utils/notification_util.dart';
import 'package:Core/widgets/notification/service/notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const TAG = 'NOFITICATION: ';

abstract class NotificationCore {
  static const String TABLE_NAME = "notification";
  static const String KEY_TOKEN_LAST = "TokenLast";
  static const String KEY_TOKEN_NEW = "TokenNew";
  NotifiProvider provider = NotifiProvider();
  /*
   * @author quanvo
   * @des call after init app
   * isNew to set flag request new token
   */
  Future getTokenFirebase(bool isNew) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
    var state = prefs.getBool("stateNotifi");
    var stateRegis = false;
    if (state == null)
      await prefs.setBool(
          'stateNotifi', true); // app moi cai data => set state true
    //delete token if flag is new is true
    if (isNew) {
      await firebaseMessaging.deleteInstanceID();
    }
    //get token fb
    await firebaseMessaging.getToken().then((token) async {
      //set flag
      await prefs.setBool('errorNotifi', false);
      //save token local
      await prefs.setString('token_device', token);
      //save token db
      await provider.updateWithKey(NotificationCore.KEY_TOKEN_NEW, token);
      print('${TAG} Get token notifi success => ${token}');
      stateRegis = true;
    }).catchError((onError) {
      print('${TAG} Get token notifi error => set flag');
      prefs.setBool('errorNotifi', true);
      provider.updateWithKey(NotificationCore.KEY_TOKEN_NEW, null);
    });
    if (stateRegis) {
      return true;
    } else {
      return false;
    }
  }

  /*
   * @author quanvo
   * @des hàm này là core xu ly dung de goi service dang ky token notifi 
   */
  Future regisTokenNotify(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //get data token from local
    String tokenNew = await provider.getTokenLocal(KEY_TOKEN_NEW);
    String tokenLast = await provider.getTokenLocal(KEY_TOKEN_LAST);
    if (tokenNew != tokenLast) {
      //token is new
      if (await AuthenticationBloc().isLoggin()) {
        print('${TAG} CALL SERVICE REGIS TOKEN');
        await registerTokenUser(tokenNew, getListTopicOfUser(context))
            .then((data) async {
          print('${TAG} REGIS TOKEN SUCCESS');
          //update tokenLast = token
          await provider.updateWithKey(KEY_TOKEN_LAST, tokenNew);
          //update flag
          await prefs.setBool('errorNotifi', false);
        }).catchError((onError) {
          print('${TAG} REGIS TOKEN FAIL');
          prefs.setBool('errorNotifi', true);
        });
      } else {
        print('${TAG} Skip step regis token');
      }
    } else {
      print('${TAG}  tokenNew = tokenLast => Skip step regis token');
    }
  }

  /*
   *@author quanvo
    *@des lay danh sach id topic theo user de dang ky token
   */
  List<int> getListTopicOfUser(BuildContext context) {
    //set default for all
    List<int> out = [NotificationUtil.idTopicTT];
    // var typeUser = (BlocProvider.of<AuthenticationBloc>(context).currentState
    //         as AuthenticationAuthenticated)
    //     .user
    //     .userEnum;
    // switch (typeUser) {
    //   case LOAI_USER.NHANVIEN:
    //     out = [NotificationUtil.idTopicTT, NotificationUtil.idTopicVB];
    //     break;
    //   case LOAI_USER.SINHVIEN:
    //     out = [NotificationUtil.idTopicTT, NotificationUtil.idTopicTD];
    //     break;
    //   default:
    //     out = [
    //       NotificationUtil.idTopicTT,
    //       NotificationUtil.idTopicVB,
    //       NotificationUtil.idTopicTD
    //     ];
    // }
    return out;
  }

  /*
   * @author quanvo
   * @des hàm xử lý các sự kiện khi nhận được notifi
   */
  Future configFirebase(BuildContext context) async {
    print('${TAG} SET EVENT RECEIVER NOTIFY');
    FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
    if (Platform.isIOS) iOS_Permission(firebaseMessaging);
    firebaseMessaging.configure(onMessage: (Map<String, dynamic> msg) {
      // var item = mapData(msg);
      // increaseBadge(item.page);
      showNotification(context, mapData(msg));
    }, onLaunch: (Map<String, dynamic> msg) {
      var item = mapData(msg);
      // increaseBadge(item.page);
      BlocProvider.of<CoreNotificationBloc>(context)
          .add(RedirectPage(data: item));
      // goToPageDetail(context, item.notId, item.page, item.id);
    }, onResume: (Map<String, dynamic> msg) {
      var item = mapData(msg);
      // increaseBadge(item.page);
      BlocProvider.of<CoreNotificationBloc>(context)
          .add(RedirectPage(data: item));
      // goToPageDetail(context, item.notId, item.page, item.id);
    });
  }

  /*
   * @author quanvo
   * @des detect thiet bi IOS
   */
  void iOS_Permission(FirebaseMessaging firebaseMessaging) {
    firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {});
  }

  /*
   * @author quanvo
   * @des hien thi chi tiet notify
   */
  Future showNotification(BuildContext context, ItemNotification data) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(data.title),
          content: new Text(data.body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Đóng"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Chi tiết"),
              onPressed: () {
                //redirect
                Navigator.of(context).pop();
                BlocProvider.of<CoreNotificationBloc>(context)
                    .add(RedirectPage(data: data));
                // goToPageDetail(context, data.notId, data.page, data.id);
              },
            ),
          ],
        );
      },
    );
  }
  // Future showNotification(
  //     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  //     Map<String, dynamic> msg) async {
  //   var styleInformation = new BigTextStyleInformation(msg["data"]['message'],
  //       contentTitle: msg["data"]['title']);
  //   var android = new AndroidNotificationDetails(
  //       'your channel id', "your channel name',", "your channel description",
  //       priority: Priority.High,
  //       importance: Importance.Max,
  //       style: AndroidNotificationStyle.BigText,
  //       styleInformation: styleInformation);
  //   var iOS = new IOSNotificationDetails();
  //   var platform = new NotificationDetails(android, iOS);
  //   await flutterLocalNotificationsPlugin.show(int.parse(msg["data"]['notId']),
  //       msg["data"]['title'], msg["data"]['message'], platform,
  //       payload:
  //           '${msg["data"]['notId']},${msg["data"]['page']},${msg["data"]['id']}');
  // }

  // deleteNotifyById(
  //     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  //     id) async {
  //   await flutterLocalNotificationsPlugin.cancel(id);
  // }
  increaseBadge(id) {}
  removeBadge(id) {}
  Future<bool> registerTokenDevice(String token) async {
    NotificationService service = new NotificationService(null);
    await service.registerToken(token).then((onValue) {
      return onValue;
    });
  }

  Future<bool> registerTokenUser(String token, List<int> idTopics) async {
    NotificationService service = new NotificationService(null);
    await service.registerTokenUser(token, idTopics).then((onValue) {
      return onValue;
    });
  }

  void goToPageDetail(
      BuildContext context, int notifiId, int page, int idDetail) {
    if (page == NotificationUtil.idPageNotifi) {
      jumbTab(context, NotificationUtil.idTabNotifi.toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return NotificationDetail(
                data: NotificationModel(notifiid: notifiId.toString()));
          },
        ),
      );
    }
  }

  void jumbTab(BuildContext context, String idMenu) {
    var index = tabSelector.indexWhere((item) => item.tabPage.id == idMenu);
    if (index != -1) {
      BlocProvider.of<TabBloc>(context).add(JumbTab(AppTab.values[index]));
    }
  }
}

ItemNotification mapData(Map<String, dynamic> message) {
  String _title;
  String _body;
  int _page;
  int _id;
  int _notId;
  try {
    if (Platform.isIOS) {
      _title = message['aps']['alert']['title'];
      _body = message['aps']['alert']['body'];
      _page = int.tryParse(message['page']);
      _id = int.tryParse(message['id']);
      _notId = int.tryParse(message['id']);
    } else {
      _title = message['data']['title'];
      _body = message['data']['message'];
      _page = int.tryParse(message['data']['page']);
      _id = int.tryParse(message['data']['id']);
      // _notId = int.tryParse(message['data']['notId']);
      _notId = int.tryParse(message['data']['id']); //user id
    }
  } catch (ex) {
    print(ex);
    print('Lỗi chuyển đổi dữ liệu');
  }
  return new ItemNotification(
      title: _title, body: _body, page: _page, id: _id, notId: _notId);
}

class ItemNotification {
  ItemNotification({this.title, this.body, this.page, this.id, this.notId});
  final String title;
  final String body;
  final int page;
  final int id;
  final int notId;
}
