import 'dart:async';
import 'dart:io';
import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/core/config_json/dataJson_notfound.dart';
import 'package:Core/core/config_json/models/config_json.dart';
import 'package:Core/core/config_json/service/configjson_service.dart';
import 'package:Core/core/notification/core_notification.dart';
import 'package:Core/widgets/quoc_gia/bloc/quocgia_bloc.dart';
import 'package:Core/widgets/quoc_gia/service/quocgia_service.dart';
import 'package:bloc/bloc.dart';
import 'package:Core/screens/layout/tab/bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'core/authentication/bloc/bloc.dart';
import 'core/bao-tri/baotri_page.dart';
import 'core/bao-tri/bloc/bloc.dart';
import 'core/connection-status/index.dart';
import 'core/database/bloc/bloc.dart';
import 'core/database/page/database_error_widget.dart';
import 'core/maintenance-page/bloc/index.dart';
import 'core/menu/bloc/index.dart';
import 'core/notification/bloc/index.dart';
import 'package:Core/core/translate/public.dart';
import 'core/version/bloc/index.dart';
import 'core/version/index.dart';
import 'screens/layout/tab/bloc/tab_bloc.dart';
import 'screens/layout/tab/tab.dart';
import 'utils/SharedObjects.dart';
import 'utils/index.dart';
import 'utils/theme.dart';
import 'utils/variables.dart';
import 'widgets/notification/bloc/bloc.dart';
import 'widgets/quoc_gia/quoc_gia.dart';
import 'widgets/shared/loading/loading_widget.dart';
import 'widgets/shared/overlay/overlay.dart';
//Debug bloc
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print('$bloc, $error, $stacktrace');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Cấu hình console log BLOC
  BlocSupervisor.delegate = SimpleBlocDelegate();
  ConnectionStatusSingleton.getInstance().initialize();
  ShowOverlay.getInstance().initialize();
  CachedSharedPreferences.getInstance().initialize();

  /// Cấu hình Firebase
  await FirebaseApp.configure(
    name: 'Core',
    options: Platform.isIOS
        ? Variables.firebaseOptionsIOS
        : Variables.firebaseOptionsAndroid,
  );
  //init language for app
  await AppLanguage().initLang();

  /// Lưu stroage
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  // FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MultiBlocProvider(providers: [
      /// Mở app chạy kiểm tra database
      BlocProvider<DatabaseHelperBloc>(
          create: (context) => DatabaseHelperBloc()..add(OpenDatabase())),

      ///
      BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc()),

      ///
      BlocProvider<MenuBloc>(create: (context) => MenuBloc()),

      /// Mở app chạy kiểm tra Version Bloc
      BlocProvider<VersionBloc>(
          create: (context) => VersionBloc()..add(VersionAppStarted())),

      ///
      BlocProvider<BaoTriBloc>(create: (context) => BaoTriBloc()),

      ///
      BlocProvider<MaintenancePageBloc>(
          create: (context) => MaintenancePageBloc()),

      ///
      BlocProvider<TabBloc>(create: (context) => TabBloc()),

      ///init bloc notifi
      BlocProvider<CoreNotificationBloc>(
        create: (context) => CoreNotificationBloc(),
      ),

      BlocProvider<QuocgiaBloc>(
        create: (context) => QuocgiaBloc(QuocGiaService()),
      ),
      BlocProvider<ConfigjsonBloc>(
        create: (context) => ConfigjsonBloc(
          service: ConfigJsonService(),
        ),
      ),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  StreamSubscription _steam;
  @override
  Widget build(BuildContext context) {
    return AppBuilder(builder: (context) {
      return MaterialApp(
        title: 'Core',
        theme: themeEduzaa,
        debugShowCheckedModeBanner: false,
        home: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: _createHome(),
        ),
      );
    });
  }

  _createHome() {
    return MultiBlocListener(
      listeners: [
        BlocListener<QuocgiaBloc, QuocgiaState>(
          listener: (_, QuocgiaState state) {
            if (state is DanhSachQuocgia && state.confirm != null) {
              if (!state.confirm.checkDataEmpty()) {
                BlocProvider.of<AuthenticationBloc>(_)
                    .add(QuocGiaNotFoundInDB());
                return;
              }

              BlocProvider.of<AuthenticationBloc>(_).add(AppStarted());
            }
            if (state is DanhSachQuocgia && state.confirm == null) {
              BlocProvider.of<AuthenticationBloc>(_).add(QuocGiaNotFoundInDB());
            }
          },
        ),
        BlocListener<ConfigjsonBloc, ConfigJson>(
          listener: (_, ConfigJson state) {
            if (state == null) {
              BlocProvider.of<AuthenticationBloc>(_).add(ConfigJsonError());
            }
          },
        ),
        BlocListener<DatabaseHelperBloc, DatabaseHelperState>(
          listener: (_, DatabaseHelperState state) {
            /// Sau khi kiểm tra database xong bắt đầu kiểm tra Local
            if (state is OnDBCompletedDatabaseHelperState) {
              //TODO: nếu đóng ở dưới thì mở ở đây
              BlocProvider.of<QuocgiaBloc>(_).add(CheckQuocGia());

              ShowOverlay.getInstance().showOverlay(_);

              // TODO : Chỉnh sửa ở đây để mở Bảo trì
              // BlocProvider.of<AuthenticationBloc>(_).add(LoggedIn());
              // after init db => init core notifi
              BlocProvider.of<CoreNotificationBloc>(_)
                  .add(InitNotification(context: _));

              _steam?.cancel();

              /// Điều kiện di chuyển page
              /// Pass được phân quyền
              /// State RedirectPageState
              _steam = Observable.combineLatest2<AuthenticationState,
                      CoreNotificationState, bool>(
                  BlocProvider.of<AuthenticationBloc>(_),
                  BlocProvider.of<CoreNotificationBloc>(_),
                  (AuthenticationState a, CoreNotificationState b) {
                if (a is AuthenticationAuthenticated &&
                    b is RedirectPageState) {
                  return true;
                }
                return false;
              }).listen((onData) {
                if (onData) {
                  final b = (BlocProvider.of<CoreNotificationBloc>(_).state
                      as RedirectPageState);

                  _doSomeThing(data: b.data, context: _);
                }
              });
            }
          },
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (_, AuthenticationState state) {
            /// Sau khi kiểm tra local
            /// 1: Đã xác định user. Lấy danh sách menu
            ///
            // final ngonngu = EasyLocalizationProvider.of(_).data.locale;
            ///User đã đăng nhập
            if (state is AuthenticationAuthenticated) {
              final lang = Localization.locate?.languageCode;

              ///
              final qg =
                  (BlocProvider.of<QuocgiaBloc>(_).state as DanhSachQuocgia);

              ///
              BlocProvider.of<MenuBloc>(_).add(GetMenu(profile: state.user));

              ///
              BlocProvider.of<ConfigjsonBloc>(_).add(
                InitJsonConfig(
                  codeC: qg.confirm.codeC,
                  // codeL: ngonngu.languageCode.toLowerCase(),
                  codeL: lang.toLowerCase(),
                ),
              );
            }

            ///User chưa đăng nhập
            if (state is AuthenticationUnauthenticated) {
              final lang = Localization.locate?.languageCode;
              final qg =
                  (BlocProvider.of<QuocgiaBloc>(_).state as DanhSachQuocgia);
              BlocProvider.of<ConfigjsonBloc>(_).add(
                InitJsonConfig(
                  codeC: qg.confirm.codeC,
                  codeL: lang.toLowerCase(),
                  // codeL: ngonngu.languageCode.toLowerCase(),
                ),
              );

              ///
              Navigator.popUntil(_, ModalRoute.withName('/'));

              ///
              BlocProvider.of<BaoTriBloc>(_).add(RestartBaoTri());

              ///
              BlocProvider.of<MaintenancePageBloc>(_).add(StartBaoTriPage());

              ///
              BlocProvider.of<DatabaseHelperBloc>(_).add(ClearDatabase());

              ///
              BlocProvider.of<TabBloc>(_).add(UpdateTab(AppTab.LIBRARY));

              ///
              BlocProvider.of<MenuBloc>(_).add(RemoveMenu());
            }

            /// 2: Đã xác định user đã login chạy kiểm tra bảo trì
            if (state is UserLoggedIn) {
              BlocProvider.of<BaoTriBloc>(_).add(BaoTriStart());
            }
          },
        ),
        BlocListener<VersionBloc, VersionState>(
          listener: (_, VersionState state) {
            /// Bắt buộc phải upgrade Ứng dụng
            if (state is HardUpdate) {
              BlocProvider.of<AuthenticationBloc>(_)
                  .add(YouNeedUpgradeVersionApp());
            }

            ///Hiển popup thông báo
            if (state is SoftUpdate) {
              UpdatePage.showUpdateDialog(_, BlocProvider.of<VersionBloc>(_));
            }
          },
        ),
        BlocListener<BaoTriBloc, BaoTriState>(
          listener: (_, BaoTriState state) {
            /// Có bảo trì ứng dụng hiện view bảo trì
            if (state is CoBaoTriApp) {
              Navigator.popUntil(_, ModalRoute.withName('/'));
              BlocProvider.of<AuthenticationBloc>(_)
                  .add(Maintenance(state.message));
            }

            if (state is KhongCoBaoTriApp) {
              BlocProvider.of<MaintenancePageBloc>(_).add(KiemTraBaoTriPage());
            }
          },
        ),
        BlocListener<MaintenancePageBloc, MaintenancePageState>(
          listener: (_, MaintenancePageState state) {
            /// Đã lấy danh sách các page bảo trì
            /// Thông báo vào trang home
            /// Khi trạng thái đã lấy đủ danh sách page bảo trì
            /// và trạng thái authencation chưa đăng nhập thì vô trang HomePage
            ///
            if (state is GetMaintenancePageState &&
                !(BlocProvider.of<AuthenticationBloc>(_).state
                    is AuthenticationAuthenticated)) {
              BlocProvider.of<AuthenticationBloc>(_).add(LoggedIn());
            }
          },
        ),
        BlocListener<CoreNotificationBloc, CoreNotificationState>(
          listener: (_, CoreNotificationState state) {
            if (state is InitSuccessState) {
              BlocProvider.of<CoreNotificationBloc>(_)
                  .add(CallRegisToken(context: _));
            }
          },
        ),
      ],
      child: BlocBuilder<DatabaseHelperBloc, DatabaseHelperState>(
        builder: (BuildContext _, DatabaseHelperState state) {
          //init value font for app
          SizeConfig().init(_);

          ScreenUtil.init(_, width: 411, height: 683);
          if (state is OnDBErrorDatabaseHelperState) {
            return DBHelperError();
          }

          /// Khởi tạo database thành công
          if (state is OnDBCompletedDatabaseHelperState) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (BuildContext _, AuthenticationState state) {
                if (state is AuthenticationUninitialized) {
                  return LoadingIndicator();
                }

                /// Vào trang Login
                /// Sau khi đăng nhập
                /// dispatch event lưu thông tin user
                /// dispatch event bắt đầu chạy bảo trì
                /// BlocProvider.of<BaoTriBloc>(context).add(BaoTriStart());
                ///
                if (state is QuocGiaNotFound) {
                  return QuocGiaPage();
                }

                /// Hoàn Thành tất cả công đoạn bảo trì app + page
                if (state is AuthenticationAuthenticated ||
                    state is AuthenticationUnauthenticated) {
                  // return CartListPage();
                  return TabLayout();
                }

                // if (state is AuthenticationUnauthenticated) {
                //   return LoginDienThoai();
                // }

                if (state is MaintenanceApp) {
                  return BaoTriPage(state.message);
                }

                if (state is UpgradeVersionApp) {
                  return UpdatePage();
                }

                if (state is ConfigJsonNotFound) {
                  return DataJsonNotFound();
                }

                return LoadingIndicator();
              },
            );
          }
          return LoadingIndicator();
        },
      ),
    );
  }

  _doSomeThing({ItemNotification data, BuildContext context}) {
    if (data.page == NotificationUtil.idPageNotifi) {
      BlocProvider.of<TabBloc>(context).add(UpdateTab(AppTab.THONGBAO));
      BlocProvider.of<NotificationBloc>(context).add(GetDataNotification());
    }
  }
}

class AppBuilder extends StatefulWidget {
  final Function(BuildContext) builder;

  const AppBuilder({Key key, this.builder}) : super(key: key);

  @override
  AppBuilderState createState() => new AppBuilderState();

  static AppBuilderState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<AppBuilderState>());
  }
}

class AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  void rebuild() {
    setState(() {});
  }
}
