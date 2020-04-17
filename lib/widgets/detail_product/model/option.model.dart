import 'package:flutter/cupertino.dart';

class OptionModel {
  OptionModel(
      {@required this.key, this.title, this.value, this.active = false});
  final String key;
  final String title;
  final String value;
  bool active;
}
