import 'dart:async';
import 'package:Core/core/config_json/db/config_json_provider.dart';
import 'package:Core/core/database/appdatabaseinfo.dart';
import 'package:Core/core/database/dbhelper.dart';
import 'package:Core/core/notification/db/notifi_provider.dart';
import 'package:Core/core/notification/index.dart';
import 'package:Core/utils/SharedObjects.dart';
import 'package:Core/widgets/quoc_gia/db/quocgia_db.dart';
import 'package:bloc/bloc.dart';
import 'package:Core/core/authentication/db/authen_provider.dart';
import 'package:Core/core/authentication/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication_service.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authenticationService = AuthenticationService();
  final AuthenProvider authenProvider = AuthenProvider();

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    // TODO: Add Logic
    if (event is AppStarted) {
      yield AuthenticationLoading();

      if (await isLoggin()) {
        yield UserLoggedIn();
        return;
      }
      yield AuthenticationUnauthenticated();
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      if (await isLoggin()) {
        authenticationService.insertActive();
        yield AuthenticationAuthenticated(await getUser());
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedOut) {
      ///clear SharedPreferences
      // await SharedPreferences.getInstance()
      //   ..clear();
      SharedPreferences sharedPreferences =
          CachedSharedPreferences.getInstance().sharedPreferences;
      final listK = sharedPreferences.getKeys();
      for (var item in listK) {
        if (![
          'codeC',
          'codeL',
          DBHelper.DB_VERSION,
        ].contains(item)) {
          print('remove $item');
          await sharedPreferences.remove(item);
        }
      }

      await DBHelper.dbHelper.clearExclude(
        AppDatabaseInfo(),
        exclude: [
          QuocGiaDB.TABLE_NAME,
          NotificationCore.TABLE_NAME,
          ConfigJsonProvider.TABLE_NAME
        ],
      );

      await NotifiProvider.deleteLastToken();
      //call service
      await authenticationService.logout();

      ///Logout
      yield AuthenticationUnauthenticated();
    }

    if (event is Maintenance) {
      yield MaintenanceApp(event.message);
    }

    if (event is YouNeedUpgradeVersionApp) {
      yield UpgradeVersionApp();
    }

    if (event is UpdateUser) {
      final user = await getUser();
      if (user != null) {
        var newUser = user.copyWith(profile: event.profile);
        await saveUser(newUser);

        yield AuthenticationAuthenticated(newUser);
        return;
      }

      final b = await saveUser(event.profile);
      if (b) {
        yield AuthenticationAuthenticated(event.profile);
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is QuocGiaNotFoundInDB) {
      yield QuocGiaNotFound();
    }

    if (event is ConfigJsonError) {
      yield ConfigJsonNotFound();
    }
  }

  Future<bool> isLoggin() async {
    try {
      var user = await getUser();

      if (user != null) {
        return user.token.isNotEmpty && user.loai.isNotEmpty;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveUser(Profile user) async {
    await authenProvider.delete();
    return await authenProvider.insert(user);
  }

  Future<Profile> getUser() async => await authenProvider.select();
  // Future<Profile> getUser() async => Profile(token: '123', hoten: "La la la");

  Future logout() async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }
}
