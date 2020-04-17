import 'package:Core/core/authentication/bloc/bloc.dart';
import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/core/custom_translate/easy_localization.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/main.dart';
import 'package:Core/widgets/quoc_gia/widgets/checkbox_custom.dart';
import 'package:Core/widgets/shared/buttonMidas/button_midas.dart';
import 'package:Core/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/index.dart';
import 'bloc/quocgia_bloc.dart';

class QuocGiaPage extends StatefulWidget {
  @override
  _QuocGiaPageState createState() => _QuocGiaPageState();
}

class _QuocGiaPageState extends State<QuocGiaPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<QuocgiaBloc>(context).add(GetQuocGia());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuocgiaBloc, QuocgiaState>(
      builder: (context, QuocgiaState state) {
        if (state is LoadingQuocGiaState) {
          return LoadingIndicator();
        }

        List<Widget> list = [];
        if (state is DanhSachQuocgia) {
          list.addAll(state.list
              .where((f) => f.status == 'active')
              .map((f) => CheckBoxCustom(
                    title: Text(f.tenQG, style: style17),
                    value: state.selected == f,
                    onChanged: (bool value) {
                      if (value) {
                        BlocProvider.of<QuocgiaBloc>(context)
                            .add(SelectQuocGia(quocGia: f));
                      }
                    },
                    secondary:
                        SizedBox(height: 32, child: Image.network(f.flag)),
                  ))
              .toList());
        }

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 1 / 3,
                        child: _buildBackGround()),
                    SizedBox(height: paddingM),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: paddingXS,
                        vertical: paddingL,
                      ),
                      child: Text(
                        tr('nation_1'),
                        style: style17,
                      ),
                    ),
                    SizedBox(height: paddingM),
                  ] +
                  [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingXS),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: ListTile.divideTiles(
                          context: context,
                          tiles: list + [Container()].toList(),
                        ).toList(),
                      ),
                    )
                  ] +
                  [
                    SizedBox(height: paddingXXS),
                    Padding(
                      padding: EdgeInsets.all(paddingXS),
                      child: ButtonMidas(
                        onPressed: onPressButton,
                        child: Text(
                          tr('nation_4'),
                          style: style15_semibold.copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  ],
            ),
          ),
        );
      },
    );
  }

  _buildBackGround() {
    final double scaleValue = 0.8;
    final Matrix4 transform = Matrix4.identity()
      ..scale(scaleValue, scaleValue, 1.0);
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        Opacity(
          opacity: 0.15,
          child: Image.asset(
            'assets/images/earch.jpg',
          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: transform,
          child: Image.asset('assets/images/logo.png'),
        ),
      ],
    );
  }

  onPressButton() async {
    final data =
        (BlocProvider.of<QuocgiaBloc>(context).state as DanhSachQuocgia)
            .selected;
    await AppLanguage().changeLanguage(
      Locale(
        data.codeL.toLowerCase(),
        data.codeC.toUpperCase(),
      ),
    );
    AppBuilder.of(context).rebuild();

    BlocProvider.of<QuocgiaBloc>(context).add(LoadingQuocGiaEvent());
    await BlocProvider.of<ConfigjsonBloc>(context).insertDataJson();
    BlocProvider.of<QuocgiaBloc>(context).add(ConfirmQuocGia(quocGia: data));
  }
}
