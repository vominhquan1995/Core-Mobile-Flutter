import 'package:Core/utils/index.dart';
import 'package:flutter/material.dart';

class CheckBoxCustom extends StatelessWidget {
  final Widget title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget secondary;

  const CheckBoxCustom(
      {Key key, this.title, this.value, this.onChanged, this.secondary})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () => onChanged(!value),
      leading: secondary,
      title: title,
      trailing: _buildIconCheckBox(color: value ? colorViolet : colorGrey_2),
    );
  }

  _buildIconCheckBox({Color color}) {
    return Icon(
      Icons.check_circle,
      color: color,
      size: style28.fontSize,
    );
  }
}
