import 'package:firebase_core/firebase_core.dart';

class Variables {
  static int appId = 80;
  static bool isDevelop = false;

  ///Version db trong sqlite
  ///Đặt theo quy tắc ngày public
  static final developVersionSqlite = 02032020;

  ///api la
  static final developVersionAPI = "100";
  static final developPhanQuyen = "http://phanquyenapi.ttithutech.com";
  static final developAuthentication =
      "http://apidemo.lamgigio.net/midas/chung-thuc";
  static final developMobile = "http://apidemo.lamgigio.net/midas/mobile";
  // static final developMobile = "http://192.168.3.149:3100";
  static final developCauHinhChung = "http://hcauhinhchungapi.lamgigio.net";
  static final developURLFile = "http://apidemo.lamgigio.net/midas/files";

  ///RELEASE MOBILE
  static final releaseVersionAPI = "100";
  static final releasePhanQuyen = "http://api.midasbeautyline.com/chung-thuc";
  static final releaseAuthentication =
      "http://api.midasbeautyline.com/authentication";
  static final releaseMobile = "http://api.midasbeautyline.com/mobile";
  static final releaseURLFile = "http://api.midasbeautyline.com/files";

  ///Version db trong sqlite
  static final releaseVersionSqlite = 20032020;

  ///
  static String get androidAppId => "com.midasbeautyline.vn";
  static String get iOSAppId => "1440583709";

  static int get getVersionSqlite =>
      isDevelop ? developVersionSqlite : releaseVersionSqlite;

  static String get getVersion =>
      isDevelop ? developVersionAPI : releaseVersionAPI;

  /* 
   page tài khoản
  */
  static String get menuHoaHong => isDevelop ? "1046" : "1046";
  static String get menuThanhVien => isDevelop ? "1047" : "1047";

  /* 
  page midas-rewards
  */
  static String get buttonRutDiem => isDevelop ? "1048" : "1048";
  static String get buttonLichSuYeuCau => isDevelop ? "1049" : "1049";

  ///relese
  static FirebaseOptions get firebaseOptionsIOS => FirebaseOptions(
        googleAppID: '1:499791612215:ios:90ad15255202af218172b2',
        gcmSenderID: '499791612215',
        databaseURL: 'https://midas-beauty-line.firebaseio.com',
      );

  static FirebaseOptions get firebaseOptionsAndroid => FirebaseOptions(
        googleAppID: '1:499791612215:android:8cf9aabd70950c678172b2',
        apiKey: 'AIzaSyAyyeKBObiXgf0l72-2y09upyVsMP6CM3M',
        databaseURL: 'https://midas-beauty-line.firebaseio.com/',
      );

  // /develop
  // static FirebaseOptions get firebaseOptionsIOS => FirebaseOptions(
  //       googleAppID: '1:568222993919:ios:c6de2b69b03a5be8',
  //       gcmSenderID: '568222993919',
  //       databaseURL: 'https://test-react-89a8f.firebaseio.com',
  //     );

  // static FirebaseOptions get firebaseOptionsAndroid => FirebaseOptions(
  //       googleAppID: '1:413199343728:android:2afc2cbb2b4b3171',
  //       apiKey: 'AIzaSyCd4fqihXv-OqqxEfAZxIjTCnQnSWAxJD0',
  //       databaseURL: 'https://testpush-960e2.firebaseio.com',
  //     );
}
