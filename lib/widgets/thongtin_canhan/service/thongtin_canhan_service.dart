import 'dart:async';
import 'package:Midas/core/authentication/models/profile_model.dart';
import 'package:Midas/core/page-core/bloc/errorhandle_bloc.dart';
import 'package:Midas/core/page-core/service_custom.dart';

class ProfileService extends ServiceCustom {
  ProfileService(ErrorhandleBloc bloc) : super(bloc);

  Future<Profile> fetchThongTinUser() async {
    try {
      final response = await dioE.get('/profile/get-profile');

      // If the call to the server was successful, parse the JSON
      if (response.statusCode == 200) {
        final data = response.data["result"];

        return Profile.fromJson(data);
      } else {
        throw response;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<bool> updateHoTenNgaySinh(Profile profile) async {
    try {
      final response = await dioE.post(
        '/profile/update-hoten-ngaysinh',
        data: profile.toJson(),
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}
