import 'package:Core/core/authentication/bloc/bloc.dart';
import 'package:Core/core/authentication/models/profile_model.dart';
import 'package:Core/core/custom_translate/easy_localization.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/utils/theme.dart';
import 'package:Core/widgets/shared/buttonMidas/button_midas.dart';
import 'package:Core/widgets/thongtin_canhan/bloc_thongtin_canhan/thongtincanhan_bloc.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String dateTimeNgaySinh;
  String hoTen;

  TextEditingController textCtrlHoTen;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ///

    return MultiBlocListener(
      listeners: [
        BlocListener<ThongTinCaNhanBloc, ThongTinCaNhanState>(
          listener: (_, state) {
            if (state is ThongtincanhanLoaded) {
              if (state.updateError) {
                showToastError();

                return;
              }

              showToastSucess();
            }
          },
        ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorGrey_1,
        appBar: AppBar(
          title: Text(tr('edit_1')),
          flexibleSpace: Image(
            image: AssetImage('assets/images/background_appbar.jpg'),
            fit: BoxFit.cover,
            alignment: AlignmentDirectional.center,
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (_, state) {
                if (state is AuthenticationAuthenticated) {
                  textCtrlHoTen = TextEditingController(
                    text: hoTen ?? state.user.hoten,
                  );

                  return TextField(
                    controller: textCtrlHoTen,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: tr('edit_2'),
                    ),
                    onChanged: (value) {
                      hoTen = value;
                    },
                  );
                }
                return Container();
              }),
              SizedBox(height: paddingL),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (_, state) {
                if (state is AuthenticationAuthenticated) {
                  return FlatButton(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    padding: EdgeInsets.all(paddingL),
                    onPressed: () => openSection(context: context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${tr('edit_3')}: ${dateTimeNgaySinh ?? state.user.ngaysinh}',
                          style: style15,
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              }),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          constraints: BoxConstraints(
            maxHeight: kToolbarHeight + paddingL * 3,
          ),
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: paddingL,
            vertical: paddingM,
          ),
          child: SafeArea(
            child: SizedBox(
              height: kToolbarHeight,
              child: ButtonMidas(
                onPressed: updateProfile,
                child: Text(
                  tr('edit_4'),
                  style: style15_semibold.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showToastError() {
    final snackBar = SnackBar(
      content: Text(tr('edit_5')),
      duration: Duration(seconds: 2),
    );

    _scaffoldKey?.currentState?.showSnackBar(snackBar);
  }

  showToastSucess() {
    final snackBar = SnackBar(
      content: Text(tr('edit_6')),
      duration: Duration(seconds: 2),
    );
    _scaffoldKey?.currentState?.showSnackBar(snackBar);
  }

  updateProfile() {
    if (BlocProvider.of<AuthenticationBloc>(context).state
        is AuthenticationAuthenticated) {
      ///
      final user = (BlocProvider.of<AuthenticationBloc>(context).state
              as AuthenticationAuthenticated)
          .user;

      ///
      Profile p = new Profile(
        ngaysinh: dateTimeNgaySinh ?? user.ngaysinh,
        hoten: textCtrlHoTen.text,
        loai: user.loai,
      );

      ///
      BlocProvider.of<ThongTinCaNhanBloc>(context)
          .add(UpdateThongTinCaNhan(profile: p));
    }
  }

  Future<void> openSection({BuildContext context}) async {
    // final locale = EasyLocalizationProvider.of(context).data.locale;
    final locale = Localization.locate;
    var result;
    if (locale != null) {
      result = EnumToString.fromString(
        LocaleType.values,
        locale.languageCode.toLowerCase(),
      );
    } else {
      result = LocaleType.vi;
    }

    final user = (BlocProvider.of<AuthenticationBloc>(context).state
            as AuthenticationAuthenticated)
        .user;

    DateTime dateTime;
    if (user.ngaysinh != null) {
      print(user.ngaysinh);

      final stringsplit = user.ngaysinh.split('/');

      print(stringsplit);

      try {
        var year = int.tryParse(stringsplit[0]);
        var month = int.tryParse(stringsplit[1]);
        var day = int.tryParse(stringsplit[2]);

        dateTime = DateTime(
          year,
          month,
          day,
          0,
          0,
          0,
          0,
          0,
        );
      } catch (e) {
        print(e);
        dateTime = DateTime.now();
      }
    } else {
      dateTime = DateTime.now();
    }

    print(dateTime);

    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1800),
      maxTime: DateTime(DateTime.now().year),
      onConfirm: (date) {
        setState(() {
          dateTimeNgaySinh = '${date.year}/${date.month}/${date.day}';
        });
      },
      currentTime: dateTime,
      locale: result,
    );
  }
}
