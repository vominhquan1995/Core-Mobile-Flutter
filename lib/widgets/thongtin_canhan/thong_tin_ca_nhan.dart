import 'package:Core/core/connection-status/index.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/core/function/snackbar.dart';
import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/screens/setting_notification.dart';
import 'package:Core/widgets/shared/buttonMidas/button_midas.dart';
import 'package:Core/widgets/shared/user_need_login/user_need_login.dart';
import 'package:Core/widgets/tai_khoan/widgets/item_quanly.dart';
import 'package:Core/widgets/thongtin_canhan/bloc_thongtin_canhan/thongtincanhan_bloc.dart';
import 'package:Core/widgets/thongtin_canhan/edit_profile.dart';
import 'package:Core/widgets/thongtin_canhan/service/thongtin_canhan_service.dart';
import 'package:Core/widgets/thongtin_canhan/widgets/thongtin_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Core/core/authentication/bloc/bloc.dart';
import 'package:Core/core/authentication/models/profile_model.dart';
import 'package:Core/core/google_analytics/index.dart';
import 'package:Core/core/page-core/bloc/bloc.dart';

import 'package:Core/utils/index.dart';
import 'package:Core/widgets/thongtin_canhan/bloc_upload_image/bloc.dart';

import 'package:Core/widgets/thongtin_canhan/service/upload_image_service.dart';

import 'bloc_upload_image/upload_image_bloc.dart';

class ThongTinCaNhan extends StatefulWidget {
  @override
  _ThongTinCaNhanState createState() => _ThongTinCaNhanState();
}

class _ThongTinCaNhanState extends State<ThongTinCaNhan> {
  BlocUploadImageBloc bloc;
  ThongTinCaNhanBloc thongTinCaNhanBloc;

  var snackBar;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocUploadImageBloc(
      service: UploadImageService(BlocProvider.of<ErrorhandleBloc>(context)),
    );

    thongTinCaNhanBloc = ThongTinCaNhanBloc(
      service: ProfileService(
        BlocProvider.of<ErrorhandleBloc>(context),
      ),
    )..add(GetThongTinCaNhan());

    // BlocProvider.of<AuthenticationBloc>(context)
    //         .add(UpdateUser(state.profile));

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);

    GoogleAnalytics.trackScreen(thong_tin_ca_nhan_page);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    thongTinCaNhanBloc.close();
    super.dispose();
  }

  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      showSnackBarUpdateDataKey(_scaffoldKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: thongTinCaNhanBloc,
          listener: (_, state) {
            if (state is ThongtincanhanLoaded) {
              Profile p = new Profile(
                hoten: state.profile.hoten,
                ngaysinh: state.profile.ngaysinh,
              );
              BlocProvider.of<AuthenticationBloc>(context).add(UpdateUser(p));
            }
          },
        ),

        // BlocListener(
        //   bloc: bloc,
        //   listener: (BuildContext context, BlocUploadImageState state) {
        //     if (state is SuccessUploadImageState) {
        //       _scaffoldKey.currentState.showSnackBar(new SnackBar(
        //         backgroundColor: Colors.greenAccent,
        //         content: new Text(tr('profile_6')),
        //         duration: Duration(milliseconds: 500),
        //       ));
        //       Navigator.pop(context);
        //       BlocProvider.of<AuthenticationBloc>(context)
        //           .add(UpdateUser(Profile(avatar: state.image)));
        //     }

        //     if (state is ErrorBlocUploadImageState) {
        //       Navigator.pop(context);
        //       _scaffoldKey.currentState.showSnackBar(new SnackBar(
        //         content: new Text(tr('profile_7')),
        //         duration: Duration(milliseconds: 500),
        //       ));
        //     }
        //   },
        // ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorGrey_1,
        appBar: AppBar(
          title: Text(tr('profile_1')),
          flexibleSpace: Image(
            image: AssetImage('assets/images/background_appbar.jpg'),
            fit: BoxFit.cover,
            alignment: AlignmentDirectional.center,
          ),
        ),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, AuthenticationState state) {
            if (state is AuthenticationAuthenticated) {
              final dataUser = state.user;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InkWell(
                    onTap: () => showToast(),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(paddingL),
                      child: ThongTinItem(
                        title: "${tr('profile_2')}:",
                        subtitle: dataUser.sodt,
                      ),
                    ),
                  ),
                  SizedBox(height: paddingL),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(paddingL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ThongTinItem(
                          title: "${tr('profile_3')}:",
                          subtitle: dataUser.hoten,
                        ),
                        SizedBox(height: paddingM),
                        ThongTinItem(
                          title: "${tr('profile_4')}:",
                          subtitle: dataUser.ngaysinh,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: paddingL),
                  Container(
                    color: Colors.white,
                    child: ItemQuanLy(
                      onPressed: () => goToSettingNotifi(),
                      divider: false,
                      title: tr('profile_5'),
                      image: 'assets/icon_menu/setting.svg',
                    ),
                  ),
                ],
              );
            }

            return UserNeedLogin();
          },
        ),
        bottomNavigationBar: Container(
          constraints: BoxConstraints(maxHeight: kToolbarHeight + paddingL * 3),
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: paddingL,
            vertical: paddingM,
          ),
          child: SafeArea(
            child: SizedBox(
              height: kToolbarHeight,
              child: ButtonMidas(
                onPressed: goToPageEditProfile,
                child: Text(
                  tr('profile_6'),
                  style: style15_semibold.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> loadAssets() async {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           top: false,
  //           child: ListView(
  //             shrinkWrap: true,
  //             children: <Widget>[
  //               new ListTile(
  //                   leading: new Icon(Icons.camera_alt),
  //                   title: new Text(
  //                     tr('profile_7'),
  //                   ),
  //                   onTap: () async => _cropImage(ImageSource.camera)),
  //               new ListTile(
  //                 leading: new Icon(Icons.photo_album),
  //                 title: new Text(
  //                   tr('profile_8'),
  //                 ),
  //                 onTap: () async => _cropImage(ImageSource.gallery),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  // Future<Null> _cropImage(ImageSource source) async {
  //   File image;

  //   try {
  //     image = await ImagePicker.pickImage(source: source);
  //   } catch (e) {
  //     _handleError(e);
  //   }

  //   try {
  //     if (image == null) {
  //       /// Null khi không cấp quyền chọn ảnh
  //       return;
  //     }

  //     File croppedFile = await ImageCropper.cropImage(
  //       sourcePath: image.path,
  //       maxWidth: 512,
  //       maxHeight: 512,
  //     );
  //     if (croppedFile != null) {
  //       bloc.add(UploadImage(file: croppedFile));
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // _handleError(dynamic e) {
  //   if (e?.code.toString().contains('access_denied')) {
  //     print('Access Denied when pick image');
  //     Navigator.push(context, _createRoute());
  //   }
  // }

  // Route _createRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) =>
  //         AppSettingsPage(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       return FadeTransition(
  //         opacity: new Tween<double>(
  //           begin: 0.0,
  //           end: 1.0,
  //         ).animate(animation),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  /**
   * Bình 
   * đổi email
   */
  void showToast() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(tr('profile_6'), style: style22),
            content: Text(tr('profile_7'), style: style15),
            actions: <Widget>[
              new FlatButton(
                child: new Text(tr('profile_8'),
                    style: style15.copyWith(color: colorBlue)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void goToSettingNotifi() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SettingNotificationPage();
        },
      ),
    );
  }

  goToPageEditProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: thongTinCaNhanBloc,
          child: WidgetsCore(widget: EditProfile()),
        ),
      ),
    );
  }
}
