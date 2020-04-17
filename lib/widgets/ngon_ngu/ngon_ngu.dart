import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/main.dart';
// import 'package:Core/core/custom_translate/easy_localization.dart';
// import 'package:Core/core/translate/public.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/ngon_ngu/bloc_ngon_ngu/ngonngu_bloc.dart';
import 'package:Core/widgets/ngon_ngu/service/ngon_ngu_service.dart';
import 'package:Core/widgets/quoc_gia/bloc/quocgia_bloc.dart';
import 'package:Core/widgets/quoc_gia/models/quocgia_model.dart';
import 'package:Core/widgets/quoc_gia/widgets/checkbox_custom.dart';
import 'package:Core/widgets/shared/buttonMidas/button_midas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NgonNguPage extends StatefulWidget {
  @override
  _NgonNguPageState createState() => _NgonNguPageState();
}

class _NgonNguPageState extends State<NgonNguPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  NgonnguBloc ngonnguBloc = NgonnguBloc(service: NgonNguService());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final oldLocale = Localization.locate;
    ngonnguBloc.add(GetDSNgonNgu(language: oldLocale?.languageCode));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ngonnguBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: ngonnguBloc,
      listener: (_, state) {
        // TODO: implement listener

        if (state is NgonNguLoaded && state.selected == null) {
          final oldLocale = Localization.locate;
          if (oldLocale != null) {
            ngonnguBloc.add(
              SelectNgonNgu(
                selected: new QuocGiaModel(
                    locale:
                        '${oldLocale?.languageCode}_${oldLocale?.countryCode}'),
              ),
            );
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(tr('language_1')),
          flexibleSpace: Image(
            image: AssetImage('assets/images/background_appbar.jpg'),
            fit: BoxFit.cover,
            alignment: AlignmentDirectional.center,
          ),
        ),
        body: BlocBuilder(
          bloc: ngonnguBloc,
          builder: (_, state) {
            if (state is NgonNguLoaded) {
              final select = state.selected;

              List<Widget> list = [];
              list.addAll(state.list
                  .map(
                    (f) => CheckBoxCustom(
                      title: Text(f.tenQG),
                      value: select != null
                          ? state.selected.locale == f.locale
                          : false,
                      onChanged: (bool value) {
                        if (value) {
                          ngonnguBloc.add(SelectNgonNgu(selected: f));
                          return;
                        }
                      },
                      secondary: SizedBox(
                        height: 32,
                        width: 52,
                        child: Image.network(f.flag, fit: BoxFit.fill),
                      ),
                    ),
                  )
                  .toList());

              return ListView(
                padding: EdgeInsets.symmetric(
                  vertical: paddingL,
                  horizontal: paddingXS,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: ListTile.divideTiles(
                  context: context,
                  tiles: list +
                      [
                        Container(),
                        buttonDoiNgonNgu(),
                      ].toList(),
                ).toList(),
              );

              // return ListView.builder(
              //   itemCount: state.list.length + 1,
              //   padding: EdgeInsets.symmetric(
              //     vertical: paddingL,
              //     horizontal: paddingXS,
              //   ),
              //   itemBuilder: (_, int index) {
              //     ///BUTTON ĐỔI NGÔN NGỮ
              //     if (index == state.list.length) {
              //       return buttonDoiNgonNgu();
              //     }

              //     ///DEFAULT
              //     final f = state.list[index];
              //     return CheckBoxCustom(
              //       title: Text(f.tenQG),
              //       value: select != null
              //           ? state.selected.locale == f.locale
              //           : false,
              //       onChanged: (bool value) {
              //         if (value) {
              //           ngonnguBloc.add(SelectNgonNgu(selected: f));
              //           return;
              //         }
              //       },
              //       secondary:
              //           SizedBox(height: 32, child: Image.network(f.flag)),
              //     );
              //   },
              // );
            }

            return SizedBox.expand(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buttonDoiNgonNgu() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingL,
        vertical: paddingXXS,
      ),
      child: ButtonMidas(
        onPressed: () {
          final select = (ngonnguBloc.state as NgonNguLoaded).selected;
          if (select != null) {
            AppLanguage()
                .changeLanguage(Locale(
                    select.codeL.toLowerCase(), select.codeC.toUpperCase()))
                .then((onValue) {
              final qg = (BlocProvider.of<QuocgiaBloc>(context).state
                      as DanhSachQuocgia)
                  .confirm;

              BlocProvider.of<ConfigjsonBloc>(context).add(
                InitJsonConfig(
                  codeL: select.codeL.toLowerCase(),
                  codeC: qg.maVung,
                ),
              );
              AppBuilder.of(context).rebuild();
              Navigator.of(context).pop();
            });
            // Navigator.of(context).pop();
          }
        },
        child: Text(
          tr('language_2'),
          style: style15_semibold.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
