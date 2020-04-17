import 'index.dart';

/// * TODO: đây là core xử lý http
class DioUtil {
  static Map<String, String> headers = {
    "app-key": "MIDAS",
  };

  static String get apiMidasMobile =>
      Variables.isDevelop ? Variables.developMobile : Variables.releaseMobile;

  static String get apiPhanQuyen => Variables.isDevelop
      ? Variables.developPhanQuyen
      : Variables.releasePhanQuyen;

  static String get apiAuthentication => Variables.isDevelop
      ? Variables.developAuthentication
      : Variables.releaseAuthentication;

  static String get apiUploadFile =>
      Variables.isDevelop ? Variables.developURLFile : Variables.releaseURLFile;

  static String getApiMidas() {
    final api = Variables.isDevelop
        ? Variables.developVersionAPI
        : Variables.releaseVersionAPI;
    return '$apiMidasMobile/$api/api';
  }

  static String getApiEduzaaLogin() {
    return Variables.isDevelop
        ? '$apiMidasMobile'
        : '$apiMidasMobile/v${Variables.releaseVersionAPI}';
  }

  static String getApiPhanQuyen() {
    return '$apiPhanQuyen';
  }

  static String getApiAuthentication() {
    return '$apiAuthentication/api';
  }

  static String getApiUploadFile() {
    return '$apiUploadFile';
  }
}
