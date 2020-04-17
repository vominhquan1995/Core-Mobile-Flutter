import 'dart:async';
import 'package:package_info/package_info.dart';
import 'dart:io';
import 'package:bloc/bloc.dart';

import './index.dart';

import '../version_service.dart';

final tinhChat = "tinh_chat";
final message = "message";

class VersionBloc extends Bloc<VersionEvent, VersionState> {
  final VersionService versionService = VersionService();

  // check version return code
  final int BatBuocUpdate = 1;
  final int KoBatBuoc = 2;
  final int KhongCoVersionMoi = 3;
  final int UnSupportedPlatform = 4;

  @override
  VersionState get initialState => VersionUninitialized();

  @override
  Stream<VersionState> mapEventToState(VersionEvent event) async* {
    if (event is VersionAppStarted) {
      yield CheckingVersion();
      try {
        Map result = await this._checkVersion();

        if (result[tinhChat] == this.BatBuocUpdate) {
          yield HardUpdate();
        } else if (result[tinhChat] == this.KoBatBuoc) {
          yield SoftUpdate(message: result[message]);
        } else if (result[tinhChat] == this.KhongCoVersionMoi) {
          yield NoUpdate();
        }
      } catch (e) {
        // yield NoUpdate();

        yield CheckVersionError(error: e);
      }
    }

    if (event is TellMeLater) {
      yield VersionUninitialized();
    }
  }

  Future<Map> _checkVersion() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    // Kiểm tra version
    try {
      final PackageInfo info = await PackageInfo.fromPlatform();
      final result = await this.versionService.getVersion();

      if (Platform.isAndroid) {
        print('Android ${result["android"]["version"].toString()}');

        final isNewVersion =
            result["android"]["version"].toString() != info.version;

        if (isNewVersion) {
          final isRequired = result["android"]["require"];

          if (isRequired) {
            // bat buoc update, hien update page
            return {tinhChat: BatBuocUpdate, message: result["message"]};
          } else {
            // ko bat buoc update, chi hien dialog
            return {tinhChat: KoBatBuoc, message: result["message"]};
          }
        }

        // ko co version moi;
        return {tinhChat: KhongCoVersionMoi, message: result["message"]};
      } else if (Platform.isIOS) {
        print(' IOS ${result["ios"]}');

        final isNewVersion =
            result["ios"]["version"].toString() != info.version;

        if (isNewVersion) {
          final isRequired = result["ios"]["require"];

          if (isRequired) {
            return {tinhChat: BatBuocUpdate, message: result["message"]};
          } else {
            return {tinhChat: KoBatBuoc, message: result["message"]};
          }
        }
        return {tinhChat: KhongCoVersionMoi, message: result["message"]};
      }
      return {tinhChat: UnSupportedPlatform, message: result["message"]};
    } catch (e) {
      throw e;
    }
  }
}
