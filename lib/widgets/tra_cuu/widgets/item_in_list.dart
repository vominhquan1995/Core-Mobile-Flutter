import 'package:Core/utils/index.dart';
import 'package:Core/widgets/shared/border-dash/index.dart';
import 'package:Core/widgets/tra_cuu/models/tracuu_model.dart';
import 'package:flutter/material.dart';

class ItemInList extends StatelessWidget {
  final TraCuu traCuu;
  final Function onPress;

  const ItemInList({Key key, this.traCuu, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPress ?? null,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.fiber_manual_record,
                color: colorGrey_2,
                size: 12,
              ),
              SizedBox(width: paddingM),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: paddingM,
                    top: paddingM,
                    bottom: paddingM,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(traCuu.noiDung, style: style17),
                      SizedBox(height: paddingS),
                      MySeparator(color: colorGrey_1)
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.navigate_next,
                color: colorGrey_2,
                size: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
