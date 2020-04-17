import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Core/core/page-core/bloc/bloc.dart';
import 'package:Core/utils/theme.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/setting_notification/bloc/bloc_setting_notificatiom.dart';
import 'package:Core/widgets/setting_notification/model/setting_categories_notifi_model.dart';
import 'package:Core/widgets/setting_notification/service/setting_notification_service.dart';
import 'package:Core/widgets/shared/border-dash/index.dart';

class SettingNotifiItem extends StatefulWidget {
  final SettingCategoryNotifiModel category;
  SettingNotifiItem(SettingCategoryNotifiModel category)
      : category = category,
        super(key: new ObjectKey(category));
  @override
  SettingNotifiItemState createState() {
    return new SettingNotifiItemState(category);
  }
}

class SettingNotifiItemState extends State<SettingNotifiItem> {
  SettingNotificationBloc bloc;
  @override
  Future initState() {
    bloc = SettingNotificationBloc(
        SettingNotificationService(BlocProvider.of<ErrorhandleBloc>(context)));

    super.initState();
  }

  bool _value = false;
  final SettingCategoryNotifiModel category;
  SettingNotifiItemState(this.category);
  @override
  Widget build(BuildContext context) {
    _value = category.state;
    var lastItem = category.isLast;
    return new Column(children:
        //color: Colors.white,
        [
      Container(
        child: SwitchListTile(
          activeTrackColor: Color.fromRGBO(79, 174, 51, 1),
          inactiveTrackColor: Color.fromRGBO(100, 120, 126, 1),
          value: _value,
          title: Text(
            category.title,
            style: style17.copyWith(fontStyle: FontStyle.normal),
          ),
          activeColor: Colors.white,
          onChanged: category.isDisabled ? null : _onChange,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: paddingL, left: paddingL),
        child: !lastItem
            ? MySeparator(
                color: colorGrey_2,
              )
            : Divider(
                color: borderSide.color,
              ),
      ),
    ]);
  }

  _onChange(bool newValue) {
    changeStateTopic(category.id, newValue);
    category.state = newValue;
    setState(() {
      _value = newValue;
    });
  }

  void changeStateTopic(int page_id, bool state) async {
    try {
      final responese = await bloc.updateStateTopic(page_id, state);
      if (responese) {
        category.state = state;
        bloc.setStateTopicNotifi(category.key, state);
      }
    } catch (e) {
      category.state = !state;
      bloc.setStateTopicNotifi(category.key, !state);
      //revert
      setState(() {
        _value = !state;
      });
    }
  }
}
