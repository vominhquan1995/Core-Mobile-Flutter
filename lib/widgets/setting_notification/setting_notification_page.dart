import 'package:Midas/core/translate/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Midas/core/google_analytics/index.dart';
import 'package:Midas/core/notification/core_notification.dart';
import 'package:Midas/core/page-core/bloc/bloc.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/utils/notification_util.dart';
import 'package:Midas/utils/theme.dart';
import 'package:Midas/widgets/setting_notification/index.dart';
import 'package:Midas/widgets/setting_notification/widgets/setting_notifi_item.dart';

const TAG = 'SETTING_NOFITICATION: ';
enum ConfirmAction { CANCEL, OK }

class SettingNotificationFormPage extends StatefulWidget {
  SettingNotificationFormPage({Key key}) : super(key: key);
  @override
  State<SettingNotificationFormPage> createState() =>
      new _SettingNotificationPageState();
}

class _SettingNotificationPageState extends State<SettingNotificationFormPage>
    with NotificationCore {
  List<SettingCategoryNotifiModel> categorys = [
    new SettingCategoryNotifiModel(
        NotificationUtil.idTopicTT,
        NotificationUtil.keyTopicTT,
        "Tin tức mới",
        NotificationUtil.configStateTopicDefault,
        false,
        false),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SettingNotificationBloc bloc;

  bool settingNotification = false;
  bool errorRegisNotifi = false;
  bool _isLoading = true;
  @override
  Future initState() {
    bloc = SettingNotificationBloc(
        SettingNotificationService(BlocProvider.of<ErrorhandleBloc>(context)));

    super.initState();
    GoogleAnalytics.trackScreen(setting_notification_page);
    _isLoading = true;
    bloc.checkErrorRegisNotifi().then((data) {
      if (data == null || !data) {
        //không có lỗi regis notifi
        bloc.getConfig();
        bloc.config.listen((onData) {
          //install new => on all topic
          if (onData.list_config_page.length > 0) {
            //map list with value
            for (int i = 0; i < categorys.length; i++) {
              try {
                ItemPageConfig data = onData.list_config_page
                    .where((z) => z.key == categorys[i].id)
                    .first;
                //k co gia tri config => false
                categorys[i].state = data != null
                    ? data.value
                    : NotificationUtil.configStateTopicDefault;
                //save cookie
                bloc.setStateTopicNotifi(categorys[i].key, categorys[i].state);
              } catch (Exception) {
                categorys[i].state = NotificationUtil.configStateTopicDefault;
                //save cookie
                bloc.setStateTopicNotifi(
                    categorys[i].key, NotificationUtil.configStateTopicDefault);
              }
            }
          }
          setState(() {
            settingNotification = onData.state;
            errorRegisNotifi = false;
            _isLoading = false;
          });
        });
      } else {
        //disabled
        for (int i = 0; i < categorys.length; i++) {
          categorys[i].isDisabled = true;
          categorys[i].state = NotificationUtil.configStateTopicDefault;
        }
        setState(() {
          errorRegisNotifi = true;
          settingNotification = false;
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text(
          tr('setting_1'),
          style: style15_semibold.copyWith(color: Colors.white),
        ),
        flexibleSpace: Image(
          image: AssetImage('assets/images/background_appbar.jpg'),
          fit: BoxFit.cover,
          alignment: AlignmentDirectional.center,
        ),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildBody(context),
      ),
    );
  }

  List<Widget> _buildBody(BuildContext context) {
    var eventChange = errorRegisNotifi == true ? null : setStateNotification;
    var list = new List<Widget>();
    if (_isLoading) {
      var modal = new Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height / 3),
          Center(child: CircularProgressIndicator()),
        ],
      );
      list.add(modal);
      return list;
    }
    list.add(Container(height: paddingXS, color: Colors.white));
    list.add(Container(
        color: Colors.white,
        child: new Column(children: [
          Container(
            color: Colors.white,
            // margin: EdgeInsets.only(right: paddingL, left: paddingL),
            child: SwitchListTile(
                activeTrackColor: Color.fromRGBO(79, 174, 51, 1),
                inactiveTrackColor: Color.fromRGBO(100, 120, 126, 1),
                value: settingNotification,
                title: Text(tr('setting_2'), style: style17),
                activeColor: Colors.white,
                onChanged: eventChange),
          ),
          Padding(
              padding: const EdgeInsets.only(right: paddingL, left: paddingL),
              child: Divider(
                color: colorGrey_2,
              )),
        ])));
//    if (settingNotification) {
    //add list category
//     list.add(Container(height: paddingXS, color: Colors.white));
//     list.add(new Container(
//       color: Colors.white,
//       padding: EdgeInsets.only(left: paddingL, right: paddingL),
//       //padding: EdgeInsets.only(left: 20, bottom: paddingM),
//       child: Align(
//         alignment: Alignment.bottomLeft,
//         child: Text(
//           "LOẠI THÔNG BÁO MUỐN NHẬN",
//           style: style17_black.copyWith(fontStyle: FontStyle.normal),
//         ),
//       ),
//     ));
//     //ADD LIST CONFIG
//     list.add(Container(
//         color: Colors.white,
//         child: new Column(
//             children: categorys.map((SettingCategoryNotifiModel category) {
//           return new SettingNotifiItem(
//             category,
//           );
//         }).toList())));
// //    }
//     if (errorRegisNotifi == true) {
//       var textError = new Expanded(
//         child: new Center(
//             child: Text(
//           "Đã xảy ra lỗi cấu hình thông báo trên thiết bị này.\n Mở lại ứng dụng hoặc liên hệ để được hỗ trợ.",
//           style:
//               style13.copyWith(fontStyle: FontStyle.normal, color: Colors.red),
//         )),
//       );
//       list.add(textError);
//     }
//     list.add(Container(height: paddingXS, color: Colors.white));
    return list;
  }

  Future<ConfirmAction> _dialogConfirm(BuildContext context) {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(tr('setting_3')),
          content: new Text(
              !settingNotification ? tr('setting_4') : tr('setting_5')),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(tr('setting_6')),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            new FlatButton(
              child: new Text(tr('setting_7')),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.OK);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }

  setStateNotification(value) async {
    setState(() {
      settingNotification = value;
    });
    final ConfirmAction action = await _dialogConfirm(context);
    if (action == ConfirmAction.OK) {
      onSave();
    } else {
      setState(() {
        settingNotification = !value;
      });
    }
  }

  onSave() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    var snackBar;
    try {
      final responese = await bloc.updateConfig(settingNotification);
      if (responese) {
        //update change 18/12/2019
        bloc.setStateNotifi(settingNotification);
        setState(() {
          _isLoading = false;
        });
        snackBar = SnackBar(
          content: Text(tr('setting_8')),
          key: GlobalKey(),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        settingNotification = !settingNotification;
      });
      snackBar = SnackBar(
        content: Text(e),
        key: GlobalKey(),
      );
    }
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
