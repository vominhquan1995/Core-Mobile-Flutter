import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/core/config_json/models/config_json.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/shared/text_html/text_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HinhThuc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigjsonBloc, ConfigJson>(
      builder: (BuildContext _, state) {
        List<Widget> children = [
          Text('Chọn hình thức thanh toán', style: style15),
          SizedBox(height: paddingL),
        ];

        if (state is ConfigJson && state.dataPayment != null) {
          final list = state.dataPayment;
          for (var item in list) {
            children.addAll([
              CheckBoxImageText(
                  value: true,
                  image: item.image,
                  child: DefaultTextStyle(
                    style: style15,
                    textAlign: TextAlign.left,
                    child: HtmlText(data: item.description),
                  )),
              SizedBox(height: paddingL),
            ]);
          }
        }

        return Padding(
          padding: EdgeInsets.all(paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        );
      },
    );
  }
}

class CheckBoxImageText extends StatelessWidget {
  final bool value;

  final String image;

  final Widget child;

  CheckBoxImageText({
    this.value = false,
    this.image,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RadioCustom(value: value),
        SizedBox(width: paddingL),
        SvgPicture.asset(image, width: 25, height: 25),
        SizedBox(width: paddingL),
        Expanded(child: child ?? Container())
      ],
    );
  }
}

class RadioCustom extends StatelessWidget {
  bool value;

  RadioCustom({this.value = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(),
      ),
      padding: EdgeInsets.all(paddingS),
      child: Container(
        decoration: BoxDecoration(
          color: value ? Colors.blue : Colors.white,
          shape: BoxShape.circle,
        ),
        child: Padding(padding: EdgeInsets.all(paddingM)),
      ),
    );
  }
}
